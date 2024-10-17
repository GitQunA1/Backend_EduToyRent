

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'EduToyRent')
BEGIN
    USE master;
    ALTER DATABASE EduToyRent SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EduToyRent;
END

CREATE DATABASE EduToyRent;
GO

USE EduToyRent;
GO

CREATE TABLE [User] (
  [UID] integer PRIMARY KEY IDENTITY(1, 1),
  [Email] nvarchar(255),
  [Phone] nvarchar(255),
  [Username] nvarchar(255),
  [Password] nvarchar(255),
  [Role] nvarchar(255) CHECK (role IN ('ROLE_CUSTOMER', 'ROLE_OWNER', 'ROLE_STAFF'))
)
GO

CREATE TABLE [Customer] (
  [CID] integer PRIMARY KEY IDENTITY(1, 1),
  [UID] integer,
  [Avatar] nvarchar(255),
  [Name] nvarchar(255),
  [Sex] nvarchar(255),
  [Birthday] date,
  [Address] text,
  [Membership] nvarchar(255)
)
GO

CREATE TABLE [Staff] (
  [SID] integer PRIMARY KEY IDENTITY(1, 1),
  [UID] integer,
  [Avatar] nvarchar(255),
  [Name] nvarchar(255),
  [Sex] nvarchar(255),
  [Birthday] date,
  [Office] nvarchar(255)
)
GO

CREATE TABLE [Shop_Owner] (
  [SOID] integer PRIMARY KEY IDENTITY(1, 1),
  [UID] integer,
  [Avatar] nvarchar(255),
  [Name] nvarchar(255),
  [Citizen_code] nvarchar(255),
  [Warehouse] nvarchar(255),
  [Type] nvarchar(255)
)
GO

CREATE TABLE [Product] (
  [PID] integer PRIMARY KEY IDENTITY(1, 1),
  [SOID] integer,
  [Image] nvarchar(255),
  [Name] nvarchar(255),
  [Price] float,
  [QSell] integer,
  [QRent] integer,
  [Age] integer,
  [Brand] nvarchar(255),
  [Origin] nvarchar(255),
  [Description] text,
  [Category] nvarchar(255),
  [Status] nvarchar(255)
)
GO

CREATE TABLE [Income] (
  [SOID] integer,
  [PID] integer,
  [IncSell] float,
  [QSell] integer,
  [IncRent] float,
  [QRent] integer,
  [Date] date
)
GO

CREATE TABLE [Cart] (
  [UID] integer,
  [PID] integer,
  [Quantity] integer,
  [Total] float,
  [RentTime] integer
)
GO

CREATE TABLE [Payment] (
  [PAID] integer PRIMARY KEY IDENTITY(1, 1),
  [OID] integer,
  [Amount] float,
  [Method] nvarchar(255),
  [Date] date
)
GO

CREATE TABLE [PDetail] (
  [PDID] integer PRIMARY KEY IDENTITY(1, 1),
  [PAID] integer,
  [ODID] integer,
  [Price] float,
  [points] float,
  [Deposit] float,
  [Refund_Shop] float,
  [Refund_Cus] float,
  [platform_fee] float,
  [Date] date,
  [Status] nvarchar(255)
)
GO

CREATE TABLE [Comment] (
  [CID] integer PRIMARY KEY IDENTITY(1, 1),
  [UID] integer,
  [PID] integer,
  [ODID] integer,
  [Comment] text,
  [Date] date,
  [satisfaction] nvarchar(255),
  [image] nvarchar(255)
)
GO

CREATE TABLE [Reply] (
  [CID] integer,
  [SOID] integer,
  [comment] nvarchar(255),
  [Date] date,
  [image] nvarchar(255)
)
GO

CREATE TABLE [Order] (
  [OID] integer PRIMARY KEY IDENTITY(1, 1),
  [UID] integer,
  [CreationDate] date,
  [Price] float
)
GO

CREATE TABLE [Order_Detail] (
  [ODID] integer PRIMARY KEY IDENTITY(1, 1),
  [OID] integer,
  [SOID] integer,
  [PID] integer,
  [Quantity] integer,
  [TimeRent] integer,
  [DateStart] date,
  [DateEnd] date,
  [Status] nvarchar(255)
)
GO

CREATE TABLE [Pos_Report] (
  [ODID] integer,
  [Name] nvarchar(255),
  [Quantity] int,
  [Overall] nvarchar(255),
  [External] nvarchar(255),
  [mobile_parts] nvarchar(255),
  [feature] nvarchar(255),
  [accessory] nvarchar(255),
  [image] nvarchar(255),
  [Description] nvarchar(255),
  [NoDamage] integer,
  [HalfDamage] integer,
  [FullDamage] integer,
  [Date] date
)
GO

CREATE TABLE [Pre_Repost] (
  [ODID] integer,
  [Name] nvarchar(255),
  [Quantity] integer,
  [Overall] nvarchar(255),
  [External] nvarchar(255),
  [mobile_parts] nvarchar(255),
  [feature] nvarchar(255),
  [accessory] nvarchar(255),
  [image] nvarchar(255),
  [Description] nvarchar(255),
  [Date_report] date
)
GO

CREATE TABLE [Fee_Policy] (
  [Platform] integer,
  [Week] integer,
  [BiWeek] integer,
  [Month] integer
)
GO

ALTER TABLE [Staff] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Customer] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Shop_Owner] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Product] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO

ALTER TABLE [Income] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO

ALTER TABLE [Income] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Cart] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Cart] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Order] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Order_Detail] ADD FOREIGN KEY ([OID]) REFERENCES [Order] ([OID])
GO

ALTER TABLE [PDetail] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [Payment] ADD FOREIGN KEY ([OID]) REFERENCES [Order] ([OID])
GO

ALTER TABLE [Order_Detail] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO

ALTER TABLE [Order_Detail] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [PDetail] ADD FOREIGN KEY ([PAID]) REFERENCES [Payment] ([PAID])
GO

ALTER TABLE [Pos_Report] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [Pre_Repost] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [Reply] ADD FOREIGN KEY ([CID]) REFERENCES [Comment] ([CID])
GO

ALTER TABLE [Reply] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO



INSERT INTO [User] (Email, Phone, Username, Password, Role) VALUES
('owner1@shop.com', '0912345678', 'owner1', '1', 'ROLE_OWNER'),
('owner2@shop.com', '0922345678', 'owner2', '1', 'ROLE_OWNER'),
('owner3@shop.com', '0932345678', 'owner3', '1', 'ROLE_OWNER'),
('customer1@shop.com', '0942345678', 'customer1', '1', 'ROLE_CUSTOMER'),
('customer2@shop.com', '0952345678', 'customer2', '1', 'ROLE_CUSTOMER'),
('staff1@shop.com', '0962345678', 'staff1', '1', 'ROLE_STAFF');


INSERT INTO [Customer] (UID, Avatar, Name, Sex, Birthday, Address, Membership) VALUES
(4, 'avatar_owner1.png', 'Phạm Thị D', 'Female', '1985-10-20', 'Số 10, Đường Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', '0'),
(5, 'avatar_owner2.png', 'Hoàng Văn E', 'Male', '1980-12-05', 'Số 25, Đường Nguyễn Tất Thành, Quận Hải Châu, Đà Nẵng', '0');



INSERT INTO [Staff] (UID, Avatar, Name, Sex, Birthday, Office) VALUES
(6, 'avatar_staff1.png', 'Lê Văn C', 'Male', '1985-11-22', 'Văn phòng Hà Nội');


INSERT INTO [Shop_Owner] (UID, Avatar, Name, Citizen_code, Warehouse, Type) VALUES
(1, 'avatar_owner1.png', 'Khu Vườn Sáng Tạo', '0123456789', 'Số 10, Đường Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', 'cá nhân'),
(2, 'avatar_owner2.png', 'Vương Quốc Đồ Chơi', '9876543210', 'Số 25, Đường Nguyễn Tất Thành, Quận Hải Châu, Đà Nẵng', 'công ty'),
(3, 'avatar_owner3.png', 'Chơi Là Học', '1234567890', 'Số 50, Đường Nguyễn Văn Linh, Quận 7, TP. Hồ Chí Minh', 'cửa hàng');

INSERT INTO [Product] (SOID, [Image], [Name], [Price], [QSell], [QRent], [Age], [Brand], [Origin], [Description], [Category], [Status]) VALUES
(1, 'anhsanpham', 'Quan', 2000, 10, 20, 8, 'lego', 'vn', 'dochoichotreem', 'chay', 'confirm')


