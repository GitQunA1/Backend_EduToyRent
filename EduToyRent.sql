drop database EduToyRent

create database EduToyRent
use EduToyRent

CREATE TABLE [User] (
  [UID] int PRIMARY KEY IDENTITY(1, 1),
  [Email] varchar(255),
  [Phone] varchar(255),
  [Password] varchar(255),
  [Role] varchar(50)
)
GO

CREATE TABLE [Customer] (
  [CID] int PRIMARY KEY IDENTITY(1, 1),
  [UID] int,
  [Avatar] varchar(255),
  [Name] varchar(255),
  [Sex] varchar(10),
  [Birthday] date,
  [Address] text,
  [Membership] varchar(50),
)
GO

CREATE TABLE [Staff] (
  [SID] int PRIMARY KEY IDENTITY(1, 1),
  [UID] int,
  [Avatar] varchar(255),
  [Name] varchar(255),
  [Sex] varchar(10),
  [Birthday] date,
  [Office] varchar(255)
)
GO

CREATE TABLE [Shop_Owner] (
  [SOID] int PRIMARY KEY IDENTITY(1, 1),
  [UID] int,
  [Avatar] varchar(255),
  [Name] varchar(255),
  [Citizen_code] varchar(50),
  [Warehouse] varchar(255),
  [Type] varchar(50),
  [Wallet_Staff] int
)
GO

CREATE TABLE [Product] (
  [PID] int PRIMARY KEY IDENTITY(1, 1),
  [SOID] int,
  [Image] varchar(255),
  [Name] varchar(255),
  [Price] decimal(10,2),
  [QSell] int,
  [QRent] int,
  [Age] int,
  [Brand] varchar(255),
  [Origin] varchar(255),
  [Description] text,
  [Category] varchar(255),
  [Status] varchar(50)
)
GO

CREATE TABLE [Cart] (
  [UID] int,
  [PID] int,
  [Quantity] int,
  [Total] decimal(10,2),
  [RentTime] int,
  PRIMARY KEY ([UID], [PID])
)
GO

CREATE TABLE [Comment] (
  [CommentID] int PRIMARY KEY IDENTITY(1, 1),
  [UID] int,
  [SOID] int,
  [PID] int,
  [ODID] int,
  [Comment] text,
  [Date] date,
  [Status] varchar(50)
)
GO

CREATE TABLE [Order] (
  [OID] int PRIMARY KEY IDENTITY(1, 1),
  [UID] int,
  [CreationDate] date,
  [Price] decimal(10,2)
)
GO

CREATE TABLE [Order_Detail] (
  [ODID] int PRIMARY KEY IDENTITY(1, 1),
  [OID] int,
  [SOID] int,
  [PID] int,
  [Quantity] int,
  [TimeRent] int,
  [DateStart] date,
  [DateEnd] date,
  [Status] varchar(50)
)
GO

CREATE TABLE [Payment] (
  [PAID] int PRIMARY KEY IDENTITY(1, 1),
  [OID] int,
  [TotalAmount] decimal(10,2),
  [Date_Payment] date,
  [Status_Payment] varchar(50),
  [PaymentMethod] varchar(50)
)
GO

CREATE TABLE [Payment_Detail] (
  [PDID] int PRIMARY KEY IDENTITY(1, 1),
  [PAID] int,
  [ODID] int,
  [Price] decimal(10,2),
  [deducted_points] int,
  [Deposit_Amount] decimal(10,2),
  [Refund_Shop] decimal(10,2),
  [Refund_Cus] decimal(10,2),
  [platform_fee] decimal(10,2),
  [Date_Refund] date,
  [Status_Refund] varchar(50)
)
GO

CREATE TABLE [Transaction] (
  [TID] int PRIMARY KEY IDENTITY(1, 1),
  [UID] int,
  [TotalAmount] decimal(10,2),
  [Date] date,
  [Status] varchar(50),
  [PaymentMethod] varchar(50)
)
GO

CREATE TABLE [TransactionDetail] (
  [TDID] int PRIMARY KEY IDENTITY(1, 1),
  [TID] int,
  [PID] int,
  [Quantity] int,
  [Price] decimal(10,2),
  [RentDuration] int,
  [StartDate] date,
  [EndDate] date,
  [SubTotal] decimal(10,2)
)
GO

CREATE TABLE [Shop_Report] (
  [ODID] int,
  [SOID] int,
  [Image] varchar(255),
  [Video] varchar(255),
  [NoDamage] int,
  [HalfDamage] int,
  [FullDamage] int,
  [Content] text,
  [Date_report] date,
  PRIMARY KEY ([ODID], [SOID])
)
GO

CREATE TABLE [Customer_Report] (
  [ODID] int,
  [CID] int,
  [Image] varchar(255),
  [Video] varchar(255),
  [NoDamage] int,
  [HalfDamage] int,
  [FullDamage] int,
  [Content] text,
  [Date_report] date,
  PRIMARY KEY ([ODID], [CID])
)
GO

CREATE TABLE [Fee_Policy] (
  [Platform] int,
  [Week] int,
  [BiWeek] int,
  [Month] int
)
GO

ALTER TABLE [Customer] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Staff] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Shop_Owner] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Product] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO

ALTER TABLE [Cart] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Cart] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [Order] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [Order_Detail] ADD FOREIGN KEY ([OID]) REFERENCES [Order] ([OID])
GO

ALTER TABLE [Order_Detail] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO

ALTER TABLE [Order_Detail] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Payment] ADD FOREIGN KEY ([OID]) REFERENCES [Order] ([OID])
GO

ALTER TABLE [Payment_Detail] ADD FOREIGN KEY ([PAID]) REFERENCES [Payment] ([PAID])
GO

ALTER TABLE [Payment_Detail] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [Transaction] ADD FOREIGN KEY ([UID]) REFERENCES [User] ([UID])
GO

ALTER TABLE [TransactionDetail] ADD FOREIGN KEY ([TID]) REFERENCES [Transaction] ([TID])
GO

ALTER TABLE [TransactionDetail] ADD FOREIGN KEY ([PID]) REFERENCES [Product] ([PID])
GO

ALTER TABLE [Shop_Report] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [Shop_Report] ADD FOREIGN KEY ([SOID]) REFERENCES [Shop_Owner] ([SOID])
GO

ALTER TABLE [Customer_Report] ADD FOREIGN KEY ([ODID]) REFERENCES [Order_Detail] ([ODID])
GO

ALTER TABLE [Customer_Report] ADD FOREIGN KEY ([CID]) REFERENCES [Customer] ([CID])
GO
