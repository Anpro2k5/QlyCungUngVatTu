package com.btljsp.controller;

import com.btljsp.dao.MatHangDAO;
import com.btljsp.model.MatHang;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/mathang/list")
public class MatHangServlet extends HttpServlet {
    private MatHangDAO dao = new MatHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<MatHang> list = dao.getAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/views/mathang/list.jsp").forward(req, resp);
    }
}
