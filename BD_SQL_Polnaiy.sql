use Magaz_DB_2_Test
go


create table  Currency
(
ID_Currency       bigint          not null identity (1,1) check(ID_Currency !=0),  
Full_name_rus     nvarchar(300)   not null,
Full_name_eng     nvarchar(300)   not null,
Abbreviation_rus  nvarchar(15)    not null,
Abbreviation_eng  nvarchar(15)    not null,
constraint PK_ID_Currency         primary key (ID_Currency),
) on Orders_Group

go

create table Orders_status
(
Id_Status       bigint          not null identity (1,1)  check(Id_Status !=0),
Name            nvarchar(350)   null,
[Description]   nvarchar(4000)  null,
constraint  PK_Id_Status   primary key (Id_Status),
) on Orders_Group

go



create table Orders
(
ID_Orders        bigint          not null identity (1,1)  check(Id_Orders !=0),
ID_status        bigint          null,
Date             datetime        not null default  getDate(),
Amount           float           null,
ID_Currency      bigint          not null,
Num              nvarchar(50)    not null,
[Description]    nvarchar(4000)  null,
constraint  PK_ID_Orders   primary key (ID_Orders),
constraint  FK_ID_status   foreign key (ID_status) references [dbo].Orders
)  on Orders_Group
go


create table Connection_Buyer 
(
ID_Connection_Buyer   bigint             not null identity (1,1) check(ID_Connection_Buyer  != 0),
Password              nvarchar(50)       null,
Login                 nvarchar(100)      null,
Date_Ñreated          datetime           null default GetDate(),
[Description]         nvarchar(1000)     null,
constraint PK_ID_Connection_Buyer  Primary key  (ID_Connection_Buyer),
) on Costomers_Group
go


create table Buyer_buyer
(
Id_Status       bigint          not null identity (1,1)  check(Id_Status !=0),
Name            nvarchar(350)   null,
[Description]   nvarchar(4000)  null,
constraint  PK_Id_Status   primary key (Id_Status),
) on Costomers_Group

go

create  table Buyer
(
Id_buyer               bigint         not null identity (1,1)check(Id_buyer !=0),
ID_Connection_Buyer    bigint         not null,
Name                   nvarchar(100)  null,
SurName                nvarchar(100)  null,
LastName               nvarchar(100)  null,
Id_Status              bigint         null,
Mail                   nvarchar(250)  null,
Pol                    char(1)        not null CHECK (Pol IN ('Ì', 'Æ')),
Home_Phone             nvarchar(30)   null,
Date_Of_Birth          datetime       null,
Date_Ñreated_buyer     datetime       not null default  getDate(),
[Description]          nvarchar(4000) null,
constraint PK_Id_buyer primary key (Id_buyer)
) on Costomers_Group
go


create table  Data_Orders
(
Id_Data_Orders         bigint          not null identity (1,1) check(ID_Data_Orders !=0),
ID_Employee            bigint          not null, 
ID_Orders              bigint          not null,
Id_buyer               bigint          not null,
[Description]          nvarchar(4000)  null
constraint PK_ID_Data_Orders  primary key (ID_Data_Orders),
constraint FK_ID_Employee     foreign key (ID_Employee) references [dbo].Employees on delete NO ACTION, 
constraint FK_ID_Orders       foreign key (ID_Orders)   references [dbo].Orders    on delete NO ACTION,
constraint FK_Id_buyer        foreign key (Id_buyer)    references [dbo].buyer     on delete NO ACTION 
)
go

create table TypeItem
(
Id_TypeItem      bigint          not null identity (1,1) check(Id_TypeItem !=0),
TypeItemName     nvarchar        null,
[Description]    nvarchar(4000)  null
constraint PK_Id_TypeItem  primary key (Id_TypeItem),
)

go




create table Item
(
Id_Item                    bigint          not null identity (1,1) check(Id_Item !=0),
Article_number             nvarchar(300)   null,
ID_TypeItem                bigint          not null,
Name_Item                  nvarchar(500)   null,
Image_Item                 varbinary(max)  null,
[Description]              nvarchar(4000)  null
constraint PK_Id_Item  primary key (Id_Item),
constraint FK_ID_TypeItem        foreign key (ID_TypeItem)   references [dbo].TypeItem    on delete set null,
)
go


