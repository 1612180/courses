﻿/****** Database QuanLyDeTai ******/
CREATE DATABASE QuanLyDeTai
GO
USE QuanLyDeTai
GO
/****** Table BOMON ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE BOMON
(
	MABM nvarchar(4) NOT NULL,
	TENBM nvarchar(40) NULL,
	PHONG nvarchar(3) NULL,
	DIENTHOAI nvarchar(12) NULL,
	TRUONGBM nvarchar(3) NULL,
	MAKHOA nvarchar(10) NULL,
	NGAYNHANCHUC date NULL,
	CONSTRAINT PK_BOMON PRIMARY KEY (MABM) 
)

/****** Table CHUDE ******/
CREATE TABLE CHUDE
(
	MACD nvarchar(4) NOT NULL,
	TENCD nvarchar(50) NULL,
	CONSTRAINT PK_CHUDE PRIMARY KEY (MACD) 
)

/****** Table CONGVIEC ******/
CREATE TABLE CONGVIEC
(
	MADT nvarchar(3) NOT NULL,
	SOTT int NOT NULL,
	TENCV nvarchar(50) NULL,
	NGAYBD date NULL,
	NGAYKT date NULL,
	CONSTRAINT PK_CONGVIEC PRIMARY KEY (MADT, SOTT) 
)

/****** Table DETAI ******/
CREATE TABLE DETAI
(
	MADT nvarchar(3) NOT NULL,
	TENDT nvarchar(50) NULL,
	CAPQL nvarchar(15) NULL,
	KINHPHI numeric(10, 1) NULL,
	NGAYBD date NULL,
	NGAYKT date NULL,
	MACD nvarchar(4) NULL,
	GVCNDT nvarchar(3) NULL,
	CONSTRAINT PK_DETAI PRIMARY KEY (MADT) 
)

/****** Table GIAOVIEN ******/
CREATE TABLE GIAOVIEN
(
	MAGV nvarchar(3) NOT NULL,
	HOTEN nvarchar(40) NULL,
	LUONG numeric(10, 1) NULL,
	PHAI nvarchar(3) NULL,
	NGSINH date NULL,
	DIACHI nvarchar(50) NULL,
	GVQLCM nvarchar(3) NULL,
	MABM nvarchar(4) NULL,
	CONSTRAINT PK_GIAOVIEN PRIMARY KEY (MAGV) 
)

/****** Table GV_DT ******/
CREATE TABLE GV_DT
(
	MAGV nvarchar(3) NOT NULL,
	DIENTHOAI nvarchar(12) NOT NULL,
	CONSTRAINT PK_GV_DT PRIMARY KEY (MAGV, DIENTHOAI) 
)

/****** Table KHOA ******/
CREATE TABLE KHOA
(
	MAKHOA nvarchar(10) NOT NULL,
	TENKHOA nvarchar(40) NULL,
	NAMTL nvarchar(4) NULL,
	PHONG nvarchar(3) NULL,
	DIENTHOAI nvarchar(12) NULL,
	TRUONGKHOA nvarchar(3) NULL,
	NGAYNHANCHUC date NULL,
	CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA) 
)

/****** Table NGUOITHAN ******/
CREATE TABLE NGUOITHAN
(
	MAGV nvarchar(3) NOT NULL,
	TEN nvarchar(15) NOT NULL,
	NGSINH date NULL,
	PHAI nvarchar(3) NULL,
	CONSTRAINT PK_NGUOITHAN PRIMARY KEY (MAGV, TEN) 
)

/****** Table THAMGIADT ******/
CREATE TABLE THAMGIADT
(
	MAGV nvarchar(3) NOT NULL,
	MADT nvarchar(3) NOT NULL,
	STT int NOT NULL,
	PHUCAP numeric(5, 1) NULL,
	KETQUA nvarchar(3) NULL,
	CONSTRAINT PK_THAMGIADT PRIMARY KEY (MAGV, MADT, STT) 
)

ALTER TABLE BOMON ADD CONSTRAINT FK_BOMON_GIAOVIEN FOREIGN KEY(TRUONGBM)
REFERENCES GIAOVIEN (MAGV)

ALTER TABLE BOMON ADD CONSTRAINT FK_BOMON_KHOA FOREIGN KEY(MAKHOA)
REFERENCES KHOA (MAKHOA)

ALTER TABLE CONGVIEC  ADD CONSTRAINT FK_CONGVIEC_DETAI FOREIGN KEY(MADT)
REFERENCES DETAI (MADT)

ALTER TABLE DETAI ADD CONSTRAINT FK_DETAI_CHUDE FOREIGN KEY(MACD)
REFERENCES CHUDE (MACD)

ALTER TABLE DETAI ADD CONSTRAINT FK_DETAI_GIAOVIEN FOREIGN KEY(GVCNDT)
REFERENCES GIAOVIEN (MAGV)

ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_GIAOVIEN_BOMON FOREIGN KEY(MABM)
REFERENCES BOMON (MABM)

ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_GIAOVIEN_GIAOVIEN FOREIGN KEY(GVQLCM)
REFERENCES GIAOVIEN (MAGV)

ALTER TABLE GV_DT  ADD CONSTRAINT FK_GV_DT_GIAOVIEN FOREIGN KEY(MAGV)
REFERENCES GIAOVIEN (MAGV)

ALTER TABLE KHOA ADD CONSTRAINT FK_KHOA_GIAOVIEN FOREIGN KEY(TRUONGKHOA)
REFERENCES GIAOVIEN (MAGV)

ALTER TABLE NGUOITHAN ADD CONSTRAINT FK_NGUOITHAN_GIAOVIEN FOREIGN KEY(MAGV)
REFERENCES GIAOVIEN (MAGV)

ALTER TABLE THAMGIADT ADD CONSTRAINT FK_THAMGIADT_CONGVIEC FOREIGN KEY(MADT, STT)
REFERENCES CONGVIEC (MADT, SOTT)

ALTER TABLE THAMGIADT ADD CONSTRAINT FK_THAMGIADT_GIAOVIEN FOREIGN KEY(MAGV)
REFERENCES GIAOVIEN (MAGV)

--Phái chỉ có Nam, Nữ.
ALTER TABLE GIAOVIEN
ADD CONSTRAINT C_PHAI_GIAOVIEN
CHECK (PHAI IN ('Nam', N'Nữ'))
--
ALTER TABLE NGUOITHAN
ADD CONSTRAINT C_PHAI_NGUOITHAN
CHECK (PHAI IN ('Nam', N'Nữ'))


--Insert CHUDE
INSERT INTO CHUDE (MACD, TENCD) VALUES (N'NCPT', N'Nghiên cứu phát triển')
INSERT INTO CHUDE (MACD, TENCD) VALUES (N'QLGD', N'Quản lý giáo dục')
INSERT INTO CHUDE (MACD, TENCD) VALUES (N'ƯDCN', N'Ứng dụng công nghệ')

--Insert KHOA(MAKHOA, TENKHOA, NAMTL, PHONG, DIENTHOAI, NGAYNHANCHUC)
INSERT INTO KHOA (MAKHOA, TENKHOA, NAMTL, PHONG, DIENTHOAI, NGAYNHANCHUC) VALUES (N'CNTT', N'Công nghệ thông tin', N'1995', N'B11', N'0838123456', CAST(N'2005-02-20' AS Date))
INSERT INTO KHOA (MAKHOA, TENKHOA, NAMTL, PHONG, DIENTHOAI, NGAYNHANCHUC) VALUES (N'SH', N' Hóa học', N'1980', N'B31', N'0838454545', CAST(N'2000-10-11' AS Date))
INSERT INTO KHOA (MAKHOA, TENKHOA, NAMTL, PHONG, DIENTHOAI, NGAYNHANCHUC) VALUES (N'HH', N'Sinh học', N'1980', N'B41', N'0838456465', CAST(N'2001-10-15' AS Date))
INSERT INTO KHOA (MAKHOA, TENKHOA, NAMTL, PHONG, DIENTHOAI, NGAYNHANCHUC) VALUES (N'VL', N'Vật lý', N'1976', N'B21', N'0838223223', CAST(N'2003-09-18' AS Date))


--Insert BOMON(MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC)
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'CNTT', N'Công nghệ tri thức', N'B15', N'0838126126', N'CNTT', NULL)
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'HHC', N'Hóa hữu cơ', N'B44', N'838222222', N'HH', NULL)
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'HL', N'Hóa lý', N'B42', N'0838878787', N'HH', NULL)
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'HPT', N'Hóa phân tích', N'B43', N'0838777777', N'HH', CAST(N'2007-10-15' AS Date))
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'HTTT', N'Hệ thống thông tin', N'B13', N'0838125125', N'CNTT', CAST(N'2004-09-20' AS Date))
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'MMT', N'Mạng máy tính', N'B16', N'0838676767', N'CNTT', CAST(N'2005-05-15' AS Date))
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'SH', N'Sinh hóa', N'B33', N'0838898989', N'SH', NULL)
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'VLĐT', N'Vật lý điện tử', N'B23', N'0838234234', N'VL', NULL)
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'VLƯD', N'Vật lý ứng dụng', N'B24', N'0838454545', N'VL', CAST(N'2006-02-18' AS Date))
INSERT INTO BOMON (MABM, TENBM, PHONG, DIENTHOAI, MAKHOA, NGAYNHANCHUC) VALUES (N'VS', N'Vi sinh', N'B32', N'0838909090', N'SH', CAST(N'2007-01-01' AS Date))

--Insert GIAOVIEN
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'001', N'Nguyễn Hoài An', CAST(2000.0 AS Numeric(10, 1)), N'Nam', CAST(N'1973-02-15' AS Date), N'25/3 Lạc Long Quân, Q.10, TP HCM', NULL, N'MMT')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'002', N'Trần Trà Hương', CAST(2500.0 AS Numeric(10, 1)), N'Nữ', CAST(N'1960-06-20' AS Date), N'125 Trần Hưng Đạo, Q.1, TP HCM', NULL, N'HTTT')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'003', N'Nguyễn Ngọc Ánh', CAST(2200.0 AS Numeric(10, 1)), N'Nữ', CAST(N'1975-05-11' AS Date), N'12/21 Võ Văn Ngân Thủ Đức, TP HCM', N'002', N'HTTT')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'004', N'Trương Nam Sơn', CAST(2300.0 AS Numeric(10, 1)), N'Nam', CAST(N'1959-06-20' AS Date), N'215 Lý Thường Kiệt, TP Biên Hòa', NULL, N'VS')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'005', N'Lý Hoàng Hà', CAST(2500.0 AS Numeric(10, 1)), N'Nam', CAST(N'1954-10-23' AS Date), N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM', NULL, N'VLĐT')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'006', N'Trần Bạch Tuyết', CAST(1500.0 AS Numeric(10, 1)), N'Nữ', CAST(N'1980-05-20' AS Date), N'127 Hùng Vương, TP Mỹ Tho', N'004', N'VS')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'007', N'Nguyễn An Trung', CAST(2100.0 AS Numeric(10, 1)), N'Nam', CAST(N'1976-06-05' AS Date), N'234 3/2, TP Biên Hòa', NULL, N'HPT')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'008', N'Trần Trung Hiếu', CAST(1800.0 AS Numeric(10, 1)), N'Nam', CAST(N'1977-08-06' AS Date), N'22/11 Lý Thường Kiệt', N'007', N'HPT')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'009', N'Trần Hoàng Nam', CAST(2000.0 AS Numeric(10, 1)), N'Nam', CAST(N'1975-11-22' AS Date), N'234 Trần Não, An Phú, TP HCM', N'001', N'MMT')
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM) VALUES (N'010', N'Phạm Nam Thanh', CAST(1500.0 AS Numeric(10, 1)), N'Nam', CAST(N'1980-12-12' AS Date), N'221 Hùng Vương, Q.5, TP HCM', N'007', N'HPT')

--Update KHOA(TRUONGKHOA)
UPDATE KHOA SET KHOA.TRUONGKHOA = '002' WHERE KHOA.MAKHOA = 'CNTT'
UPDATE KHOA SET KHOA.TRUONGKHOA = '007' WHERE KHOA.MAKHOA = 'HH'
UPDATE KHOA SET KHOA.TRUONGKHOA = '004' WHERE KHOA.MAKHOA = 'SH'
UPDATE KHOA SET KHOA.TRUONGKHOA = '005' WHERE KHOA.MAKHOA = 'VL'

--Update BOMON(TRUONGBM)
UPDATE BOMON SET BOMON.TRUONGBM = '007' WHERE BOMON.MABM = 'HPT'
UPDATE BOMON SET BOMON.TRUONGBM = '002' WHERE BOMON.MABM = 'HTTT'
UPDATE BOMON SET BOMON.TRUONGBM = '001' WHERE BOMON.MABM = 'MMT'
UPDATE BOMON SET BOMON.TRUONGBM = '005' WHERE BOMON.MABM = 'VLƯD'
UPDATE BOMON SET BOMON.TRUONGBM = '004' WHERE BOMON.MABM = 'VS'

--Insert GV_DT
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'001', N'0838912112')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'001', N'0903123123')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'002', N'0913454545')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'003', N'0838121212')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'003', N'0903656565')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'003', N'0937125125')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'006', N'0937888888')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'008', N'0653717171')
INSERT INTO GV_DT (MAGV, DIENTHOAI) VALUES (N'008', N'0913232323')

--Insert DETAI
INSERT INTO DETAI (MADT, TENDT, CAPQL, KINHPHI, NGAYBD, NGAYKT, MACD, GVCNDT) VALUES (N'001', N'HTTT quản lý các trường ĐH', N'ĐHQG', CAST(20.0 AS Numeric(10, 1)), CAST(N'2004-10-20' AS Date), CAST(N'2008-10-20' AS Date), N'QLGD', N'002')
INSERT INTO DETAI (MADT, TENDT, CAPQL, KINHPHI, NGAYBD, NGAYKT, MACD, GVCNDT) VALUES (N'002', N'HTTT quản lý giáo vụ cho một khoa', N'Trường', CAST(20.0 AS Numeric(10, 1)), CAST(N'2000-10-12' AS Date), CAST(N'2001-10-12' AS Date), N'QLGD', N'002')
INSERT INTO DETAI (MADT, TENDT, CAPQL, KINHPHI, NGAYBD, NGAYKT, MACD, GVCNDT) VALUES (N'003', N'Nghiên cứu chế tạo sợi Nanô Platin', N'ĐHQG', CAST(300.0 AS Numeric(10, 1)), CAST(N'2008-05-15' AS Date), CAST(N'2010-05-15' AS Date), N'NCPT', N'005')
INSERT INTO DETAI (MADT, TENDT, CAPQL, KINHPHI, NGAYBD, NGAYKT, MACD, GVCNDT) VALUES (N'004', N'Tạo vật liệu sinh học bằng màng ối người', N'Nhà nước', CAST(100.0 AS Numeric(10, 1)), CAST(N'2007-01-01' AS Date), CAST(N'2009-12-31' AS Date), N'NCPT', N'004')
INSERT INTO DETAI (MADT, TENDT, CAPQL, KINHPHI, NGAYBD, NGAYKT, MACD, GVCNDT) VALUES (N'005', N'Ứng dụng hóa học xanh', N'Trường', CAST(200.0 AS Numeric(10, 1)), CAST(N'2003-10-10' AS Date), CAST(N'2004-12-10' AS Date), N'ƯDCN', N'007')
INSERT INTO DETAI (MADT, TENDT, CAPQL, KINHPHI, NGAYBD, NGAYKT, MACD, GVCNDT) VALUES (N'006', N'Nghiên cứu tế bào gốc', N'Nhà nước', CAST(4000.0 AS Numeric(10, 1)), CAST(N'2006-10-20' AS Date), CAST(N'2009-10-20' AS Date), N'NCPT', N'004')
INSERT INTO DETAI (MADT, TENDT, CAPQL, KINHPHI, NGAYBD, NGAYKT, MACD, GVCNDT) VALUES (N'007', N'HTTT quản lý thư viện ở các trường đại học', N'Trường', CAST(20.0 AS Numeric(10, 1)), CAST(N'2009-05-10' AS Date), CAST(N'2010-05-10' AS Date), N'QLGD', N'001')

--Insert CONGVIEC
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'001', 1, N'Khởi tạo và Lập kế hoạch', CAST(N'2007-10-20' AS Date), CAST(N'2008-12-20' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'001', 2, N'Xác định yêu cầu', CAST(N'2008-12-21' AS Date), CAST(N'2008-03-21' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'001', 3, N'Phân tích hệ thống', CAST(N'2008-03-22' AS Date), CAST(N'2008-05-22' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'001', 4, N'Thiết kế hệ thống', CAST(N'2008-05-23' AS Date), CAST(N'2008-06-23' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'001', 5, N'Cài đặt thử nghiệm', CAST(N'2008-06-24' AS Date), CAST(N'2008-10-20' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'002', 1, N'Khởi tạo và Lập kế hoạch', CAST(N'2009-05-10' AS Date), CAST(N'2009-07-10' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'002', 2, N'Xác định yêu cầu', CAST(N'2009-07-11' AS Date), CAST(N'2009-10-11' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'002', 3, N'Phân tích hệ thống', CAST(N'2009-10-12' AS Date), CAST(N'2009-12-20' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'002', 4, N'Thiết kế hệ thống', CAST(N'2009-12-21' AS Date), CAST(N'2010-03-22' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'002', 5, N'Cài đặt thử nghiệm', CAST(N'2010-03-23' AS Date), CAST(N'2010-05-10' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'006', 1, N'Lấy mẫu', CAST(N'2006-10-20' AS Date), CAST(N'2007-02-20' AS Date))
INSERT INTO CONGVIEC (MADT, SOTT, TENCV, NGAYBD, NGAYKT) VALUES (N'006', 2, N'Nuôi cấy', CAST(N'2007-02-21' AS Date), CAST(N'2008-08-21' AS Date))

--Insert THAMGIADT
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'001', N'002', 1, CAST(0.0 AS Numeric(5, 1)), NULL)
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'001', N'002', 2, CAST(2.0 AS Numeric(5, 1)), NULL)
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'002', N'001', 4, CAST(2.0 AS Numeric(5, 1)), N'Đạt')
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'003', N'001', 1, CAST(1.0 AS Numeric(5, 1)), N'Đạt')
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'003', N'001', 2, CAST(0.0 AS Numeric(5, 1)), N'Đạt')
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'003', N'001', 4, CAST(1.0 AS Numeric(5, 1)), N'Đạt')
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'003', N'002', 2, CAST(0.0 AS Numeric(5, 1)), NULL)
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'004', N'006', 1, CAST(0.0 AS Numeric(5, 1)), N'Đạt')
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'004', N'006', 2, CAST(1.0 AS Numeric(5, 1)), N'Đạt')
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'006', N'006', 2, CAST(1.5 AS Numeric(5, 1)), N'Đạt')
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'009', N'002', 3, CAST(0.5 AS Numeric(5, 1)), NULL)
INSERT INTO THAMGIADT (MAGV, MADT, STT, PHUCAP, KETQUA) VALUES (N'009', N'002', 4, CAST(1.5 AS Numeric(5, 1)), NULL)

--Insert NGUOITHAN
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'001', N'Hùng', CAST(N'1990-01-14' AS Date), N'Nam')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'001', N'Thủy', CAST(N'1994-12-05' AS Date), N'Nữ')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'003', N'Hà', CAST(N'1997-09-03' AS Date), N'Nữ')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'003', N'Thu', CAST(N'1998-09-03' AS Date), N'Nữ')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'007', N'Mai', CAST(N'2003-03-26' AS Date), N'Nữ')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'007', N'Vy', CAST(N'2000-02-14' AS Date), N'Nữ')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'008', N'Nam', CAST(N'1991-05-06' AS Date), N'Nam')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'009', N'An', CAST(N'1996-08-19' AS Date), N'Nam')
INSERT INTO NGUOITHAN (MAGV, TEN, NGSINH, PHAI) VALUES (N'010', N'Nguyệt', CAST(N'2006-01-14' AS Date), N'Nữ')


