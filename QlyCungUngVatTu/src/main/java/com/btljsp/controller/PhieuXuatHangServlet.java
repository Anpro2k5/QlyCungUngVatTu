package com.btljsp.controller;

import com.btljsp.dao.DBConnection;
import com.btljsp.dao.PhieuXuatHangDAO;
import com.btljsp.model.PhieuXuatHang;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/phieuxuathang")
public class PhieuXuatHangServlet extends HttpServlet {
    private PhieuXuatHangDAO dao;

    public void init() {
        Connection conn = DBConnection.getConnection();
        dao = new PhieuXuatHangDAO(conn);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<PhieuXuatHang> list = dao.getAll();
        request.setAttribute("listPX", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/phieuxuathang/list.jsp");
        dispatcher.forward(request, response);
    }
}
