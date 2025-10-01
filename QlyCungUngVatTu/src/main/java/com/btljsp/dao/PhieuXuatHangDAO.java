package com.btljsp.dao;

import com.btljsp.model.PhieuXuatHang;
import com.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhieuXuatHangDAO {
    public List<PhieuXuatHang> getAll() {
        List<PhieuXuatHang> list = new ArrayList<>();
        String sql = "SELECT * FROM phieuxuathang";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                PhieuXuatHang px = new PhieuXuatHang();
                px.setId(rs.getInt("id"));
                px.setNgay(rs.getDate("ngay"));
                list.add(px);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
