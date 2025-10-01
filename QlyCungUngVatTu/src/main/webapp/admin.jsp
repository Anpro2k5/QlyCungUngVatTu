<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.btljsp.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Admin</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f4f6f9; }
        header { background: #2d6ca2; color: white; padding: 1rem; text-align: center; }
        nav { background: #333; padding: 0.5rem; }
        nav a { color: white; margin-right: 1rem; text-decoration: none; }
        nav a:hover { text-decoration: underline; }
        .container { padding: 1.5rem; }
        .card {
            background: #fff; padding: 1rem; margin: 1rem 0;
            border-radius: 6px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h2 { color: #2d6ca2; }
        .btn {
            display: inline-block; padding: 0.5rem 1rem;
            background: #2d6ca2; color: white; text-decoration: none;
            border-radius: 4px; margin-top: 0.5rem;
        }
        .btn:hover { background: #1b4e75; }
    </style>
</head>
<body>
<header>
    <h1>Trang Quản trị Hệ thống</h1>
</header>

<nav>
    <a href="index.jsp">Trang chủ</a>
    <a href="logout">Đăng xuất</a>
</nav>

<div class="container">
    <%
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null) {
    %>
        <div class="card">
            <h2>Xin chào, <%= currentUser.getUsername() %></h2>
            <p>Bạn đang đăng nhập với vai trò: <b><%= currentUser.getRole() %></b></p>
        </div>

        <div class="card">
            <h3>Chức năng dành cho Admin</h3>
            <ul>
                <li><a href="user/list" class="btn">Quản lý Người dùng</a></li>
                <li><a href="mathang/list" class="btn">Quản lý Mặt hàng</a></li>
                <li><a href="nhanvien/list" class="btn">Quản lý Nhân viên</a></li>
                <li><a href="phanxuong/list" class="btn">Quản lý Phân xưởng</a></li>
            </ul>
        </div>
    <%
        } else {
    %>
        <p>Bạn chưa đăng nhập. Vui lòng <a href="login.jsp">đăng nhập</a>.</p>
    <% } %>
</div>
</body>
</html>
