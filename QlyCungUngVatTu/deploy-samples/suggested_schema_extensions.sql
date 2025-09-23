-- Suggested schema extensions for supply-management system
-- File: deploy-samples/suggested_schema_extensions.sql
-- Purpose: add line-items, inventory transactions, users/roles, suppliers, categories, timestamps, indexes and helper triggers.
-- Review before applying; adapt types/names to your conventions.

-- 1) Add audit columns to existing tables (if missing)
ALTER TABLE phanxuong
  ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE nhanvien
  ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE mathang
  MODIFY soluong INT NOT NULL DEFAULT 0,
  ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE phieuxuathang
  ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ADD COLUMN created_by INT NULL; -- FK to users.id (added below)

-- 2) Table: suppliers (nhà cung cấp)
CREATE TABLE IF NOT EXISTS nha_cung_cap (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(255) NOT NULL,
  diachi VARCHAR(255),
  lien_he VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3) Table: categories (phân loại mặt hàng)
CREATE TABLE IF NOT EXISTS category (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(255) NOT NULL,
  description VARCHAR(512),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4) Link products to category and supplier
ALTER TABLE mathang
  ADD COLUMN category_id INT NULL,
  ADD COLUMN supplier_id INT NULL,
  ADD FOREIGN KEY (category_id) REFERENCES category(id),
  ADD FOREIGN KEY (supplier_id) REFERENCES nha_cung_cap(id);

-- 5) Table: phieuxuathang_item (line items)
CREATE TABLE IF NOT EXISTS phieuxuathang_item (
  id INT PRIMARY KEY AUTO_INCREMENT,
  phieuxuathang_id INT NOT NULL,
  mathang_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(13,2) DEFAULT 0.00,
  subtotal DECIMAL(13,2) AS (quantity * unit_price) STORED,
  note VARCHAR(512),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (phieuxuathang_id) REFERENCES phieuxuathang(id) ON DELETE CASCADE,
  FOREIGN KEY (mathang_id) REFERENCES mathang(id)
);

-- 6) Table: inventory_transactions (ghi nhận biến động tồn kho)
CREATE TABLE IF NOT EXISTS inventory_transaction (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mathang_id INT NOT NULL,
  change_qty INT NOT NULL,
  txn_type ENUM('OUT','IN','ADJUST','RETURN') NOT NULL,
  reference_table VARCHAR(100), -- e.g., 'phieuxuathang', 'pnh' etc.
  reference_id INT NULL,
  created_by INT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  note VARCHAR(512),
  FOREIGN KEY (mathang_id) REFERENCES mathang(id)
);

-- 7) Users, roles, user_roles (simple auth model)
CREATE TABLE IF NOT EXISTS users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  fullname VARCHAR(255),
  email VARCHAR(255),
  active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS user_roles (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- 8) Indexes and performance hints
CREATE INDEX IF NOT EXISTS idx_mathang_category ON mathang(category_id);
CREATE INDEX IF NOT EXISTS idx_mathang_supplier ON mathang(supplier_id);
CREATE INDEX IF NOT EXISTS idx_phieuxuat_created_at ON phieuxuathang(created_at);
CREATE INDEX IF NOT EXISTS idx_inventory_mathang_created ON inventory_transaction(mathang_id, created_at);

-- 9) Trigger example (MySQL) to update mathang.soluong when a phieuxuathang_item is inserted/deleted
-- Use application-level transactions where possible. Triggers below are illustrative; test carefully.
DELIMITER $$
CREATE TRIGGER trg_phieuxuathang_item_after_insert
AFTER INSERT ON phieuxuathang_item
FOR EACH ROW
BEGIN
  -- decrease stock on outbound
  UPDATE mathang SET soluong = IFNULL(soluong,0) - NEW.quantity WHERE id = NEW.mathang_id;
  -- log transaction
  INSERT INTO inventory_transaction(mathang_id, change_qty, txn_type, reference_table, reference_id, created_at)
  VALUES(NEW.mathang_id, -NEW.quantity, 'OUT', 'phieuxuathang', NEW.phieuxuathang_id, NOW());
END$$

CREATE TRIGGER trg_phieuxuathang_item_after_delete
AFTER DELETE ON phieuxuathang_item
FOR EACH ROW
BEGIN
  -- restore stock on delete
  UPDATE mathang SET soluong = IFNULL(soluong,0) + OLD.quantity WHERE id = OLD.mathang_id;
  INSERT INTO inventory_transaction(mathang_id, change_qty, txn_type, reference_table, reference_id, created_at)
  VALUES(OLD.mathang_id, OLD.quantity, 'IN', 'phieuxuathang', OLD.phieuxuathang_id, NOW());
END$$
DELIMITER ;

-- 10) Suggested constraints / checks
-- Example: ensure quantity non-negative at application level; MySQL CHECK constraints have limited enforcement depending on version.

-- 11) Sample queries you will need
-- Get items of a phieu xuat and totals
-- SELECT p.id, p.ngayxuat, pi.mathang_id, m.ten, pi.quantity, pi.unit_price, pi.subtotal
-- FROM phieuxuathang p JOIN phieuxuathang_item pi ON p.id=pi.phieuxuathang_id
-- JOIN mathang m ON pi.mathang_id=m.id WHERE p.id = ?;

-- Inventory snapshot
-- SELECT m.id, m.ten, m.soluong, c.ten as category, s.ten as supplier FROM mathang m
-- LEFT JOIN category c ON m.category_id=c.id
-- LEFT JOIN nha_cung_cap s ON m.supplier_id=s.id;

-- Notes and recommendations:
-- 1) Prefer managing stock changes in application service layer inside DB transactions to control complex business logic (reserving stock, shipping, rollbacks).
-- 2) Use JNDI DataSource in Tomcat for production; keep credentials out of WAR.
-- 3) Add seed data for roles/users and initial categories/suppliers before using app.
-- 4) Add unit/integration tests that run against a disposable DB (Docker) to validate triggers and transactions.

-- End of suggested schema extensions
