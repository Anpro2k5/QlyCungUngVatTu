<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.btljsp.model.NhanVien" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Nhân viên</title>
</head>
<body>
<%
    NhanVien nv = (NhanVien) request.getAttribute("nv");
%>
<h2><%= (nv == null ? "Thêm nhân viên" : "Sửa nhân viên") %></h2>
<form method="post" action="">
    <input type="hidden" name="id" value="<%= (nv == null ? "" : nv.getId()) %>">
    Tên: <input type="text" name="ten" value="<%= (nv == null ? "" : nv.getTen()) %>"><br>
    Chức vụ: <input type="text" name="chucvu" value="<%= (nv == null ? "" : nv.getChucVu()) %>"><br>
    SĐT: <input type="text" name="sdt" value="<%= (nv == null ? "" : nv.getSdt()) %>"><br>
    <button type="submit">Lưu</button>
</form>
<a href="list">Quay lại</a>
</body>
</html>
