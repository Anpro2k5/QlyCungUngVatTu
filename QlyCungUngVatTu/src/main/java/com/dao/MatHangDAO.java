package com.btljsp.dao;

import com.btljsp.model.MatHang;
import java.sql.*;
import java.util.*;

public class MatHangDAO {
    private Connection conn;

    public MatHangDAO(Connection conn) {
        this.conn = conn;
    }

    public List<MatHang> getAll() {
        List<MatHang> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM mathang";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MatHang mh = new MatHang(
                    rs.getInt("id"),
                    rs.getString("ten"),
                    rs.getString("donvitinh"),
                    rs.getInt("soluong")
                );
                list.add(mh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(MatHang mh) {
        try {
            String sql = "INSERT INTO mathang(ten, donvitinh, soluong) VALUES (?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, mh.getTen());
            ps.setString(2, mh.getDonViTinh());
            ps.setInt(3, mh.getSoLuong());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

