package com.btljsp.dao;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {
    private static final String FALLBACK_URL = "jdbc:mysql://localhost:3307/ten_database?useSSL=false&serverTimezone=UTC";
    private static final String FALLBACK_USER = "root";
    private static final String FALLBACK_PASS = "123456";

    private static HikariDataSource ds;

    static {
        try {
            Properties props = loadProps();
            HikariConfig cfg = new HikariConfig();
            cfg.setJdbcUrl(props.getProperty("db.url", FALLBACK_URL));
            cfg.setUsername(props.getProperty("db.user", FALLBACK_USER));
            cfg.setPassword(props.getProperty("db.password", FALLBACK_PASS));
            String poolSize = props.getProperty("db.poolSize");
            if (poolSize != null) {
                cfg.setMaximumPoolSize(Integer.parseInt(poolSize));
            }
            ds = new HikariDataSource(cfg);
        } catch (Throwable t) {
            // If HikariCP initialization fails, fall back to DriverManager on demand
            ds = null;
        }
    }

    private static Properties loadProps() {
        Properties props = new Properties();
        // 1) check system property override
        String externalPath = System.getProperty("external.db.properties");
        // 1a) if not set, try standard Tomcat catalina.base/conf/db.properties
        if (externalPath == null || externalPath.isEmpty()) {
            String catalinaBase = System.getProperty("catalina.base");
            if (catalinaBase != null && !catalinaBase.isEmpty()) {
                externalPath = catalinaBase + File.separator + "conf" + File.separator + "db.properties";
            } else {
                // fallback to XAMPP default
                externalPath = "C:\\xampp\\tomcat\\conf\\db.properties";
            }
        }
        try {
            File ext = new File(externalPath);
            if (ext.exists() && ext.isFile()) {
                try (InputStream in = new FileInputStream(ext)) {
                    props.load(in);
                    return props;
                }
            }
        } catch (Exception e) {
            // ignore and try classpath next
        }

        // 2) fall back to classpath resource
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (Exception e) {
            // ignore, will use fallbacks
        }
        return props;
    }

    public static Connection getConnection() {
        try {
            if (ds != null) {
                return ds.getConnection();
            }
            Properties props = loadProps();
            String url = props.getProperty("db.url", FALLBACK_URL);
            String user = props.getProperty("db.user", FALLBACK_USER);
            String pass = props.getProperty("db.password", FALLBACK_PASS);
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
