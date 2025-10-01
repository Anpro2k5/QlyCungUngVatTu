package com.btljsp.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*") // áp dụng cho tất cả các request
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // không cần code gì thêm ở đây
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        // Cho phép đi qua nếu:
        // 1. Đã đăng nhập
        // 2. Đang truy cập trang login.jsp hoặc servlet /login
        // 3. Đang truy cập các file tĩnh (css, js, images)
        if (loggedIn
                || uri.endsWith("login.jsp")
                || uri.endsWith("login")
                || uri.contains("/assets/")) {
            chain.doFilter(request, response); // cho đi tiếp
        } else {
            // Nếu chưa login -> chuyển về login.jsp
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // không cần code gì thêm
    }
}
