

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



INSERT INTO [User] (Email, Phone, Username, [Password], [Role]) VALUES
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
(1, 'https://thebookland.vn/contents/1670045337198_Mathlink%20Cubes%20Numberblocks%20%201-10%20(1).jpg', N'Bộ học toán Mathlink Cubes Numberblocks số đếm 1-10', 650000, 20, 30, 3, N'Educational Insights', N'Mỹ', N'Numberblocks là chương trình truyền hình đạt hàng loạt giải thưởng...', N'toán học', N'Thành công'),
(1, 'https://thebookland.vn/images/1689223695931_BrainBolt%20Genius%20(2).jpg', N'Máy chơi luyện trí nhớ và giải đố: BrainBolt® Genius (phiên bản nâng cao)', 702000, 20, 30, 7, N'Educational Insights', N'Mỹ', N'Brainbolt Genius thiết kế như máy chơi game...', N'Giải đố', N'Thành công'),
(1, 'https://down-vn.img.susercontent.com/file/f6712a6a3922417db99b06295074d8a5.webp', N'Bộ thẻ học thông minh 16 chủ đề 416 thẻ song ngữ Anh Việt cho bé Glen Doman', 70000, 20, 30, 1, N'OEM', N'Việt Nam', N'Bộ 416 thẻ học thông minh song ngữ Việt...', N'Ngôn ngữ', N'Thành công'),
(1, 'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lepg7377ij039f.webp', N'Bảng Vẽ Xếp Hình Nam Châm Thế Hệ Mới...', 56000, 20, 30, 3, N'không', N'Việt Nam', N'Bảng vẽ nam châm được làm bằng ABS và thép...', N'nghệ thuật', N'Thành công'),
(1, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lj6kl43gbytof9.webp', N'Bộ đồ chơi nấu ăn nhà bếp cao cấp cho bé gái bé trai...', 180000, 20, 30, 2, N'không', N'Việt Nam', N'Sử dụng chất liệu an toàn sức khỏe...', N'Mô phỏng', N'Thành công'),
(1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxStI76vRJEMadDamOLDV3VBD8WIrc2xqcsQ&s', N'Tranh ghép hình cho bé bằng gỗ trí tuệ 30 mảnh...', 20000, 20, 30, 4, N'không', N'Việt Nam', N'Đồ chơi ghép hình là một trong những món không thể thiếu...', N'Xếp hình', N'Thành công'),
(1, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lsxlendswhi120@resize_w450_nl.webp', N'Bảng vẽ tự xóa BABYTREE màn hình LCD thông minh...', 140000, 20, 30, 3, N'không', N'Việt Nam', N'Màn hình LCD chất lượng cao...', N'nghệ thuật', N'Thành công'),
(1, 'https://down-vn.img.susercontent.com/file/cn-11134207-7r98o-lu0evrra1e2sf7@resize_w450_nl.webp', N'WISLEO Đồ chơi xếp hình hiding block Logic...', 66000, 20, 30, 3, N'không', N'Trung Quốc', N'Khối xây dựng ẩn này là một hộp màu...', N'Giải đố', N'Thành công'),
(1, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd6x-lve6azjkdfye1d@resize_w450_nl.webp', N'Tranh Đính Đá Mini Nhiều Hình Thủ Công Tự Làm...', 10000, 20, 30, 6, N'không', N'Việt Nam', N'Chất liệu: Canvas + đá resin...', N'nghệ thuật', N'Thành công'),
(1, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-ljyzknlh90xu82@resize_w450_nl.webp', N'Bộ mỹ phẩm đồ chơi trang điểm 33 món không độc hại...', 98000, 20, 30, 4, N'không', N'Việt Nam', N'Bộ trang điểm cho trẻ em bao gồm Son bóng * 6...', N'Mô phỏng', N'Thành công'),
(2, 'https://s.alicdn.com/@sc04/kf/H980bc265c5ae43eca0b4b558db8e2d13o.png_720x720q50.jpg', 'Vật Liệu Montessori Đồ Chơi Giáo Dục Hỗ Trợ Giảng Dạy Cho Địa Lý Thiết Bị Globe-Thế Giới Các Bộ Phận', 585000, 20, 30, 2, 'Adena Montessori', 'Trung Quốc', 'Đường kính 16.5cm \nKích thước 62*47*3.8cm', 'Địa lý', 'Thành công'),
(2, 'https://s.alicdn.com/@sc04/kf/H980bc265c5ae43eca0b4b558db8e2d13o.png_720x720q50.jpg', 'Xe cứu hỏa Abrick ECOIFFIER 003290', 529000, 20, 30, 4, 'ECOIFFIER', 'Pháp', 'Xe cứu hỏa Ecoiffier Abrick bao gồm : 1 xe cứu hỏa lớn, 1 xe hơi nhỏ, 3 nhân vật lính cứu hỏa.', 'mô phỏng', 'Thành công'),
(2, 'https://img.lazcdn.com/g/p/4ce91789d630a492ab1fbb7c45a4ba1d.jpg_720x720q80.jpg_.webp', 'Kính Viễn Vọng Ngoài Trời Kính Viễn Vọng Khúc Xạ Thiên Văn Trong Suốt Cao Đồ Chơi Giảng Dạy Khoa Học Với Giá Ba Chân Thị Kính Phóng Đại 20X 30X 40X Cho Trẻ Em', 611000, 20, 30, 5, 'không', 'Việt Nam', 'Kính thiên văn thiên văn cho trẻ em với ống kính quang học nhiều lớp, hình ảnh rõ nét.', 'thiên văn', 'Thành công'),
(2, 'https://www.mykingdom.com.vn/cdn/shop/files/6024397.jpg?v=1721987083&width=1100', 'Bộ cát, dụng cụ và khay chơi cát KINETIC SAND 6024397', 599000, 20, 30, 3, 'KINETIC SAND', 'Thuy Điển', 'Bắt đầu cuộc phiêu lưu vào thế giới cổ tích với Bộ cát, dụng cụ và khay chơi cát.', 'khoa học', 'Thành công'),
(2, 'https://www.mykingdom.com.vn/cdn/shop/products/s-l640_1_0f733a51-5177-47c7-a628-daf3124d9e6d.jpg?v=1684886078&width=990', 'Đồ chơi xe lắp ráp ô tô Lamborghini Roadster tỉ lệ 1:24 MAISTO MT39900', 599000, 20, 30, 6, 'MAISTO', 'Trung Quốc', 'Đồ chơi Maisto xe lắp ráp ô tô Lamborghini Roadster tỉ lệ 1:24.', 'kĩ thuật', 'Thành công'),
(2, 'https://www.mykingdom.com.vn/cdn/shop/products/zj16-pk_1_1.jpg?v=1684995393&width=1100', 'Bảng vẽ thông minh size 10 inch Hồng COOLKIDS ZJ16', 399000, 20, 30, 3, 'COOLKIDS', 'Trung Quốc', 'Sản phẩm có chất liệu an toàn, được thiết kế tỉ mỉ, cẩn thận, không gây hại cho sức khỏe của bé.', 'khoa học', 'Thành công'),
(2, 'https://www.mykingdom.com.vn/cdn/shop/files/DS1059H-03-10_2.jpg?v=1715065631&width=990', 'Xếp hình 3D NASA: Tên lửa vũ trụ Saturn V - Apollo PUZZLES DS1059H', 359000, 20, 30, 8, 'PUZZLES', 'Trung Quốc', 'Đồ chơi trẻ em xếp hình 3D NASA: Tên lửa vũ trụ Saturn V Apollo.', 'xếp hình', 'Thành công'),
(2, 'https://www.mykingdom.com.vn/cdn/shop/products/8852rb_1__1.jpg?v=1685096880&width=990', 'Đồ Chơi Rubik 3x3 SPIN GAMES 8852RB', 319000, 20, 30, 8, 'SPIN GAMES', 'Trung Quốc', 'Rubik là một trò chơi trí tuệ giải khối lập phương thú vị và hấp dẫn.', 'Giải đố', 'Thành công'),
(2, 'https://www.mykingdom.com.vn/cdn/shop/products/mykingdom-6041518_3.jpg?v=1714013265&width=990', 'Trò chơi rút gỗ SPIN GAMES 6041518', 189000, 20, 30, 6, 'SPIN GAMES', 'Trung Quốc', 'Gồm 48 thanh gỗ chắc chắn, được mài nhẵn không góc nhọn, không bị xước, an toàn cho trẻ nhỏ.', 'Giải đố', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-robot-devo-thong-thai-dieu-khien-tu-xa-vecto-vt2108_3.jpg?v=1713774609&width=990', 'Đồ chơi Robot DEVO thông thái điều khiển từ xa VECTO VT2108', 899000, 20, 30, 5, 'VECTO', 'Trung Quốc', 'Đồ chơi Robot DEVO thông thái điều khiển từ xa với nhiều chức năng hiện đại.', 'Kĩ thuật', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/products/vtk46_b179c3fb-8388-4898-a80f-d0e8d49abc96.jpg?v=1707221339&width=990', 'Đồ chơi Robot Patrol Man điều khiển từ xa VECTO VTK46', 799000, 20, 30, 3, 'VECTO', 'Trung Quốc', 'Đồ chơi Robot Patrol Man điều khiển từ xa VECTO – Người máy tiên tiến đa chức năng cho bé vừa học vừa chơi, khám phá thế giới công nghệ tương lai cực vui...', 'Kĩ thuật', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/products/BRU02526_1.jpg?v=1684841812&width=990', 'Đồ chơi mô hình tỷ lệ 1:16 xe cảnh sát Jeep và người BRUDER BRU02526', 1699000, 20, 30, 4, 'BRUDER', 'Đức', 'Mô hình xe cảnh sát Jeep BRU02526 mô phỏng chính xác tỉ lệ 1:16 với các chức năng tinh xảo...', 'Mô phỏng', 'Thành công'),
(3, 'https://cdn0.fahasa.com/media/catalog/product/i/m/image_213680.jpg', 'Seri Phòng Thí Nghiệm Nhỏ STEM 1007 - Con Tìm Hiểu Hệ Mặt Trời (Vật Lý)', 129000, 20, 30, 6, 'Shenzhen', 'Trung Quốc', 'Bộ đồ chơi khoa học thú vị giúp bé tìm hiểu về hệ mặt trời và thiên văn học...', 'Thiên văn', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/files/6d57adb11f0f8e09f133ad587b2f7854.jpg?v=1706859146&width=990', 'Đồ chơi máy chiếu Thiên văn học STEAM 1423000801', 799000, 20, 30, 6, 'STEAM', 'Trung Quốc', 'Máy chiếu thiên văn học giúp bé khám phá các ngôi sao và hành tinh...', 'Thiên văn', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/products/1423001071_1_8e8bf366-fe94-4bae-9892-9d54b69d9ffa.jpg?v=1706986752&width=990', 'Đồ chơi lắp ráp dùng năng lượng mặt trời - Xe và Thuyền STEAM 1423001071', 459000, 20, 30, 6, 'STEAM', 'Trung Quốc', 'Bộ lắp ráp với động cơ và tấm pin năng lượng mặt trời, giúp bé tìm hiểu về kỹ thuật...', 'Kĩ thuật', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/files/34100f71fcedc143c1c6d4a448890947.jpg?v=1717669879&width=990', 'Xe đạp trẻ em Royal Baby Flying Bear 12 inch Màu Vàng RB12B-9', 3000000, 20, 30, 2, 'BIKE', 'Trung Quốc', 'Xe đạp trẻ em Royal Baby Flying Bear với thiết kế mạnh mẽ và độ an toàn cao...', 'Thể chất', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/products/nt05g2-nentrang_1.jpg?v=1706986368&width=990', 'Xe Scooter 2 bánh Neon Vector Yvolution NT05G2 xanh lá', 1599000, 20, 30, 5, 'SCOOTER', 'Trung Quốc', 'Xe scooter 2 bánh Neon Vector là sản phẩm nổi bật với màu sắc tươi trẻ và tính năng vận động...', 'Thể chất', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/files/PAB024_35503aaf-9b58-4eea-8bb8-9ce805cc5a74.jpg?v=1727249941&width=990', 'Xe chòi chân kèm đèn và nhạc cho bé PEEK A BOO PAB024', 999000, 20, 30, 1, 'PEEK A BOO', 'Trung Quốc', 'Xe chòi chân giúp bé phát triển các kỹ năng vận động và tư duy...', 'Thể chất', 'Thành công'),
(3, 'https://giaocumontessori.com/web/image/product.product/174/image_1024/%5B0770100%5D%20Gh%C3%A9p%20h%C3%ACnh%20b%E1%BA%A3n%20%C4%91%E1%BB%93%20th%E1%BA%BF%20gi%E1%BB%9Bi%20v%C3%A0%20b%E1%BB%99%20c%E1%BB%9D%20c%E1%BB%A7a%20c%C3%A1c%20n%C6%B0%E1%BB%9Bc?unique=eb6c920', 'Ghép hình bản đồ thế giới và bộ cờ của các nước', 1339000, 20, 30, 6, 'Không', 'Việt Nam', 'Bản đồ thế giới và cờ các nước giúp bé tìm hiểu về địa lý và vị trí các quốc gia...', 'Địa lý', 'Thành công'),
(3, 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-dan-piano-meo-con-bx1025z.jpg?v=1720779066&width=990', 'Đồ chơi đàn piano mèo con B.BRAND BX1025Z', 1199000, 20, 30, 2, 'B. BRAND', 'Trung Quốc', 'Đàn piano mèo con với thiết kế đáng yêu và nhiều tính năng hiện đại giúp bé phát triển khả năng âm nhạc...', 'Nghệ thuật', 'Thành công');
GO


INSERT INTO [Fee_Policy] (Platform, Week, BiWeek, Month)
VALUES (10, 10, 18, 30)
GO


