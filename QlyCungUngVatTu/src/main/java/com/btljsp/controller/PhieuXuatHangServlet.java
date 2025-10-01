package com.btljsp.controller;

import com.btljsp.dao.PhieuXuatHangDAO;
import com.btljsp.model.PhieuXuatHang;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/phieuxuathang/list")
public class PhieuXuatHangServlet extends HttpServlet {
    private PhieuXuatHangDAO dao = new PhieuXuatHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<PhieuXuatHang> list = dao.getAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/views/phieuxuathang/list.jsp").forward(req, resp);
    }
}
