<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.btljsp.model.NhanVien" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Nhân viên</title>
</head>
<body>
<h2>Danh sách Nhân viên</h2>
<a href="new">Thêm nhân viên</a>
<table border="1" cellpadding="5">
    <tr>
        <th>ID</th><th>Tên</th><th>Chức vụ</th><th>SĐT</th><th>Hành động</th>
    </tr>
    <%
        List<NhanVien> list = (List<NhanVien>) request.getAttribute("list");
        if (list != null) {
            for (NhanVien nv : list) {
    %>
        <tr>
            <td><%=nv.getId()%></td>
            <td><%=nv.getTen()%></td>
            <td><%=nv.getChucVu()%></td>
            <td><%=nv.getSdt()%></td>
            <td>
                <a href="edit?id=<%=nv.getId()%>">Sửa</a>
                <a href="delete?id=<%=nv.getId()%>" onclick="return confirm('Xóa nhân viên này?')">Xóa</a>
            </td>
        </tr>
    <%      }
        }
    %>
</table>
</body>
</html>
