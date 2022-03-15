create database Buoi_1
/*a, Tạo các table */
create table SV
(
	MaSV varchar(30) primary key not null,
	TenSV nvarchar(30),
	Que nvarchar(30)
)
create table MON
(
	MaMH varchar(30) primary key not null,
	TenMH nvarchar(30),
	Sotc nvarchar(30)
)

create table KQ
(
	MaSV varchar(30),
	MaMH varchar(30),
	Diem nvarchar(30),
	CONSTRAINT FK_kq primary key(MaSV,MaMH),
)

alter table KQ add CONSTRAINT FK_kq_sv foreign key(MaSV)
			references SV(MaSV)

alter table KQ add CONSTRAINT FK_kq_mon foreign key(MaMH)
			references MON(MaMH)

/* b, Thêm các ràng buộc*/ 

alter table MON 
add CONSTRAINT chk_MON_Sotc check(Sotc>=2 and Sotc<=5);

alter table MON 
add CONSTRAINT MON_macdinh_Sotc default(3);

alter table MON 
add constraint TenMH_duy_nhat unique(TenMH);

alter table KQ 
add CONSTRAINT chk_KQ_Diem check(Diem>=0 and Diem<=10);

/*c, Nhập dữ liệu*/

insert into SV values
('2020604554',N'Nguyễn Xuân Thắng',N'Thái Bình'),
('2020604553',N'Nguyễn Xuân Thắng',N'Thái Hà'),
('2020604552',N'Nguyễn Xuân Thắng',N'Hà Nội')


insert into MON values
('IT01',N'Toán',5),
('IT02',N'Hóa',4),
('IT03',N'Lý',3)


insert into KQ values
(2020604554,N'IT01',10),
(2020604553,N'IT02',10),
(2020604552,N'IT03',10)

insert into KQ values
(2020604554,N'IT02',10),
(2020604553,N'IT03',10),
(2020604552,N'IT01',10)

select * from SV
select * from MON
select * from KQ
create table XY
(	
	main int
)