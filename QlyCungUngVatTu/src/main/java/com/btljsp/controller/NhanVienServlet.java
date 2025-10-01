package com.btljsp.controller;

import com.btljsp.dao.NhanVienDAO;
import com.btljsp.model.NhanVien;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/nhanvien/list")
public class NhanVienServlet extends HttpServlet {
    private NhanVienDAO dao = new NhanVienDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<NhanVien> list = dao.getAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/views/nhanvien/list.jsp").forward(req, resp);
    }
}
