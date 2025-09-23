package com.btljsp.controller;

import com.btljsp.dao.InventoryTransactionDAO;
import com.btljsp.dao.PhieuXuatHangItemDAO;
import com.btljsp.dao.DBConnection;
import com.btljsp.model.PhieuXuatHangItem;
import com.btljsp.model.InventoryTransaction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/phieuxuathang/create")
public class CreatePhieuXuatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Expect form data: ngayxuat, itemIds[], quantities[], unitPrices[]
        String ngayXuat = req.getParameter("ngayxuat");
        String[] itemIds = req.getParameterValues("itemIds");
        String[] quantities = req.getParameterValues("quantities");
        String[] unitPrices = req.getParameterValues("unitPrices");
        String createdByStr = req.getParameter("createdBy");
        Integer createdBy = null;
        if (createdByStr != null && !createdByStr.isEmpty()) createdBy = Integer.valueOf(createdByStr);

        if (itemIds == null || quantities == null || itemIds.length != quantities.length) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid items");
            return;
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1) Insert phieuxuathang
            String insertPhieu = "INSERT INTO phieuxuathang (ngayxuat, created_by) VALUES (?,?)";
            int phieuId = -1;
            try (PreparedStatement ps = conn.prepareStatement(insertPhieu, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, ngayXuat);
                if (createdBy != null) ps.setInt(2, createdBy); else ps.setNull(2, java.sql.Types.INTEGER);
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) { if (rs.next()) phieuId = rs.getInt(1); }
            }

            // DAOs
            PhieuXuatHangItemDAO itemDAO = new PhieuXuatHangItemDAO();
            InventoryTransactionDAO txnDAO = new InventoryTransactionDAO();

            // 2) Loop items: insert item, update mathang.soluong, insert inventory_transaction
            String updateMathang = "UPDATE mathang SET soluong = soluong - ? WHERE id = ?";
            try (PreparedStatement updMathang = conn.prepareStatement(updateMathang)) {
                for (int i = 0; i < itemIds.length; i++) {
                    int mathangId = Integer.parseInt(itemIds[i]);
                    int qty = Integer.parseInt(quantities[i]);
                    BigDecimal price = BigDecimal.ZERO;
                    if (unitPrices != null && unitPrices.length > i && unitPrices[i] != null && !unitPrices[i].isEmpty()) {
                        price = new BigDecimal(unitPrices[i]);
                    }

                    PhieuXuatHangItem item = new PhieuXuatHangItem();
                    item.setPhieuXuatId(phieuId);
                    item.setMathangId(mathangId);
                    item.setQuantity(qty);
                    item.setUnitPrice(price);
                    itemDAO.insert(item, conn);

                    // update stock
                    updMathang.setInt(1, qty);
                    updMathang.setInt(2, mathangId);
                    updMathang.executeUpdate();

                    // insert inventory transaction
                    InventoryTransaction tx = new InventoryTransaction();
                    tx.setMathangId(mathangId);
                    tx.setChangeQty(-qty);
                    tx.setTxnType("OUT");
                    tx.setReferenceTable("phieuxuathang");
                    tx.setReferenceId(phieuId);
                    tx.setCreatedBy(createdBy);
                    txnDAO.insert(tx, conn);
                }
            }

            conn.commit();
            resp.sendRedirect(req.getContextPath() + "/phieuxuathang");

        } catch (SQLException ex) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ignore) {}
            throw new ServletException("DB error", ex);
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignore) {}
        }
    }
}
