package com.btljsp.dao;

import com.btljsp.model.PhieuXuatHang;
import java.sql.*;
import java.util.*;

public class PhieuXuatHangDAO {
    private Connection conn;

    public PhieuXuatHangDAO(Connection conn) {
        this.conn = conn;
    }

    public List<PhieuXuatHang> getAll() {
        List<PhieuXuatHang> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM phieuxuathang";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PhieuXuatHang(
                        rs.getInt("id"),
                        rs.getDate("ngayxuat")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
