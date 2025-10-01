<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
</head>
<body>
<h2>Đăng nhập</h2>

<form action="login" method="post">
    <p>Tên đăng nhập: <input type="text" name="username" required></p>
    <p>Mật khẩu: <input type="password" name="password" required></p>
    <button type="submit">Đăng nhập</button>
</form>

<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>
</body>
</html>
