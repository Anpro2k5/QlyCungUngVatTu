package com.btljsp.controller;

import com.btljsp.dao.UserDAO;
import com.btljsp.model.User;
import com.btljsp.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/user/list")
public class ListUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            UserDAO dao = new UserDAO(conn);
            List<User> users = dao.getAllUsers();

            req.setAttribute("users", users);
            req.getRequestDispatcher("/views/user/list.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải danh sách user");
        }
    }
}
