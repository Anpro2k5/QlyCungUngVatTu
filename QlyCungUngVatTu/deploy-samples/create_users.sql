-- Sample SQL to create users table and insert a test admin
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'nhanvien'
);

-- Insert a test admin (username: admin, password: admin)
INSERT INTO users (username, password, role) VALUES ('admin', 'admin', 'admin')
ON DUPLICATE KEY UPDATE username = username;