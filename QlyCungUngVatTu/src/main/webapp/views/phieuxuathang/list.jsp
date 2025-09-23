<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Phiếu xuất hàng - Danh sách</title>
</head>
<body>
<h2>Danh sách phiếu xuất hàng</h2>
<!-- Link directly to the JSP form for creating a new phieu xuat -->
<a href="${pageContext.request.contextPath}/views/phieuxuathang/form.jsp">Tạo phiếu mới (form)</a>
<table>
    <thead>
    <tr><th>ID</th><th>Ngày xuất</th><th>Thao tác</th></tr>
    </thead>
    <tbody>
    <c:forEach var="p" items="${phieuxuathangList}">
        <tr>
            <td>${p.id}</td>
            <td>${p.ngayXuat}</td>
            <td><a href="${pageContext.request.contextPath}/phieuxuathang/view?id=${p.id}">Xem</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
