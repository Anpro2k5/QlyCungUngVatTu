<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Phân xưởng</title>
</head>
<body>
<h2>Danh sách Phân xưởng</h2>
<a href="views/phanxuong/form.jsp">Thêm phân xưởng</a>
<table border="1">
    <tr>
        <th>ID</th><th>Tên</th><th>Địa chỉ</th>
    </tr>
    <c:forEach var="px" items="${listPX}">
        <tr>
            <td>${px.id}</td>
            <td>${px.ten}</td>
            <td>${px.diaChi}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
