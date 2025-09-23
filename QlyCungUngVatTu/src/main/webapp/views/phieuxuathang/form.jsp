<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Tạo phiếu xuất hàng</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 8px; }
        .actions { margin-top: 12px; }
    </style>
</head>
<body>
<h2>Tạo phiếu xuất hàng</h2>
<form method="post" action="${pageContext.request.contextPath}/phieuxuathang/create">
    <label>Ngày xuất: <input type="date" name="ngayxuat" required value="${pageContext.request.time}" /></label>
    <input type="hidden" name="createdBy" value="${sessionScope.user != null ? sessionScope.user.id : ''}" />

    <h3>Danh sách mặt hàng</h3>
    <table id="itemsTable">
        <thead>
        <tr>
            <th>Hàng</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Ghi chú</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <!-- initial row -->
        <tr>
            <td>
                <!-- TODO: replace with server-rendered options from mathang list -->
                <select name="itemIds">
                    <option value="1">[1] Ví dụ Mặt hàng A</option>
                    <option value="2">[2] Ví dụ Mặt hàng B</option>
                </select>
            </td>
            <td><input type="number" name="quantities" min="1" value="1" required/></td>
            <td><input type="number" step="0.01" name="unitPrices" value="0.00"/></td>
            <td><input type="text" name="notes"/></td>
            <td><button type="button" class="removeBtn">Xóa</button></td>
        </tr>
        </tbody>
    </table>

    <div class="actions">
        <button type="button" id="addRow">Thêm dòng</button>
        <button type="submit">Lưu phiếu</button>
        <a href="${pageContext.request.contextPath}/phieuxuathang">Trở về danh sách</a>
    </div>
</form>

<script>
    document.getElementById('addRow').addEventListener('click', function() {
        const tbody = document.querySelector('#itemsTable tbody');
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>
                <select name="itemIds">
                    <option value="1">[1] Ví dụ Mặt hàng A</option>
                    <option value="2">[2] Ví dụ Mặt hàng B</option>
                </select>
            </td>
            <td><input type="number" name="quantities" min="1" value="1" required/></td>
            <td><input type="number" step="0.01" name="unitPrices" value="0.00"/></td>
            <td><input type="text" name="notes"/></td>
            <td><button type="button" class="removeBtn">Xóa</button></td>
        `;
        tbody.appendChild(tr);
    });

    document.querySelector('#itemsTable').addEventListener('click', function(e) {
        if (e.target && e.target.classList.contains('removeBtn')) {
            const row = e.target.closest('tr');
            row.parentNode.removeChild(row);
        }
    });
</script>
</body>
</html>
