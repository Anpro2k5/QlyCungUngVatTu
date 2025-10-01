package com.btljsp.dao;

import com.btljsp.model.PhanXuong;
import com.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhanXuongDAO {
    public List<PhanXuong> getAll() {
        List<PhanXuong> list = new ArrayList<>();
        String sql = "SELECT * FROM phanxuong";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                PhanXuong px = new PhanXuong();
                px.setId(rs.getInt("id"));
                px.setTen(rs.getString("ten"));
                list.add(px);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
