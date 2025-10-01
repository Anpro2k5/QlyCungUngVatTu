package com.btljsp.controller;

import com.btljsp.dao.UserDAO;
import com.btljsp.model.User;
import com.btljsp.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/user/add")
public class AddUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        int nhanvienId = Integer.parseInt(req.getParameter("nhanvienId"));

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO dao = new UserDAO(conn);
            User u = new User();
            u.setUsername(username);
            u.setPassword(password);
            u.setRole(role);
            u.setNhanvienId(nhanvienId);
            dao.addUser(u);
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/user/list");
    }
}
