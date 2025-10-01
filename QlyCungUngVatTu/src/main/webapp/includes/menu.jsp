<%@ page contentType="text/html;charset=UTF-8" %>
<%
    com.btljsp.model.User menuUser = (com.btljsp.model.User) session.getAttribute("user");
    String ctx = request.getContextPath();
    String menuRole = null;
    if (menuUser != null && menuUser.getRole() != null) {
        menuRole = menuUser.getRole().toLowerCase();
    }
%>

<div style="background:#333; padding:10px;">
    <!-- Luôn có Trang chủ -->
    <a href="<%= ctx %>/index.jsp" style="color:white; margin-right:15px;">Trang chủ</a>

    <% if (menuUser == null) { %>
        <!-- Chưa login -->
        <a href="<%= ctx %>/login.jsp" style="color:white; margin-right:15px;">Đăng nhập</a>
    <% } else { %>
        <!-- Đã login -->
        <span style="color:#ddd; margin-right:15px;">
            Xin chào, <strong style="color:white;"><%= menuUser.getUsername() %></strong>
        </span>

        <% if ("admin".equals(menuRole)) { %>
            <!-- Admin -->
            <a href="<%= ctx %>/admin.jsp" style="color:white; margin-right:15px;">Trang Admin</a>

        <% } else if ("quanlykho".equals(menuRole) || "manager".equals(menuRole)) { %>
            <!-- Quản lý kho -->
            <a href="<%= ctx %>/manager.jsp" style="color:white; margin-right:15px;">Trang Quản lý Kho</a>
            <a href="<%= ctx %>/mathang/list" style="color:white; margin-right:15px;">Mặt hàng</a>

        <% } else { %>
            <!-- Nhân viên -->
            <a href="<%= ctx %>/nhanvien/list" style="color:white; margin-right:15px;">Nhân viên</a>
            <a href="<%= ctx %>/user.jsp" style="color:white; margin-right:15px;">Trang Nhân viên</a>
        <% } %>

        <!-- Logout luôn có -->
        <a href="<%= ctx %>/logout" style="color:yellow;">Đăng xuất</a>
    <% } %>
</div>
