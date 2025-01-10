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
Password              nvarchar(50)       null,                                                     -- Пароль аккаунта на ресурсе
Login                 nvarchar(100)      null,                                                     -- Логин аккаунта на ресурсе
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
Id_buyer                    bigint         not null identity (1,1)check(Id_buyer !=0),      -- ID Покупателя
ID_Connection_Buyer         bigint         not null,                                        -- ID данных о личном аккаунте на ресурсе покупателя 
Id_Status                   bigint         null,                                            -- ID Статуса покупателя
Name                        nvarchar(100)  null,                                            -- Имя
SurName                     nvarchar(100)  null,                                            -- Фамилия
LastName                    nvarchar(100)  null,                                            -- Отчество
Mail                        nvarchar(250)  null,                                            -- Электронная почта покупателя
Pol                         char(1)        not null CHECK (Pol IN ('М', 'Ж')),              -- Пол
Phone                       nvarchar(30)   null,                                            -- Действующий телефон покупателя
Date_Of_Birth               datetime       null,                                            -- Дата роождения
[Description]               nvarchar(4000) null,                                            -- Комментарий
constraint PK_Id_buyer             primary key (Id_buyer),
constraint FK_ID_Connection_Buyer  foreign key (ID_Connection_Buyer)   references dbo.Connection_Buyer  on delete set null on Update cascade,
constraint FK_Id_Buyer_statuss     foreign key (Id_Status)             references dbo.Buyer_status      on delete NO ACTION
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
Product_measurement_Name        nvarchar(300)   not null,                                                  --Наименование Типа измерения товара 
SysProductMeasurementName       nvarchar(300)   not null,                                                  --Системное Наименование Типа измерения товара 
[Description]                   nvarchar(4000)  null                                                       --Комментарий
Constraint PK_ID_product_measurement  primary key (ID_product_measurement)
)

create table Item                                                                       --Товар
(
Id_Item                    bigint          not null identity (1,1) check(Id_Item !=0),              --ID Карточки товра
ID_product_measurement     bigint          not null,                                                --ID Типа измерения товара  
ID_TypeItem                bigint          not null,                                                --ID Типа товара
Article_number             nvarchar(300)   null,                                                    --Артикул товара
Name_Item                  nvarchar(500)   null,                                                    --Наименование товара
Image_Item                 varbinary(max)  null,                                                    --Изображение товара
Manufacturer               nvarchar(500)   null,                                                    --Производитель товара
Country                    nvarchar(200)   null,                                                    --Страна  Производителя товара
City                       nvarchar(200)   null,                                                    --Город  Производителя товара
Adress                     nvarchar(800)   null,                                                    --Адрес Производителя товара
Mail                       nvarchar(250)   null,                                                    --Электронная почта производителя товара 
Phone                      nvarchar(30)    null,                                                    --Контактный телефон производителя товара
Logo                       varbinary(max)  null,                                                    --Логотип производителя товара
Date_Сreated               datetime        not null  default GetDate(),                             --Дата заведения карточки товара
[Description]              nvarchar(4000)  null                                                     --Комментарий 
constraint PK_Id_Item  primary key (Id_Item),
constraint FK_ID_TypeItem                   foreign key (ID_TypeItem)              references [dbo].TypeItem                       on delete NO ACTION,
constraint FK_ID_product_measurement        foreign key (ID_product_measurement)   references [dbo].Type_of_product_measurement    on delete NO ACTION
)
go



create table Type_Storage_location                               --Тип места хранения
(
ID_Type_Storage_location                    bigint              not null identity(1,1) check(ID_Type_Storage_location != 0),  --ID Типа места хранение
Name_Type_Storage_location                  nvarchar(300)       not null,                                                     --Наименование типа места хранениея 
SysNameTypeStoragelocation                  nvarchar(300)       not null,                                                     --Системное наименование типа места хранения
[Description]                               nvarchar(4000)      null                                                          --Комментарий
constraint PK_ID_Type_Storage_location      primary key (ID_Type_Storage_location),
)

go

create table Storage_location                                                    --Место хранение
(
ID_Storage_location        bigint              not null identity(1,1) check(ID_Storage_location != 0),   --ID Место хранение экземпляра
ID_Type_Storage_location   bigint              not null,                                                 --ID Типа места хранение
Name                       nvarchar(400)       not null,                                                 --Наименование места хранения
Country                    nvarchar(200)       null,                                                     --Страна  места хранения
City                       nvarchar(200)       null,                                                     --Город  места хранения
Adress                     nvarchar(800)       not null,                                                 --Адрес места хранения
Mail                       nvarchar(250)       null,                                                     --Электронная почта хранение экземпляра
Phone                      nvarchar(30)        null,                                                     --Действующий телефон хранение экземпляра
Date_Сreated               datetime            not null  default GetDate(),                              --Дата заведения в систему места хранения
[Description]              nvarchar(4000)      null                                                      --Комментарий
constraint PK_ID_Storage_location          primary key (ID_Storage_location),
constraint FK_ID_Type_Storage_location     foreign key (ID_Type_Storage_location)        references [dbo].Type_Storage_location    on delete NO ACTION
)

go

create table Exemplar                                                                   --Экземпляр
(
ID_Exemplar            bigint          not null   identity (1,1)  check(ID_Exemplar != 0),     --ID Экземпляра
Id_Item                bigint          not null,                                               --ID Карточки товара
ID_Currency            bigint          not null,											   --ID Валюта, цены на экземпляр
ID_Storage_location    bigint          not null,                                               --ID Место хранение экземпляра
Serial_number          nvarchar(800)   not null,                                               --Серийный номер экземпляра товара
Old_Price              float           not null,                                               --Цена экземпляра
JSON_Size_Volume       nvarchar(max)   null      check(isjson(JSON_Size_Volume)>0),            --Данный JSON параметры самого экземпляра
New_Price              float           not null,                                               --Цена экземпляра после начисления 
Date_Сreated           datetime        not null  default GetDate(),                            --Дата внесения экземпляра в систему
[Description]          nvarchar(4000)  null                                                    --Комментарий
constraint PK_ID_Exemplar              primary key (ID_Exemplar),
constraint FK_ID_Item                  foreign key (Id_Item)                 references [dbo].Item                on delete NO ACTION,
constraint FK_ID_Currency_Exemplar     foreign key (ID_Currency)             references [dbo].Currency            on delete NO ACTION,
constraint FK_ID_Storage_location      foreign key (ID_Storage_location)     references [dbo].Storage_location    on delete NO ACTION
)

go

/*
create table ItemExemplar                                                    --Экземпляр к товару
(
ID_ItemExemplar  bigint          not null   identity (1,1)  check(ID_ItemExemplar != 0),     --ID Данных карточки товара к Экземпляру  
ID_Exemplar      bigint          not null,                                                   --ID Экземпляра
Id_Item          bigint          not null                                                    --ID Карточки товра
constraint PK_ID_Exemplar    primary key (ID_ItemExemplar)
)

go
*/