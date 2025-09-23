package com.btljsp.controller;

import com.btljsp.dao.DBConnection;
import com.btljsp.dao.NhanVienDAO;
import com.btljsp.model.NhanVien;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/nhanvien")
public class NhanVienServlet extends HttpServlet {
    private NhanVienDAO nhanVienDAO;

    public void init() {
        Connection conn = DBConnection.getConnection();
        nhanVienDAO = new NhanVienDAO(conn);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<NhanVien> list = nhanVienDAO.getAll();
        request.setAttribute("listNV", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/nhanvien/list.jsp");
        dispatcher.forward(request, response);
    }
}
