<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - BTLJSP</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="assets/js/main.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
        header { background:#2d6ca2; color: white; padding: 1rem; }
        nav { background:#f4f4f4; padding: .5rem 1rem; }
        nav a { margin-right: 1rem; color:#333; text-decoration:none }
        .container { padding: 1rem; }
        ul { list-style-type: none; padding: 0; }
        li { margin: .5rem 0; }
    </style>
</head>
<body>
<header>
    <h1>Hệ thống Quản lý Cung Ứng Vật Tư</h1>
</header>

<nav>
    <%@ include file="includes/menu.jsp" %>
</nav>

<div class="container">
    <h2>Chào mừng đến hệ thống!</h2>
    <%
        com.btljsp.model.User currentUser = (com.btljsp.model.User) session.getAttribute("user");
        if (currentUser == null) {
    %>
        <p>Bạn chưa đăng nhập. Vui lòng <a href="login.jsp">đăng nhập</a>.</p>
    <%
        } else {
            String role = currentUser.getRole() == null ? "" : currentUser.getRole().toLowerCase();
    %>
        <h3>Xin chào, <%= currentUser.getUsername() %> (vai trò: <%= role %>)</h3>

        <%
            if ("admin".equals(role)) {
        %>
            <ul>
                <li><a href="nhanvien/list">Quản lý Nhân viên</a></li>
                <li><a href="mathang/list">Quản lý Mặt hàng</a></li>
                <li><a href="phanxuong/list">Quản lý Phân xưởng</a></li>
            </ul>
        <%
            } else if ("quanlykho".equals(role) || "manager".equals(role)) {
        %>
            <ul>
                <li><a href="mathang/list">Danh sách Mặt hàng</a></li>
                <li><a href="phieuxuathang/list">Danh sách Phiếu xuất hàng</a></li>
            </ul>
        <%
            } else {
        %>
            <ul>
                <li><a href="nhanvien/list">Thông tin Nhân viên</a></li>
                <li><a href="user.jsp">Trang cá nhân</a></li>
            </ul>
        <%
            }
        }
        %>
</div>
</body>
</html>
