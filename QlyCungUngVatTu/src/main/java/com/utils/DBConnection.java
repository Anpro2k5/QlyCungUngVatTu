package com.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static String jdbcURL = Config.get("db.url");
    private static String jdbcUser = Config.get("db.username");
    private static String jdbcPass = Config.get("db.password");
    private static String jdbcDriver = Config.get("db.driver");
   

    public static Connection getConnection() {
        try {
            Class.forName(jdbcDriver);
            return DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return null;
    }    
}
