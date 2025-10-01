package com.btljsp.controller;

import com.btljsp.dao.UserDAO;
import com.btljsp.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editUser")
public class EditUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User u = new User();
        u.setUserId(id);   // ✅ dùng setUserId, không còn setId
        u.setUsername(username);
        u.setPassword(password);
        u.setRole(role);

        // TODO: gọi userDAO.update(u); nếu bạn đã viết phương thức update
        response.sendRedirect("listUsers.jsp");
    }
}
