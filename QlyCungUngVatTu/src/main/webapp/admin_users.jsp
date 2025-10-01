<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.btljsp.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Người dùng</title>
</head>
<body>
    <%@ include file="includes/menu.jsp" %>

    <h2>Danh sách người dùng</h2>
    <p><a href="admin/users/add">Thêm người dùng</a></p>

    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users != null && !users.isEmpty()) {
    %>
        <table border="1" cellpadding="8" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Nhân viên ID</th>
                <th>Actions</th>
            </tr>
            <%
                for (User u : users) {
            %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getUsername() %></td>
                    <td><%= u.getRole() %></td>
                    <td><%= u.getNhanvienId() %></td>
                    <td>
                        <a href="admin/users/edit?id=<%= u.getId() %>">Edit</a> |
                        <form method="post" action="admin/users/delete" style="display:inline; margin:0; padding:0;">
                            <input type="hidden" name="id" value="<%= u.getId() %>">
                            <button type="submit" onclick="return confirm('Xác nhận xóa người dùng này?');">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        } else {
    %>
        <p>Chưa có người dùng nào!</p>
    <%
        }
    %>
</body>
</html>