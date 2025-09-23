package com.btljsp;

import com.btljsp.dao.DBConnection;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                System.out.println("✅ Kết nối DB thành công!");
            } else {
                System.out.println("❌ Không thể kết nối DB!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

