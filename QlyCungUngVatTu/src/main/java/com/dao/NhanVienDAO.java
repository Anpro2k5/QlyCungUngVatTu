package com.example.btljsp.dao;

import com.example.btljsp.model.NhanVien;
import java.sql.*;
import java.util.*;

public class NhanVienDAO {
    public List<NhanVien> getAll() {
        List<NhanVien> list = new ArrayList<>();
        String sql = "SELECT * FROM nhanvien";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                NhanVien nv = new NhanVien(
                        rs.getInt("id"),
                        rs.getString("ten"),
                        rs.getString("chucvu"),
                        rs.getString("sdt"),
                        rs.getInt("phanxuong_id")
                );
                list.add(nv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

