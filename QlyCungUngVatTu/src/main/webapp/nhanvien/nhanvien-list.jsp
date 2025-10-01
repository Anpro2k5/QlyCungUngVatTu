<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.btljsp.model.NhanVien" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Nhân viên</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid #333; padding: 8px; text-align: center; }
        a { text-decoration: none; color: blue; }
    </style>
</head>
<body>
<h2 style="text-align:center;">Danh sách Nhân viên</h2>

<a href="<%=request.getContextPath()%>/nhanvien/new">➕ Thêm Nhân viên</a><br/><br/>

<table>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Chức vụ</th>
        <th>Số điện thoại</th>
        <th>Hành động</th>
    </tr>
    <%
        List<NhanVien> list = (List<NhanVien>) request.getAttribute("list");
        if (list != null) {
            for (NhanVien nv : list) {
    %>
    <tr>
        <td><%= nv.getId() %></td>
        <td><%= nv.getTen() %></td>
        <td><%= nv.getChucvu() %></td>
        <td><%= nv.getSdt() %></td>
        <td>
            <a href="<%=request.getContextPath()%>/nhanvien/edit?id=<%=nv.getId()%>">Sửa</a> |
            <a href="<%=request.getContextPath()%>/nhanvien/delete?id=<%=nv.getId()%>"
               onclick="return confirm('Xóa nhân viên này?');">Xóa</a>
        </td>
    </tr>
    <%      }
        }
    %>
</table>

</body>
</html>
