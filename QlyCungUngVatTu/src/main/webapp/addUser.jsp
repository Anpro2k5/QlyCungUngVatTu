<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Người dùng</title>
 </head>
<body>
    <%@ include file="includes/menu.jsp" %>

    <h2>Thêm người dùng mới</h2>
    <form method="post" action="admin/users/add">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        Role: <input type="text" name="role" value="nhanvien"><br>
        Nhân viên ID (tùy chọn): <input type="text" name="nhanvienId"><br>
        <button type="submit">Tạo</button>
    </form>

</body>
</html>
