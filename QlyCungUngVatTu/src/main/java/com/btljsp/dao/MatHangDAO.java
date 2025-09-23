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
                list.add(new MatHang(
                    rs.getInt("id"),
                    rs.getString("ten"),
                    rs.getString("donvitinh"),
                    rs.getInt("soluong")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
