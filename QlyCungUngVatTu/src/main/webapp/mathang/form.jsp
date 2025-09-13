<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm Mặt hàng</title>
</head>
<body>
<h2>Thêm Mặt hàng</h2>
<form action="${pageContext.request.contextPath}/mathang" method="post">
    Tên: <input type="text" name="ten"><br>
    Đơn vị tính: <input type="text" name="donvitinh"><br>
    Số lượng: <input type="number" name="soluong"><br>
    <input type="submit" value="Lưu">
</form>
</body>
</html>
