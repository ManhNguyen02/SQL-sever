create database baiThucHanh

create table Locations(
	LocationID char(6) PRIMARY KEY,
	Names nvarchar(50) not null,
	Descriptions nvarchar(100)
);

create table Land (
	LandID int primary key identity,
	Title nvarchar(100) not  null,
	LocationID char(6) ,
	Detail nvarchar(1000) ,
	StarDate datetime not null,
	EndDate datetime not null,
	foreign key (LocationID) references Locations(LocationID)
);

create table Building (
	BuildingID  int primary key identity,
	LandID int ,
	BuildingType nvarchar(50),
	Area int Default '50',
	Floors int Default '1',
	Rooms int Default '1'
);


insert into Locations(LocationID, Names, Descriptions ) values	('190089', N'Hà Nội', N'Đất để ở và kinh doanh'),
																('907291', N'Hà Nội', N'Đất để ở và kinh doanh'),
																('429013', N'Hà Nội', N'Đất để ở và kinh doanh');

insert into Land (Title,LocationID,Detail,StarDate,EndDate) values		(N'Lô đất số 1', '190089', N'Mảnh đất đẹp', 2023-05-19, 2024-06-13),
																		(N'Lô đất số 2', '907291', N'Mảnh đất đẹp', 2023-01-25, 2024-05-10),
																		(N'Lô đất số 3', '429013', N'Mảnh đất đẹp', 2023-06-29, 2024-02-25);
																		select * from Land
insert into Building(LandID, BuildingType, Area, Floors,Rooms) values	(2, N'Nhà dân', 50, 1, 1),
																		(3, N'Nhà dân', 50, 1, 1),
																		(4, N'Nhà dân', 50, 1, 1);

select * from Building where Area > 100;

select * from Land where EndDate < 2013-01;

select * from Locations where Names = 'MyDinh';

create view v_Buildings as
select BuildingID, Title, Names, BuildingType, Area, Floors 
from Building b
inner join Land l on l.LandID = b.LandID
inner join Locations lt on lt.LocationID = l.LocationID;

create view v_TopBuildings as 
select *
from Building ;

select *from v_TopBuildings