/*a,*/
create table CongTy
(
	MaCT varchar(30) primary key not null,
	TenCT nvarchar(30),
	TrangThai char(30),
	ThanhPho nvarchar(30)
)
create table SanPham
(
	MaSP varchar(30) primary key not null,
	TenSP nvarchar(30),
	MauSac char(10),
	Gia float(30),
	SoLuongCo int
)

create table CungUng
(
	MaCT varchar(30) not null,
	MaSP varchar(30),
	SoLuongBan int,
	CONSTRAINT FK_cu primary key(MaCT,MaSP),
)

alter table CungUng add CONSTRAINT FK_cu_sp foreign key(MaSP)
			references SanPham(MaSP)

alter table CungUng add CONSTRAINT FK_cu_cty foreign key(MaCT)
			references CongTy(MaCT)
/*b, ràng buộc*/
alter table SanPham
add constraint mau_md default(MauSac = N'đỏ')

alter table SanPham 
add constraint TenSP_duy_nhat unique(TenSP);

alter table CungUng 
add constraint slb check(SoLuongBan > 0)

/*c,add values*/
insert into CongTy values
('ct01',N'Nguyễn Xuân Thắng company','hd','HaNoi'),
('ct02',N'Nguyễn Xuân Thắng company','hd','HaNam'),
('ct03',N'Nguyễn Xuân Thắng company','hd','TpHoChiMinh')

insert into SanPham values
('sp01','kem','Trang',3000,100),
('sp02','ao','xanh',100000,7),
('sp03','sach','do',5000,20)

insert into CungUng values
('ct01','sp01',1),
('ct02','sp01',2),
('ct03','sp01',3)

insert into CungUng values
('ct01','sp02',1),
('ct02','sp02',2),
('ct03','sp02',3)

select * from CongTy;
select * from SanPham;
select * from CungUng;
select * from SanPham
	inner join CungUng on SanPham.MaSP = CungUng.MaSP





