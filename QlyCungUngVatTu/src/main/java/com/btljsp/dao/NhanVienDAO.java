package com.btljsp.dao;

import com.btljsp.model.NhanVien;
import java.sql.*;
import java.util.*;

public class NhanVienDAO {
    private Connection conn;

    public NhanVienDAO(Connection conn) {
        this.conn = conn;
    }

    public List<NhanVien> getAll() {
        List<NhanVien> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM nhanvien";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new NhanVien(
                    rs.getInt("id"),
                    rs.getString("ten"),
                    rs.getString("chucvu"),
                    rs.getString("sdt"),
                    rs.getInt("phanxuong_id")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
