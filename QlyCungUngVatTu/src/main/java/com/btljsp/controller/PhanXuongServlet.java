package com.btljsp.controller;

import com.btljsp.dao.PhanXuongDAO;
import com.btljsp.model.PhanXuong;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/phanxuong/list")
public class PhanXuongServlet extends HttpServlet {
    private PhanXuongDAO dao = new PhanXuongDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<PhanXuong> list = dao.getAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/views/phanxuong/list.jsp").forward(req, resp);
    }
}
