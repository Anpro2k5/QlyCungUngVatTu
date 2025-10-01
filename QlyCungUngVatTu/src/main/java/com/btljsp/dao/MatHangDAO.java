package com.btljsp.dao;

import com.btljsp.model.MatHang;
import com.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatHangDAO {
    public List<MatHang> getAll() {
        List<MatHang> list = new ArrayList<>();
        String sql = "SELECT * FROM mathang";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                MatHang m = new MatHang();
                m.setId(rs.getInt("id"));
                m.setTenHang(rs.getString("tenhang"));
                m.setDonGia(rs.getDouble("dongia"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(MatHang mh) {
        String sql = "INSERT INTO mathang(tenhang, dongia) VALUES(?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, mh.getTenHang());
            ps.setDouble(2, mh.getDonGia());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
