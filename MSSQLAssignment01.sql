create database MSSQLAssignment01 ;


create table khachHang(
	KID int primary key identity,
	ten nvarchar(255),
	tuoi int,
	sdt char(20),
	diaChi nvarchar(255),
);

create table donHang(
	DID int primary key identity,
	tongTien money,
	ngayMua date,
	KID int,
	foreign key (KID) references khachHang(KID),
);

create table danhSachSanPham(
	SPID int primary key identity,
	tenSP nvarchar(255),
	moTaSP nvarchar(255),
	giaSanPham money
);

create table chiTietDonHang(
	CTID int primary key identity,
	donVi nvarchar(50),
	gia money,
	soLuong int,
	thanhTien money,
	SPID int, 
	DID int,
	foreign key(SPID) references danhSachSanPham(SPID),
	foreign key(DID) references donHang(DID)
);



insert into khachHang (ten,tuoi,sdt,diaChi) values ('Nguyễn Văn An','41','987654321','111 Nguyễn Trãi, Thanh Xuân, Hà Nội');
insert into khachHang (ten,tuoi,sdt,diaChi) values ('Nguyễn Văn Bình','45','123456789','234 Quang Trung, Hà Đông, Hà Nội');

insert into donHang (tongTien,KID) values ('1500',1);
insert into donHang (tongTien,KID) values ('2000',2);

UPDATE donHang
SET ngayMua = '2023-05-20'
WHERE DID = 4;

insert into danhSachSanPham (tenSP,motaSP,giaSanPham) values ('Máy tính T450','Máy nhập mới','1000');
insert into danhSachSanPham (tenSP,motaSP,giaSanPham) values ('Điện thoại Nokkia5670','Điện thoại đang hot','200');
insert into danhSachSanPham (tenSP,motaSP,giaSanPham) values ('Máy in SamSung','Máy in đang ế','100');

insert into chiTietDonHang (donVi,gia,soLuong,thanhTien,SPID,DID) values('Chiếc','1000','1','1000',1,1);
insert into chiTietDonHang (donVi,gia,soLuong,thanhTien,SPID,DID) values('Chiếc','200','2','400',1,1);
insert into chiTietDonHang (donVi,gia,soLuong,thanhTien,SPID,DID) values('Chiếc','100','1','100',1,1);


ALTER TABLE khachHang
ADD DID INT,
FOREIGN KEY (DID)
REFERENCES donHang (DID);


select * from khachHang;

select * from danhSachSanPham;

select * from donHang;


select * from khachHang 
order by ten ASC;

select * from danhSachSanPham
order by SPID DESC;

select ten from khachHang
join danhSachSanPham on khachHang.KID = danhSachSanPham.SPID
where khachHang.KID = '1' or danhSachSanPham.SPID = '1'

SELECT sp.tenSP, sp.motaSP, sp.giaSanPham
FROM khachHang kh
JOIN donHang dh ON kh.KID = dh.KID
JOIN chiTietDonHang ctdh ON dh.DID = ctdh.DID
JOIN danhSachSanPham sp ON ctdh.SPID = sp.SPID
WHERE kh.ten = 'Nguyễn Văn An';

select DID, ten, tuoi, sdt, diaChi  
from donHang d
join khachHang k on d.KID = k.KID;

select SPID, tenSP, moTaSP, giaSanPham 
from danhSachSanPham;

select DID, tongTien
from khachHang k
join donHang d on d.KID = k.KID;


update danhSachSanPham 
set giaSanPham = '200'
where SPID = '3';

update danhSachSanPham 
set giaSanPham = '400'
where SPID = '2';

update danhSachSanPham 
set giaSanPham = '4000'
where SPID = '1';

select * from danhSachSanPham


select * from chiTietDonHang

UPDATE donHang
SET ngayMua = '2023-05-01'
WHERE DID = 3;

UPDATE donHang
SET ngayMua = '2023-05-02'
WHERE DID = 4;

alter table danhSachSanPham
add ngayraMat date

CREATE INDEX tenSP
ON danhSachSanPham (tenSP);

create index tenKH
on khachHang (ten);

create view View_KhachHang as 
select  ten, diaChi, sdt
from khachHang;

create view  View_SanPham as
select tenSP, giaSanpham
from danhSachSanPham;

create view View_KhachHang_SanPham as
select  ten, sdt, tenSP, soLuong, ngayMua
FROM khachHang k
INNER JOIN donHang d ON k.KID = d.KID
INNER JOIN chiTietDonHang ct ON d.DID = ct.CTID
INNER JOIN danhSachSanPham dssp on ct.CTID = dssp.SPID ;

create procedure SP_TimKH_MaKH(@KID int)
as
begin
select * from khachHang
where KID = @KID
end


create procedure  SP_TimKH_MaHD(@DID int)
as
begin
select * from khachHang
where DID = @DID
end

exec SP_TimKH_MaKH @KID = 1

create procedure SP_SanPham_MaKH (@KID int, @SPID int)
as
begin
select k.ten, sp.tenSP
from khachHang k
inner join danhSachSanPham sp on k.KID = sp.SPID
where k.KID = @KID
end

exec SP_SanPham_MaKH @KID = 1,@SPID = 3
