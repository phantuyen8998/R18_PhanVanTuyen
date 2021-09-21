DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;

USE ThucTap;

-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- Thêm ít nhất 3 bản ghi vào table

DROP TABLE IF EXISTS GiangVien ;
CREATE TABLE GiangVien (
	magv INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    hoten VARCHAR(30) NOT NULL, 
    luong INT UNSIGNED
);

DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien (
	masv int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    hoten VARCHAR(30) NOT NULL,
    namsinh DATE NOT NULL,
    quequan VARCHAR (50)
);

DROP TABLE IF EXISTS DeTai ;
CREATE TABLE DeTai(
	madt INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tendt VARCHAR(30) NOT NULL,
    kinhphi int NOT NULL,
    noithuctap VARCHAR(30)
);

DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan(
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    masv int UNSIGNED NOT NULL,
    madt INT UNSIGNED ,
    magv INT UNSIGNED NOT NULL,
    ketqua VARCHAR(30),
    FOREIGN KEY (madt) REFERENCES DeTai(madt) ON DELETE CASCADE,
    FOREIGN KEY (magv) REFERENCES GiangVien(magv) ON DELETE CASCADE
);

INSERT INTO GiangVien(hoten,luong) 
VALUES ('Tran Nhat Hoa',5500000),
	   ('Phan Doan Cuong',7500000),
       ('Nguyen Hong Hanh',2500000),
       ('Nguyen Dinh Anh',3500000),
	   ('Tran Khanh Dung',4500000);

INSERT INTO SinhVien(hoten,namsinh,quequan)
VALUES ('Phan Van Tuyen','1999-02-10','Bac Giang'),
	   ('Nguyen Duy Anh','1999-05-10','Ha Noi'),
       ('Vu Thi Nhai','1999-03-10','Bac Ninh'),
       ('Vu Duy Minh','1999-06-10','TPHCM'),
       ('Nguyen Anh Tuan','1999-07-10','Da Nang'),
       ('Duong Van Dat','1999-11-10','Hue');


INSERT INTO DeTai(tendt,kinhphi,noithuctap) 
VALUES ('Cong Nghe Sinh Hoc',100000,'88 Le Thanh Nghi'),
	   ('Cong Nghe Hoa Hoc',120000,'102 Tran Dai Nghia'),
       ('Lap Trinh Win',190000,'33 Bach Mai'),
       ('Lap Trinh IOS',260000,'123 Kim Nguu'),
       ('Tri Tue Nhan Tao',410000,'23 Tran Hung Dao');
       
       
INSERT INTO HuongDan(masv,madt,magv,ketqua) 
VALUES (1,1,1,'Gioi'),
	   (2,1,4,'Kha'),
       (3,5,3,'Trung Binh'),
       (4,3,3,'Xuat Sac'),
       (5,4,2,'Kha');
       
INSERT INTO HuongDan(masv,magv) 
VALUES (6,5);
       
SELECT * FROM GiangVien;
SELECT * FROM SinhVien;
SELECT * FROM DeTai;
SELECT * FROM HuongDan;

-- 2. Viết lệnh để
-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
SELECT sv.masv, sv.hoten, hd.madt
FROM SinhVien sv
LEFT JOIN HuongDan hd
ON sv.masv = hd.masv
WHERE hd.madt IS NULL
GROUP BY sv.masv;

-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’
SELECT t.tendt, count(hd.masv) as sosinhvien
FROM HuongDan hd
JOIN DeTai t
ON hd.madt = t.madt
WHERE hd.madt = 1
GROUP BY t.tendt;

-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm:
-- mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")

DROP VIEW IF EXISTS SinhVienInfo;
CREATE VIEW SinhVienInfo AS
SELECT sv.masv, sv.hoten, CASE WHEN t.tendt IS NULL THEN 'Chưa có'
							   ELSE t.tendt END AS TenDeTai
FROM SinhVien sv
JOIN HuongDan hd
ON sv.masv = hd.masv
LEFT JOIN DeTai t
ON t.madt = hd.madt
GROUP BY sv.masv;

SELECT * FROM SinhVienInfo;

-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900
-- thì hiện ra thông báo "năm sinh phải > 1900"

DROP TRIGGER IF EXISTS Year_SV;
DELIMITER $$
CREATE TRIGGER Year_SV
BEFORE INSERT ON SinhVien
FOR EACH ROW
BEGIN
	IF Year(NEW.namsinh) <= 1900
    THEN SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT= 'năm sinh phải > 1900';
	END IF;

END$$
DELIMITER ;

INSERT INTO SinhVien(hoten,namsinh,quequan)
VALUES ('Pham Quoc Dai','1800-12-18','Thai Binh');

-- 5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông
-- tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi
ALTER TABLE HuongDan
ADD FOREIGN KEY(masv) REFERENCES SinhVien(masv) ON DELETE CASCADE;

DELETE FROM SinhVien WHERE masv = 5;
SELECT * FROM SinhVien;
SELECT * FROM HuongDan;






