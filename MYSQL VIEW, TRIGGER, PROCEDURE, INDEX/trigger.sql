USE COBA_TRIGGER;

SELECT * FROM employee;

-- UPDATE employee SET nama_depan = 'Aziz' WHERE employee_id = 4;

SELECT * FROM employee_count;
SELECT * FROM employee_log;

-- SHOW TRIGGERS TRIGGER_BEFORE_UPDATE;
SHOW TRIGGERS;

SELECT * FROM barang;
-- DESC barang;
SELECT * FROM barang_log;
-- SELECT * FROM user_log;
-- DESC barang_log;
-- TRUNCATE barang_log;
-- DROP TABLE barang_log;
-- SELECT * FROM user_log;
-- DROP TRIGGER trigger_before_update_1;

UPDATE barang SET barcode = 11, nama = 'LED', harga = 220000, kategori = 'Teknologi' WHERE barang_id = 1;

-- CREATE TABLE barang_log (
-- 	id_barang_log INT PRIMARY KEY AUTO_INCREMENT,
-- 	barang_id INT,
--     old_barcode VARCHAR(100),
--     new_barcode VARCHAR(100),
--     old_nama VARCHAR(100),
--     new_nama VARCHAR(100),
--     old_harga INT,
--     new_harga INT,
--     old_kategori VARCHAR(100),
--     new_kategori ENUM('Kendaraan', 'Teknologi', 'Kebutuhan Premier')
-- );

-- delimiter |
-- create trigger trigger_before_update_1
-- 	before update
-- 	on barang
-- 	for each row
-- begin
-- 	INSERT INTO barang_log SET 
-- 		barang_id = old.barang_id,
-- 		old_barcode = old.barcode,
-- 		new_barcode = new.barcode,
-- 		old_nama = old.nama,
-- 		new_nama = new.nama,
-- 		old_harga = old.harga,
-- 		new_harga = new.harga,
-- 		old_kategori = old.kategori,
-- 		new_kategori = new.kategori;
-- end;
-- |
-- delimiter ;
