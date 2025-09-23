package com.btljsp.dao;

import com.btljsp.model.PhanXuong;
import java.sql.*;
import java.util.*;

public class PhanXuongDAO {
    private Connection conn;

    public PhanXuongDAO(Connection conn) {
        this.conn = conn;
    }

    public List<PhanXuong> getAll() {
        List<PhanXuong> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM phanxuong";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PhanXuong(
                    rs.getInt("id"),
                    rs.getString("ten"),
                    rs.getString("diachi")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
