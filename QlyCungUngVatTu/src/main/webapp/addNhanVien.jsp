<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Nhân Viên</title>
</head>
<body>
    <%@ include file="includes/menu.jsp" %>
    <h2>Thêm Nhân viên mới</h2>
    <form action="${pageContext.request.contextPath}/nhanvien/add" method="post">
        Họ tên: <input type="text" name="ten" required><br><br>
        Chức vụ: <input type="text" name="chucvu" required><br><br>
        SĐT: <input type="text" name="sdt"><br><br>
        <button type="submit">Lưu</button>
    </form>
</body>
</html>
