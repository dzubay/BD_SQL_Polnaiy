
--������ ���� �������� �� ��������� ������ ���� , ��� ������ ��������.
create database Magaz_DB_2
on primary -- ����� ������� ��������� ������ ������(�� �����������).
(
name =  Magaz_DB_2_Root,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Magaz_DB_2_Root\Magaz_DB_2_Root.mdf', --��������� ���������������� ��� ����� ��.
size = 50 mb ,--����� ��������� ������ ����� ��.
maxsize = 5000 mb, --����� ������������ ������ ����� ��.
filegrowth = 50 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Costomers_Group_2 --������ ������ ��� ������ �� ��������
(
name =  Customers_Data_2_1,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Costomers_Group_2\Customers_Data_2_1.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Customers_Data_2_2,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Costomers_Group_2\Customers_Data_2_2.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Products_Group_2 --������ ������ ������ ��� ������ �� �������
(
name =  Product_Data_2_1,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Products_Group_2\Product_Data_2_1.ndf', --��������� ���������������� ��� ����� ��.
size = 50 mb ,--����� ��������� ������ ����� ��.
maxsize = 1000 mb, --����� ������������ ������ ����� ��.
filegrowth = 50 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Product_Data_2_2,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Products_Group_2\Product_Data_2_2.ndf', --��������� ���������������� ��� ����� ��.
size = 50 mb ,--����� ��������� ������ ����� ��.
maxsize = 1000 mb, --����� ������������ ������ ����� ��.
filegrowth = 50 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Orders_Group_2 --������ ������ ����� ��� ������ �� �������
(
name =  Orders_Data_2_1,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Orders_Group_2\Orders_Data_2_1.ndf', --��������� ���������������� ��� ����� ��.
size = 75 mb ,--����� ��������� ������ ����� ��.
maxsize = 750 mb, --����� ������������ ������ ����� ��.
filegrowth = 75 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Orders_Data_2_2,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Orders_Group_2\Orders_Data_2_2.ndf', --��������� ���������������� ��� ����� ��.
size = 75 mb ,--����� ��������� ������ ����� ��.
maxsize = 750 mb, --����� ������������ ������ ����� ��.
filegrowth = 75 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Employee_Group_2 -- �������� ������ ������ ��� �����������
(
name =  Employee_Data_2_1,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Employee_Group_2\Employee_Data_2_1.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Employee_Data_2_2,-- ��������� ���� ������
filename ='d:\���������\��\��� �����\Employee_Group_2\Employee_Data_2_2.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
)
log on --����� ��������� ������� ���� ������.
(
name ='Log_Data_2',-- ��������� ���������� ��� ������� ���������� �� (������������ ��� ��������� � ��)
filename = 'd:\���������\��\��� �����\Log_Data_2\Log_Data_2.ldf',--��������� ���������������� ��� ����� ������� ���������� ��. 
size = 20mb,-- ����� ��������� ������ ����� ������� ��.
maxsize =1200mb, --����� ������������ ������ ����� ������� ��.
filegrowth = 40mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ������� ��.
)
collate Cyrillic_General_CI_AS --����� ��������� ��� �� �� ��������������
go


ALTER DATABASE Magaz_DB_2  -- ��������� ���������������� ��,
SET RECOVERY FULL        -- FULL | SIMPLE | BULK_LOGGED. ��������� ������ ������� �������������� (Full) 
go






-------------------------------------------------------------------------------------------------------------------------
use Magaz_DB_2
go
create table dbo.[Employees]
(
ID_Employee                bigint         not null identity (1,1) check(ID_Employee !=0),
ID_Department              bigint         null,
ID_Group                   bigint         null,
ID_The_Subgroup            bigint         null,
ID_Passport                bigint         not null,
ID_Branch                  bigint         null,
ID_Post                    bigint         null,
ID_Status_Employee         bigint         null,
ID_Connection_String       bigint         null,
ID_Chief                   bigint         null,
Name                       nvarchar(100)  null,
SurName                    nvarchar(100)  null,
LastName                   nvarchar(100)  null,
Date_Of_Hiring             datetime       not null, 
Date_�ard_�reated_Employee datetime       not null default GetDate(),
Residential_Address        nvarchar(400)  null,
Home_Phone                 nvarchar(30)   null,
Cell_Phone                 nvarchar(30)   null,
Image_Employees            varbinary(max) null,    
Work_Phone                 nvarchar(30)   null,
Mail                       nvarchar(150)  null,
Pol                        char(1)        not null CHECK (Pol IN ('�', '�')),
Date_Of_Dismissal          datetime       null,
Date_Of_Birth              datetime       not null,
[Description]              nvarchar(1000) null, 
constraint PK_ID_Employee Primary key  (ID_Employee),
constraint FK_Employees_ID_Chief Foreign key(ID_Chief) references dbo.Employees(ID_Employee)  on delete NO ACTION --on Update NO ACTION  --��������� �� ���� ����, �������� �� ������ �� �����������, ��� �������� ���������  null � ������ ����, ��� ���������� ��������� ���������.
) on Employee_Group_2
go


--alter table dbo.[Employees] add Image_Employees varbinary(max) null;

create table dbo.[Department]
(
ID_Department               bigint         not null identity (1,1) check(ID_Department != 0),
ID_Head_Department          bigint         null,
ID_Vice_Head_Department     bigint         null,
Name_Department             nvarchar(300)  not null,
ID_Branch                   bigint         null,
Department_�ode             int            null,
[Description]               nvarchar(1000) null, 
constraint PK_ID_Department Primary key  (ID_Department),
) on Employee_Group_2
go

create table dbo.[Group] 
(
ID_Group                bigint         not null identity (1,1) check(ID_Group  != 0),
ID_Head_Group           bigint         null,
ID_Vice_Head_Group      bigint         null,
ID_Department           bigint         not null,
Name_Group              nvarchar(300)  not null,
ID_Branch               bigint         null,
Department_�ode         int            null,
[Description]           nvarchar(1000) null, 
constraint PK_ID_Group  Primary key  (ID_Group),
) on Employee_Group_2
go

create table dbo.[The_Subgroup] 
(
ID_The_Subgroup            bigint         not null identity (1,1) check(ID_The_Subgroup  != 0),
ID_Head_The_Subgroup       bigint         null,
ID_Vice_Head_The_Subgroup  bigint         null,
ID_Group                   bigint         not null,
Name_The_Subgroup          nvarchar(300)  not null,
ID_Branch                  bigint         null,
Department_�ode            int            null,
[Description]              nvarchar(1000) null,
ID_Parent_The_Subgroup     bigint         null,
constraint PK_The_Subgroup Primary key  (ID_The_Subgroup),
constraint FK_ID_Parent_The_Subgroup Foreign key (ID_Parent_The_Subgroup) references The_Subgroup(ID_The_Subgroup)  on delete NO ACTION
) on Employee_Group_2
go

create table dbo.[Passport] 
(
ID_Passport                bigint         not null identity (1,1) check(ID_Passport  != 0),
Number_Series              nvarchar(100)  not null,
Date_Of_Issue              Datetime       not null,
Department_Code            nvarchar(20)   not null,
Issued_By_Whom             nvarchar(400)  not null,
Registration               nvarchar(200)  not null,
Military_Duty              nvarchar(200)  not null,
[Description]              nvarchar(1000) null,
constraint PK_ID_Passport Primary key  (ID_Passport),
) on Employee_Group_2
go

create table Post  
(
ID_Post               bigint         not null identity (1,1) check(ID_Post  != 0),
Name_Post             nvarchar(200)  not null,
ID_Department         bigint         not null,
ID_Group              bigint         not null,
ID_The_Subgroup       bigint         not null,
[Description]         nvarchar(1000) null,
constraint PK_ID_Post Primary key  (ID_Post),
) on Employee_Group_2
go

create table Status_Employee  
(
ID_Status_Employee   bigint         not null identity (1,1) check(ID_Status_Employee  != 0),
Name_Status_Employee nvarchar(100)  not null,
[Description]        nvarchar(1000) null,
constraint PK_ID_Status_Employee Primary key  (ID_Status_Employee),
) on Employee_Group_2
go

create table Connection_String 
(
ID_Connection_String   bigint    not null identity (1,1) check(ID_Connection_String  != 0),
Password      nvarchar(50)       null,
Login         nvarchar(100)      null,
Date_�reated  datetime           null default GetDate(),
[Description] nvarchar(1000)     null,
constraint PK_ID_Connection_String  Primary key  (ID_Connection_String),
) on Employee_Group_2
go

create table Branch 
(
ID_Branch     bigint          not null identity (1,1) check(ID_Branch  != 0),
Id_Country    bigint          null,
City          nvarchar(100)   not null,
[Address]     nvarchar(300)   not null,
Name_Branch   nvarchar(300)   not null,
Mail          nvarchar(300)   null,
Phone         nvarchar(15)    null,
Postal_Code   int             null,
INN           int             not null,
[Description] nvarchar(1000)  null,
constraint PK_ID_Branch  Primary key  (ID_Branch),
) on Employee_Group_2
go

create table Country 
(
Id_Country         bigint           not null identity (1,1) check(ID_Country  != 0),
Name_Country       nvarchar(150)    not null,
Name_English       nvarchar(150)    not null,
Cod_Country_Phone  nvarchar(10)     null,
constraint PK_ID_Country  Primary key  (ID_Country),
) on Employee_Group_2
go

ALTER TABLE dbo.[Employees]
Add 
CONSTRAINT FK_Employees_ID_Department Foreign key  (ID_Department) references dbo.[Department](ID_Department)  on delete set null on Update cascade ,
CONSTRAINT FK_Employees_ID_Group Foreign key  (ID_Group) references dbo.[Group](ID_Group)  on delete set null on Update cascade ,
CONSTRAINT FK_Employees_ID_The_Subgroup Foreign key  (ID_The_Subgroup) references dbo.[The_Subgroup](ID_The_Subgroup)  on delete set null on Update cascade ,
CONSTRAINT FK_Employees_ID_Passport Foreign key  (ID_Passport) references dbo.[Passport](ID_Passport)  on delete cascade on Update cascade ,
CONSTRAINT FK_Employees_ID_Branch Foreign key  (ID_Branch) references dbo.[Branch](ID_Branch)  on delete set null on Update cascade,
CONSTRAINT FK_Employees_ID_Post Foreign key  (ID_Post) references dbo.[Post](ID_Post)  on delete set null on Update cascade,
CONSTRAINT FK_Employees_ID_Status_Employee Foreign key  (ID_Status_Employee) references dbo.[Status_Employee](ID_Status_Employee)  on delete set null on Update cascade,
CONSTRAINT FK_Employees_ID_Connection_String Foreign key  (ID_Connection_String) references dbo.[Connection_String](ID_Connection_String) on delete set null on Update cascade 
go
ALTER TABLE dbo.[Department]
Add 
CONSTRAINT FK_Department_ID_Head_Department Foreign key  (ID_Head_Department) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_Department_ID_Vice_Head_Department Foreign key  (ID_Vice_Head_Department) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_Department_ID_Branch Foreign key  (ID_Vice_Head_Department) references dbo.[Branch](ID_Branch)  
go
ALTER TABLE dbo.[Group]
Add 
CONSTRAINT FK_Group_ID_Head_Group Foreign key  (ID_Head_Group) references dbo.[Employees](ID_Employee) ,
CONSTRAINT FK_Group_ID_Vice_Head_Group Foreign key  (ID_Vice_Head_Group) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_Group_ID_Department Foreign key  (ID_Department) references dbo.[Department](ID_Department),
CONSTRAINT FK_Group_ID_Branch Foreign key  (ID_Branch) references dbo.[Branch](ID_Branch)
go
ALTER TABLE dbo.[The_Subgroup]
Add 
CONSTRAINT FK_The_Subgroup_ID_Head_The_Subgroup Foreign key  (ID_Head_The_Subgroup) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_The_Subgroup_ID_Vice_Head_The_Subgroup Foreign key  (ID_Vice_Head_The_Subgroup) references dbo.[Employees](ID_Employee),
CONSTRAINT FK_The_Subgroup_ID_Group Foreign key  (ID_Group) references dbo.[Group](ID_Group),
CONSTRAINT FK_The_Subgroup_ID_Branch Foreign key  (ID_Branch) references dbo.[Branch](ID_Branch)
go
ALTER TABLE dbo.[Post]
Add
CONSTRAINT FK_Post_ID_Department Foreign key  (ID_Department) references dbo.[Department](ID_Department),
CONSTRAINT FK_Post_ID_Group Foreign key  (ID_Group) references dbo.[Group](ID_Group),
CONSTRAINT FK_Post_ID_The_Subgroup Foreign key  (ID_The_Subgroup) references dbo.[The_Subgroup](ID_The_Subgroup)
go
ALTER TABLE dbo.[Branch]
Add
CONSTRAINT FK_Branch_Id_Country Foreign key  (Id_Country) references dbo.[Country](Id_Country)  on delete set null on Update cascade
go



CREATE PARTITION FUNCTION PF_PartFuncDate_2 (DateTime)
AS RANGE LEFT FOR VALUES ('01.01.2022', '01.01.2024', '01.01.2026');
go
CREATE PARTITION SCHEME PF_PartFuncDate_2
AS PARTITION PF_PartFuncDate_2
TO (Costomers_Group_2,Orders_Group_2,Products_Group_2,Employee_Group_2)
go   -- ��������������� �� ���� �������� �������� 

--select * from  sys.partition_functions  -- �������� ������� ���������������
--select * from sys.partition_schemes  -- �������� ���� ���������������
 
--������� ������� ����� ���������������, � �� ������� �� ��������.
--DROP PARTITION SCHEME PF_PartFuncDate_2
--� ����� ��� ���� �������
--DROP PARTITION FUNCTION  PF_PartFuncDate_2