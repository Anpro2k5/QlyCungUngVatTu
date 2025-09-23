package com.btljsp.dao;

import com.btljsp.model.PhieuXuatHangItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhieuXuatHangItemDAO {

    public int insert(PhieuXuatHangItem item, Connection conn) throws SQLException {
        String sql = "INSERT INTO phieuxuathang_item (phieuxuathang_id, mathang_id, quantity, unit_price, note) VALUES (?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, item.getPhieuXuatId());
            ps.setInt(2, item.getMathangId());
            ps.setInt(3, item.getQuantity());
            if (item.getUnitPrice() != null) ps.setBigDecimal(4, item.getUnitPrice()); else ps.setBigDecimal(4, java.math.BigDecimal.ZERO);
            ps.setString(5, item.getNote());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    item.setId(id);
                    return id;
                }
            }
        }
        return -1;
    }

    public List<PhieuXuatHangItem> findByPhieuId(int phieuId, Connection conn) throws SQLException {
        String sql = "SELECT id, phieuxuathang_id, mathang_id, quantity, unit_price, note, created_at FROM phieuxuathang_item WHERE phieuxuathang_id = ?";
        List<PhieuXuatHangItem> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, phieuId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PhieuXuatHangItem item = new PhieuXuatHangItem();
                    item.setId(rs.getInt("id"));
                    item.setPhieuXuatId(rs.getInt("phieuxuathang_id"));
                    item.setMathangId(rs.getInt("mathang_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getBigDecimal("unit_price"));
                    item.setNote(rs.getString("note"));
                    item.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(item);
                }
            }
        }
        return list;
    }
}
