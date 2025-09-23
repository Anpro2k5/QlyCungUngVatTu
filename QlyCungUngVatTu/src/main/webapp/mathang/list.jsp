<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Mặt hàng</title>
</head>
<body>
<h2>Danh sách Mặt hàng</h2>
<a href="views/mathang/form.jsp">Thêm mặt hàng</a>
<table border="1">
    <tr>
        <th>ID</th><th>Tên</th><th>Đơn vị tính</th><th>Số lượng</th>
    </tr>
    <c:forEach var="mh" items="${listMH}">
        <tr>
            <td>${mh.id}</td>
            <td>${mh.ten}</td>
            <td>${mh.donViTinh}</td>
            <td>${mh.soLuong}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
