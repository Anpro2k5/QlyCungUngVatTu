<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.btljsp.model.NhanVien" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách Nhân viên</title>
</head>
<body>
    <%@ include file="includes/menu.jsp" %>

    <h2>Danh sách Nhân viên</h2>

    <%
        List<NhanVien> ds = (List<NhanVien>) request.getAttribute("dsNhanVien");
        if (ds != null && !ds.isEmpty()) {
    %>
        <table border="1" cellpadding="8" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Chức vụ</th>
                <th>SĐT</th>
            </tr>
            <%
                for (NhanVien nv : ds) {
            %>
                <tr>
                    <td><%= nv.getId() %></td>
                    <td><%= nv.getTen() %></td>
                    <td><%= nv.getChucvu() %></td>
                    <td><%= nv.getSdt() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        } else {
    %>
        <p>Chưa có nhân viên nào!</p>
    <%
        }
    %>
</body>
</html>
