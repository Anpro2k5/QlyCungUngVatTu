package com.btljsp.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.btljsp.model.User;

public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String uri = req.getRequestURI();

        if (user != null) {
            String role = user.getRole();

            if (uri.endsWith("admin.jsp") && !"admin".equalsIgnoreCase(role)) {
                res.sendRedirect(req.getContextPath() + "/accessDenied.jsp");
                return;
            }

            if (uri.endsWith("manager.jsp") && !"manager".equalsIgnoreCase(role)) {
                res.sendRedirect(req.getContextPath() + "/accessDenied.jsp");
                return;
            }
        }

        // Cho phép đi tiếp
        chain.doFilter(request, response);
    }
}
