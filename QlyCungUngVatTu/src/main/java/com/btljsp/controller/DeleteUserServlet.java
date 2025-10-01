package com.btljsp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.btljsp.dao.UserDAO;

@WebServlet("/admin/users/delete")
public class DeleteUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                userDAO.delete(id);
            } catch (Exception ex) {
                // ignore for now
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
