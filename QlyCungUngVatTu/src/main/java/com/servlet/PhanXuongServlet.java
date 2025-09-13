package com.btljsp.controller;

import com.btljsp.dao.PhanXuongDAO;
import com.btljsp.dao.DBConnection;
import com.btljsp.model.PhanXuong;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/phanxuong")
public class PhanXuongServlet extends HttpServlet {
    private PhanXuongDAO phanXuongDAO;

    public void init() {
        Connection conn = DBConnection.getConnection();
        phanXuongDAO = new PhanXuongDAO(conn);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<PhanXuong> list = phanXuongDAO.getAll();
        request.setAttribute("listPX", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/phanxuong/list.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ten = request.getParameter("ten");
        String diaChi = request.getParameter("diachi");

        PhanXuong px = new PhanXuong(0, ten, diaChi);
        phanXuongDAO.insert(px);

        response.sendRedirect("phanxuong");
    }
}

