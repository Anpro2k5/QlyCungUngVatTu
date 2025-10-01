<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.btljsp.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa Người dùng</title>
 </head>
<body>
    <%@ include file="includes/menu.jsp" %>

    <h2>Chỉnh sửa người dùng</h2>
    <%
        User u = (User) request.getAttribute("userToEdit");
        if (u == null) { %>
            <p>Người dùng không tìm thấy.</p>
        <% } else { %>
    <form method="post" action="admin/users/edit">
        <input type="hidden" name="id" value="<%= u.getId() %>">
        Username: <input type="text" name="username" value="<%= u.getUsername() %>"><br>
        Password: <input type="text" name="password" value="<%= u.getPassword() %>"><br>
        Role: <input type="text" name="role" value="<%= u.getRole() %>"><br>
        Nhân viên ID: <input type="text" name="nhanvienId" value="<%= u.getNhanvienId() %>"><br>
        <button type="submit">Lưu</button>
    </form>
        <% } %>

</body>
</html>
