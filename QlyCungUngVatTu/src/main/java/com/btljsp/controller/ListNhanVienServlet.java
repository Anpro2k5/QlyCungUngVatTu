package com.btljsp.controller;

import com.btljsp.dao.NhanVienDAO;
import com.btljsp.model.NhanVien;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/nhanvien/list")
public class ListNhanVienServlet extends HttpServlet {
    private NhanVienDAO nhanVienDAO = new NhanVienDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<NhanVien> list = nhanVienDAO.getAll();
        req.setAttribute("dsNhanVien", list);

        req.getRequestDispatcher("/listNhanVien.jsp").forward(req, resp);
    }
}
