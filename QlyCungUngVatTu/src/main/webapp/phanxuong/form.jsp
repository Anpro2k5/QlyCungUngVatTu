<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm Phân xưởng</title>
</head>
<body>
<h2>Thêm Phân xưởng</h2>
<form action="${pageContext.request.contextPath}/phanxuong" method="post">
    Tên: <input type="text" name="ten"><br>
    Địa chỉ: <input type="text" name="diachi"><br>
    <input type="submit" value="Lưu">
</form>
</body>
</html>
