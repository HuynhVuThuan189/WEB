create database FivemenCoffee;

 use FivemenCoffee;

 	create table TAIKHOAN (
		MaTK int IDENTITY(1,1) PRIMARY KEY,
		SoDienThoai char(10),
		MatKhau varchar(20),
		RoleID int
	);

	create table NHANVIEN (
		MaNV int IDENTITY(1,1) PRIMARY KEY,
		TenNV nvarchar(50) NOT NULL,
		SoDienThoai char(10) NOT NULL,
		NgaySinh Date,
		GioiTinh char(3),
		DiaChi char(50) NOT NULL,
		NgayVaoLam Date NOT NULL,
		ChucVu char(25) NOT NULL
	);

	create table VOUCHER (
		MaVoucher INT IDENTITY(1,1) PRIMARY KEY,
		TenVoucher nvarchar(40) NOT NULL,
		TiLeGiamGia float NOT NULL,
		NgayBatDau Date NOT NULL,
		NgayKetThuc Date NOT NULL
	);

	create table DANHMUCSP (
		MaDanhMuc int IDENTITY(1,1) PRIMARY KEY,
		TenDanhMuc nvarchar(50) NoT NULL,
		MoTa nvarchar(200)
	);

	create table SANPHAM (
		MaSP int IDENTITY(1,1) PRIMARY KEY,
		TenSP nvarchar(50) NOT NULL,
		GiaTien Money,
		SoLuong int NOT NULL,
		MaDanhMuc int NOT NULL,
		MoTa nvarchar(200),
		MaNCC int NOT NULL
	);

	create table KHACHHANG (
		MaKH int IDENTITY(1,1) PRIMARY KEY,
		TenKH nvarchar(50) NOT NULL,
		SoDienThoai char(10) NOT NULL,
		NgaySinh Date,
		GioiTinh char(10),
		DiaChi char(50) NOT NULL,
		LoaiKH char(50) NOT NULL
	);

	create table DONDATHANG (
		MaDDH int IDENTITY(1,1) PRIMARY KEY,
		MaKH int NOT NULL,
		MaVoucher int,
		TongDonHang money,
		SoTienGiam money,
		ThanhTien money,
		MaNV int,
		NgayDatHang Date,
		MaNVC int
	);

	create table CTDH (
		MaDDH int NOT NULL,
		MaSP int NOT NULL,
		SoLuong int NOT NULL,
		GiaTien Money
	);

	create table HINHANH (
		MaHinhAnh int IDENTITY(1,1) PRIMARY KEY,
		LinkHinhAnh varchar(200),
		MaSP int
	);

	create table NHAVANCHUYEN (
		MaNVC int IDENTITY(1,1) primary key,
		TenNVC nvarchar (200),
		DiaChi nvarchar(200) ,
		Email nvarchar(200) 
	);

	create table NHACUNGCAP (
		MaNCC int IDENTITY(1,1) PRIMARY KEY,
		TenNCC nvarchar(200) NOT NULL,
		DiaChi nvarchar(200) ,
		Email nvarchar(200) 
	);

	create table ROLES (
		RoleID int IDENTITY(1,1) primary key,
		RoleName nvarchar (50),
		MoTa nvarchar(200) 
	);

	-----------------

--Bảng tài khoản--
ALTER TABLE TAIKHOAN ADD CONSTRAINT FK_TAIKHOAN FOREIGN KEY (RoleID) REFERENCES Role(RoleID);
--Bảng đơn đặt hàng--
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_VOUCHER FOREIGN KEY (MaVoucher) REFERENCES VOUCHER(MaVoucher);
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_NHAVANCHUYEN FOREIGN KEY (MaNVC) REFERENCES NHAVANCHUYEN(MaNVC);
--Bảng chi tiết đặt hàng--
ALTER TABLE CTDH ADD CONSTRAINT FK_DONDATHANG FOREIGN KEY (MaDDH) REFERENCES DONDATHANG(MaDDH);
--Bảng sản phẩm--
ALTER TABLE SANPHAM ADD CONSTRAINT FK_DANHMUCSP FOREIGN KEY (MaDanhMuc) REFERENCES DANHMUCSP(MaDanhMuc);
ALTER TABLE SANPHAM ADD CONSTRAINT FK_NHACUNGCAP FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC);
--Bảng hình ảnh--
ALTER TABLE HINHANH ADD CONSTRAINT FK_SANPHAM FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP);

	-----------------

--------------------------------------DATA BẢNG ROLES--------------------------------
insert into Roles(RoleName,MoTa) values( N'Người dùng', N'Có chức năng mua các sản phẩm và thao tác trên trang web');
insert into Roles(RoleName,MoTa) values( N'Quản trị viên', N'Thay đổi và kiểm soát các thông tin chi tiết của cửa hàng');

------------------------------------DATA BẢNG TÀI KHOẢN-----------------------------
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0343988242','FivemenCoffee',1);
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0962534995','FivemenCoffee',1);
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0786667333','FivemenCoffee',1);
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0567779900','FivemenCoffee',2);
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0366789012','FivemenCoffee',2);
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0995551673','FivemenCoffee',2);
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0705620098','FivemenCoffee',2);
insert into TAIKHOAN(SoDienThoai,MatKhau,RoleID) values('0375665412','21042002',2);

-----------------------------------DATA BẢNG NHÂN VIÊN------------------------------
insert into NHANVIEN(TenNV, SoDienThoai, NgaySinh, GioiTinh, DiaChi, NgayVaoLam, ChucVu) values (N'Trần Văn Quang','0375665412','2002-04-21','Nam','Đak Lak','2022-11-20','Quan tri vien');
insert into NHANVIEN(TenNV, SoDienThoai, NgaySinh, GioiTinh, DiaChi, NgayVaoLam, ChucVu) values (N'Lê Công Thành','0990221112','2002-01-07','Nam','Lam Đong','2022-11-20','Quan tri vien');
insert into NHANVIEN(TenNV, SoDienThoai, NgaySinh, GioiTinh, DiaChi, NgayVaoLam, ChucVu) values (N'Nguyễn Hoàng Nhật','0770033111','2002-09-09','Nam','Tien Giang','2022-11-20','Quan tri vien');
insert into NHANVIEN(TenNV, SoDienThoai, NgaySinh, GioiTinh, DiaChi, NgayVaoLam, ChucVu) values (N'Võ Hoàng Phúc','0522141338','2002-04-13','Nam','Ben Tre','2022-11-25','Quan tri vien');
insert into NHANVIEN(TenNV, SoDienThoai, NgaySinh, GioiTinh, DiaChi, NgayVaoLam, ChucVu) values (N'Nguyễn Hữu Thắng','0776254420','2001-12-05','Nam','Binh Đinh','2022-11-25','Quan tri vieng');

-----------------------------------DATA BẢNG VOUCHER----------------------------------
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Siêu sale 6/6',0.2,'2022-06-06','2022-06-08');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Siêu sale 7/7',0.2,'2022-07-07','2022-07-10');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Siêu sale 8/8',0.2,'2022-08-08','2022-08-11');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Siêu sale 9/9',0.2,'2022-09-09','2022-09-12');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Siêu sale 10/10',0.2,'2022-10-10','2022-10-13');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Siêu sale 11/11',0.2,'2022-11-11','2022-11-14');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Siêu sale 12/12',0.2,'2022-12-12','2022-12-15');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Black Friday 2022',0.4,'2022-11-25','2022-11-26');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Voucher giảm giá 20%',0.2,'2022-06-01','2021-12-30');
insert into VOUCHER(TenVoucher, TiLeGiamGia, NgayBatDau, NgayKetThuc) values(N'Không giảm giá',0,'2022-06-12','2023-03-19');


-----------------------------------DATA BẢNG DANH MỤC SẢN PHẨM-----------------
insert into DANHMUCSP(TenDanhMuc,MoTa) values (N'Hạt cà phê',N'Hạt cà phê chất lượng cao');
insert into DANHMUCSP(TenDanhMuc,MoTa) values (N'Cà phê rang',N'cà phê hạt rang theo công thức gia truyền đặc biệt Fivemen');
insert into DANHMUCSP(TenDanhMuc,MoTa) values (N'Cà phê rang xay',N'Cà phê rang xay nguyên chất');
insert into DANHMUCSP(TenDanhMuc,MoTa) values (N'Cốt cà phê',N'Cốt cà phê được Fivemen chế biến sẵn');
insert into DANHMUCSP(TenDanhMuc,MoTa) values (N'Cà phê Fivemen',N'Cà phê Five men độc quyền');
insert into DANHMUCSP(TenDanhMuc,MoTa) values (N'Cà phê rang xay trộn',N'Cà phê rang xay trộn mang đến hương vị đặc biệt hơn');

-----------------------------------DATA BẢNG NHÀ CUNG CẤP-----------------------------------------------------------
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Fivemen Coffee',N'KP 6, P. Linh Trung, TP. Thủ Đức, TP. Hồ Chí Minh',N'coffee@petecof.vn');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Tập đoàn Cà phê Trung Nguyên',N'Bến Thành, Quận 1, Thành phố Hồ Chí Minhh',N'cs@trungnguyenlegend.com');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Công ty Cổ phần Vinacafe Biên Hòa',N'Phường An Bình, Thành phố Biên Hòa, tỉnh Đồng Nai',N'vinacafe@vinacafebienhoa.com');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Công ty TNHH Nestle Việt Nam',N'Phường Đa Kao, Quận 1, Tp.Hồ Chí Minh',N'consumer.services@vn.nestle.com');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Công ty TNHH Cà phê Ngon Việt Nam',N'Xã ĐrayBHăng, H. CuKuin, Đắc Lắc',N'cafengon@gmail.com');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Tập đoàn Cà phê An Thái',N'Vườn Lài, Q.Tân Phú, Tp.HCM',N'info@anthaigroup.vn');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'King Coffee',N'Buôn Mê Thuột, Đăk Lăk',N'hello@tnicorporation.com');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Highlands Coffee',N'Quận 1, Hồ Chí Minh',N'customerservice@highlandscoffee.com.vn');
insert into NHACUNGCAP(TenNCC,DiaChi,Email) values (N'Công ty cổ phần Cà phê PETEC',N'Phường Võ Thị Sáu, Quận 3, TP. Hồ Chí Minh',N'coffee@petecof.vn');

----------------------------------DATA BẢNG SẢN PHẨM-------------------------------------------
insert into sanpham(TenSP,GiaTien,SoLuong,MaDanhMuc,MoTa,MaNCC) values (N'Hạt cà phê Robusta 1kg',65000,10000,1,N'Hạt cà phê Robusta chất lượng cao, đơn vị kg',2);
insert into sanpham(TenSP,GiaTien,SoLuong,MaDanhMuc,MoTa,MaNCC) values (N'Hạt cà phê Robusta rang 1kg',85000,5000,2,N'Hạt cà phê Robusta rang chất lượng cao, đơn vị kg',1);
insert into sanpham(TenSP,GiaTien,SoLuong,MaDanhMuc,MoTa,MaNCC) values (N'Cà phê Robusta rang xay, 1kg',120000,5000,3,N'Cà phê Robusta rang xay chất lượng cao, đơn vị kg',1); 
insert into sanpham(TenSP,GiaTien,SoLuong,MaDanhMuc,MoTa,MaNCC) values (N'Cốt cà phê Robusta nguyên chất, 100ml',20000,10000,4,N'Cốt cà phê Robusta nguyên chất được Fivemen chế biến mỗi ngày, đơn vị ml',1); 

---------------------------------DATA BẢNG KHÁCH HÀNG-------------------------------------------------------------
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thị Lan Hương','0775432880','1999-03-07','Nu','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lâm Quốc Thái','0965234110','2000-10-21','Nam','Ha Noi','Bac');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thị Thu','0522089743','1989-01-20','Nu','Binh Duong','Bac');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thị Hương Thảo','0356971253','2003-12-09','Nu','Ha Tinh','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Hữu Nhật Tân','0786672110','1998-09-25','Nam','An Giang','Bac');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Phạm Gia Lộc','0965623689','2003-03-16','Nam','Long An','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Trịnh Thảo My','0304994467','1999-12-07','Nu','Ca Mau','Bac');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thị Thanh Hân','0722514482','1990-02-18','Nu','TPHCM','Vang');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Quốc Trưởng','0977541105','1992-04-19','Nam','Ha Noi','Vang');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thị Minh Thu','0972713345','1980-12-21','Nu','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Kim Phụng','0798800453','2000-12-06','Nu','Kien Giang','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Vũ Thái Hòa','0977754230','1990-07-01','Nam','Lam Dong','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trần Thị Thanh Vân','0567843398','1999-10-02','Nu','Nghe An','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Phan Thị Yến Nhi','0568987650','2001-05-16','Nu','Phu Tho','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Hải Đăng','0343876555','1996-03-17','Nam','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Minh Tiến','0722219632','1998-04-20','Nam','Ha Noi','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trần Hoàng Khang','0563488642','2000-07-12','Nam','Dong Nai','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trần Mai Thùy Trang','0763987600','1992-08-14','Nu','Quang Ngai','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Ngọc Như Quỳnh','0544789987','2001-10-05','Nu','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thu Thảo','0544789761','2001-12-06','Nu','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Phước Thiên','0544766587','2000-01-07','Nam','Dong Nai','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Duy','0334567988','1999-10-12','Nam','Long An','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Ngọc Vy','0775345987','2001-11-13','Nu','Lang Son','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Thanh Tú','0346876003','1998-07-28','Nu','Ha Noi','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trần Nguyễn Thanh Tú','0234876559','2000-04-18','Nu','Ha Noi','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Hưng','0500085478','2000-11-05','Nam','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Chính Tuệ','0234446761','1997-06-24','Nam','Ben Tre','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Phùng Các Các','0875098092','2001-08-26','Nu','Tien Giang','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thị Yến Linh','0789909094','2000-09-17','Nu','Long An','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Quốc Khải','0798898555','1990-02-09','Nam','Ha Noi','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trịnh Thị Thu Hà','0257963354','1998-01-10','Nu','Dong Nai','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thị Khánh Hà','0423356925','1997-11-11','Nu','Khanh Hoa','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Duy Hưng','0222549830','2001-10-28','Nam','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Minh Phát','0532561984','2000-12-27','Nam','Ninh Thuan','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Quốc Hữu Duy','0365240118','1994-09-26','Nam','Binh Thuan','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Thị Kim','0254632002','1992-08-25','Nu','Binh Duong','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thúy Nga','0563299807','1993-06-24','Nu','Binh Phuoc','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trần Trung Hiếu','0595720348','1995-06-23','Nam','Nam Dinh','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trần Ngọc Minh Anh','0620125497','1996-06-22','Nu','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Thị Thúy An','0359668211','2000-03-05','Nu','Quy Nhon','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Ngọc Thùy Anh','0589246785','2001-04-06','Nu','Phu Yen','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Minh Huy','0798523123','2002-05-12','Nam','Dong Thap','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Trần Kim Sang','0953124624','1999-06-14','Nam','An Giang','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Quốc Thịnh','0932568879','1998-07-15','Nam','Tay Ninh','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Tạ Tấn Hoàng','0956238700','1989-08-16','Nam','Ca Mau','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Bùi Minh Trung Trực','0585628812','1997-09-17','Nam','Long An','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Nguyễn Thanh Lam','0523259727','2001-10-18','Nu','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Võ Trọng Danh','0785213644','1996-12-19','Nam','TPHCM','Dong');
insert into KHACHHANG(TenKH,SoDienThoai,NgaySinh,GioiTinh,DiaChi,LoaiKH) values (N'Lê Kim Tiền','0586982871','1995-11-21','Nu','Ha Noi','Dong');

-----------------------------------DATA BẢNG NHÀ VẬN CHUYỂN---------------------------------------------------------
insert into NHAVANCHUYEN (TenNVC,DiaChi,Email)values(N'VN Post',N'Tp.Hồ Chí Minh',N'vietnampost@gmail.com')
insert into NHAVANCHUYEN (TenNVC,DiaChi,Email)values(N'Giao hàng nhanh-GHN',N'Tp. Hồ Chí Minh',N'giaohangnhanhviennam@gmail.com')
insert into NHAVANCHUYEN (TenNVC,DiaChi,Email)values(N'Giao hàng tiết kiệm-GHTK',N'TP. Hồ Chí Minh',N'giaohangtietkiem@gmail.com')
insert into NHAVANCHUYEN (TenNVC,DiaChi,Email)values(N'J&T Express',N'TP. Hồ Chí Minh',N'jtexpress@gmail.com')
insert into NHAVANCHUYEN (TenNVC,DiaChi,Email)values(N'Viettel Post',N'TP. Hồ Chí Minh',N'viettelpost@gmail.com')
insert into NHAVANCHUYEN (TenNVC,DiaChi,Email)values(N'Shipchung',N'TP. Hồ Chí Minh',N'shipchungvn@gmail.com')

----------------------------------DATA BẢNG ĐƠN ĐẶT HÀNG-----------------------------------------------------------
insert into DONDATHANG(MaKH,MaVoucher,TongDonHang,SoTienGiam,ThanhTien,MaNV,NgayDatHang,MaNVC) values (1,9,240000,0,240000,1,'2022-10-22',1);
insert into DONDATHANG(MaKH,MaVoucher,TongDonHang,SoTienGiam,ThanhTien,MaNV,NgayDatHang,MaNVC) values (2,9,65000,0,65000,1,'2022-10-23',2);
insert into DONDATHANG(MaKH,MaVoucher,TongDonHang,SoTienGiam,ThanhTien,MaNV,NgayDatHang,MaNVC) values (3,9,85000,0,85000,1,'2022-10-24',2);
insert into DONDATHANG(MaKH,MaVoucher,TongDonHang,SoTienGiam,ThanhTien,MaNV,NgayDatHang,MaNVC) values (5,9,140000,0,140000,1,'2022-10-24',2);
insert into DONDATHANG(MaKH,MaVoucher,TongDonHang,SoTienGiam,ThanhTien,MaNV,NgayDatHang,MaNVC) values (6,9,20000,0,20000,1,'2022-10-24',3);

-----------------------------------DATA BẢNG CHI TIẾT ĐƠN HÀNGG-----------------------------------------------------
insert into CTDH(MaDDH,MaSP,SoLuong,GiaTien)values(1,3,2,120000);
insert into CTDH(MaDDH,MaSP,SoLuong,GiaTien)values(2,1,1,65000);
insert into CTDH(MaDDH,MaSP,SoLuong,GiaTien)values(3,2,1,85000);
insert into CTDH(MaDDH,MaSP,SoLuong,GiaTien)values(4,3,1,120000);
insert into CTDH(MaDDH,MaSP,SoLuong,GiaTien)values(4,4,1,20000);
insert into CTDH(MaDDH,MaSP,SoLuong,GiaTien)values(5,4,1,20000);

---------------------------------DATA BẢNG HÌNH ẢNH------------------------------------------------------------__
insert into HINHANH(LinkHinhAnh, MaSP) values('https://product.hstatic.net/200000309869/product/banner_tmdt-20_c6c0f7ee20cf4b0b9041fefb9d9877cc_master.png',1);
insert into HINHANH(LinkHinhAnh, MaSP) values('https://product.hstatic.net/200000309869/product/banner_tmdt-02_3439a0e21ae44af9a31efaad9c72ec69_master.png',2);
insert into HINHANH(LinkHinhAnh, MaSP) values('https://product.hstatic.net/200000309869/product/pha_phin_truyen_thong_1_aec76f2bd76049f780928fa9fc8ec4c2_1024x1024.png',3);
insert into HINHANH(LinkHinhAnh, MaSP) values('https://product.hstatic.net/200000309869/product/ca_phe_den_dong_chai_100ml_1_3302d233d8dd4c688de08b6aa820e3fd_1024x1024.png',4);
