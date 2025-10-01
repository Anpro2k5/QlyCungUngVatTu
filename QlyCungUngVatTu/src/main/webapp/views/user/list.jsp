<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.btljsp.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách User</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background: #f4f4f4; }
        a.btn { display:inline-block; padding:4px 8px; background:#2d6ca2; color:#fff; text-decoration:none; border-radius:3px; }
        a.btn:hover { background:#1b4e75; }
    </style>
</head>
<body>
    <h2>Danh sách người dùng</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Tài khoản</th>
            <th>Role</th>
            <th>Nhân viên ID</th>
            <th>Thao tác</th>
        </tr>
        <%
            List<User> users = (List<User>) request.getAttribute("users");
            if (users != null) {
                for (User u : users) {
        %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getRole() %></td>
            <td><%= u.getNhanvienId() %></td>
            <td>
                <a href="<%=request.getContextPath()%>/user/editForm?id=<%=u.getId()%>" class="btn">Sửa</a>
                <a href="<%=request.getContextPath()%>/user/delete?id=<%=u.getId()%>" class="btn">Xóa</a>
            </td>
        </tr>
        <% 
                }
            } 
        %>
    </table>
    <br>
    <a href="<%=request.getContextPath()%>/views/user/add.jsp" class="btn">Thêm User mới</a>
</body>
</html>
