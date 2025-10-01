<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.btljsp.model.NhanVien" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Nhân viên</title>
</head>
<body>
<h2 style="text-align:center;">
    <% NhanVien nv = (NhanVien) request.getAttribute("nhanvien"); %>
    <%= (nv == null) ? "Thêm Nhân viên" : "Sửa Nhân viên" %>
</h2>

<form action="<%=request.getContextPath()%>/nhanvien/<%= (nv == null) ? "insert" : "update" %>" method="post" style="width:300px; margin:auto;">
    <% if (nv != null) { %>
        <input type="hidden" name="id" value="<%=nv.getId()%>">
    <% } %>
    <label>Tên:</label><br/>
    <input type="text" name="ten" value="<%= (nv != null) ? nv.getTen() : "" %>" required><br/><br/>

    <label>Chức vụ:</label><br/>
    <input type="text" name="chucvu" value="<%= (nv != null) ? nv.getChucvu() : "" %>" required><br/><br/>

    <label>Số điện thoại:</label><br/>
    <input type="text" name="sdt" value="<%= (nv != null) ? nv.getSdt() : "" %>" required><br/><br/>

    <button type="submit">Lưu</button>
    <a href="<%=request.getContextPath()%>/nhanvien/list">Quay lại</a>
</form>

</body>
</html>
