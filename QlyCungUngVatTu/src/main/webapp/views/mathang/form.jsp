<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Mặt Hàng</title>
    <style>label{display:block;margin:.5rem 0}</style>
</head>
<body>
    <h2>Thêm Mặt Hàng</h2>
    <form action="${pageContext.request.contextPath}/mathang" method="post">
        <label> Tên: <input type="text" name="ten" required/></label>
        <label> Đơn vị tính: <input type="text" name="donvitinh" required/></label>
        <label> Số lượng: <input type="number" name="soluong" min="0" value="0" required/></label>
        <button type="submit">Lưu</button>
        <a href="${pageContext.request.contextPath}/mathang">Hủy</a>
    </form>
</body>
</html>
