create database BAITAP2
GO

USE BAITAP2
GO

CREATE TABLE DichVu(
LoaiDichVu char(20) not null primary key,
MucPhi int,
NgayBatDau date,
NgayKetThuc date
)
insert into DichVu values('1',2000000,'2015/11/20','12/10/2022')
insert into DichVu values('2',1000000,'7/2/2021','7/3/2022')
insert into DichVu values('3',1000000,'2/11/2021','2/12/2022')
insert into DichVu values('4',1300000,'4/5/2021','12/6/2022')
insert into DichVu values('5',1100000,'10/3/2021','12/4/2022')

CREATE TABLE QuanLiDichVu(
MaDichVu char(10) not null primary key,
TenDichVu char(10),
MieuTaDichVu varchar(50)
)
insert into QuanLiDichVu values('T213','Thue Xe 1','Thuê xe 4 chỗ')
insert into QuanLiDichVu values('T214','Thue Xe 2','Thuê xe 6 chỗ')
insert into QuanLiDichVu values('T215','Thue Xe 3','Thuê xe 8 chỗ')
insert into QuanLiDichVu values('T216','Thue Xe 4','Thuê xe 12 chỗ')
insert into QuanLiDichVu values('T217','Thue Xe 5','Thuê xe 20 chỗ')

CREATE TABLE HopDongChiTiet (
SoHopDong int not null primary key,
BienSoXe char(10),
LoaiXe char(10),
SoChoNgoi int,
HangXe char(10)
)
INSERT INTO HopDongChiTiet values (15,'N92D','Wigo',4,'Toyota')
INSERT INTO HopDongChiTiet values (8,'N347Y1','Giulia',5,'Alfa Romeo')
INSERT INTO HopDongChiTiet values (5,'G3J93','Compass',5,'Jeep')
INSERT INTO HopDongChiTiet values (19,'J37X92','Lux SA2.0',7,'Vinfast')
INSERT INTO HopDongChiTiet values (61,'M367BZ','3 Series',5,'Cerato') 
INSERT INTO HopDongChiTiet values (43,'S13B83','Ecosport',5,'Hiace')

CREATE TABLE QuanLiMucPhi(
MaMucPhi int not null primary key,
LoaiMucPhi char(20),
SoTien int
)

insert into QuanLiMucPhi values(1,'Mức phí 1',15)
insert into QuanLiMucPhi values(2,'Mức phí 2',20)
insert into QuanLiMucPhi values(3,'Mức phí 3',25)
insert into QuanLiMucPhi values(4,'Mức phí 4',30)
insert into QuanLiMucPhi values(5,'Mức phí 5',35)

CREATE TABLE DichVuChiTiet(
MaChiTiet int not null primary key,
MaDichVu char(10),
LoaiDichVu char(20)
constraint fk_DichVuChiTiet_DichVu Foreign key(LoaiDichVu) REFERENCES DichVu(LoaiDichVu),
constraint fk_DichVuChiTiet_QuanLiDichVu Foreign key(MaDichVu) REFERENCES QuanLiDichVu(MaDichVu)
)

insert into DichVuChiTiet values(1,'T213','1')
insert into DichVuChiTiet values(2,'T214','2')
insert into DichVuChiTiet values(3,'T215','3')
insert into DichVuChiTiet values(4,'T216','4')
insert into DichVuChiTiet values(5,'T217','5')

CREATE TABLE QuanLiChiPhi(
MaQuanLi int not null primary key,
SoHopDong int,
MaMucPhi int
constraint fk_QuanLiChiPhi_HopDongChiTiet Foreign key(SoHopDong) REFERENCES HopDongChiTiet(SoHopDong),
constraint fk_QuanLiChiPhi_QuanLiMucPhi Foreign key(MaMucPhi) REFERENCES QuanLiMucPhi(MaMucPhi)
)
insert into QuanLiChiPhi values(10,15,1)
insert into QuanLiChiPhi values(11,5,2)
insert into QuanLiChiPhi values(12,19,3)
insert into QuanLiChiPhi values(13,61,4)
insert into QuanLiChiPhi values(14,null,null)

CREATE TABLE MaNhaCungCap(
MaNhaCungCap int primary key not null,
Ten char(20),
DiaChi char(20),
MaSoThue char(15),
sdt int
)

insert into MaNhaCungCap values(2110,'Quan','Ha Long','BX370',012345667)
insert into MaNhaCungCap values(2111,'Thang','Cao Bang','BX371',017345667)
insert into MaNhaCungCap values(2112,'Minh','Dien Bien','BX372',016345667)
insert into MaNhaCungCap values(2113,'Thanh','Mong Cai','BX373',012545667)
insert into MaNhaCungCap values(2114,'Tuan Anh','lang Son','BX374',014345667)
insert into MaNhaCungCap values(2115,'Linh','Ha Noi','BX375',013345667)

CREATE TABLE HopDong(
MaQuanLi int,
MaChiTiet int,
MaNhaCungCap int
constraint fk_HopDong_MaNhaCungCap Foreign key(MaNhaCungCap) REFERENCES MaNhaCungCap(MaNhaCungCap),
constraint fk_HopDong_QuanLiChiPhi Foreign key(MaQuanLi) REFERENCES QuanLiChiPhi(MaQuanLi),
constraint fk_HopDong_DichVuChiTiet Foreign key(MaChiTiet) REFERENCES DichVuChiTiet(MaChiTiet),
)

insert into HopDong values(10,1,2110)
insert into HopDong values(11,2,2111)
insert into HopDong values(12,3,2112)
insert into HopDong values(13,4,2113)
insert into HopDong values(14,5,2114)

--cau 3 Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ   (DONE)
select * from HopDongChiTiet
where HopDongChiTiet.SoChoNgoi > 5

--cau 4  Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe     (DONE)
--       thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
--       thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km
select MaNhaCungCap.MaNhaCungCap,Ten,sdt,MaSoThue,DiaChi from MaNhaCungCap 
join HopDong on MaNhaCungCap.MaNhaCungCap = HopDong.MaNhaCungCap
join QuanLiChiPhi on HopDong.MaQuanLi = QuanLiChiPhi.MaQuanLi
join HopDongChiTiet on QuanLiChiPhi.SoHopDong = HopDongChiTiet.SoHopDong
join QuanLiMucPhi on QuanLiChiPhi.MaMucPhi = QuanLiMucPhi.MaMucPhi
where HopDongChiTiet.HangXe = 'Toyota' and QuanLiMucPhi.SoTien = 15 or HopDongChiTiet.HangXe = 'KIA' and QuanLiMucPhi.SoTien = 20

--cau 5 Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung   (DONE)
--      cấp và giảm dần theo mã số thuế
select MaNhaCungCap.MaNhaCungCap,Ten,sdt,MaSoThue,DiaChi from MaNhaCungCap
order by MaNhaCungCap.ten ASC,MaNhaCungCap.MaSoThue DESC

--cau 6  Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
--       yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu  (DONE)
--       cung cấp là “20/11/2015”
select Ten,count(SoHopDong) as "Số Lượng" from MaNhaCungCap 
join HopDong on MaNhaCungCap.MaNhaCungCap = HopDong.MaNhaCungCap
join DichVuChiTiet on HopDong.MaChiTiet = DichVuChiTiet.MaChiTiet
join DichVu on DichVuChiTiet.LoaiDichVu = DichVu.LoaiDichVu
join QuanLiChiPhi on HopDong.MaQuanLi = QuanLiChiPhi.MaQuanLi
where DichVu.NgayBatDau = '2015/11/20'
group by Ten


-- Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe  (DONE)
-- chỉ được liệt kê một lần
select distinct(hangXe),SoHopDong,BienSoXe,LoaiXe,SoChoNgoi from HopDongChiTiet

-- câu 8 Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia,
-- HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp phương
-- tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương (DONE)
-- tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra
select distinct MaNhaCungCap.MaNhaCungCap,DiaChi,MaSoThue from MaNhaCungCap
join HopDong on MaNhaCungCap.MaNhaCungCap = HopDong.MaNhaCungCap
join QuanLiChiPhi on HopDong.MaQuanLi = QuanLiChiPhi.MaQuanLi


-- câu 9 Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
-- thuộc dòng xe “Hiace” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Cerato”  (DONE)
select distinct MaNhaCungCap.MaNhaCungCap,DiaChi,MaSoThue,HopDongChiTiet.hangXe from MaNhaCungCap
join HopDong on MaNhaCungCap.MaNhaCungCap = HopDong.MaNhaCungCap
join QuanLiChiPhi on HopDong.MaQuanLi = QuanLiChiPhi.MaQuanLi
join HopDongChiTiet on QuanLiChiPhi.SoHopDong = HopDongChiTiet.SoHopDong
where HopDongChiTiet.hangXe = 'Hiace' or HopDongChiTiet.hangXe = 'Cerato'

-- câu 10 Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp  (DONE)
-- phương tiện lần nào cả.
select distinct MaNhaCungCap.MaNhaCungCap,DiaChi,MaSoThue from MaNhaCungCap
join HopDong on MaNhaCungCap.MaNhaCungCap = HopDong.MaNhaCungCap
join QuanLiChiPhi on HopDong.MaQuanLi = QuanLiChiPhi.MaQuanLi
where QuanLiChiPhi.MaMucPhi is null and QuanLiChiPhi.SoHopDong is null