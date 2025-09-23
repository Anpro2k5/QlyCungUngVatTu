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
                PhanXuong px = new PhanXuong(
                    rs.getInt("id"),
                    rs.getString("ten"),
                    rs.getString("diachi")
                );
                list.add(px);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(PhanXuong px) {
        try {
            String sql = "INSERT INTO phanxuong(ten, diachi) VALUES (?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, px.getTen());
            ps.setString(2, px.getDiaChi());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
