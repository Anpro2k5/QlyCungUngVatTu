package com.btljsp.controller;

import com.btljsp.dao.MatHangDAO;
import com.btljsp.dao.DBConnection;
import com.btljsp.model.MatHang;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/mathang")
public class MatHangServlet extends HttpServlet {
    private MatHangDAO matHangDAO;

    public void init() {
        Connection conn = DBConnection.getConnection();
        matHangDAO = new MatHangDAO(conn);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<MatHang> list = matHangDAO.getAll();
        request.setAttribute("listMH", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/mathang/list.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ten = request.getParameter("ten");
        String donViTinh = request.getParameter("donvitinh");
        int soLuong = Integer.parseInt(request.getParameter("soluong"));

        MatHang mh = new MatHang(0, ten, donViTinh, soLuong);
        matHangDAO.insert(mh);

        response.sendRedirect("mathang");
    }
}

