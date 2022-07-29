-- -----------------------------------------------------------------------------------------
-- delimiter $$
-- CREATE PROCEDURE contoh()
-- begin
-- 	SELECT * FROM barang;
-- end $$
-- delimiter ;

-- call contoh()
-- SELECT * FROM barang
-- -----------------------------------------------------------------------------------------

-- delimiter $$
-- CREATE PROCEDURE latihan1()
-- begin
-- 	SELECT * FROM barang limit 3;
-- end $$
-- delimiter ;

-- call latihan1
-- show create procedure latihan1

-- DROP PROCEDURE IF EXISTS latihan1;

-- delimiter $$
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `latihan1`()
-- begin
-- 	SELECT * FROM barang limit 5;
-- end $$
-- delimiter ;
-- -----------------------------------------------------------------------------------------
-- delimiter $$
-- CREATE PROCEDURE dms.latihan1()
-- begin
-- 	declare jumlahkota, totalkota int default 0;
--     declare namakota varchar(100) default '';
-- 	SELECT count(*), sum(city_id), city_name into jumlahkota, totalkota, namakota FROM simcity;
--     SET jumlahkota = 20;
--     SELECT jumlahkota, totalkota, namakota;
-- end $$
-- delimiter ;

-- call latihan1()

-- SHOW CREATE PROCEDURE latihan1

-- DROP PROCEDURE IF EXISTS latihan1

-- -----------------------------------------------------------------------------------------
-- 1. Parameter
-- 2. in parameter
-- 3. out parameter
-- 4. inout parameter

-- DROP PROCEDURE IF EXISTS parameter1

-- delimiter $$
-- CREATE PROCEDURE parameter1(
-- 	in nama_kota varchar(100)
-- )
-- begin
-- 	DECLARE namakota varchar(100);
--     SET namakota = concat('%', nama_kota ,'%');
-- 	SELECT * FROM simcity WHERE city_name LIKE namakota;
-- end $$
-- delimiter ;

-- call parameter1('Locs')

-- SELECT * FROM simcity
-- UPDATE simcity SET city_name = 'Jakarta Selatan South' WHERE city_id = 4

-- ===========================================

-- DROP PROCEDURE IF EXISTS parameter2

-- delimiter $$
-- CREATE PROCEDURE parameter2(
-- 	in nama_kota varchar(100),
--     out jumlah int
-- )
-- begin
-- 	DECLARE namakota varchar(100);
--     SET namakota = concat('%', nama_kota ,'%');
-- 	SELECT count(*) INTO jumlah FROM simcity WHERE city_name LIKE namakota;
-- end $$
-- delimiter ;
-- call parameter2('Jakarta', @jumlah);
-- SELECT @jumlah;
-- SELECT * FROM simcity WHERE city_name LIKE '%jakarta%';

-- ===========================================

-- DROP PROCEDURE IF EXISTS parameter3

-- delimiter $$
-- CREATE PROCEDURE parameter3(
-- 	in nama_kota varchar(100),
--     inout jumlah int
-- )
-- begin
-- 	DECLARE namakota varchar(100);
--     SET namakota = concat('%', nama_kota ,'%');
-- 	SELECT count(*) + jumlah INTO jumlah FROM simcity WHERE city_name LIKE namakota;
-- end $$
-- delimiter ;

-- set @jumlah = 0;
-- call parameter3('bogor', @jumlah);
-- SELECT @jumlah;

-- -----------------------------------------------------------------------------------------

-- SHOW databases;
-- use dms;
-- SHOW TABLES;
-- SHOW PROCEDURE STATUS;
-- SHOW PROCEDURE STATUS WHERE DB = 'dms';
-- SHOW PROCEDURE STATUS LIKE '%par%';
-- SHOW CREATE PROCEDURE parameter1;
-- SELECT * FROM information_schema.ROUTINES;
-- SELECT * FROM information_schema.ROUTINES WHERE ROUTINE_NAME LIKE '%par%';

-- begin
-- 	DECLARE namakota varchar(100);
--     SET namakota = concat('%', nama_kota ,'%');
-- 	SELECT * FROM simcity WHERE city_name LIKE namakota;
-- end

-- -----------------------------------------------------------------------------------------

-- CREATE TABLE customer (
-- 	customer_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
--     customer_name VARCHAR(100),
--     address VARCHAR(200),
--     limit_amount decimal(12,0)
-- )

-- INSERT INTO customer (customer_name, address, limit_amount) VALUES 
-- ('Hendro', 'Jakarta Utara', 200000),
-- ('Rian', 'Jakarta Barat', 300000),
-- ('Trisuli', 'Jakarta Selatan', 400000),
-- ('Mirdas', 'Jakarta Timur', 500000),
-- ('Dede', 'Jakarta Pusat', 600000);


-- DROP PROCEDURE customer_level;

-- delimiter $$
-- CREATE PROCEDURE customer_level(
-- 	in cus_name VARCHAR(100),
--     out level_cat VARCHAR(100)
-- )
-- begin
-- 	DECLARE amount_val decimal(12,0) default 0;
--     SELECT limit_amount INTO amount_val FROM customer WHERE customer_name 
--     LIKE CONCAT('%', cus_name ,'%');
--     IF (amount_val >= 200000 AND amount_val < 400000) THEN 
-- 		SET level_cat = 'GOLD';
-- 	ELSEIF (amount_val >= 400000 AND amount_val < 600000) THEN
-- 		SET level_cat = 'PLATINUM';
-- 	ELSE
-- 		SET level_cat = 'SILVER';
-- 	END IF;
-- end $$
-- delimiter ;

-- CALL customer_level ('trisuli', @level);
-- SELECT @level

-- SHOW CREATE PROCEDURE customer_level;

-- SELECT * FROM customer

-- -----------------------------------------------------------------------------------------

-- DROP PROCEDURE IF EXISTS customerlevel_withcase;

-- DESC customer

-- SELECT * FROM customer

-- delimiter $$
-- CREATE PROCEDURE customerlevel_withcase(
-- 	in cus_name VARCHAR(100),
--     out level_cat VARCHAR(100)
-- )
-- begin
-- 	DECLARE amount_val decimal(12,0) default 0;
--     SELECT limit_amount INTO amount_val FROM customer WHERE customer_name 
--     LIKE concat('%', cus_name ,'%');
--     CASE
-- 		WHEN ( (amount_val >= 200000) AND (amount_val < 400000) ) THEN
-- 			SET level_cat = 'GOLD';
-- 		WHEN ( (amount_val >= 400000) AND (amount_val < 600000) ) THEN
-- 			SET level_cat = 'PLATINUM';
-- 		ELSE
-- 			SET level_cat = 'SILVER';
--     END CASE;
-- end $$
-- delimiter ;

-- CALL customerlevel_withcase('rian', @namasaya);
-- SELECT @namasaya;

-- -----------------------------------------------------------------------------------------

-- DROP PROCEDURE loopdemo;

-- delimiter $$
-- CREATE PROCEDURE loopdemo()
-- begin
-- 	DECLARE x INT;
--     DECLARE str VARCHAR(100);
--     SET x = 1;
--     SET str = '';
--     myloop : loop
-- 		IF x > 10 THEN
-- 			leave myloop;
-- 		END IF;
--         SELECT x;
--         SET x = x + 1;
--         IF (x mod 2) THEN
-- 			iterate myloop;
-- 		ELSE
-- 			SET str = concat(str, x, ',');
-- 		END IF;
--     end loop myloop;
--     SELECT str;
-- end $$
-- delimiter ;

-- CALL loopdemo();

-- SHOW CREATE PROCEDURE loopdemo;

-- -----------------------------------------------------------------------------------------
-- 1. Perintah dasar while loop
-- 2. Contoh Penggunaan

-- CREATE TABLE calender(
-- 	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
--     fulldate DATE UNIQUE,
--     day TINYINT,
--     month TINYINT,
--     quarter TINYINT,
--     year INT
-- )

-- delimiter $$
-- CREATE PROCEDURE insertcalender(dt date)
-- begin
-- 	INSERT INTO calender (fulldate, day, month, quarter, year)
--     VALUES (dt, 
-- 		extract(day from dt), 
--         extract(month from dt),
--         extract(quarter from dt),
--         extract(year from dt)
-- 	);
-- end $$
-- delimiter ;

-- CALL insertcalender('2021-06-22');

-- SELECT * FROM calender

-- DROP PROCEDURE loadcalender

-- delimiter $$
-- CREATE PROCEDURE loadcalender(
-- 	in startdate DATE,
--     in day INT
-- )
-- begin
-- 	DECLARE counter INT DEFAULT 1;
--     DECLARE dt DATE DEFAULT startdate;
--     myloop : while (counter <= day) do
-- 		CALL insertcalender(dt);
--         SET counter = counter + 1;
--         SET dt = date_add(dt, interval 2 day);
-- --       IF ( counter >= 10 ) THEN
-- -- 			leave myloop;
-- -- 		END IF;
-- 	end while myloop;
-- end $$
-- delimiter ;

-- CALL loadcalender('2021-01-01', 31)
-- SHOW CREATE PROCEDURE loadcalender
-- SELECT * FROM calender
-- TRUNCATE calender

-- -----------------------------------------------------------------------------------------
-- 1. Perintah dasar repeat loop
-- 2. Contoh penggunaan

-- DROP PROCEDURE repeatdemo;

-- delimiter $$
-- CREATE PROCEDURE repeatdemo()
-- begin
-- 	DECLARE counter INT DEFAULT 1;
--     DECLARE result VARCHAR(100) DEFAULT '';
--     REPEAT
-- 		SET result = concat(result, counter, ',');
--         SET counter = counter + 1;
-- 	UNTIL (counter > 10)
--     END REPEAT;
--     SELECT result;
-- end $$
-- delimiter ;

-- call repeatdemo()





