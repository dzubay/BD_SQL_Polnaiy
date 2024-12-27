use Magaz_DB_2_Test
go


create table  Currency                               --Валюта
(
ID_Currency       bigint          not null identity (1,1) check(ID_Currency !=0),      -- ID валюты
Full_name_rus     nvarchar(300)   not null,                                            -- Полное наименование валюты на русском
Full_name_eng     nvarchar(300)   not null,                                            -- Полное наименование валюты на английском
Abbreviation_rus  nvarchar(15)    not null,                                            -- Короткое наименование на русском
Abbreviation_eng  nvarchar(15)    not null,                                            -- Короткое наименование на английском
constraint PK_ID_Currency         primary key (ID_Currency),
) on Orders_Group

go

create table Orders_status                                                  --Статус заказа
(
Id_Status              bigint          not null identity (1,1)  check(Id_Status !=0),   -- ID статуса заказа
Name                   nvarchar(300)   not null,                                        -- Наименование статуса заказа
SysTypeOrderStatusName nvarchar(300)   not null,                                        -- Системное имя статуса заказа
[Description]          nvarchar(4000)  null,                                            -- Комментарии
constraint  PK_Id_Status   primary key (Id_Status),
) on Orders_Group

go



create table Orders                                                                 --Заказ
(
ID_Orders        bigint          not null identity (1,1)  check(Id_Orders !=0),      -- ID заказа
ID_status        bigint          null,                                               -- ID статуса заказа
Date             datetime        not null default  getDate(),                        -- Дата создания заказа
Amount           float           null,                                               -- Сумма заказа
ID_Currency      bigint          not null,                                           -- Валюта заказа
Num              nvarchar(50)    not null,                                           -- Номер заказа
[Description]    nvarchar(4000)  null,                                               -- Комментарий
constraint  PK_ID_Orders   primary key (ID_Orders),
constraint  FK_ID_status   foreign key (ID_status) references [dbo].Orders
)  on Orders_Group
go


create table Connection_Buyer                                                     --Аккаунт покупателя
(
ID_Connection_Buyer   bigint             not null identity (1,1) check(ID_Connection_Buyer  != 0), -- ID данных о личном аккаунте на ресурсе покупателя 
Password              nvarchar(50)       null,                                                     -- пароль аккаунта на ресурсе
Login                 nvarchar(100)      null,                                                     -- Логин аккаунта на рессурсе
Date_Сreated          datetime           not null default GetDate(),                               -- Дата создания аккаунта
[Description]         nvarchar(1000)     null,                                                     -- Комментарий
constraint PK_ID_Connection_Buyer  Primary key  (ID_Connection_Buyer),
) on Costomers_Group
go


create table Buyer_status                                              --Статуса покупателя
(
Id_Status              bigint          not null identity (1,1)  check(Id_Status !=0),  -- ID Статуса покупателя
Name                   nvarchar(300)   not null,                                       -- Наименования статуса покупателя
SysTypeBuyerStatusName nvarchar(300)   not null,                                       -- Системное имя статуса покупателя
[Description]          nvarchar(4000)  null,                                           -- Комментарий
constraint  PK_Id_Status   primary key (Id_Status),
) on Costomers_Group

go

create  table Buyer                                                     --Покупатель
(
Id_buyer               bigint         not null identity (1,1)check(Id_buyer !=0),      -- ID Покупателя
ID_Connection_Buyer    bigint         not null,                                        -- ID данных о личном аккаунте на ресурсе покупателя 
Name                   nvarchar(100)  null,                                            -- Имя
SurName                nvarchar(100)  null,                                            -- Фамилия
LastName               nvarchar(100)  null,                                            -- Отчество
Id_Status              bigint         null,                                            -- ID Статуса покупателя
Mail                   nvarchar(250)  null,                                            -- Электронная почта покупателя
Pol                    char(1)        not null CHECK (Pol IN ('М', 'Ж')),              -- Пол
Phone                  nvarchar(30)   null,                                            -- Действующий телефон покупателя
Date_Of_Birth          datetime       null,                                            -- Дата роождения
[Description]          nvarchar(4000) null,                                            -- Комментарий
constraint PK_Id_buyer primary key (Id_buyer)
) on Costomers_Group
go


create table  Data_Orders                                                    --Вспомогательная таблицца, данные о заказе
(
Id_Data_Orders         bigint          not null identity (1,1) check(ID_Data_Orders !=0),  -- ID данных о заказе
ID_Employee            bigint          not null,                                           -- ID Сотрудника или бота
ID_Orders              bigint          not null,                                           -- ID Заказа
Id_buyer               bigint          not null,	                                       -- ID Покупателя
[Description]          nvarchar(4000)  null
constraint PK_ID_Data_Orders  primary key (ID_Data_Orders),
constraint FK_ID_Employee     foreign key (ID_Employee) references [dbo].Employees on delete NO ACTION, 
constraint FK_ID_Orders       foreign key (ID_Orders)   references [dbo].Orders    on delete NO ACTION,
constraint FK_Id_buyer        foreign key (Id_buyer)    references [dbo].buyer     on delete NO ACTION 
)
go

create table TypeItem                                                 --Тип товара
(
Id_TypeItem      bigint          not null identity (1,1) check(Id_TypeItem !=0),  -- ID Типа товара
TypeItemName     nvarchar(300)   not null,                                        -- Наименование типа тоара
SysTypeItemName  nvarchar(300)   not null,                                        -- Системное наименование типа товара
[Description]    nvarchar(4000)  null                                             -- Комментарий
constraint PK_Id_TypeItem  primary key (Id_TypeItem),
)

go

create table Type_of_product_measurement                                            --Тип измерения товара
(
ID_product_measurement          bigint          not null identity (1,1) check(ID_product_measurement !=0), --ID Типа измерения товара 
ID_Product_measurement_Name     nvarchar(300)   not null,                                                  --Наименование Типа измерения товара 
ID_SysProductMeasurementName    nvarchar(300)   not null,                                                  --Системное Наименование Типа измерения товара 
[Description]                   nvarchar(4000)  null                                                       --Комментарий
Constraint PK_ID_product_measurement  primary key (ID_product_measurement)
)

create table Item                                                                       --Товар
(
Id_Item                    bigint          not null identity (1,1) check(Id_Item !=0),              --ID Карточки товра
ID_product_measurement     bigint          not null,                                                --ID Типа измерения товара   
Article_number             nvarchar(300)   null,                                                    --Артикул товара
ID_TypeItem                bigint          not null,                                                --ID Типа товара
Name_Item                  nvarchar(500)   null,                                                    --Наименование товара
Image_Item                 varbinary(max)  null,                                                    --Изображение товара
[Description]              nvarchar(4000)  null                                                     --Комментарий 
constraint PK_Id_Item  primary key (Id_Item),
constraint FK_ID_TypeItem                   foreign key (ID_TypeItem)              references [dbo].TypeItem                       on delete NO ACTION,
constraint FK_ID_product_measurement        foreign key (ID_product_measurement)   references [dbo].Type_of_product_measurement    on delete NO ACTION,
)
go


