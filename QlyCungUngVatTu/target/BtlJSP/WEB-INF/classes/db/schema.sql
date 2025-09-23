-- Starter schema for BTL Quản lý cung ứng vật tư (example)

CREATE TABLE phanxuong (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(255),
  diachi VARCHAR(255)
);

CREATE TABLE nhanvien (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(255),
  chucvu VARCHAR(255),
  sdt VARCHAR(50),
  phanxuong_id INT,
  FOREIGN KEY (phanxuong_id) REFERENCES phanxuong(id)
);

CREATE TABLE mathang (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(255),
  donvitinh VARCHAR(100),
  soluong INT
);

CREATE TABLE phieuxuathang (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ngayxuat DATE
);
