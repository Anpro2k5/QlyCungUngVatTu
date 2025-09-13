<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Nhân viên</title>
    <link rel="stylesheet" href="../../assets/css/style.css">
</head>
<body>
<header>
    <h1>Danh sách Nhân viên</h1>
</header>

<nav>
    <a href="../../index.jsp">Trang chủ</a>
    <a href="../../nhanvien">Nhân viên</a>
    <a href="../../mathang">Mặt hàng</a>
    <a href="../../phanxuong">Phân xưởng</a>
    <a href="../../phieuxuathang">Phiếu xuất</a>
</nav>

<div class="container">
    <a href="form.jsp">➕ Thêm Nhân viên</a>
    <table>
        <tr>
            <th>ID</th><th>Tên</th><th>Chức vụ</th><th>SĐT</th>
        </tr>
        <c:forEach var="nv" items="${listNV}">
            <tr>
                <td>${nv.id}</td>
                <td>${nv.ten}</td>
                <td>${nv.chucvu}</td>
                <td>${nv.sdt}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>

