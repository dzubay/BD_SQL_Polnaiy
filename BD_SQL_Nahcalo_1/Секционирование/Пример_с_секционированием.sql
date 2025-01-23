
--Сначала требуется ввести данные о пути к папкам, и после чего запускать.
declare                                          --------------------------------------------
 @Magaz_DB_Root        nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Magaz_DB_Root\'     +  'Magaz_DB_Root.mdf'               -- Папка для  Magaz_DB_Root
,@Customers_Data_1     nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Costomers_Group\'   +  'Customers_Data_1.ndf'            -- Одна папка для двух файлов
,@Customers_Data_2     nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Costomers_Group\'   +  'Customers_Data_2.ndf'            -- Costomers_Group
,@Product_Data_1	   nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Products_Group\'    +  'Product_Data_1.ndf'              -- Одна папка для двух файлов
,@Product_Data_2	   nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Products_Group\'    +  'Product_Data_2.ndf'	           -- Products_Group
,@Orders_Data_1	       nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Orders_Group\'      +  'Orders_Data_1.ndf'               -- Одна папка для двух файлов
,@Orders_Data_2	       nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Orders_Group\'      +  'Orders_Data_2.ndf'	           -- Orders_Group
,@Employee_Data_1	   nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Employee_Group\'    +  'Employee_Data_1.ndf'             -- Одна папка для двух файлов
,@Employee_Data_2	   nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Employee_Group\'    +  'Employee_Data_2.ndf'	           -- Employee_Group
,@Log_Data             nvarchar(400) =  'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\Log_Data\'          +  'Log_Data.ldf'                    -- Папка для  Log_Data
                                         --------------------------------------------    
--Потом введите данные о секционировании, и о файловойгруппе для него. Так же путь к папке где он будет хронится
 declare 
 @ID_Employee_Audit_PARTITION  nvarchar(400) = 'd:\Программы\БД\Моя база данных\2024\Более новая БД\Настройка реплики\PARTITION\'  +  'ID_Employee_Audit_PARTITION.ndf' -- Папка для одного файла



declare @SQL_Cod nvarchar(max) -- В коде не должно быть комментариев, а то будут ошибка, или просто не сработает
set @SQL_Cod = N'
create database Magaz_DB
on primary 																	
(																			
name =  Magaz_DB_Root,													
filename = '''+@Magaz_DB_Root+''',										
size = 50 mb ,																
maxsize = 5000 mb,															
filegrowth = 50 mb															
),																			
filegroup  Costomers_Group												
(																			
name =  Customers_Data_1,													
filename = '''+@Customers_Data_1+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
),																			
(																			
name =  Customers_Data_2,													
filename = '''+@Customers_Data_2+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
),																			
filegroup  Products_Group													
(																			
name =  Product_Data_1,													
filename = '''+@Product_Data_1+''',										
size = 50 mb,																
maxsize = 1000 mb,															
filegrowth = 50 mb															
),																			
(																			
name =  Product_Data_2,													
filename = '''+@Product_Data_2+''',										
size = 50 mb,																
maxsize = 1000 mb,															
filegrowth = 50 mb															
),																			
filegroup  Orders_Group													
(																			
name =  Orders_Data_1,													
filename = '''+@Orders_Data_1+''',										
size = 50 mb,																
maxsize = 500 mb,															
filegrowth = 50 mb															
),																			
(																			
name =  Orders_Data_2,													
filename = '''+@Orders_Data_2+''',										
size = 50 mb,																
maxsize = 500 mb,															
filegrowth = 50 mb															
),																			
filegroup  Employee_Group													
(																			
name =  Employee_Data_1,													
filename = '''+@Employee_Data_1+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
),																			
(																			
name =  Employee_Data_2,													
filename = '''+@Employee_Data_2+''',										
size = 25 mb,																
maxsize = 250 mb,															
filegrowth = 25 mb															
),
filegroup  ID_Employee_Audit_PARTITION	
(
 name = ID_Employee_Audit_PARTITION                    
,FileName = '''+@ID_Employee_Audit_PARTITION+'''
,size	 = 50 mb
,maxsize = 5000 mb,															
filegrowth = 50 mb	
) 
log on																		
(																			
name = Log_Data,															
filename = '''+@Log_Data+''',												
size = 20mb,																
maxsize =1200mb,															
filegrowth = 40mb															
)																			
collate Cyrillic_General_CI_AS                                              
'

EXEC sp_executesql @SQL_Cod

go
-------------------------------------------------------------------------------------------------------------------------

--Создаём диопазонное секционирование.
--№1 Создаём файловую группу ID_Employee_Audit_PARTITION
--№2 Создаём функцию секционирования PF_PartFuncDate_LEFT
--№3 Создаём схему секционирования  SH_PartFuncDate_LEFT

--Наименование name должно будет тоже самое что и  FileName а то будет ошибка

use Magaz_DB
go
CREATE PARTITION FUNCTION PF_PartFuncDate_LEFT (int)  
AS RANGE right FOR VALUES (
2000,
4000,
6000,
8000);
go

CREATE PARTITION SCHEME SH_PartFuncDate_LEFT
AS PARTITION PF_PartFuncDate_LEFT
all TO (ID_Employee_Audit_PARTITION) -- Всё в одну файловую группу
go  

--select * from sys.partitions
--select * from sys.partition_functions  -- Просмотр функции Секционирования
--select * from sys.partition_schemes    -- Просмотр схем Секционирования
 
--Сначала удаляем схему секционирования, а то функция не удалится.

--DROP PARTITION SCHEME SH_PartFuncDate_LEFT 
--DROP PARTITION SCHEME SH_PartFuncDate_Right
--А потом уже саму функцию

--DROP PARTITION FUNCTION  PF_PartFuncDate_LEFT
--DROP PARTITION FUNCTION 	PF_PartFuncDate_Right


-----------------------------------------------------------------------------------------------------------------------------

ALTER DATABASE Magaz_DB  -- Изменение протоколирования БД,
SET RECOVERY FULL        -- FULL | SIMPLE | BULK_LOGGED. Указываем модель полного восстановления (Full) 
go



use Magaz_DB
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
Date_Сard_Сreated_Employee datetime       not null default GetDate(),
Residential_Address        nvarchar(400)  null,
Home_Phone                 nvarchar(30)   null,
Cell_Phone                 nvarchar(30)   null,
Image_Employees            varbinary(max) null,    
Work_Phone                 nvarchar(30)   null,
Mail                       nvarchar(150)  null,
Pol                        char(1)        not null CHECK (Pol IN ('М', 'Ж')),
Date_Of_Dismissal          datetime       null,
Date_Of_Birth              datetime       not null,
[Description]              nvarchar(1000) null, 
constraint PK_ID_Employee Primary key  (ID_Employee),
constraint FK_Employees_ID_Chief Foreign key(ID_Chief) references dbo.Employees(ID_Employee)  on delete NO ACTION --on Update NO ACTION  --Ссылается на саму себя, указывая на одного из сотрудников, при удалении останится  null в данном поле, при обновлении изменения внесуться.
) on Employee_Group
go


--alter table dbo.[Employees] add Image_Employees varbinary(max) null;

create table dbo.[Department]
(
ID_Department               bigint         not null identity (1,1) check(ID_Department != 0),
ID_Head_Department          bigint         null,
ID_Vice_Head_Department     bigint         null,
Name_Department             nvarchar(300)  not null,
ID_Branch                   bigint         null,
Department_Сode             int            null,
[Description]               nvarchar(1000) null, 
constraint PK_ID_Department Primary key  (ID_Department),
) on Employee_Group
go

create table dbo.[Group] 
(
ID_Group                bigint         not null identity (1,1) check(ID_Group  != 0),
ID_Head_Group           bigint         null,
ID_Vice_Head_Group      bigint         null,
ID_Department           bigint         not null,
Name_Group              nvarchar(300)  not null,
ID_Branch               bigint         null,
Department_Сode         int            null,
[Description]           nvarchar(1000) null, 
constraint PK_ID_Group  Primary key  (ID_Group),
) on Employee_Group
go

create table dbo.[The_Subgroup] 
(
ID_The_Subgroup            bigint         not null identity (1,1) check(ID_The_Subgroup  != 0),
ID_Head_The_Subgroup       bigint         null,
ID_Vice_Head_The_Subgroup  bigint         null,
ID_Group                   bigint         not null,
Name_The_Subgroup          nvarchar(300)  not null,
ID_Branch                  bigint         null,
Department_Сode            int            null,
[Description]              nvarchar(1000) null,
ID_Parent_The_Subgroup     bigint         null,
constraint PK_The_Subgroup Primary key  (ID_The_Subgroup),
constraint FK_ID_Parent_The_Subgroup Foreign key (ID_Parent_The_Subgroup) references The_Subgroup(ID_The_Subgroup)  on delete NO ACTION
) on Employee_Group
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
) on Employee_Group
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
) on Employee_Group
go

create table Status_Employee  
(
ID_Status_Employee   bigint         not null identity (1,1) check(ID_Status_Employee  != 0),
Name_Status_Employee nvarchar(100)  not null,
[Description]        nvarchar(1000) null,
constraint PK_ID_Status_Employee Primary key  (ID_Status_Employee),
) on Employee_Group
go

create table Connection_String 
(
ID_Connection_String   bigint    not null identity (1,1) check(ID_Connection_String  != 0),
Password      nvarchar(50)       null,
Login         nvarchar(100)      null,
Date_Сreated  datetime           null default GetDate(),
[Description] nvarchar(1000)     null,
constraint PK_ID_Connection_String  Primary key  (ID_Connection_String),
) on Employee_Group
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
) on Employee_Group
go

create table Country 
(
Id_Country         bigint           not null identity (1,1) check(ID_Country  != 0),
Name_Country       nvarchar(150)    not null,
Name_English       nvarchar(150)    not null,
Cod_Country_Phone  nvarchar(10)     null,
constraint PK_ID_Country  Primary key  (ID_Country),
) on Employee_Group
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



use Magaz_DB
go

create table dbo.[Employees_Audit]
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_Employee                bigint         null,
ID_Department              bigint         null,
ID_Group                   bigint         null,
ID_The_Subgroup            bigint         null,
ID_Passport                bigint         null,
ID_Branch                  bigint         null,
ID_Post                    bigint         null,
ID_Status_Employee         bigint         null,
ID_Connection_String       bigint         null,
ID_Chief                   bigint         null,
Name                       nvarchar(100)  null,
SurName                    nvarchar(100)  null,
LastName                   nvarchar(100)  null,
Date_Of_Hiring             datetime       null, 
Date_Сard_Сreated_Employee datetime       null,
Residential_Address        nvarchar(400)  null,
Home_Phone                 nvarchar(30)   null,
Cell_Phone                 nvarchar(30)   null, 
Work_Phone                 nvarchar(30)   null,
Mail                       nvarchar(150)  null,
Pol                        char(1)        null,
Date_Of_Dismissal          datetime       null,
Date_Of_Birth              datetime       null,
[Description]              nvarchar(1000) null, 
Image_Employees            varbinary(max) null,   
--CONSTRAINT index_Employees_Audit PRIMARY KEY CLUSTERED ( AuditID ) 
) on  ID_Employee_Audit_PARTITION  --Схема
go

create clustered index index_Employees_Audit_1 on Employees_Audit(AuditID) on SH_PartFuncDate_LEFT(AuditID)
create nonclustered index index_Employees_Audit_1_n on Employees_Audit(AuditID,ID_Employee)
create nonclustered index index_Employees_Audit_1_n2 on Employees_Audit(AuditID,Date_Сard_Сreated_Employee) 
go

--------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------Employees_Audit_6---таблица для переноса секции--------------------------------------------------------------------------------
-----С теми же индексами, кластерными и не кластерными--------------------------------------------------------------------------------------------------

create table dbo.[Employees_Audit_6]
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_Employee                bigint         null,
ID_Department              bigint         null,
ID_Group                   bigint         null,
ID_The_Subgroup            bigint         null,
ID_Passport                bigint         null,
ID_Branch                  bigint         null,
ID_Post                    bigint         null,
ID_Status_Employee         bigint         null,
ID_Connection_String       bigint         null,
ID_Chief                   bigint         null,
Name                       nvarchar(100)  null,
SurName                    nvarchar(100)  null,
LastName                   nvarchar(100)  null,
Date_Of_Hiring             datetime       null, 
Date_Сard_Сreated_Employee datetime       null,
Residential_Address        nvarchar(400)  null,
Home_Phone                 nvarchar(30)   null,
Cell_Phone                 nvarchar(30)   null, 
Work_Phone                 nvarchar(30)   null,
Mail                       nvarchar(150)  null,
Pol                        char(1)        null,
Date_Of_Dismissal          datetime       null,
Date_Of_Birth              datetime       null,
[Description]              nvarchar(1000) null, 
Image_Employees            varbinary(max) null,   
--CONSTRAINT index_Employees_Audit_6 PRIMARY KEY CLUSTERED ( AuditID ) --on SH_PartFuncDate_LEFT(AuditID) 
)  on  ID_Employee_Audit_PARTITION
go 

create clustered index index_Employees_Audit_6 on Employees_Audit_6(AuditID) on SH_PartFuncDate_LEFT(AuditID)
create nonclustered index index_Employees_Audit_6_n on Employees_Audit_6(AuditID,ID_Employee)
create nonclustered index index_Employees_Audit_6_n2 on Employees_Audit_6(AuditID,Date_Сard_Сreated_Employee) 
go

	CREATE TRIGGER TR_Employees_Audit ON dbo.Employees
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Employees_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
							   ,ID_Department             
							   ,ID_Group                  
							   ,ID_The_Subgroup           
							   ,ID_Passport               
							   ,ID_Branch                 
							   ,ID_Post                   
							   ,ID_Status_Employee        
							   ,ID_Connection_String      
							   ,ID_Chief                  
							   ,Name                      
							   ,SurName                   
							   ,LastName                  
							   ,Date_Of_Hiring            
							   ,Date_Сard_Сreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U'            
									,D.ID_Employee               
									,D.ID_Department             
									,D.ID_Group                  
									,D.ID_The_Subgroup           
									,D.ID_Passport               
									,D.ID_Branch                 
									,D.ID_Post                   
									,D.ID_Status_Employee        
									,D.ID_Connection_String      
									,D.ID_Chief                  
									,D.Name                      
									,D.SurName                   
									,D.LastName                  
									,D.Date_Of_Hiring            
									,D.Date_Сard_Сreated_Employee
									,D.Residential_Address       
									,D.Home_Phone                
									,D.Cell_Phone                
									,D.Work_Phone                
									,D.Mail                      
									,D.Pol                       
									,D.Date_Of_Dismissal         
									,D.Date_Of_Birth             
									,D.[Description]             
									,D.Image_Employees                                                                                                                 
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Employees_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
							   ,ID_Department             
							   ,ID_Group                  
							   ,ID_The_Subgroup           
							   ,ID_Passport               
							   ,ID_Branch                 
							   ,ID_Post                   
							   ,ID_Status_Employee        
							   ,ID_Connection_String      
							   ,ID_Chief                  
							   ,Name                      
							   ,SurName                   
							   ,LastName                  
							   ,Date_Of_Hiring            
							   ,Date_Сard_Сreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
									,D.ID_Employee               
									,D.ID_Department             
									,D.ID_Group                  
									,D.ID_The_Subgroup           
									,D.ID_Passport               
									,D.ID_Branch                 
									,D.ID_Post                   
									,D.ID_Status_Employee        
									,D.ID_Connection_String      
									,D.ID_Chief                  
									,D.Name                      
									,D.SurName                   
									,D.LastName                  
									,D.Date_Of_Hiring            
									,D.Date_Сard_Сreated_Employee
									,D.Residential_Address       
									,D.Home_Phone                
									,D.Cell_Phone                
									,D.Work_Phone                
									,D.Mail                      
									,D.Pol                       
									,D.Date_Of_Dismissal         
									,D.Date_Of_Birth             
									,D.[Description]             
									,D.Image_Employees           
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Employees_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
							   ,ID_Department             
							   ,ID_Group                  
							   ,ID_The_Subgroup           
							   ,ID_Passport               
							   ,ID_Branch                 
							   ,ID_Post                   
							   ,ID_Status_Employee        
							   ,ID_Connection_String      
							   ,ID_Chief                  
							   ,Name                      
							   ,SurName                   
							   ,LastName                  
							   ,Date_Of_Hiring            
							   ,Date_Сard_Сreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
									,I.ID_Employee               
									,I.ID_Department             
									,I.ID_Group                  
									,I.ID_The_Subgroup           
									,I.ID_Passport               
									,I.ID_Branch                 
									,I.ID_Post                   
									,I.ID_Status_Employee        
									,I.ID_Connection_String      
									,I.ID_Chief                  
									,I.Name                      
									,I.SurName                   
									,I.LastName                  
									,I.Date_Of_Hiring            
									,I.Date_Сard_Сreated_Employee
									,I.Residential_Address       
									,I.Home_Phone                
									,I.Cell_Phone                
									,I.Work_Phone                
									,I.Mail                      
									,I.Pol                       
									,I.Date_Of_Dismissal         
									,I.Date_Of_Birth             
									,I.[Description]             
									,I.Image_Employees           
                    FROM    Inserted I
        END
GO


create table dbo.[Department_Audit]
(
AuditID                     INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                  nVARCHAR(128)  null,
ModifiedDate                DATETIME       null,
Operation                   CHAR(1)        null,
ID_Department               bigint         null,
ID_Head_Department          bigint         null,
ID_Vice_Head_Department     bigint         null,
Name_Department             nvarchar(300)  null,
ID_Branch                   bigint         null,
Department_Сode             int            null,
[Description]               nvarchar(1000) null, 
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Department_Audit ON dbo.Department
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Department_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Сode          
							   ,[Description]            
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
									,D.ID_Department            
									,D.ID_Head_Department       
									,D.ID_Vice_Head_Department  
									,D.Name_Department          
									,D.ID_Branch                
									,D.Department_Сode          
									,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Department_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Сode          
							   ,[Description]                    
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Department            
									,D.ID_Head_Department       
									,D.ID_Vice_Head_Department  
									,D.Name_Department          
									,D.ID_Branch                
									,D.Department_Сode          
									,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Department_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Сode          
							   ,[Description]                     
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Department           
									,I.ID_Head_Department      
									,I.ID_Vice_Head_Department 
									,I.Name_Department         
									,I.ID_Branch               
									,I.Department_Сode         
									,I.[Description]           
                    FROM    Inserted I
        END
GO

create table dbo.Group_Audit
(
AuditID                 INTEGER        NOT NULL IDENTITY(1, 1),
ModifiedBy              nVARCHAR(128)  null,
ModifiedDate            DATETIME       null,
Operation               CHAR(1)        null,
ID_Group                bigint         null,
ID_Head_Group           bigint         null,
ID_Vice_Head_Group      bigint         null,
ID_Department           bigint         null,
Name_Group              nvarchar(300)  null,
ID_Branch               bigint         null,
Department_Сode         int            null,
[Description]           nvarchar(1000) null, 
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group

go
	CREATE TRIGGER TR_Group_Audit ON dbo.[Group]
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Group_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Group           
							   ,ID_Head_Group      
							   ,ID_Vice_Head_Group 
							   ,ID_Department      
							   ,Name_Group         
							   ,ID_Branch          
							   ,Department_Сode    
							   ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
									,D.ID_Group           
									,D.ID_Head_Group      
									,D.ID_Vice_Head_Group 
									,D.ID_Department      
									,D.Name_Group         
									,D.ID_Branch          
									,D.Department_Сode    
									,D.[Description]      
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Group_Audit
                            ( 
                                ModifiedBy         
							   ,ModifiedDate       
							   ,Operation          
                               ,ID_Group           
							   ,ID_Head_Group      
							   ,ID_Vice_Head_Group 
							   ,ID_Department      
							   ,Name_Group         
							   ,ID_Branch          
							   ,Department_Сode    
							   ,[Description]      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Group           
									,D.ID_Head_Group      
									,D.ID_Vice_Head_Group 
									,D.ID_Department      
									,D.Name_Group         
									,D.ID_Branch          
									,D.Department_Сode    
									,D.[Description]                          
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Group_Audit
                    ( 
                         ModifiedBy         
						,ModifiedDate       
						,Operation          
						,ID_Group           
						,ID_Head_Group      
						,ID_Vice_Head_Group 
						,ID_Department      
						,Name_Group         
						,ID_Branch          
						,Department_Сode    
						,[Description]                         
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Group           
									,I.ID_Head_Group      
									,I.ID_Vice_Head_Group 
									,I.ID_Department      
									,I.Name_Group         
									,I.ID_Branch          
									,I.Department_Сode    
									,I.[Description]      
                    FROM    Inserted I
        END
GO


create table dbo.[The_Subgroup_Audit] 
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_The_Subgroup            bigint         null,
ID_Head_The_Subgroup       bigint         null,
ID_Vice_Head_The_Subgroup  bigint         null,
ID_Group                   bigint         null,
Name_The_Subgroup          nvarchar(300)  null,
ID_Branch                  bigint         null,
Department_Сode            int            null,
[Description]              nvarchar(1000) null,
ID_Parent_The_Subgroup     bigint         null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go

	CREATE TRIGGER TR_The_Subgroupt_Audit ON dbo.The_Subgroup
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.The_Subgroup_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_The_Subgroup          
							   ,ID_Head_The_Subgroup     
							   ,ID_Vice_Head_The_Subgroup
							   ,ID_Group                 
							   ,Name_The_Subgroup        
							   ,ID_Branch                
							   ,Department_Сode          
							   ,[Description]            
							   ,ID_Parent_The_Subgroup            
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_The_Subgroup          
                                    ,D.ID_Head_The_Subgroup     
                                    ,D.ID_Vice_Head_The_Subgroup
                                    ,D.ID_Group                 
                                    ,D.Name_The_Subgroup        
                                    ,D.ID_Branch                
                                    ,D.Department_Сode          
                                    ,D.[Description]            
                                    ,D.ID_Parent_The_Subgroup                   
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.The_Subgroup_Audit
                            ( 
                                ModifiedBy                
                               ,ModifiedDate              
                               ,Operation                 
                               ,ID_The_Subgroup          
                               ,ID_Head_The_Subgroup     
                               ,ID_Vice_Head_The_Subgroup
                               ,ID_Group                 
                               ,Name_The_Subgroup        
                               ,ID_Branch                
                               ,Department_Сode          
                               ,[Description]            
                               ,ID_Parent_The_Subgroup                          
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_The_Subgroup          
                                    ,D.ID_Head_The_Subgroup     
                                    ,D.ID_Vice_Head_The_Subgroup
                                    ,D.ID_Group                 
                                    ,D.Name_The_Subgroup        
                                    ,D.ID_Branch                
                                    ,D.Department_Сode          
                                    ,D.[Description]            
                                    ,D.ID_Parent_The_Subgroup                       
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.The_Subgroup_Audit
                    ( 
                                 ModifiedBy                
                                ,ModifiedDate              
                                ,Operation                 
                                ,ID_The_Subgroup          
                                ,ID_Head_The_Subgroup     
                                ,ID_Vice_Head_The_Subgroup
                                ,ID_Group                 
                                ,Name_The_Subgroup        
                                ,ID_Branch                
                                ,Department_Сode          
                                ,[Description]            
                                ,ID_Parent_The_Subgroup                         
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_The_Subgroup          
                                    ,I.ID_Head_The_Subgroup     
                                    ,I.ID_Vice_Head_The_Subgroup
                                    ,I.ID_Group                 
                                    ,I.Name_The_Subgroup        
                                    ,I.ID_Branch                
                                    ,I.Department_Сode          
                                    ,I.[Description]            
                                    ,I.ID_Parent_The_Subgroup               
                    FROM    Inserted I
        END
GO

create table dbo.Passport_Audit
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_Passport                bigint         null,
Number_Series              nvarchar(100)  null,
Date_Of_Issue              Datetime       null,
Department_Code            nvarchar(20)   null,
Issued_By_Whom             nvarchar(400)  null,
Registration               nvarchar(200)  null,
Military_Duty              nvarchar(200)  null,
[Description]              nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Passport_Audit ON dbo.Passport
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Passport_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport      
                               ,Number_Series    
                               ,Date_Of_Issue    
                               ,Department_Code  
                               ,Issued_By_Whom   
                               ,Registration     
                               ,Military_Duty    
                               ,[Description]             
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Passport      
                                    ,D.Number_Series    
                                    ,D.Date_Of_Issue    
                                    ,D.Department_Code  
                                    ,D.Issued_By_Whom   
                                    ,D.Registration     
                                    ,D.Military_Duty    
                                    ,D.[Description]              
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Passport_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport     
                               ,Number_Series   
                               ,Date_Of_Issue   
                               ,Department_Code 
                               ,Issued_By_Whom  
                               ,Registration    
                               ,Military_Duty   
                               ,[Description]                      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Passport     
                                    ,D.Number_Series   
                                    ,D.Date_Of_Issue   
                                    ,D.Department_Code 
                                    ,D.Issued_By_Whom  
                                    ,D.Registration    
                                    ,D.Military_Duty   
                                    ,D.[Description]                      
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Passport_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport     
                               ,Number_Series   
                               ,Date_Of_Issue   
                               ,Department_Code 
                               ,Issued_By_Whom  
                               ,Registration    
                               ,Military_Duty   
                               ,[Description]                      
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Passport     
                                    ,I.Number_Series   
                                    ,I.Date_Of_Issue   
                                    ,I.Department_Code 
                                    ,I.Issued_By_Whom  
                                    ,I.Registration    
                                    ,I.Military_Duty   
                                    ,I.[Description]              
                    FROM    Inserted I
        END
GO

create table Post_Audit  
(
AuditID               INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy            nVARCHAR(128)  null,
ModifiedDate          DATETIME       null,
Operation             CHAR(1)        null,
ID_Post               bigint         null,
Name_Post             nvarchar(200)  null,
ID_Department         bigint         null,
ID_Group              bigint         null,
ID_The_Subgroup       bigint         null,
[Description]         nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Post_Audit ON dbo.Post
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Post_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]             
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Post         
                                    ,D.Name_Post       
                                    ,D.ID_Department   
                                    ,D.ID_Group        
                                    ,D.ID_The_Subgroup 
                                    ,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Post_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]                      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Post         
                                    ,D.Name_Post       
                                    ,D.ID_Department   
                                    ,D.ID_Group        
                                    ,D.ID_The_Subgroup 
                                    ,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Post_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]                       
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Post         
                                    ,I.Name_Post       
                                    ,I.ID_Department   
                                    ,I.ID_Group        
                                    ,I.ID_The_Subgroup 
                                    ,I.[Description]             
                    FROM    Inserted I
        END
GO

create table Status_Employee_Audit  
(
AuditID              INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy           nVARCHAR(128)  null,
ModifiedDate         DATETIME       null,
Operation            CHAR(1)        null,
ID_Status_Employee   bigint         null,
Name_Status_Employee nvarchar(100)  null,
[Description]        nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Status_Employee_Audit ON dbo.Status_Employee
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Status_Employee_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Status_Employee  
                               ,Name_Status_Employee
                               ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Status_Employee  
                                    ,D.Name_Status_Employee
                                    ,D.[Description]                
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Status_Employee_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Status_Employee  
                               ,Name_Status_Employee
                               ,[Description]                       
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Status_Employee  
                                    ,D.Name_Status_Employee
                                    ,D.[Description]                         
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Status_Employee_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Status_Employee  
                               ,Name_Status_Employee
                               ,[Description]                          
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Status_Employee  
                                    ,I.Name_Status_Employee
                                    ,I.[Description]                 
                    FROM    Inserted I
        END
GO

create table Connection_String_Audit 
(
AuditID                INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy             nVARCHAR(128)  null,
ModifiedDate           DATETIME       null,
Operation              CHAR(1)        null,
ID_Connection_String   bigint         null,
Password               nvarchar(50)   null,
Login                  nvarchar(100)  null,
Date_Сreated           datetime       null,
[Description]          nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Connection_String_Audit ON dbo.Connection_String
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Connection_String_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Connection_String 
                               ,Password             
                               ,Login                
                               ,Date_Сreated         
                               ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Connection_String 
                                    ,D.Password             
                                    ,D.Login                
                                    ,D.Date_Сreated         
                                    ,D.[Description]                   
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Connection_String_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Connection_String 
                               ,Password             
                               ,Login                
                               ,Date_Сreated         
                               ,[Description]                           
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Connection_String 
                                    ,D.Password             
                                    ,D.Login                
                                    ,D.Date_Сreated         
                                    ,D.[Description]                           
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Connection_String_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Connection_String 
                               ,Password             
                               ,Login                
                               ,Date_Сreated         
                               ,[Description]                            
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Connection_String 
                                    ,I.Password             
                                    ,I.Login                
                                    ,I.Date_Сreated         
                                    ,I.[Description]                  
                    FROM    Inserted I
        END
GO
create table Branch_Audit 
(
AuditID       INTEGER         NOT NULL IDENTITY(1, 1) ,
ModifiedBy    nVARCHAR(128)   null,
ModifiedDate  DATETIME        null,
Operation     CHAR(1)         null,
ID_Branch     bigint          null,
Id_Country    bigint          null,
City          nvarchar(100)   null,
[Address]     nvarchar(300)   null,
Name_Branch   nvarchar(300)   null,
Mail          nvarchar(300)   null,
Phone         nvarchar(15)    null,
Postal_Code   int             null,
INN           int             null,
[Description] nvarchar(1000)  null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Branch_Audit ON dbo.Branch
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Branch_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]        
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Branch    
                                    ,D.Id_Country   
                                    ,D.City         
                                    ,D.[Address]    
                                    ,D.Name_Branch  
                                    ,D.Mail         
                                    ,D.Phone        
                                    ,D.Postal_Code  
                                    ,D.INN          
                                    ,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Branch_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]                  
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Branch    
                                    ,D.Id_Country   
                                    ,D.City         
                                    ,D.[Address]    
                                    ,D.Name_Branch  
                                    ,D.Mail         
                                    ,D.Phone        
                                    ,D.Postal_Code  
                                    ,D.INN          
                                    ,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Branch_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]                   
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Branch    
                                    ,I.Id_Country   
                                    ,I.City         
                                    ,I.[Address]    
                                    ,I.Name_Branch  
                                    ,I.Mail         
                                    ,I.Phone        
                                    ,I.Postal_Code  
                                    ,I.INN          
                                    ,I.[Description]          
                    FROM    Inserted I
        END
GO

create table Country_Audit 
(
AuditID            INTEGER          NOT NULL IDENTITY(1, 1) ,
ModifiedBy         nVARCHAR(128)    null,
ModifiedDate       DATETIME         null,
Operation          CHAR(1)          null,
Id_Country         bigint           null,
Name_Country       nvarchar(150)    null,
Name_English       nvarchar(150)    null,
Cod_Country_Phone  nvarchar(10)     null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Country_Audit  ON dbo.Country
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Country_Audit 
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone           
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.Id_Country        
                                    ,D.Name_Country      
                                    ,D.Name_English      
                                    ,D.Cod_Country_Phone           
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Country_Audit 
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone                   
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.Id_Country        
                                    ,D.Name_Country      
                                    ,D.Name_English      
                                    ,D.Cod_Country_Phone                   
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Country_Audit 
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone                   
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.Id_Country        
                                    ,I.Name_Country      
                                    ,I.Name_English      
                                    ,I.Cod_Country_Phone           
                    FROM    Inserted I
        END
GO


--select * from Country
--select * from Passport
--select * from Status_Employee
--select * from Connection_String
--select * from Branch
--select * from Department
--select * from [Group]
--select * from The_Subgroup
--select * from Post

--select * from Country_Audit
--select * from Passport_Audit
--select * from Status_Employee_Audit
--select * from Connection_String_Audit
--select * from Branch_Audit
--select * from Department_Audit
--select * from Group_Audit
--select * from The_Subgroup_Audit
--select * from Post_Audit
-----------------------------------------------------------1111111111111111111111111111111111111111---------------------------------------------------
use Magaz_DB
go
begin tran
INSERT INTO dbo.Country (Name_Country, Name_English, Cod_Country_Phone) VALUES
('Австралия', 'Australia', '+61'),
('Австрия', 'Austria', '+43'),
('Азербайджан', 'Azerbaijan', '+994'),
('Албания', 'Albania', '+355'),
('Алжир', 'Algeria', '+213'),
('Американское Самоа', 'American Samoa', '+1684'),
('Ангилья', 'Anguilla', '+1264'),
('Ангола', 'Angola', '+244'),
('Антигуа и Барбуда', 'Antigua and Barbuda', '+1-268'),
('Аргентина', 'Argentina', '+54'),
('Армения', 'Armenia', '+374'),
('Афганистан', 'Afghanistan', '+93'),
('Багамские Острова', 'Bahamas', '+1-242'),
('Бангладеш', 'Bangladesh', '+880'),
('Барбадос', 'Barbados', '+1-246'),
('Бахрейн', 'Bahrain', '+973'),
('Беларусь', 'Belarus', '+375'),
('Белиз', 'Belize', '+501'),
('Бельгия', 'Belgium', '+32'),
('Бенин', 'Benin', '+229'),
('Болгария', 'Bulgaria', '+359'),
('Боливия', 'Bolivia', '+591'),
('Бразилия', 'Brazil', '+55'),
('Буркина-Фасо', 'Burkina Faso', '+226'),
('Бурунди', 'Burundi', '+257'),
('Вануату', 'Vanuatu', '+678'),
('Ватикан', 'Vatican City', '+39'),
('Венгрия', 'Hungary', '+36'),
('Венесуэла', 'Venezuela', '+58'),
('Вьетнам', 'Vietnam', '+84'),
('Габон', 'Gabon', '+241'),
('Гаити', 'Haiti', '+509'),
('Гана', 'Ghana', '+233'),
('Греция', 'Greece', '+30'),
('Гренада', 'Grenada', '+1-473'),
('Грузия', 'Georgia', '+995'),
('Дания', 'Denmark', '+45'),
('Джорджия', 'Georgia', '+995'),
('Доминика', 'Dominica', '+1-767'),
('Доминиканская Республика', 'Dominican Republic', '+1-809'),
('Египет', 'Egypt', '+20'),
('Замбия', 'Zambia', '+260'),
('Зимбабве', 'Zimbabwe', '+263'),
('Индия', 'India', '+91'),
('Индонезия', 'Indonesia', '+62'),
('Иордания', 'Jordan', '+962'),
('Ирландия', 'Ireland', '+353'),
('Исландия', 'Iceland', '+354'),
('Испания', 'Spain', '+34'),
('Италия', 'Italy', '+39'),
('Кабо-Верде', 'Cabo Verde', '+238'),
('Казахстан', 'Kazakhstan', '+7'),
('Канаду', 'Canada', '+1'),
('Катар', 'Qatar', '+974'),
('Кения', 'Kenya', '+254'),
('Кипр', 'Cyprus', '+357'),
('Киргизия', 'Kyrgyzstan', '+996'),
('Китай', 'China', '+86'),
('Корея, Северная', 'North Korea', '+850'),
('Корея, Южная', 'South Korea', '+82'),
('Коста-Рика', 'Costa Rica', '+506'),
('Кот-д’Ивуар', 'Ivory Coast', '+225'),
('Куба', 'Cuba', '+53'),
('Кюрасао', 'Curaçao', '+599'),
('Лаос', 'Laos', '+856'),
('Латвия', 'Latvia', '+371'),
('Лесото', 'Lesotho', '+266'),
('Литва', 'Lithuania', '+370'),
('Люксембург', 'Luxembourg', '+352'),
('Маврикий', 'Mauritius', '+230'),
('Мавритания', 'Mauritania', '+222'),
('Мадейра', 'Madeira', '+351'),
('Малайзия', 'Malaysia', '+60'),
('Мали', 'Mali', '+223'),
('Мальдивы', 'Maldives', '+960'),
('Мальта', 'Malta', '+356'),
('Мексика', 'Mexico', '+52'),
('Молдова', 'Moldova', '+373'),
('Монако', 'Monaco', '+377'),
('Монголия', 'Mongolia', '+976'),
('Морокко', 'Morocco', '+212'),
('Намибия', 'Namibia', '+264'),
('Непал', 'Nepal', '+977'),
('Нигер', 'Niger', '+227'),
('Нигерия', 'Nigeria', '+234'),
('Новая Зеландия', 'New Zealand', '+64'),
('Норвегия', 'Norway', '+47'),
('Объединенные Арабские Эмираты', 'United Arab Emirates', '+971'),
('Оман', 'Oman', '+968'),
('Пакистан', 'Pakistan', '+92'),
('Палау', 'Palau', '+680'),
('Панама', 'Panama', '+507'),
('Папуа – Новая Гвинея', 'Papua New Guinea', '+675'),
('Парагвай', 'Paraguay', '+595'),
('Португалия', 'Portugal', '+351'),
('Россия', 'Russia', '+7'),
('Румыния', 'Romania', '+40'),
('Сальвадор', 'El Salvador', '+503'),
('Саудовская Аравия', 'Saudi Arabia', '+966'),
('Сингапур', 'Singapore', '+65'),
('Словакия', 'Slovakia', '+421'),
('Словения', 'Slovenia', '+386'),
('Сомали', 'Somalia', '+252'),
('Судан', 'Sudan', '+249'),
('Таджикистан', 'Tajikistan', '+992'),
('Таиланд', 'Thailand', '+66'),
('Тайвань', 'Taiwan', '+886'),
('Танзания', 'Tanzania', '+255'),
('Того', 'Togo', '+228'),
('Туркменистан', 'Turkmenistan', '+993'),
('Турция', 'Turkey', '+90'),
('Уганда', 'Uganda', '+256'),
('Узбекистан', 'Uzbekistan', '+998'),
('Украина', 'Ukraine', '+380'),
('Уругвай', 'Uruguay', '+598'),
('Филиппины', 'Philippines', '+63'),
('Финляндия', 'Finland', '+358'),
('Франция', 'France', '+33'),
('Хорватия', 'Croatia', '+385'),
('Центральноафриканская Республика', 'Central African Republic', '+236'),
('Чад', 'Chad', '+235'),
('Чехия', 'Czech Republic', '+420'),
('Чили', 'Chile', '+56'),
('Швейцария', 'Switzerland', '+41'),
('Швеция', 'Sweden', '+46'),
('Эквадор', 'Ecuador', '+593'),
('Экваториальная Гвинея', 'Equatorial Guinea', '+240'),
('Эстония', 'Estonia', '+372'),
('Южноафриканская Республика', 'South Africa', '+27'),
('Южный Судан', 'South Sudan', '+211'),
('Япония', 'Japan', '+81');

go

---------------------------------------------------------------------22222222222222222222222222222222222222---------------------------------------------
set nocount, xact_abort on


   DECLARE @i INT = 0;

WHILE @i < 100
BEGIN
    INSERT INTO Passport (Number_Series, Date_Of_Issue, Department_Code, Issued_By_Whom, Registration, Military_Duty, [Description])
    VALUES (
        CAST(ROUND(RAND() * 9999, 0) AS NVARCHAR(10)) + '-' + CAST(ROUND(RAND() * 999999, 0) AS NVARCHAR(10)), 
        DATEADD(DAY, -ROUND(RAND() * 15650, 0), GETDATE()), 
        CAST(ROUND(RAND() * 999999, 0) AS NVARCHAR(10)), 
        CASE WHEN ROUND(RAND() * 9, 0) = 0 THEN N'Отделение паспортного стола города Москвы'
             WHEN ROUND(RAND() * 9, 0) = 1 THEN N'Паспортный стол города Санкт-Петербурга'
             WHEN ROUND(RAND() * 9, 0) = 2 THEN N'Отделение по выдаче паспортов города Новосибирска'
			 WHEN ROUND(RAND() * 9, 0) = 3 THEN N'Отделом УФМС по Краснодарскому краю, города Архипа-Осипова'
			 WHEN ROUND(RAND() * 9, 0) = 4 THEN N'Отделом УФМС по Ставропольскому краю, города Ставрополя'
			 WHEN ROUND(RAND() * 9, 0) = 5 THEN N'Отделом УФМС по Калужскому району, города Калуги'
			 WHEN ROUND(RAND() * 9, 0) = 6 THEN N'Отделения паспортного стола по городу Владивосток'
			 WHEN ROUND(RAND() * 9, 0) = 7 THEN N'Отделения паспортного стола по городу Елец'
			 WHEN ROUND(RAND() * 9, 0) = 8 THEN N'Отделения паспортного стола по Республике Карачаево-Черкесия в городе Залукокажи'
             ELSE N'Паспортный стол города Екатеринбурга' END,
        CASE WHEN ROUND(RAND() * 12, 0) = 0 THEN N'ул. Пушкина, д. 1, г. Москва'
             WHEN ROUND(RAND() * 12, 0) = 1 THEN N'ул. Ленина, д. 2, г. Санкт-Петербург'
             WHEN ROUND(RAND() * 12, 0) = 2 THEN N'ул. Свердлова, д. 3, г. Новосибирск'
			 WHEN ROUND(RAND() * 12, 0) = 3 THEN N'ул. Кутузова, д. 3,к 2, г. Лысвегас'
			 WHEN ROUND(RAND() * 12, 0) = 4 THEN N'ул. Подольских курсантов, д. 43,стр 2, г. Пятигорск'
			 WHEN ROUND(RAND() * 12, 0) = 5 THEN N'ул. Проспект Богратиона, д. 10,к 3, г. Салекамск'
			 WHEN ROUND(RAND() * 12, 0) = 6 THEN N'ул. Ленина, д. 145, г. Сывтывкар'
			 WHEN ROUND(RAND() * 12, 0) = 7 THEN N'ул. Павла Морозова, д. 43,к 6, г. Москва'
			 WHEN ROUND(RAND() * 12, 0) = 8 THEN N'ул. Лесная, д. 46,к 5, г. Новосибирск'
			 WHEN ROUND(RAND() * 12, 0) = 9 THEN N'ул. Проспект Ермолова, д. 78,стр 2, к 6, г. Москва'
			 WHEN ROUND(RAND() * 12, 0) = 10 THEN N'ул. Бульвар северный, д. 79, г. Владикавказ'
			 WHEN ROUND(RAND() * 12, 0) = 11 THEN N'ул. Чкалова, д.56,к 34, г. Ставрополь'
             ELSE N'ул. Куйбышева, д. 4, г. Екатеринбург' END,
        CASE 
		     WHEN ROUND(RAND() * 101, 0) = 0  THEN N'Военнообязанный, проходил службу в части 12345, ВДВ'
             WHEN ROUND(RAND() * 101, 0) = 1  THEN 'Номер части: 23456789, Род войск: Пехота, Дата начала службы: 01.01.2010, Дата окончания службы: 31.12.2015'
             WHEN ROUND(RAND() * 101, 0) = 2  THEN 'Номер части: 123, Род войск: ВМС, Дата начала службы: 15.03.2005, Дата окончания службы: 15.03.2010'
             WHEN ROUND(RAND() * 101, 0) = 3  THEN 'Номер части: 45678, Род войск: Авиация, Дата начала службы: 01.06.2008, Дата окончания службы: 30.06.2013'
             WHEN ROUND(RAND() * 101, 0) = 4  THEN 'Номер части: 98765432, Род войск: Артиллерия, Дата начала службы: 20.02.2000, Дата окончания службы: 20.02.2005'
             WHEN ROUND(RAND() * 101, 0) = 5  THEN 'Номер части: 345, Род войск: Инженерные войска, Дата начала службы: 10.11.2011, Дата окончания службы: 10.11.2016'
             WHEN ROUND(RAND() * 101, 0) = 6  THEN 'Номер части: 6789, Род войск: Специальные силы, Дата начала службы: 01.04.2007, Дата окончания службы: 01.04.2012'
             WHEN ROUND(RAND() * 101, 0) = 7  THEN 'Номер части: 123456789, Род войск: связи, Дата начала службы: 15.08.2006, Дата окончания службы: 15.08.2011'
             WHEN ROUND(RAND() * 101, 0) = 8  THEN 'Номер части: 222, Род войск: ПВО, Дата начала службы: 01.12.2009, Дата окончания службы: 01.12.2014'
             WHEN ROUND(RAND() * 101, 0) = 9  THEN 'Номер части: 456789, Род войск: Механизированные войска, Дата начала службы: 10.05.2003, Дата окончания службы: 10.05.2008'
             WHEN ROUND(RAND() * 101, 0) = 10  THEN 'Номер части: 333, Род войск: Кадровые войска, Дата начала службы: 20.01.2012, Дата окончания службы: 20.01.2017'
             WHEN ROUND(RAND() * 101, 0) = 11  THEN 'Номер части: 5555, Род войск: ЗПС, Дата начала службы: 11.02.2001, Дата окончания службы: 11.02.2006'
             WHEN ROUND(RAND() * 101, 0) = 12  THEN 'Номер части: 678, Род войск: Логистика, Дата начала службы: 01.07.2004, Дата окончания службы: 01.07.2009'
             WHEN ROUND(RAND() * 101, 0) = 13  THEN 'Номер части: 7891234, Род войск: Авиация, Дата начала службы: 15.05.2002, Дата окончания службы: 15.05.2007'
             WHEN ROUND(RAND() * 101, 0) = 14  THEN 'Номер части: 888, Род войск: Морская пехота, Дата начала службы: 20.10.2015, Дата окончания службы: 20.10.2020'
             WHEN ROUND(RAND() * 101, 0) = 15  THEN 'Номер части: 4444, Род войск: Технические войска, Дата начала службы: 25.03.2003, Дата окончания службы: 25.03.2008'
             WHEN ROUND(RAND() * 101, 0) = 16  THEN 'Номер части: 999, Род войск: Условия задач, Дата начала службы: 01.09.2010, Дата окончания службы: 01.09.2015'
             WHEN ROUND(RAND() * 101, 0) = 17  THEN 'Номер части: 1000, Род войск: Пехота, Дата начала службы: 12.08.2011, Дата окончания службы: 12.08.2016'
             WHEN ROUND(RAND() * 101, 0) = 18  THEN 'Номер части: 2222, Род войск: Артиллерия, Дата начала службы: 03.04.2002, Дата окончания службы: 03.04.2007'
             WHEN ROUND(RAND() * 101, 0) = 19  THEN 'Номер части: 55555, Род войск: Бронетанковые войска, Дата начала службы: 01.01.2014, Дата окончания службы: 01.01.2019'
             WHEN ROUND(RAND() * 101, 0) = 20  THEN 'Номер части: 444, Род войск: Саперы, Дата начала службы: 10.12.2005, Дата окончания службы: 10.12.2010'
             WHEN ROUND(RAND() * 101, 0) = 21  THEN 'Номер части: 777, Род войск: Ракетные войска, Дата начала службы: 15.11.2007, Дата окончания службы: 15.11.2012'
             WHEN ROUND(RAND() * 101, 0) = 22  THEN 'Номер части: 8888, Род войск: Подводные силы, Дата начала службы: 30.06.2009, Дата окончания службы: 30.06.2014'
             WHEN ROUND(RAND() * 101, 0) = 23  THEN 'Номер части: 101, Род войск: ПВО, Дата начала службы: 21.05.2008, Дата окончания службы: 21.05.2013'
             WHEN ROUND(RAND() * 101, 0) = 24  THEN 'Номер части: 121, Род войск: Специальные войска, Дата начала службы: 01.02.2001, Дата окончания службы: 01.02.2006'
             WHEN ROUND(RAND() * 101, 0) = 25  THEN 'Номер части: 1010, Род войск: Инженерные войска, Дата начала службы: 01.03.2014, Дата окончания службы: 01.03.2019'
             WHEN ROUND(RAND() * 101, 0) = 26  THEN 'Номер части: 212, Род войск: Воздушные силы, Дата начала службы: 15.12.2010, Дата окончания службы: 15.12.2015'
             WHEN ROUND(RAND() * 101, 0) = 27  THEN 'Номер части: 1313, Род войск: Командование, Дата начала службы: 01.04.2012, Дата окончания службы: 01.04.2017'
             WHEN ROUND(RAND() * 101, 0) = 28  THEN 'Номер части: 303, Род войск: Сигнальные войска, Дата начала службы: 20.06.2003, Дата окончания службы: 20.06.2008'
             WHEN ROUND(RAND() * 101, 0) = 29  THEN 'Номер части: 9090, Род войск: БТГ, Дата начала службы: 01.08.2014, Дата окончания службы: 01.08.2019'
             WHEN ROUND(RAND() * 101, 0) = 30  THEN 'Номер части: 7171, Род войск: Гвардейские войска, Дата начала службы: 15.10.2015, Дата окончания службы: 15.10.2020'
             WHEN ROUND(RAND() * 101, 0) = 31  THEN 'Номер части: 1456, Род войск: Десантные войска, Дата начала службы: 01.12.2011, Дата окончания службы: 01.12.2016'
             WHEN ROUND(RAND() * 101, 0) = 32  THEN 'Номер части: 1234567, Род войск: Военная разведка, Дата начала службы: 20.01.2009, Дата окончания службы: 20.01.2014'
             WHEN ROUND(RAND() * 101, 0) = 33  THEN 'Номер части: 88888, Род войск: ВТС, Дата начала службы: 10.05.2005, Дата окончания службы: 10.05.2010'
             WHEN ROUND(RAND() * 101, 0) = 34  THEN 'Номер части: 32, Род войск: Дальняя авиация, Дата начала службы: 01.01.2015, Дата окончания службы: 01.01.2020'
             WHEN ROUND(RAND() * 101, 0) = 35  THEN 'Номер части: 909, Род войск: Тыловые войска, Дата начала службы: 01.02.2012, Дата окончания службы: 01.02.2017'
             WHEN ROUND(RAND() * 101, 0) = 36  THEN 'Номер части: 4567, Род войск: Оперативные силы, Дата начала службы: 10.03.2006, Дата окончания службы: 10.03.2011'
             WHEN ROUND(RAND() * 101, 0) = 37  THEN 'Номер части: 1111, Род войск: Воздушно-десантные, Дата начала службы: 15.09.2018, Дата окончания службы: 15.09.2023'
             WHEN ROUND(RAND() * 101, 0) = 38  THEN 'Номер части: 77777, Род войск: Радиационная, химическая и биологическая защита, Дата начала службы: 25.12.1999, Дата окончания службы: 25.12.2004'
             WHEN ROUND(RAND() * 101, 0) = 39  THEN 'Номер части: 4343, Род войск: Генеральный штаб, Дата начала службы: 20.05.2000, Дата окончания службы: 20.05.2005'
             WHEN ROUND(RAND() * 101, 0) = 40  THEN 'Номер части: 232323, Род войск: Инженерные войска, Дата начала службы: 01.01.2021, Дата окончания службы: 01.01.2026'
             WHEN ROUND(RAND() * 101, 0) = 41  THEN 'Номер части: 4141414, Род войск: Морская пехота, Дата начала службы: 15.03.2008, Дата окончания службы: 15.02.2013'
             WHEN ROUND(RAND() * 101, 0) = 42  THEN 'Номер части: 707, Род войск: ВМС, Дата начала службы: 01.04.2011, Дата окончания службы: 01.04.2016'
             WHEN ROUND(RAND() * 101, 0) = 43  THEN 'Номер части: 585858, Род войск: Саперы, Дата начала службы: 10.11.2014, Дата окончания службы: 10.11.2019'
             WHEN ROUND(RAND() * 101, 0) = 44  THEN 'Номер части: 62, Род войск: Авиация, Дата начала службы: 18.07.2009, Дата окончания службы: 18.07.2014'
             WHEN ROUND(RAND() * 101, 0) = 45  THEN 'Номер части: 565, Род войск: Артиллерия, Дата начала службы: 20.05.2014, Дата окончания службы: 20.05.2019'
             WHEN ROUND(RAND() * 101, 0) = 46  THEN 'Номер части: 9999, Род войск: Специальные войска, Дата начала службы: 10.05.2003, Дата окончания службы: 10.05.2008'
             WHEN ROUND(RAND() * 101, 0) = 47  THEN 'Номер части: 11, Род войск: Ракетные войска, Дата начала службы: 12.04.2013, Дата окончания службы: 12.04.2018'
             WHEN ROUND(RAND() * 101, 0) = 48  THEN 'Номер части: 22, Род войск: Защита, Дата начала службы: 01.01.2017, Дата окончания службы: 01.01.2022'
             WHEN ROUND(RAND() * 101, 0) = 49  THEN 'Номер части: 77, Род войск: ПВО, Дата начала службы: 15.08.2018, Дата окончания службы: 15.08.2023'
             WHEN ROUND(RAND() * 101, 0) = 50  THEN 'Номер части: 44444, Род войск: Бронетанковые войска, Дата начала службы: 21.09.2001, Дата окончания службы: 21.09.2006'
             WHEN ROUND(RAND() * 101, 0) = 51  THEN 'Номер части: 888, Род войск: Подводные силы, Дата начала службы: 01.04.2010, Дата окончания службы: 01.04.2015'
             WHEN ROUND(RAND() * 101, 0) = 52  THEN 'Номер части: 9000000, Род войск: Тактические войска, Дата начала службы: 30.06.2005, Дата окончания службы: 30.06.2010'
             WHEN ROUND(RAND() * 101, 0) = 53  THEN 'Номер части: 55, Род войск: Генеральный штаб, Дата начала службы: 20.10.2011, Дата окончания службы: 20.10.2016'
             WHEN ROUND(RAND() * 101, 0) = 54  THEN 'Номер части: 877, Род войск: ВВС, Дата начала службы: 01.12.2009, Дата окончания службы: 01.12.2014'
             WHEN ROUND(RAND() * 101, 0) = 55  THEN 'Номер части: 3, Род войск: ССР, Дата начала службы: 05.01.2016, Дата окончания службы: 05.01.2021'
             WHEN ROUND(RAND() * 101, 0) = 56  THEN 'Номер части: 66666, Род войск: Специальные операции, Дата начала службы: 15.02.2015, Дата окончания службы: 15.02.2020'
             WHEN ROUND(RAND() * 101, 0) = 57  THEN 'Номер части: 8888, Род войск: Пехота, Дата начала службы: 10.03.2003, Дата окончания службы: 10.03.2008'
             WHEN ROUND(RAND() * 101, 0) = 58  THEN 'Номер части: 74, Род войск: Разведка, Дата начала службы: 14.05.2011, Дата окончания службы: 14.05.2016'
             WHEN ROUND(RAND() * 101, 0) = 59  THEN 'Номер части: 999999, Род войск: Воздушные силы, Дата начала службы: 21.12.2010, Дата окончания службы: 21.12.2015'
             WHEN ROUND(RAND() * 101, 0) = 60  THEN 'Номер части: 50, Род войск: Оперативные силы, Дата начала службы: 20.03.2013, Дата окончания службы: 20.03.2018'
             WHEN ROUND(RAND() * 101, 0) = 61  THEN 'Номер части: 22222, Род войск: Инженерные войска, Дата начала службы: 31.12.2008, Дата окончания службы: 31.12.2013'
             WHEN ROUND(RAND() * 101, 0) = 62  THEN 'Номер части: 66, Род войск: Артиллерия, Дата начала службы: 15.04.2015, Дата окончания службы: 15.04.2020'
             WHEN ROUND(RAND() * 101, 0) = 63  THEN 'Номер части: 434, Род войск: Тактические войска, Дата начала службы: 10.08.2014, Дата окончания службы: 10.08.2019'
             WHEN ROUND(RAND() * 101, 0) = 64  THEN 'Номер части: 72, Род войск: Саперы, Дата начала службы: 01.02.2010, Дата окончания службы: 01.02.2015'
             WHEN ROUND(RAND() * 101, 0) = 65  THEN 'Номер части: 8989, Род войск: ПВО, Дата начала службы: 01.06.2003, Дата окончания службы: 01.06.2008'
             WHEN ROUND(RAND() * 101, 0) = 66  THEN 'Номер части: 101010, Род войск: Военная разведка, Дата начала службы: 20.01.2009, Дата окончания службы: 20.01.2014'
             WHEN ROUND(RAND() * 101, 0) = 67  THEN 'Номер части: 1818, Род войск: Морская пехота, Дата начала службы: 15.05.2005, Дата окончания службы: 15.05.2010'
             WHEN ROUND(RAND() * 101, 0) = 68  THEN 'Номер части: 3434, Род войск: Все стороны, Дата начала службы: 01.08.2011, Дата окончания службы: 01.08.2016'
             WHEN ROUND(RAND() * 101, 0) = 69  THEN 'Номер части: 999, Род войск: Специальные силы, Дата начала службы: 10.10.2020, Дата окончания службы: 10.10.2025'
             WHEN ROUND(RAND() * 101, 0) = 70  THEN 'Номер части: 100, Род войск: Пехота, Дата начала службы: 15.12.2016, Дата окончания службы: 15.12.2021'
             WHEN ROUND(RAND() * 101, 0) = 71  THEN 'Номер части: 44444, Род войск: Воздушные силы, Дата начала службы: 01.03.2018, Дата окончания службы: 01.03.2023'
             WHEN ROUND(RAND() * 101, 0) = 72  THEN 'Номер части: 33333, Род войск: Артиллерия, Дата начала службы: 02.06.2014, Дата окончания службы: 02.06.2019'
             WHEN ROUND(RAND() * 101, 0) = 73  THEN 'Номер части: 5757, Род войск: ВМС, Дата начала службы: 10.12.2007, Дата окончания службы: 10.12.2012'
             WHEN ROUND(RAND() * 101, 0) = 74  THEN 'Номер части: 313, Род войск: ПВО, Дата начала службы: 21.07.2006, Дата окончания службы: 21.07.2011'
             WHEN ROUND(RAND() * 101, 0) = 75  THEN 'Номер части: 8282, Род войск: Ракетные войска, Дата начала службы: 15.11.2017, Дата окончания службы: 15.11.2022'
             WHEN ROUND(RAND() * 101, 0) = 76  THEN 'Номер части: 484, Род войск: Инженерные войска, Дата начала службы: 10.05.2009, Дата окончания службы: 10.05.2014'
             WHEN ROUND(RAND() * 101, 0) = 77  THEN 'Номер части: 355, Род войск: Тактические войска, Дата начала службы: 01.01.2019, Дата окончания службы: 01.01.2024'
             WHEN ROUND(RAND() * 101, 0) = 78  THEN 'Номер части: 202020, Род войск: Исследовательские войска, Дата начала службы: 10.02.2012, Дата окончания службы: 10.02.2017'
             WHEN ROUND(RAND() * 101, 0) = 79  THEN 'Номер части: 131, Род войск: Сигнальные войска, Дата начала службы: 05.06.2003, Дата окончания службы: 05.06.2008'
             WHEN ROUND(RAND() * 101, 0) = 80  THEN 'Номер части: 77777, Род войск: Дуэльные силы, Дата начала службы: 15.04.2015, Дата окончания службы: 15.04.2020'
             WHEN ROUND(RAND() * 101, 0) = 81  THEN 'Номер части: 2222222, Род войск: Подводные силы, Дата начала службы: 01.01.2004, Дата окончания службы: 01.01.2009'
             WHEN ROUND(RAND() * 101, 0) = 82  THEN 'Номер части: 828, Род войск: Специальные операции, Дата начала службы: 01.10.2013, Дата окончания службы: 01.10.2018'
             WHEN ROUND(RAND() * 101, 0) = 83  THEN 'Номер части: 7, Род войск: Инженерные войска, Дата начала службы: 01.06.2012, Дата окончания службы: 01.06.2017'
             WHEN ROUND(RAND() * 101, 0) = 84  THEN 'Номер части: 3838, Род войск: Пехота, Дата начала службы: 10.02.2008, Дата окончания службы: 10.02.2013'
             WHEN ROUND(RAND() * 101, 0) = 85  THEN 'Номер части: 1919, Род войск: Тактические войска, Дата начала службы: 05.03.2020, Дата окончания службы: 05.03.2025'
             WHEN ROUND(RAND() * 101, 0) = 86  THEN 'Номер части: 555, Род войск: Артиллерия, Дата начала службы: 15.06.2011, Дата окончания службы: 15.06.2016'
             WHEN ROUND(RAND() * 101, 0) = 87  THEN 'Номер части: 44, Род войск: Военная Полиц, Дата начала службы: 12.12.2018, Дата окончания службы: 12.12.2023'
             WHEN ROUND(RAND() * 101, 0) = 88  THEN 'Номер части: 20, Род войск: Логистика, Дата начала службы: 01.01.2011, Дата окончания службы: 01.01.2016'
             WHEN ROUND(RAND() * 101, 0) = 89  THEN 'Номер части: 99, Род войск: Гвардейские войска, Дата начала службы: 15.08.2000, Дата окончания службы: 15.08.2005'
             WHEN ROUND(RAND() * 101, 0) = 90  THEN 'Номер части: 4040, Род войск: ЗПС, Дата начала службы: 10.05.2012, Дата окончания службы: 10.05.2017'
             WHEN ROUND(RAND() * 101, 0) = 91  THEN 'Номер части: 777777, Род войск: Тактические войска, Дата начала службы: 05.01.2015, Дата окончания службы: 05.01.2020'
             WHEN ROUND(RAND() * 101, 0) = 92  THEN 'Номер части: 505, Род войск: Специальные операции, Дата начала службы: 20.10.2011, Дата окончания службы: 20.10.2016'
             WHEN ROUND(RAND() * 101, 0) = 93  THEN 'Номер части: 2121, Род войск: Объединенные силы, Дата начала службы: 01.04.2011, Дата окончания службы: 01.04.2016'
             WHEN ROUND(RAND() * 101, 0) = 94  THEN 'Номер части: 99, Род войск: Инженерные войска, Дата начала службы: 20.01.2010, Дата окончания службы: 20.01.2015'
             WHEN ROUND(RAND() * 101, 0) = 95  THEN 'Номер части: 22, Род войск: ПВО, Дата начала службы: 10.11.2008, Дата окончания службы: 10.11.2013'
             WHEN ROUND(RAND() * 101, 0) = 96  THEN 'Номер части: 444, Род войск: Авиация, Дата начала службы: 15.03.2012, Дата окончания службы: 15.03.2017'
             WHEN ROUND(RAND() * 101, 0) = 97  THEN 'Номер части: 800, Род войск: диабетическая война, Дата начала службы: 20.05.2004, Дата окончания службы: 20.05.2010'
             WHEN ROUND(RAND() * 101, 0) = 98  THEN 'Номер части: 211, Род войск: Освобождение, Дата начала службы: 01.02.2020, Дата окончания службы: 01.02.2025'
             WHEN ROUND(RAND() * 101, 0) = 99  THEN 'Номер части: 620, Род войск: Разведывательные войска, Дата начала службы: 15.09.2014, Дата окончания службы: 15.09.2019'
             WHEN ROUND(RAND() * 101, 0) = 100 THEN 'Номер части: 8000, Род войск: Далекое разведка, Дата начала службы: 01.12.2006, Дата окончания службы: 01.12.2011'
     ELSE N'Не военнообязанный' END,
       CASE   WHEN ROUND(RAND() * 51, 0) = 1  THEN 'Необходимо обновить фотографию в паспорте.'
              WHEN ROUND(RAND() * 51, 0) = 2  THEN 'Дефект страницы с личными данными.'
              WHEN ROUND(RAND() * 51, 0) = 3  THEN 'Серийный номер паспорта затерт.'
              WHEN ROUND(RAND() * 51, 0) = 4  THEN 'Дата выдачи паспорта требует уточнения.'
              WHEN ROUND(RAND() * 51, 0) = 5  THEN 'Некорректный адрес в регистрационных данных.'
              WHEN ROUND(RAND() * 51, 0) = 6  THEN 'Отсутствует подпись в правом нижнем углу.'
              WHEN ROUND(RAND() * 51, 0) = 7  THEN 'Паспорт повреждён, требуется замена.'
              WHEN ROUND(RAND() * 51, 0) = 8  THEN 'Ошибки в данных о месте рождения.'
              WHEN ROUND(RAND() * 51, 0) = 9  THEN 'Частично потерян штамп о гражданстве.'
              WHEN ROUND(RAND() * 51, 0) = 10 THEN 'Записи не соответствуют актуальным данным.'
              WHEN ROUND(RAND() * 51, 0) = 11 THEN 'Страница с визами требует проверки на подлинность.'
              WHEN ROUND(RAND() * 51, 0) = 12 THEN 'Неполное ФИО, необходимо исправление.'
              WHEN ROUND(RAND() * 51, 0) = 13 THEN 'Срок действия паспорта истекает скоро.'
              WHEN ROUND(RAND() * 51, 0) = 14 THEN 'Не хватает отметки о прописке.'
              WHEN ROUND(RAND() * 51, 0) = 15 THEN 'Дефект на обложке, требуется новая.'
              WHEN ROUND(RAND() * 51, 0) = 16 THEN 'Проблемы с утратой идентификационного номера.'
              WHEN ROUND(RAND() * 51, 0) = 17 THEN 'Некорректный код подразделения.'
              WHEN ROUND(RAND() * 51, 0) = 18 THEN 'Отсутствует информация о национальности.'
              WHEN ROUND(RAND() * 51, 0) = 19 THEN 'Произошла ошибка при вводе имени отца.'
              WHEN ROUND(RAND() * 51, 0) = 20 THEN 'Отметка о разводе не указана.'
              WHEN ROUND(RAND() * 51, 0) = 21 THEN 'Необходимо внести изменения из-за смены фамилии.'
              WHEN ROUND(RAND() * 51, 0) = 22 THEN 'Лишние записи на странице с данными.'
              WHEN ROUND(RAND() * 51, 0) = 23 THEN 'Страница с фотографией повреждена.'
              WHEN ROUND(RAND() * 51, 0) = 24 THEN 'Прописка не совпадает с фактическим местом жительства.'
              WHEN ROUND(RAND() * 51, 0) = 25 THEN 'Не очищена информация о предыдущем паспорте.'
              WHEN ROUND(RAND() * 51, 0) = 26 THEN 'Ошибки в дате рождения, требуется корректировка.'
              WHEN ROUND(RAND() * 51, 0) = 27 THEN 'Страны, посещённые в туристических целях, не указаны.'
              WHEN ROUND(RAND() * 51, 0) = 28 THEN 'Заменить паспорт при обнаружении существенных дефектов.'
              WHEN ROUND(RAND() * 51, 0) = 29 THEN 'Неправильный форм-фактор документа.'
              WHEN ROUND(RAND() * 51, 0) = 30 THEN 'Несоответствие данных в разных частях паспорта.'
              WHEN ROUND(RAND() * 51, 0) = 31 THEN 'Качество печати паспорта низкое.'
              WHEN ROUND(RAND() * 51, 0) = 32 THEN 'Не хватает страницы с информацией о визах.'
              WHEN ROUND(RAND() * 51, 0) = 33 THEN 'Случайный разрыв на странице с личными данными.'
              WHEN ROUND(RAND() * 51, 0) = 34 THEN 'Отсутствие штампа о выезде за границу.'
              WHEN ROUND(RAND() * 51, 0) = 35 THEN 'Ошибки в отчество, требуются изменения.'
              WHEN ROUND(RAND() * 51, 0) = 36 THEN 'Документ необходимо продлить.'
              WHEN ROUND(RAND() * 51, 0) = 37 THEN 'Фотография не соответствует требованиям.'
              WHEN ROUND(RAND() * 51, 0) = 38 THEN 'Запись о смене гражданства не актуальна.'
              WHEN ROUND(RAND() * 51, 0) = 39 THEN 'Неправильная информация о родителях.'
              WHEN ROUND(RAND() * 51, 0) = 40 THEN 'Нужна проверка на наличие подделок.'
              WHEN ROUND(RAND() * 51, 0) = 41 THEN 'Необходимо внести данные о новом месте работы.'
              WHEN ROUND(RAND() * 51, 0) = 42 THEN 'Некорректный почтовый индекс в адресе.'
              WHEN ROUND(RAND() * 51, 0) = 43 THEN 'Страничка с контактами не заполнена.'
              WHEN ROUND(RAND() * 51, 0) = 44 THEN 'Отсутствует подпись владельца паспорта.'
              WHEN ROUND(RAND() * 51, 0) = 45 THEN 'Проблемы с аутентичностью документа.'
              WHEN ROUND(RAND() * 51, 0) = 46 THEN 'Дополнительные записи не должны присутствовать.'
              WHEN ROUND(RAND() * 51, 0) = 47 THEN 'Порвана страница с данными о визах.'
              WHEN ROUND(RAND() * 51, 0) = 48 THEN 'Следует подтвердить данные о образовательной квалификации.'
              WHEN ROUND(RAND() * 51, 0) = 49 THEN 'Паспорт требует архивирования.'
              WHEN ROUND(RAND() * 51, 0) = 50 THEN 'Обновление фотографии обязательно перед новым сроком.'
	          ELSE N'' END
    );
    
    SET @i = @i + 1;
	print ' Добавлено строк' +  ' - число   ' + convert(nvarchar(10),@i);
   
        

END;
-------------------------------------------------------------33333333333333333333333333333333333333333-------------------------------------------------------
go
		  insert into  Status_Employee (Name_Status_Employee,[Description])
		  values
			  ('Действующий',''),
			  ('В Архиве','Это значит что пользователь когда работал, и на данный момент уволен'),
			  ('Пробный период','От 1 до 3 месяцев'),
			  ('На проверке','Проверяется в СБ'),
			  ('Дублированая Учётная запись',''),
			  ('Неисправная','')

go
-------------------------------------------------------------444444444444444444444444444444444444444444---------------------------------------------------------

declare @i int  =1;
 while @i < = 1014
  begin 
      insert into  Connection_String (Password,Login,Date_Сreated,[Description])
	  values 
	  (
	   (REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, 15), '-', '')),
	   (REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '')),
	   DATEADD(DAY, -ROUND(RAND() * 950, 0), GETDATE()),
       CASE   
               WHEN ROUND(RAND() * 51, 0) = 1  THEN 'Необходимо обновить фотографию в паспорте.'
               WHEN ROUND(RAND() * 51, 0) = 2  THEN 'Дефект страницы с личными данными.'
               WHEN ROUND(RAND() * 51, 0) = 3  THEN 'Несоответствие данных в паспорте и базе.'
               WHEN ROUND(RAND() * 51, 0) = 4  THEN 'Проблема с доступом к учетной записи.'
               WHEN ROUND(RAND() * 51, 0) = 5  THEN 'Требуется подтверждение личности.'
               WHEN ROUND(RAND() * 51, 0) = 6  THEN 'Срок действия документа истек.'
               WHEN ROUND(RAND() * 51, 0) = 7  THEN 'Отсутствие необходимых документов.'
               WHEN ROUND(RAND() * 51, 0) = 8  THEN 'Неверный формат загрузки документа.'
               WHEN ROUND(RAND() * 51, 0) = 9  THEN 'Проверка подлинности документа.'
               WHEN ROUND(RAND() * 51, 0) = 10 THEN 'Требуется поездка в офис для уточнения.'
               WHEN ROUND(RAND() * 51, 0) = 11 THEN 'Информация не соответствует стандартам.'
               WHEN ROUND(RAND() * 51, 0) = 12 THEN 'Документ поврежден.'
               WHEN ROUND(RAND() * 51, 0) = 13 THEN 'Недостаточно прав для выполнения действия.'
               WHEN ROUND(RAND() * 51, 0) = 14 THEN 'Страничка с отметкой о запрете выезда.'
               WHEN ROUND(RAND() * 51, 0) = 15 THEN 'Необходимо указать дополнительную информацию.'
               WHEN ROUND(RAND() * 51, 0) = 16 THEN 'Копия документа нечеткая.'
               WHEN ROUND(RAND() * 51, 0) = 17 THEN 'Требуется дубликат документа.'
               WHEN ROUND(RAND() * 51, 0) = 18 THEN 'Необходимо провести проверку данных.'
               WHEN ROUND(RAND() * 51, 0) = 19 THEN 'Исправление данных в паспорте.'
               WHEN ROUND(RAND() * 51, 0) = 20 THEN 'Недостаточно времени для обработки.'
               WHEN ROUND(RAND() * 51, 0) = 21 THEN 'Требуется другое удостоверение личности.'
               WHEN ROUND(RAND() * 51, 0) = 22 THEN 'Не удалось проверить подлинность документа.'
               WHEN ROUND(RAND() * 51, 0) = 23 THEN 'Проблема с сканированием документа.'
               WHEN ROUND(RAND() * 51, 0) = 24 THEN 'Ошибка в системе обработки.'
               WHEN ROUND(RAND() * 51, 0) = 25 THEN 'Требуется ксерокопия документа.'
               WHEN ROUND(RAND() * 51, 0) = 26 THEN 'Запрос документов не выполнен.'
               WHEN ROUND(RAND() * 51, 0) = 27 THEN 'Необходимо удостоверение от работодателя.'
               WHEN ROUND(RAND() * 51, 0) = 28 THEN 'Требуется предоставление справок.'
               WHEN ROUND(RAND() * 51, 0) = 29 THEN 'Перепроверка ранее предоставленной информации.'
               WHEN ROUND(RAND() * 51, 0) = 30 THEN 'Отсутствует подпись заявителя.'
               WHEN ROUND(RAND() * 51, 0) = 31 THEN 'Некорректные данные в анкете.'
               WHEN ROUND(RAND() * 51, 0) = 32 THEN 'Требуется подтверждение гражданства.'
               WHEN ROUND(RAND() * 51, 0) = 33 THEN 'Неверный ИНН или ОГРН.'
               WHEN ROUND(RAND() * 51, 0) = 34 THEN 'Фотография не соответствует требованиям.'
               WHEN ROUND(RAND() * 51, 0) = 35 THEN 'Отказ в обработке заявления.'
               WHEN ROUND(RAND() * 51, 0) = 36 THEN 'Заявление необходимо повторить.'
               WHEN ROUND(RAND() * 51, 0) = 37 THEN 'Не хватает информации для завершения.'
               WHEN ROUND(RAND() * 51, 0) = 38 THEN 'Активация учетной записи приостановлена.'
               WHEN ROUND(RAND() * 51, 0) = 39 THEN 'Документы не прошли проверку.'
               WHEN ROUND(RAND() * 51, 0) = 40 THEN 'Заявка передана на дополнительную проверку.'
               WHEN ROUND(RAND() * 51, 0) = 41 THEN 'Необходимо исправить ошибки в анкете.'
               WHEN ROUND(RAND() * 51, 0) = 42 THEN 'Ошибка в адресе проживания.'
               WHEN ROUND(RAND() * 51, 0) = 43 THEN 'Требуется указать актуальный номер телефона.'
               WHEN ROUND(RAND() * 51, 0) = 44 THEN 'Копия документа неразборчива.'
               WHEN ROUND(RAND() * 51, 0) = 45 THEN 'Необходима дополнительная справка от врача.'
               WHEN ROUND(RAND() * 51, 0) = 46 THEN 'Необходимо заполнение дополнительного поля.'
               WHEN ROUND(RAND() * 51, 0) = 47 THEN 'Запрос отклонен по техническим причинам.'
               WHEN ROUND(RAND() * 51, 0) = 48 THEN 'Необходимо предоставить документы на ребенка.'
               WHEN ROUND(RAND() * 51, 0) = 49 THEN 'Неправильный тип документа.'
               WHEN ROUND(RAND() * 51, 0) = 50 THEN 'Системная ошибка, попробуйте позже.'
          ELSE N'' END
	  );
  set @i = @i +1
  print ' Добавлено строк' +  ' - число   ' + convert(nvarchar(10),@i);
  end;


go
-----------------------------------------------------555555555555555555555555555555555555555555555-----------------------------------------------------------------------------------------

insert into Branch  (Id_Country,City,[Address],Name_Branch,INN) values 
(2, 'Вена', 'ул. Штефан-Платц, 1', 'Cafe Central'                                           ,(round(rand()*999999999,0))),
(2, 'Грац', 'Плошад Кайнза, 3', 'MuseumsQuartier'                                           ,(round(rand()*999999999,0))),
(2, 'Инсбрук', 'Тирольская ул., 1', 'Alpenzoo Innsbruck'									,(round(rand()*999999999,0))),
(2, 'Линц', 'Ул. Нернсдорфер, 12', 'Ars Electronica Center'									,(round(rand()*999999999,0))),
(2, 'Зальцбург', 'Мирбельгasse, 5', 'Mozart’s Birthplace'									,(round(rand()*999999999,0))),
(2, 'Клагенфурт', 'Ул. Кайзеров, 7', 'Wörthersee Stadion'									,(round(rand()*999999999,0))),
(2, 'Вельс', 'Плошад Битца, 6', 'Heldendenkmal'												,(round(rand()*999999999,0))),
(2, 'Швехат', 'Ул. Слотицких, 8', 'Shopping City Süd'										,(round(rand()*999999999,0))),
(2, 'Бургленд', 'Ул. Мададея, 14', 'Therme Linsberg Asia'									,(round(rand()*999999999,0))),
(2, 'Ландек', 'Ул. Польгейтакер, 9', 'Heiliggeistkirche'									,(round(rand()*999999999,0))),
(7, 'Кросдейл', 'Старый Район, 32', 'Tropical Breeze Resort'								,(round(rand()*999999999,0))),
(7, 'Сэндли', 'Ул. Лос-Вегас, 20', 'Azure Sands Hotel'										,(round(rand()*999999999,0))),
(7, 'Бланшард', 'Ул. Прекрасного Леса, 4', 'Coral Springs Community Center'					,(round(rand()*999999999,0))),
(7, 'Мэригорд', 'Река Боун, 17', 'Distant Shores Spa'										,(round(rand()*999999999,0))),
(7, 'Эбен-Хейд', 'На берегу, 11', 'Sunnyville Bakery'										,(round(rand()*999999999,0))),
(7, 'Фламинго', 'Ул. Чудесных Восходов, 9', 'Flamingo Seafood'								,(round(rand()*999999999,0))),
(7, 'Кемп-дю-Лак', 'Ул. Головокружительной Ночи, 25', 'Mountain Views Resort'				,(round(rand()*999999999,0))),
(7, 'Бэймонт', 'Ул. Солнечного Заката, 8', 'Sunshine International'							,(round(rand()*999999999,0))),
(7, 'Слоновое Ушко', 'Ул. Ясного Неба, 13', 'Ocean Breeze'									,(round(rand()*999999999,0))),
(7, 'Дилетант' , 'Старый Бульвар, 3', 'Visions Art Studio'									,(round(rand()*999999999,0))),
(17, 'Минск', 'ул. Независимости, 12', 'Магазин электроники'								,(round(rand()*999999999,0))),
(17, 'Гродно', 'пл. Ленина, 5', 'Кафе Гродно'												,(round(rand()*999999999,0))),
(17, 'Брест', 'ул. Советская, 7', 'Брестская крепость'										,(round(rand()*999999999,0))),
(17, 'Могилёв', 'ул. Гагарина, 9', 'Кинотеатр Победа'										,(round(rand()*999999999,0))),
(17, 'Витебск', 'пл. Победы, 2', 'Витебская филармония'										,(round(rand()*999999999,0))),
(17, 'Гомель', 'ул. Барыкина, 15', 'Гомельский замок'										,(round(rand()*999999999,0))),
(17, 'Солигорск', 'ул. Центральная, 1', 'Кафе Привет'										,(round(rand()*999999999,0))),
(17, 'Бобруйск', 'ул. Орловская, 5', 'Музей Бобруйска'										,(round(rand()*999999999,0))),
(17, 'Пинск', 'ул. Ленина, 6', 'Каминный зал'												,(round(rand()*999999999,0))),
(17, 'Светлогорск', 'ул. Маяковского, 10', 'Магазин солнечных очков'						,(round(rand()*999999999,0))),
(19, 'Брюссель', 'пл. Сукане, 1', 'Шоколадная лавка'										,(round(rand()*999999999,0))),
(19, 'Антверпен', 'ул. Культофрейм, 7', 'Алмазная биржа'									,(round(rand()*999999999,0))),
(19, 'Гент', 'ул. Фламандская гулли, 3', 'Санкт-Бавона'										,(round(rand()*999999999,0))),
(19, 'Брюгге', 'ул. Кувелье, 11', 'Бельгийская пивоварня'									,(round(rand()*999999999,0))),
(19, 'Льеж', 'ул. Любезных, 5', 'Музей Леопольда'											,(round(rand()*999999999,0))),
(19, 'Лугано', 'ул. Солнечной, 4', 'Луганский архив'										,(round(rand()*999999999,0))),
(19, 'Тревизо', 'ул. Ледяной, 8', 'Sports Plaza'											,(round(rand()*999999999,0))),
(19, 'Мехелен', 'ул. Гелльт, 15', 'Круглый стол'											,(round(rand()*999999999,0))),
(19, 'Шарлеруа', 'ул. Вирлина, 2', 'Театр Шарлеруа'											,(round(rand()*999999999,0))),
(19, 'Намюр', 'пл. Ламброзу, 6', 'Кинотеатр Лиона'											,(round(rand()*999999999,0))),
(21, 'София', 'ул. Витоша, 39', 'Кафе Яуза'													,(round(rand()*999999999,0))),
(21, 'Пловдив', 'ул. Капитан Райчо, 4', 'Исторический музей'								,(round(rand()*999999999,0))),
(21, 'Варна', 'ул. Приморская, 11', 'Морской сад'											,(round(rand()*999999999,0))),
(21, 'Бургас', 'ул. Бургаская, 8', 'Морской порт'											,(round(rand()*999999999,0))),
(21, 'Русе', 'ул. Широкая, 5', 'Бельведер'													,(round(rand()*999999999,0))),
(21, 'Стара Загора', 'ул. Пролетарская, 16', 'Римский стадион'								,(round(rand()*999999999,0))),
(21, 'Добрич', 'ул. Добруджанская, 22', 'Парк Победы'										,(round(rand()*999999999,0))),
(21, 'Сливен', 'ул. Освобождения, 12', 'Церковь Святой Софии'								,(round(rand()*999999999,0))),
(21, 'Перник', 'ул. Новой луджи, 9', 'Городской спорткомплекс'								,(round(rand()*999999999,0))),
(21, 'Шумен', 'ул. Тракийская, 10', 'Кафе парковое'											,(round(rand()*999999999,0))),
(27, 'Ватикан', 'ул. Святого Петра, 1', 'Секретариат Святого Престола'						,(round(rand()*999999999,0))),
(27, 'Рим', 'ул. Форум, 14', 'Куланго'														,(round(rand()*999999999,0))),
(27, 'Асколи-Пичено', 'ул. Бенедикто, 21', 'Курия'											,(round(rand()*999999999,0))),
(27, 'Треви', 'ул. фонтанная, 7', 'Треви-капелла'											,(round(rand()*999999999,0))),
(27, 'Римини', 'ул. Виа, 10', 'Пьетро'														,(round(rand()*999999999,0))),
(27, 'Неаполь', 'ул. Мерказу, 9', 'Сакра Капеле'											,(round(rand()*999999999,0))),
(27, 'Тоскана', 'ул. Пресвятой, 13', 'Тосканская Осень'										,(round(rand()*999999999,0))),
(27, 'Флоренция', 'ул. Лоренцо, 19', 'Флоренция Сияния'										,(round(rand()*999999999,0))),
(27, 'Сиена', 'ул. Собора, 5', 'Вилла Иги'													,(round(rand()*999999999,0))),
(27, 'Болонья', 'ул. Теплова, 28', 'Теннери'												,(round(rand()*999999999,0))),
(28, 'Будапешт', 'ул. Ваци, 23', 'Сенат'													,(round(rand()*999999999,0))),
(28, 'Дебрецен', 'ул. Тертле, 10', 'Площадь Лайоса'											,(round(rand()*999999999,0))),
(28, 'Сегед', 'ул. Торвальда, 5', 'Сегедская Конфессия'										,(round(rand()*999999999,0))),
(28, 'Мишкольц', 'ул. Абдрея, 15', 'Гражданский центр'										,(round(rand()*999999999,0))),
(28, 'Печ', 'ул. Хольцер, 12', 'Печиньские танцы'											,(round(rand()*999999999,0))),
(28, 'Шопрон', 'ул. Хунгари, 7', 'Термы Ньирьхаз'											,(round(rand()*999999999,0))),
(28, 'Капошвар', 'ул. Сечет, 3', 'Район Хаус'												,(round(rand()*999999999,0))),
(28, 'Ньиредьхаз', 'ул. Тинкера, 20', 'Космическая площадь'									,(round(rand()*999999999,0))),
(28, 'Залакарош', 'ул. Зала, 1', 'Парусные гонки'											,(round(rand()*999999999,0))),
(28, 'Сомбате́й', 'ул. Великого, 5', 'Фейерверк джи'											,(round(rand()*999999999,0))),
(30, 'Ханой', 'ул. Лун, 16', 'Cafe Viet'													,(round(rand()*999999999,0))),
(30, 'Хошимин', 'ул. Малайзийская, 4', 'Турагенство'										,(round(rand()*999999999,0))),
(30, 'Дананг', 'ул. Да Ка, 17', 'Тибетская кухня'											,(round(rand()*999999999,0))),
(30, 'Нha Транг', 'ул. Лос-Остыль, 12', 'Соломоновский паб'									,(round(rand()*999999999,0))),
(30, 'Хайфонг', 'ул. Зелёная, 12', 'Дворой'													,(round(rand()*999999999,0))),
(30, 'Сайгон', 'ул. Садовая, 6', 'Западные витки'											,(round(rand()*999999999,0))),
(30, 'Вьетнам', 'ул. Солнца, 13', 'Студия номер один'										,(round(rand()*999999999,0))),
(30, 'Ниньбинь', 'ул. Бортаи, 7', 'Гарден кафе'												,(round(rand()*999999999,0))),
(30, 'Сапа', 'ул. Бенгровая, 2', 'Рататуй'													,(round(rand()*999999999,0))),
(30, 'Муйне', 'ул. Мировой, 1', 'Судец Старого мира'										,(round(rand()*999999999,0))),
(31, 'Либревиль', 'ул. Блан, 9', 'Центр Габона'												,(round(rand()*999999999,0))),
(31, 'Френшвиль', 'ул. Мира, 8', 'Национальный музей'										,(round(rand()*999999999,0))),
(31, 'Овандо', 'ул. Солнечных дня, 2', 'Габонский авангард'									,(round(rand()*999999999,0))),
(31, 'Майонг' , 'ул. Лунная, 4', 'Кафе Мелодии'												,(round(rand()*999999999,0))),
(31, 'Уэли' , 'ул. Океанская, 7', 'Футбольный клуб'											,(round(rand()*999999999,0))),
(31, 'Ангар' , 'ул. Наморская, 1', 'Новое вдохновение'										,(round(rand()*999999999,0))),
(31, 'Нсылиндза' , 'ул. Сапфировая, 10', 'Творческий кластер'								,(round(rand()*999999999,0))),
(31, 'Гуа' , 'ул. Гора, 3', 'Спортивная лига'												,(round(rand()*999999999,0))),
(31, 'Бите' , 'ул. Леса, 22', 'Школа искусств'												,(round(rand()*999999999,0))),
(31, 'Тшане' , 'ул. Премьера, 4', 'Кофейня Норман'											,(round(rand()*999999999,0))),
(32, 'Порт-о-Пренс', 'ул. Чирка, 15', 'Музей Гаити'											,(round(rand()*999999999,0))),
(32, 'Кап-Айтьен', 'ул. Жимаха, 12', 'Кафе Ривер'											,(round(rand()*999999999,0))),
(32, 'Жакмель', 'ул. Плутус, 10', 'Бельмонт'												,(round(rand()*999999999,0))),
(32, 'Леоган', 'ул. Кемпер, 9', 'Забава'													,(round(rand()*999999999,0))),
(32, 'Канзас', 'ул. Равенчроба, 20', 'Национальный дворец'									,(round(rand()*999999999,0))),
(32, 'Лимонье', 'ул. Тетани, 16', 'Кампус Святого Григория'									,(round(rand()*999999999,0))),
(32, 'Плавнёр' , 'ул. Валерийская, 8', 'Кучерята'											,(round(rand()*999999999,0))),
(32, 'Авриль' , 'ул. Кауто, 1', 'Тайные искусства'											,(round(rand()*999999999,0))),
(32, 'Селдре' , 'ул. Апти 18, 25', 'Прямой путь'											,(round(rand()*999999999,0))),
(32, 'Петито' , 'ул. Дверко, 5', 'Пиршество'												,(round(rand()*999999999,0))),
(33, 'Аккра', 'ул. Аутограба, 24', 'Арт-центр'												,(round(rand()*999999999,0))),
(33, 'Кумаси', 'ул. Заветы, 9', 'Сандовил'													,(round(rand()*999999999,0))),
(33, 'Тема', 'ул. Лотосовая, 11', 'Клубной Темы'											,(round(rand()*999999999,0))),
(33, 'Кумаси', 'ул. Жемчужная, 21', 'Гостиница Радуга'										,(round(rand()*999999999,0))),
(33, 'Такоради', 'ул. Кладбищенская, 3', 'Фестиваль красок'									,(round(rand()*999999999,0))),
(33, 'Элеманту', 'ул. Лина, 20', 'Национальный дом'											,(round(rand()*999999999,0))),
(33, 'Джирниабон', 'ул. Искусство, 4', 'КЛК Мастеров'										,(round(rand()*999999999,0))),
(33, 'Чанго', 'ул. Лабо, 7', 'Центр Общины'													,(round(rand()*999999999,0))),
(33, 'Насанго', 'ул. Хартту, 15', 'Школа художников'										,(round(rand()*999999999,0))),
(33, 'Дукоме' , 'ул. Аваллон, 14', 'Кулинарные традиции'									,(round(rand()*999999999,0))),
(34, 'Афины', 'ул. Соцветий, 25', 'Афинея'													,(round(rand()*999999999,0))),
(34, 'Салоники', 'ул. Руководящих духом, 19', 'Центр Администраций'							,(round(rand()*999999999,0))),
(34, 'Патры', 'ул. Ипполита, 13', 'Фрагменты Нагорной'										,(round(rand()*999999999,0))),
(34, 'Ираклион', 'ул. Образовательная, 8', 'Туроператор'									,(round(rand()*999999999,0))),
(34, 'Делфи', 'ул. Левуни, 1', 'Культурный центр'											,(round(rand()*999999999,0))),
(34, 'Ретимно', 'ул. Солнечная, 12', 'Кофейня Старая'										,(round(rand()*999999999,0))),
(34, 'Керкира', 'ул. Ораторская, 29', 'Пирамида'											,(round(rand()*999999999,0))),
(34, 'Ханья', 'ул. Калипсо, 3', 'Музей доминирования'										,(round(rand()*999999999,0))),
(34, 'Каливи' , 'ул. Графикар, 4', 'Кошачий дом'											,(round(rand()*999999999,0))),
(34, 'Замверце' , 'ул. Паула, 22', 'Анилизации'												,(round(rand()*999999999,0))),
(36, 'Тбилиси', 'ул. Руставели, 28', 'Тбилисский магнат'									,(round(rand()*999999999,0))),
(36, 'Батуми', 'ул. Олимпийская, 9', 'Футбольный клуб'										,(round(rand()*999999999,0))),
(36, 'Кутаиси', 'ул. Бережок, 7', 'Красное озеро'											,(round(rand()*999999999,0))),
(36, 'Зугдиди', 'ул. Кобаладзе, 18', 'Ноев ковчег'											,(round(rand()*999999999,0))),
(36, 'Рустави', 'ул. Буяка, 12', 'Центр фестивалей'											,(round(rand()*999999999,0))),
(36, 'Зестафони' , 'ул. Босоножек, 14', 'Семья'												,(round(rand()*999999999,0))),
(36, 'Ткибули' , 'ул. Барышевская, 5', 'Спорт'												,(round(rand()*999999999,0))),
(36, 'Гори' , 'ул. Гували, 22', 'Кафе Мосты'												,(round(rand()*999999999,0))),
(36, 'Джвари' , 'ул. Солнце, 30', 'Культурный сообщественный центр'							,(round(rand()*999999999,0))),
(36, 'Ахалцихе' , 'ул. Толефон, 8', 'Гнездо'												,(round(rand()*999999999,0))),
(37, 'Копенгаген', 'ул. Гамле, 12', 'Кафе Гарден '											,(round(rand()*999999999,0))),
(37, 'Оденсе', 'ул. Сена, 17', 'Морской контракт'											,(round(rand()*999999999,0))),
(37, 'Ааргус', 'ул. Стратенгаден, 8', 'Пешеходный центр'									,(round(rand()*999999999,0))),
(37, 'Вейле', 'ул. Ниллига на поле, 3', 'Фестиваль Дании'									,(round(rand()*999999999,0))),
(37, 'Хернинг', 'ул. Хамперо, 6', 'Национальный обиходный'									,(round(rand()*999999999,0))),
(37, 'Силея' , 'ул. Пример, 9', 'Домен Гетти'												,(round(rand()*999999999,0))),
(37, 'Скандеборг' , 'ул. Сконжи, 11', 'Кафе Бриггит'										,(round(rand()*999999999,0))),
(37, 'Целлдес' , 'ул. Нэймд Кайтке, 16', 'Нгейбсцлавех'										,(round(rand()*999999999,0))),
(37, 'Хингслевт' , 'ул. Молтеккер, 22', 'Росси'												,(round(rand()*999999999,0))),
(37, 'Гравер' , 'ул. Вико, 5', 'Аскадаль'													,(round(rand()*999999999,0))),
(41, 'Каир', 'ул. Мермута, 14', 'Африканский центр'											,(round(rand()*999999999,0))),
(41, 'Гиза', 'ул. Комплекс, 3', 'Гигантский поросенок'										,(round(rand()*999999999,0))),
(41, 'Луксор', 'ул. Господина, 20', 'Темпл Анкли'											,(round(rand()*999999999,0))),
(41, 'Александрия', 'ул. Глазбоя, 11', 'Кофейня Будущее'									,(round(rand()*999999999,0))),
(41, 'Порт-Саид', 'ул. Портовая, 23', 'Кафе Кракен'											,(round(rand()*999999999,0))),
(41, 'Шарм-Эль-Шейх', 'ул. Аргасева, 17', 'Кинотеатр Марант'								,(round(rand()*999999999,0))),
(41, 'Ассут', 'ул. Пастора, 19', 'Египетская картина'										,(round(rand()*999999999,0))),
(41, 'Асуан', 'ул. Нокс, 22', 'Находка'														,(round(rand()*999999999,0))),
(41, 'Танта', 'ул. Адвокат, 9', 'Река Леон' 												,(round(rand()*999999999,0))),
(41, 'Хургада', 'ул. Водяного, 15', 'Кафе Сафари'											,(round(rand()*999999999,0))),
(42, 'Лусака', 'ул. Джуни, 3', 'Центр одежды'												,(round(rand()*999999999,0))),
(42, 'Коппербелт', 'ул. Долорес, 7', 'Музей'												,(round(rand()*999999999,0))),
(42, 'Солвера', 'ул. Прыжка, 25', 'Сказка о числах'											,(round(rand()*999999999,0))),
(42, 'Ндола', 'ул. Ламбрет, 11', 'Галерея'													,(round(rand()*999999999,0))),
(42, 'Мзузу', 'ул. Сталинграда, 30', 'Маскарад'												,(round(rand()*999999999,0))),
(42, 'Касама', 'ул. Баракова, 20', 'Комната тишины'											,(round(rand()*999999999,0))),
(42, 'Чипата', 'ул. Ферейнта, 12', 'Загадка'												,(round(rand()*999999999,0))),
(42, 'Чарди', 'ул. Лемур, 19', 'Поездка в Льва'												,(round(rand()*999999999,0))),
(42, 'Паула', 'ул. Хана, 8', 'Супер-маркет'													,(round(rand()*999999999,0))),
(42, 'Соломо', 'ул. Кубларова, 13', 'Школа सजरेशन'											,(round(rand()*999999999,0))),
(44, 'Нью-Дели', 'ул. Конгресс, 40', 'Cafe Coffee Day'										,(round(rand()*999999999,0))),
(44, 'Мумбаи', 'ул. Чаттри, 24', 'Flavors Cafe'												,(round(rand()*999999999,0))),
(44, 'Бангалор', 'ул. Мадохбх, 15', 'Art Gallery'											,(round(rand()*999999999,0))),
(44, 'Хайдарабад', 'ул. Налападир, 29', 'Cafe Nook'											,(round(rand()*999999999,0))),
(44, 'Ченнай', 'ул. Рамкамал, 8', 'Royal Palace'											,(round(rand()*999999999,0))),
(44, 'Коимбатор', 'Ул. Трайвани, 12', 'Nasi lemak'											,(round(rand()*999999999,0))),
(44, 'Калькутта', 'ул. Гирдон, 29', 'Tea House'												,(round(rand()*999999999,0))),
(44, 'Гудапери', 'ул. Шиванга, 4', 'Kok Sar'												,(round(rand()*999999999,0))),
(44, 'Пуне', 'ул. Келлі, 18', 'Fortress of Fortune'											,(round(rand()*999999999,0))),
(44, 'Дели', 'ул. Эльгейти, 11', 'Ice Cream Kingdom'										,(round(rand()*999999999,0))),
(47, 'Дублин', 'ул. Килларни, 13', 'Дублинский замок'										,(round(rand()*999999999,0))),
(47, 'Корк', 'ул. Котта, 19', 'Корковский Старый'											,(round(rand()*999999999,0))),
(47, 'Голвей', 'ул. Келли, 22', 'Магазин Светелка'											,(round(rand()*999999999,0))),
(47, 'Лимерик', 'ул. Мерси, 4', 'Галерея Естер'												,(round(rand()*999999999,0))),
(47, 'Слайго', 'ул. Пьюзга, 11', 'Неизвестный Царь'											,(round(rand()*999999999,0))),
(47, 'Уотерфорд', 'ул. Фмтрана, 25', 'Астрациянские Мифы'									,(round(rand()*999999999,0))),
(47, 'Вексфорд', 'ул. Избрание, 2', 'Морская Стена'											,(round(rand()*999999999,0))),
(47, 'Кромайк', 'ул. Офегра, 18', 'Свет над призраками'										,(round(rand()*999999999,0))),
(47, 'Кароджика', 'ул. Быстрота, 16', 'Отель Станка'										,(round(rand()*999999999,0))),
(47, 'Мейвилд', 'ул. Знайдер, 32', 'Тату-артистка Айра'										,(round(rand()*999999999,0))),
(48, 'Рейкьявик', 'ул. Льда, 1', 'Cafe Bla'													,(round(rand()*999999999,0))),
(48, 'Копавогюр', 'ул. Фьятр, 10', 'Солнечный ветер'										,(round(rand()*999999999,0))),
(48, 'Акюрейри', 'ул. Нордсаль, 32', 'Дельта'												,(round(rand()*999999999,0))),
(48, 'Снайфедльснесс', 'ул. Лунная, 9', 'Сорок Дев' 										,(round(rand()*999999999,0))),
(48, 'Хусавик', 'ул. Клявич, 7', 'Свет Дорннара'											,(round(rand()*999999999,0))),
(48, 'Гардар' , 'ул. Мирной, 3', 'Кафе Согласия'											,(round(rand()*999999999,0))),
(48, 'Грюдберг' , 'ул. Лесной, 12', 'Типа'													,(round(rand()*999999999,0))),
(48, 'Дейпивогюр' , 'ул. Маяка, 2', 'Книга Рекордов'										,(round(rand()*999999999,0))),
(48, 'Эгильстадир' , 'ул. Жемчуг, 4', 'Творческие пути'										,(round(rand()*999999999,0))),
(48, 'Фладесвагур' , 'ул. Фьельд, 13', 'Пустынные огни'										,(round(rand()*999999999,0))),
(49, 'Мадрид', 'ул. Гранде, 43', 'El Corte Inglés'											,(round(rand()*999999999,0))),
(49, 'Барселона', 'ул. Лампа, 8', 'La Boqueria'												,(round(rand()*999999999,0))),
(49, 'Валенсия', 'ул. Сьерра, 15', 'Mercado Central'										,(round(rand()*999999999,0))),
(49, 'Севилья', 'ул. Марифко, 21', 'Real Alcázar'											,(round(rand()*999999999,0))),
(49, 'Малага', 'ул. Лас-Каланки, 20', 'Picasso Museum'										,(round(rand()*999999999,0))),
(49, 'Сарагоса', 'ул. Ибсена, 25', 'Площадь Пьедад'											,(round(rand()*999999999,0))),
(49, 'Вик', 'ул. Сервантес, 11', 'Кафе Сервантес'											,(round(rand()*999999999,0))),
(49, 'Кадис', 'ул. Замечательный, 5', 'La Merced'											,(round(rand()*999999999,0))),
(49, 'Санта-Крус-де-Тенерифе', 'ул. Норден, 20', 'Террасы Роттерама'						,(round(rand()*999999999,0))),
(49, 'Аликанте', 'ул. Теплофф, 8', 'Posidonia'												,(round(rand()*999999999,0))),
(50, 'Рим', 'ул. Ватикана, 1', 'Римский зал'												,(round(rand()*999999999,0))),
(50, 'Милан', 'ул. Графика, 14', 'Популярный рынок'											,(round(rand()*999999999,0))),
(50, 'Венеция', 'ул. Канала, 1', 'Мост Вздохов'												,(round(rand()*999999999,0))),
(50, 'Неаполь', 'ул. Санта-Мария, 19', 'Пиццерия Пьяццалин'									,(round(rand()*999999999,0))),
(50, 'Турин', 'ул. Верди, 24', 'Проблемы Вин'												,(round(rand()*999999999,0))),
(50, 'Флоренция', 'ул. Нельсана, 5', 'Галерея Уффици'										,(round(rand()*999999999,0))),
(50, 'Сиена', 'ул. Кремонз, 6', 'Ресторан Боска'											,(round(rand()*999999999,0))),
(50, 'Болонья', 'ул. Фрумат, 21', 'Британский парламент'									,(round(rand()*999999999,0))),
(50, 'Палермо', 'ул. Доливаира, 7', 'Лациус'												,(round(rand()*999999999,0))),
(50, 'Лечче', 'ул. Траппила, 4', 'Кулинарная академия'										,(round(rand()*999999999,0))),
(52, 'Алматы', 'ул. Сатпаева, 45', 'Казахстанская газета'									,(round(rand()*999999999,0))),
(52, 'Нур-Султан', 'ул. Тауелсиздик, 7', 'Главный офис'										,(round(rand()*999999999,0))),
(52, 'Шымкент', 'ул. Парк имени Аубакирова, 56', 'Школа искусств'							,(round(rand()*999999999,0))),
(52, 'Караганда', 'ул. Центральная, 30', 'Клиент'											,(round(rand()*999999999,0))),
(52, 'Актау', 'ул. Лесная, 24', 'Галерея'													,(round(rand()*999999999,0))),
(52, 'Атырау', 'ул. Фасолья, 3', 'Совет хозяйки'											,(round(rand()*999999999,0))),
(52, 'Павлодар', 'ул. Депутатская, 20', 'Альтернативный бизнес'								,(round(rand()*999999999,0))),
(52, 'Усть-Каменогорск', 'ул. Мостовая, 18', 'Экономика'									,(round(rand()*999999999,0))),
(52, 'Семей', 'ул. Птицеград, 22', 'Эксперт'												,(round(rand()*999999999,0))),
(52, 'Талдыкорган', 'ул. Талгат, 21', 'Экология'											,(round(rand()*999999999,0))),
(53, 'Оттава', 'улица Причал, 30', 'Канады Идеи'											,(round(rand()*999999999,0))),
(53, 'Торонто', 'улица Она, 50', 'Кока-кола'												,(round(rand()*999999999,0))),
(53, 'Ванкувер', 'перекога Дельта, 70', 'Пудра Групп'										,(round(rand()*999999999,0))),
(53, 'Монреаль', 'площадь Бизации, 9', 'Шикарный Час'										,(round(rand()*999999999,0))),
(53, 'Калгари', 'ул. Мандрит, 2', 'Гардероб Успеха'											,(round(rand()*999999999,0))),
(53, 'Квебек', 'ул. Святого Иосифа, 44', 'Библиотека искусства'								,(round(rand()*999999999,0))),
(53, 'Виктория', 'перекрёсток Седан, 22', 'Карбастер Стайл'									,(round(rand()*999999999,0))),
(53, 'Едмотон', 'улица Мербар, 33', 'Лимон'													,(round(rand()*999999999,0))),
(53, 'Ошава', 'ул. Полоска, 7', 'Завод Солнечных технологий'								,(round(rand()*999999999,0))),
(53, 'Виннипег', 'улица Устрицы, 15', 'Виноге'												,(round(rand()*999999999,0))),
(56, 'Никосия', 'ул. Мариуполь, 9', 'Кипрская печка'										,(round(rand()*999999999,0))),
(56, 'Лимассол', 'ул. Корейская, 8', 'Курорты'												,(round(rand()*999999999,0))),
(56, 'Ларнака', 'ул. Вита, 22', 'Крыше'														,(round(rand()*999999999,0))),
(56, 'Фамагуста', 'ул. Араски, 5', 'Тайный зал'												,(round(rand()*999999999,0))),
(56, 'Пафос', 'ул. Михайловская, 15', 'Кофе-чай'											,(round(rand()*999999999,0))),
(56, 'Кирения', 'ул. Мечты, 21', 'Виноградная пята'											,(round(rand()*999999999,0))),
(56, 'Кирранья', 'ул. Метель, 4', 'Лучше вместе'											,(round(rand()*999999999,0))),
(56, 'Сольферино', 'ул. Невозвратной, 16', 'Кукушка'										,(round(rand()*999999999,0))),
(56, 'Агтода', 'ул. Нечай, 14', 'Кофе Эспрессо'												,(round(rand()*999999999,0))),
(56, 'Вивос' , 'ул. Студентская, 10', 'Тайна'												,(round(rand()*999999999,0))),
(57, 'Ош', 'ул.Ажара, 19', 'Кафе Сысоев'													,(round(rand()*999999999,0))),
(57, 'Бишкек', 'ул. Нукус, 21', 'Vintage Center'											,(round(rand()*999999999,0))),
(57, 'Талас', 'ул. Ленинская, 28', 'Галерея Краски'											,(round(rand()*999999999,0))),
(57, 'Нарын', 'ул. Треугольная, 12', 'Будда'												,(round(rand()*999999999,0))),
(57, 'Узбекистан', 'ул. Седир, 5', 'Талд СТК'												,(round(rand()*999999999,0))),
(57, 'Каракол', 'ул. Ашта, 14', 'Снежные склоны'											,(round(rand()*999999999,0))),
(57, 'Жалалабад', 'ул. Великого Ислама, 18', 'Садочкодержатель'								,(round(rand()*999999999,0))),
(57, 'Чолпон-Ата', 'ул. Чеченская, 28', 'Пункт раздачи'										,(round(rand()*999999999,0))),
(57, 'Майлуу-Суу', 'ул. Маяк, 5', 'Кулинарное искусство'									,(round(rand()*999999999,0))),
(57, 'Иссык-Куль' , 'ул. Мечты, 17', 'Америкады ќе'											,(round(rand()*999999999,0))),
(58, 'Пекин', 'ул. Ляньху, 30', 'Пекинская Студия'											,(round(rand()*999999999,0))),
(58, 'Шанхай', 'ул. Порт, 13', 'Сельский рынок'												,(round(rand()*999999999,0))),
(58, 'Гуанчжоу', 'ул. Дзинсини, 34', 'Майя'													,(round(rand()*999999999,0))),
(58, 'Шэньчжэнь', 'ул. Ланьцзян, 4', 'Клуб финансовой доступности'							,(round(rand()*999999999,0))),
(58, 'Чэнду', 'ул. Гуйте, 26', 'Кухня Сиони'												,(round(rand()*999999999,0))),
(58, 'Тяньцзинь', 'ул. Шуньмэнь, 18', 'Мудрецы'												,(round(rand()*999999999,0))),
(58, 'Сиань', 'ул. Духовного пути, 12', 'Большая стена'										,(round(rand()*999999999,0))),
(58, 'Цзинань', 'ул. Боковой, 7', 'Дворец Куси'												,(round(rand()*999999999,0))),
(58, 'Луоянг', 'ул. Хуаншу, 15', 'Терпение'													,(round(rand()*999999999,0))),
(58, 'Чунцин', 'ул. Долинная, 9', 'Торговый центр'											,(round(rand()*999999999,0))),
(65, 'Вьентьян', 'ул. Просветления, 22', 'Кафе Сиды'										,(round(rand()*999999999,0))),
(65, 'Луангпрабанг', 'ул. Лотосовая, 10', 'Племенной фестиваль'								,(round(rand()*999999999,0))),
(65, 'Паксе', 'ул. Границы, 19', 'Философия истока'											,(round(rand()*999999999,0))),
(65, 'Саване', 'ул. Пещеры, 12', 'Старомодный стиль'										,(round(rand()*999999999,0))),
(65, 'Секонг', 'ул. Победителей, 7', 'Семенцы'												,(round(rand()*999999999,0))),
(65, 'Пхонгсали', 'ул. Реки, 23', 'Кубик кольца'											,(round(rand()*999999999,0))),
(65, 'Латхай', 'ул. Неля, 2', 'Гармония вкуса'												,(round(rand()*999999999,0))),
(65, 'Намтхунг', 'ул. Зелёная, 20', 'Крупное здн'											,(round(rand()*999999999,0))),
(65, 'Таунгвольд' , 'ул. Оратат, 14', 'Творческая гармонь'									,(round(rand()*999999999,0))),
(65, 'Пакхонг' , 'ул. Честная, 8', 'Зал Чудес'												,(round(rand()*999999999,0))),
(66, 'Рига', 'ул. Бривибас, 4', 'Латвийский музей'											,(round(rand()*999999999,0))),
(66, 'Юрмала', 'ул. Джанекса, 12', 'Юрмальская квартира'									,(round(rand()*999999999,0))),
(66, 'Лиепая', 'ул. Лиепайская, 6', 'Фестиваль Лиепая'										,(round(rand()*999999999,0))),
(66, 'Кулдига', 'ул. Фредерикса, 11', 'Летний лагерь'										,(round(rand()*999999999,0))),
(66, 'Даугавпилс', 'ул. Шиманевича, 8', 'Центр юря'											,(round(rand()*999999999,0))),
(66, 'Валмиера', 'ул. Надежда, 18', 'Круглый театр'											,(round(rand()*999999999,0))),
(66, 'Резекне', 'ул. Золотая, 5', 'Лаборатория'												,(round(rand()*999999999,0))),
(66, 'Гулбене', 'ул. Оранжевая, 2', 'Школа'													,(round(rand()*999999999,0))),
(66, 'Мадона', 'ул. Латвийская, 1', 'Кофейня'												,(round(rand()*999999999,0))),
(66, 'Алушта', 'ул. Найти, 14', 'Пиршествование'											,(round(rand()*999999999,0))),
(67, 'Масерене', 'ул. Тавишул, 3', 'Кофейня Пузырь'											,(round(rand()*999999999,0))),
(67, 'Брека', 'ул. Харьковская, 11', 'Сказки Пухера'										,(round(rand()*999999999,0))),
(67, 'Лесото', 'ул. Ураганная, 15', 'Чашка Чая'												,(round(rand()*999999999,0))),
(67, 'Монкло', 'ул. Ивне, 16', 'Царская Книга'												,(round(rand()*999999999,0))),
(67, 'Фрея', 'ул. Зверей, 52', 'Пиршествование'												,(round(rand()*999999999,0))),
(67, 'Лумера', 'ул. Хуфсай, 8', 'Лосось'													,(round(rand()*999999999,0))),
(67, 'Аплосон', 'ул. Байрок, 17', 'Истинная правда'											,(round(rand()*999999999,0))),
(67, 'Ботсвана', 'ул. Мото, 4', 'Ресторан Неприятности'										,(round(rand()*999999999,0))),
(67, 'Калос Левонья', 'ул. Небо, 10', 'Асп может а'											,(round(rand()*999999999,0))),
(67, 'Полагас кедры', 'ул. Замок, 25', 'Черта'												,(round(rand()*999999999,0))),
(68, 'Вильнюс', 'ул. Вильнюс, 8', 'Кафе Вильнюс'											,(round(rand()*999999999,0))),
(68, 'Ковно', 'ул. Солнце Золотое, 19', 'Музей Традиций'									,(round(rand()*999999999,0))),
(68, 'Клайпеда', 'ул. Яблонь, 12', 'Кораблекрушение'										,(round(rand()*999999999,0))),
(68, 'Шяуляй', 'ул. Складная, 8', 'Кукуруза'												,(round(rand()*999999999,0))),
(68, 'Паланга', 'ул. Чистая, 11', 'Рыбный рынок'											,(round(rand()*999999999,0))),
(68, 'Укмерге', 'ул. Возвращения, 4', 'Торговая сетка'										,(round(rand()*999999999,0))),
(68, 'Тракай', 'ул. Замок, 23', 'Площадь возрождения'										,(round(rand()*999999999,0))),
(68, 'Панеэ', 'ул. Костюмы, 7', 'Торговая сеть'												,(round(rand()*999999999,0))),
(68, 'Маруупите', 'ул. Молодежи, 44', 'Загадка'												,(round(rand()*999999999,0))),
(68, 'Заукь', 'ул. Душа, 9', 'Вдохновение'													,(round(rand()*999999999,0))),
(74, 'Бамако', 'ул. Мартыновых, 2', 'Музей Мали'											,(round(rand()*999999999,0))),
(74, 'Сигу', 'ул. Франа, 15', 'Галерея искусства'											,(round(rand()*999999999,0))),
(74, 'Коулокоро', 'ул. Ная, 9', 'Кафе'														,(round(rand()*999999999,0))),
(74, 'Себеку', 'ул. Легквз, 4', 'Смелые Искусства'											,(round(rand()*999999999,0))),
(74, 'Кикавар', 'ул. Дао, 7', 'Спортивный клуб'												,(round(rand()*999999999,0))),
(74, 'Гао', 'ул. Южная, 11', 'Клуб Водства'													,(round(rand()*999999999,0))),
(74, 'Кесера', 'ул. Автопилот, 3', 'Научный комитет'										,(round(rand()*999999999,0))),
(74, 'Коилигаа', 'ул. Бусин, 8', 'Восточные Бегемоты'										,(round(rand()*999999999,0))),
(74, 'Гераба', 'ул. Гулли, 2', 'Язык искусств'												,(round(rand()*999999999,0))),
(74, 'Темпли' , 'ул. Сметан, 19', 'Скандинавская свадьба'									,(round(rand()*999999999,0))),
(76, 'Валлетта', 'ул. Сент-Джорджа, 1', 'Мальтийская башня'									,(round(rand()*999999999,0))),
(76, 'Слиема', 'ул. Пооя, 3', 'Ресторан Елены'												,(round(rand()*999999999,0))),
(76, 'Моста', 'ул. Степанова, 50', 'Футбольный клуб'										,(round(rand()*999999999,0))),
(76, 'К эффективность', 'ул. Лотос, 18', 'Время человечества'								,(round(rand()*999999999,0))),
(76, 'Калкары', 'ул. Мир, 25', 'Маска'														,(round(rand()*999999999,0))),
(76, 'Забрака', 'ул. Фатимы, 4', 'Маленький Миф'											,(round(rand()*999999999,0))),
(76, 'Сан-паули', 'ул. Взгляда, 12', 'Кемпинги'												,(round(rand()*999999999,0))),
(76, 'Слиэбо', 'ул. Слиэбо, 22', 'Творческая жизнь'											,(round(rand()*999999999,0))),
(76, 'Церковь Святого Лаврентия', 'ул. Лондонского, 15', 'Мысли'							,(round(rand()*999999999,0))),
(76, 'Маленг', 'ул. Адмиральского, 8', 'Настоящий вкус'										,(round(rand()*999999999,0))),
(77, 'Мехико', 'ул. Лос-Тура, 45', 'Пасал Дель Злата'										,(round(rand()*999999999,0))),
(77, 'Гвадалахара', 'ул. Флорентино, 18', 'Кулинарные знакомства'							,(round(rand()*999999999,0))),
(77, 'Монтеррей', 'ул. Островная, 2', 'Фарм Дельиком'										,(round(rand()*999999999,0))),
(77, 'Пуэбла', 'ул. Мытища, 14', 'Розовый свет'												,(round(rand()*999999999,0))),
(77, 'Тихуана', 'ул. Небесной, 1', 'Клуб недавно'											,(round(rand()*999999999,0))),
(77, 'Канкун', 'ул. Группы, 3', 'Смелые мечты'												,(round(rand()*999999999,0))),
(77, 'Оахака', 'ул. Эспанолы, 7', 'Мясорубка'												,(round(rand()*999999999,0))),
(77, 'Сан-Луис-Потоси', 'ул. Капустиниана, 2', 'Гуиспарт'									,(round(rand()*999999999,0))),
(77, 'Гвадалахара', 'ул. Параллельная, 22', 'Гадания'										,(round(rand()*999999999,0))),
(77, 'Сакатекас', 'ул. Розовых, 28', 'Космический поток'									,(round(rand()*999999999,0))),
(78, 'Кишинев', 'ул. Мира, 25', 'Магазин своей идеи'										,(round(rand()*999999999,0))),
(78, 'Тирасполь', 'ул. Маяка, 9', 'Ташкент'													,(round(rand()*999999999,0))),
(78, 'Бельцы', 'ул. Рафаэля, 13', 'Кафе снижения'											,(round(rand()*999999999,0))),
(78, 'Рышкань', 'ул. Гензал, 22', 'Кружевой дом'											,(round(rand()*999999999,0))),
(78, 'Дрокия', 'ул. Полосатая, 5', 'Объединил'												,(round(rand()*999999999,0))),
(78, 'Фалешты', 'ул. Творчества, 14', 'Стиль мили'											,(round(rand()*999999999,0))),
(78, 'Сороки', 'ул. Фиалка, 2', 'РЕКС'														,(round(rand()*999999999,0))),
(78, 'Мадракешть', 'ул. Сарматис, 17', 'На тугу'											,(round(rand()*999999999,0))),
(78, 'Оргей', 'ул. Точки, 15', 'Творческие идеи'											,(round(rand()*999999999,0))),
(78, 'Шолдань', 'ул. Лота, 12', 'Новые горизонты'											,(round(rand()*999999999,0))),
(79, 'Монте-Карло', 'ул. Прекрасной Нати, 18', 'Каберет Афины'								,(round(rand()*999999999,0))),
(79, 'Монако', 'ул. Лунная, 9', 'Искусственная Цветы'										,(round(rand()*999999999,0))),
(79, 'Кап-д Ай', 'ул. Березовая, 24', 'Фестиваль Ретро'										,(round(rand()*999999999,0))),
(79, 'Ментон', 'ул. Печерская, 2', 'Небо'													,(round(rand()*999999999,0))),
(79, 'Ла-Турбье', 'ул. Баросень, 13', 'Редакция Статистики'									,(round(rand()*999999999,0))),
(79, 'Сент-Агата', 'ул. Лисовский, 5', 'Атлас'												,(round(rand()*999999999,0))),
(79, 'Маленькая буквка', 'ул. Вишневый, 24', 'Волшебный Пай'								,(round(rand()*999999999,0))),
(79, 'Тентин', 'ул. Зелёный, 1', 'Записи'													,(round(rand()*999999999,0))),
(79, 'Рокебрюн', 'ул. Червонцев, 14', 'Эскурсии'											,(round(rand()*999999999,0))),
(79, 'Ницца', 'ул. Вишневый, 8', 'Токийский стиль'											,(round(rand()*999999999,0))),
(80, 'Улан-Батор', 'ул. Оружия, 1', 'Музей наследия'										,(round(rand()*999999999,0))),
(80, 'Дархан', 'ул. Тысяча, 10', 'Культовый дом'											,(round(rand()*999999999,0))),
(80, 'Эрдэнэтийн', 'ул. Шумква, 50', 'Академия пространств'									,(round(rand()*999999999,0))),
(80, 'Булган', 'ул. Портчин-Худжир, 2', 'Спорт и движения'									,(round(rand()*999999999,0))),
(80, 'Завхан', 'ул. Видов, 7', 'Культурный центр'											,(round(rand()*999999999,0))),
(80, 'Сухбаатар', 'ул. Атласная, 4', 'Сила'													,(round(rand()*999999999,0))),
(80, 'Ховд', 'ул. Ливан, 30', 'Клиент'														,(round(rand()*999999999,0))),
(80, 'Дорнод', 'ул. Солнечная, 8', 'Находка'												,(round(rand()*999999999,0))),
(80, 'Говь-Алтай', 'ул. Небо, 2', 'Собрание'												,(round(rand()*999999999,0))),
(80, 'Улгей', 'ул. Зоя, 14', 'Моя преданность'												,(round(rand()*999999999,0))),
(83, 'Катманду', 'ул. Гуркхал, 33', 'Культурная ассоциация'									,(round(rand()*999999999,0))),
(83, 'Покхара', 'ул. Зеленоводный, 5', 'Нельсон'											,(round(rand()*999999999,0))),
(83, 'Лали-Гадж', 'ул. Долина, 23', 'Тайная тропа'											,(round(rand()*999999999,0))),
(83, 'Патан', 'ул. Серебряная, 9', 'Святой маяк'											,(round(rand()*999999999,0))),
(83, 'Бхактапур', 'ул. Рудник, 8', 'Водопад'												,(round(rand()*999999999,0))),
(83, 'Джонгшуд', 'ул. Гуркха, 14', 'Совет'													,(round(rand()*999999999,0))),
(83, 'Суркхет', 'ул. Т такоми, 4', 'Служба'													,(round(rand()*999999999,0))),
(83, 'Танаху', 'ул. Идол, 17', 'Гармония'													,(round(rand()*999999999,0))),
(83, 'Чатангу' , 'ул. Чави, 14', 'Изобилие'													,(round(rand()*999999999,0))),
(83, 'Налгад', 'ул. Лани, 16', 'Дерево'														,(round(rand()*999999999,0))),
(84, 'Ниамей', 'ул. Котабо, 8', 'Национальный музей'										,(round(rand()*999999999,0))),
(84, 'Мардид', 'ул. Бейт, 10', 'Кафе Авель'													,(round(rand()*999999999,0))),
(84, 'Зиндэр' , 'ул. Басима, 26', 'Творчество'												,(round(rand()*999999999,0))),
(84, 'Досо' , 'ул. Достон, 4', 'Туризм' 													,(round(rand()*999999999,0))),
(84, 'Кайе' , 'ул. Четыре, 11', 'Первая палата'												,(round(rand()*999999999,0))),
(84, 'Маджер' , 'ул. Хадиджа, 7', 'Философия'												,(round(rand()*999999999,0))),
(84, 'Гурджафилина' , 'ул. Слабая, 5', 'Национальная идея'									,(round(rand()*999999999,0))),
(84, 'Сабы' , 'ул. Гробу, 15', 'Музей картин'												,(round(rand()*999999999,0))),
(84, 'Текру' , 'ул. Красноглазый, 22', 'Кулинарная академия'								,(round(rand()*999999999,0))),
(84, 'Парана' , 'ул. Виноградов, 33', 'Старый смелый'										,(round(rand()*999999999,0))),
(87, 'Осло', 'ул. Акерсгет, 24', 'Кафе Норвегия'											,(round(rand()*999999999,0))),
(87, 'Берген', 'ул. Солстиг, 2', 'Картинная галерея'										,(round(rand()*999999999,0))),
(87, 'Ставангер', 'ул. Кюре, 5', 'Музей искусства'											,(round(rand()*999999999,0))),
(87, 'Тромсё', 'ул. Глория, 10', 'Полярный кукольный'										,(round(rand()*999999999,0))),
(87, 'Дрогедо', 'ул. Хювинг, 3', 'Галерея'													,(round(rand()*999999999,0))),
(87, 'Ларвик', 'ул. Ларвикская, 12', 'Национальная арена'									,(round(rand()*999999999,0))),
(87, 'Арендаль', 'ул. Пакаст, 18', 'Конференция'											,(round(rand()*999999999,0))),
(87, 'Копенгаген', 'ул. Майда, 25', 'Книжный центр'											,(round(rand()*999999999,0))),
(87, 'Хамар', 'ул. Шелли, 8', 'Кинотеатры'													,(round(rand()*999999999,0))),
(87, 'Лиллехамер', 'ул. Бетиг, 10', 'Национальный художественный музей'						,(round(rand()*999999999,0))),
(89, 'Маскат', 'ул. Пирамида, 2', 'Кофе Оман'												,(round(rand()*999999999,0))),
(89, 'Дукм', 'ул. Золотая, 5', 'Мусоросжигательный завод'									,(round(rand()*999999999,0))),
(89, 'Салаллах', 'ул. Маяк, 11', 'Пробуждение'												,(round(rand()*999999999,0))),
(89, 'Сур', 'ул. Событие, 8', 'Лурерхен'													,(round(rand()*999999999,0))),
(89, 'Мукасар', 'ул. Первая, 19', 'Една'													,(round(rand()*999999999,0))),
(89, 'Бибар', 'ул. Сланыра, 6', 'Эко-экспедишн'												,(round(rand()*999999999,0))),
(89, 'Далфур', 'ул. Сахаимай, 22', 'Реальность'												,(round(rand()*999999999,0))),
(89, 'Назарет', 'ул. Сканья, 26', 'Творить'													,(round(rand()*999999999,0))),
(89, 'Хиджель', 'ул. Рубина, 13', 'Творческая техника'										,(round(rand()*999999999,0))),
(89, 'Легенда', 'ул. Сиденья, 3', 'Кофе Центральный'										,(round(rand()*999999999,0))),
(90, 'Исламабад', 'ул. Индии, 20', 'Национальный совет'										,(round(rand()*999999999,0))),
(90, 'Карачи', 'ул. Креатив, 36', 'Умный двор'												,(round(rand()*999999999,0))),
(90, 'Лахор', 'ул. Асатт, 7', 'Лаборатории'													,(round(rand()*999999999,0))),
(90, 'Пешавар', 'ул. Лаунг, 8', 'Закусочная'												,(round(rand()*999999999,0))),
(90, 'Кветта', 'ул. Зозо, 4', 'Мост'														,(round(rand()*999999999,0))),
(90, 'Сурат', 'ул. Конфетный, 25', 'Пещера'													,(round(rand()*999999999,0))),
(90, 'Малихабад', 'ул. Лимон, 9', 'Оазис'													,(round(rand()*999999999,0))),
(90, 'Фейсалабад', 'ул. Славы, 3', 'Финария'												,(round(rand()*999999999,0))),
(90, 'Равалпинди', 'ул. Опер, 18', 'Фейерверк'												,(round(rand()*999999999,0))),
(90, 'Карачи', 'ул. Лотос, 16', 'Города'													,(round(rand()*999999999,0))),
(96, 'Москва', 'ул. Тверская, 14', 'Госдума'												,(round(rand()*999999999,0))),
(96, 'Санкт-Петербург', 'ул. Невский, 32', 'Эрмитаж'										,(round(rand()*999999999,0))),
(96, 'Новосибирск', 'ул. Красный проспект, 50', 'Культурный центр'							,(round(rand()*999999999,0))),
(96, 'Екатеринбург', 'ул. Ленина, 23', 'Президент-отель'									,(round(rand()*999999999,0))),
(96, 'Казань', 'ул. Баумана, 22', 'Театр кукол'												,(round(rand()*999999999,0))),
(96, 'Нижний Новгород', 'ул. Большая Покровская, 12', 'Галерея'								,(round(rand()*999999999,0))),
(96, 'Самара', 'ул. Куйбышева, 10', 'Кинотеатр'												,(round(rand()*999999999,0))),
(96, 'Ростов-на-Дону', 'ул. Сура, 4', 'ТЦ Мега'												,(round(rand()*999999999,0))),
(96, 'Воронеж', 'ул. Пушкина, 5', 'Музей Братска'											,(round(rand()*999999999,0))),
(96, 'Уфа', 'ул. Мира, 20', 'Магазин путешественников'										,(round(rand()*999999999,0))),
(97, 'Бухарест', 'ул. центра, 8', 'Национальный музей'										,(round(rand()*999999999,0))),
(97, 'Клуж-Напока', 'Аэропорт, 9', 'Кафе Двери'												,(round(rand()*999999999,0))),
(97, 'Яссы', 'ул. Карды, 15', 'Лужа'														,(round(rand()*999999999,0))),
(97, 'Тимишоара' , 'ул. Институтская, 6', 'Сосновые аллеи'									,(round(rand()*999999999,0))),
(97, 'Крайова' , 'ул. Саренди, 18', 'Торбоньок'												,(round(rand()*999999999,0))),
(97, 'Галац' , 'ул. Ноганова, 14', 'Национальная галерея'									,(round(rand()*999999999,0))),
(97, 'Брэила' , 'ул. Геллозовская, 30', 'Сцена'												,(round(rand()*999999999,0))),
(97, 'Питешть' , 'ул. Верментаба, 7', 'Площадь Солнца'										,(round(rand()*999999999,0))),
(97, 'Тыргу-Муреш' , 'ул. Бразильская, 28', 'Парашютистский клуб'							,(round(rand()*999999999,0))),
(97, 'Сибиу' , 'ул. Шумейкина, 25', 'Гаризонная артель'										,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Лотусовая, 10', 'Чайный дом'											,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Солнце, 15', 'Торговая мряка'										,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Баухан, 22', 'Парк'													,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Ривьере, 29', 'Отель Arcadia'										,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Кривоногова, 3', 'Гриль'												,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Богдавич, 11', 'Студия'												,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Формирующая, 22', 'Библиотека'										,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Шевилинка, 7', 'Песни'												,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Сетра, 1', 'Гармония'												,(round(rand()*999999999,0))),
(100, 'Сингапур', 'ул. Может, 14', 'Чудеса'													,(round(rand()*999999999,0))),
(101, 'Братислава', 'ул. Явора, 20', 'Сладкий Лавра'										,(round(rand()*999999999,0))),
(101, 'Кошице', 'ул. Норильская, 11', 'Магазин хороших эмоций'								,(round(rand()*999999999,0))),
(101, 'Приевидза', 'ул. Дубрук, 4', 'Кафе Сказочное'										,(round(rand()*999999999,0))),
(101, 'Жилина', 'ул. Многофункциональная, 7', 'Школа искусств'								,(round(rand()*999999999,0))),
(101, 'Нитра', 'ул. Лужу, 23', 'Кафе Вера'													,(round(rand()*999999999,0))),
(101, 'Тренчин' , 'ул. Гуджортская, 9', 'Кафе надежды'										,(round(rand()*999999999,0))),
(101, 'Попрад' , 'ул. Тигр, 8', 'Кофейня Золотое'											,(round(rand()*999999999,0))),
(101, 'Левочи' , 'ул. Еловая, 10', 'Галерея'												,(round(rand()*999999999,0))),
(101, 'Косице' , 'ул. Пробуждение, 5', 'Долгожданный'										,(round(rand()*999999999,0))),
(101, 'Кошице' , 'ул. Печная, 14', 'Интерьеры разговора'									,(round(rand()*999999999,0))),
(102, 'Любляна', 'ул. Тартинья, 29', 'Кафе Меланж'											,(round(rand()*999999999,0))),
(102, 'Марибор', 'ул. Габровая, 18', 'Магазин Счастья'										,(round(rand()*999999999,0))),
(102, 'Целе', 'ул. Волшебная, 16', 'Книга ожиданий'											,(round(rand()*999999999,0))),
(102, 'Новогрдель' , 'ул. Sarajevo, 4', 'Путешествие'										,(round(rand()*999999999,0))),
(102, 'Совина' , 'ул. Мечтателей, 27', 'Недавно'											,(round(rand()*999999999,0))),
(102, 'Помурие' , 'ул. Комнаты, 10', 'Летний сад'											,(round(rand()*999999999,0))),
(102, 'Новака' , 'ул. Аромата, 25', 'Завершение'											,(round(rand()*999999999,0))),
(102, 'Идрица' , 'ул. Esto, 2', 'Книжный журнал'											,(round(rand()*999999999,0))),
(102, 'Обечна' , 'ул. Президиума, 30', 'Регистрация'										,(round(rand()*999999999,0))),
(102, 'Славенська' , 'ул. Привязанных, 14', 'Летний сад'									,(round(rand()*999999999,0))),
(103, 'Могадишо', 'ул. Успокаивающих, 5', 'Неназванный'										,(round(rand()*999999999,0))),
(103, 'Босасо', 'ул. Бокарты, 14', 'Сенситивный дом'										,(round(rand()*999999999,0))),
(103, 'Кисмаю' , 'ул. Сучайм, 22', 'Дзен'													,(round(rand()*999999999,0))),
(103, 'Сомали' , 'ул. солнечного, 9', 'Культура'											,(round(rand()*999999999,0))),
(103, 'Дхусамареб' , 'ул. Кстати, 1', 'Творческий клуб'										,(round(rand()*999999999,0))),
(103, 'Мерка' , 'ул. Зверобой, 7', 'Морская лавка'											,(round(rand()*999999999,0))),
(103, 'Лас-анод' , 'ул. Гая, 14', 'Кукольные'												,(round(rand()*999999999,0))),
(103, 'Афгун' , 'ул. Асмар, 12', 'Лабораторная практика'									,(round(rand()*999999999,0))),
(103, 'Балад' , 'ул. Петровская, 5', 'Кураж'												,(round(rand()*999999999,0))),
(103, 'Ластичин' , 'ул. Рыба, 17', 'Не вляженный'											,(round(rand()*999999999,0))),
(104, 'Хартум', 'ул. Лотосовая, 13', 'Фармацевтика'											,(round(rand()*999999999,0))),
(104, 'Омдурман', 'ул. Катрин, 16', 'Круглый стол'											,(round(rand()*999999999,0))),
(104, 'Эль-Обеид', 'ул. Площади, 4', 'Легкий размозг'										,(round(rand()*999999999,0))),
(104, 'Даллу' , 'ул. Раннее, 20', 'Совет'													,(round(rand()*999999999,0))),
(104, 'Гаджура' , 'ул. Лагана, 9', 'Изуми'													,(round(rand()*999999999,0))),
(104, 'Бурри' , 'ул. Цветная, 11', 'Магазин тканей'											,(round(rand()*999999999,0))),
(104, 'Сеннар' , 'ул. Хельвети, 12', 'Стратегия'											,(round(rand()*999999999,0))),
(104, 'Альфайо' , 'ул. Путешествия, 6', 'Дзен'												,(round(rand()*999999999,0))),
(104, 'Джуба' , 'ул. Зеленая, 3', 'Свет камеры'												,(round(rand()*999999999,0))),
(104, 'Порт-Судан' , 'ул. Золотая, 1', 'Кружево'											,(round(rand()*999999999,0))),
(106, 'Бангкок', 'ул. Чао Прайя, 35', 'Бангкокская карта'									,(round(rand()*999999999,0))),
(106, 'Паттайя', 'ул. Рай, 10', 'Тайская кухня'												,(round(rand()*999999999,0))),
(106, 'Чиангмай', 'ул. Зодчий, 44', 'Матовая картинка'										,(round(rand()*999999999,0))),
(106, 'Пхукет', 'ул. Вокруг, 6', 'Тайское заведение'										,(round(rand()*999999999,0))),
(106, 'Краби', 'ул. Кулага, 17', 'Благодарный куст'											,(round(rand()*999999999,0))),
(106, 'Ай-Нан' , 'ул. Шумный, 23', 'Тайская звезда'											,(round(rand()*999999999,0))),
(106, 'Трат' , 'ул. Луна, 13', 'Мост'														,(round(rand()*999999999,0))),
(106, 'Удонтхани' , 'ул. Долларовая, 2', 'Достогрыжание'									,(round(rand()*999999999,0))),
(106, 'Накхонратчасима' , 'ул. Рынок, 8', 'Турист'											,(round(rand()*999999999,0))),
(106, 'Краби' , 'ул. Краби, 19', 'Ресурсы'													,(round(rand()*999999999,0))),
(107, 'Тайбэй', 'ул. Гоа, 6', 'Тайваньская особая'											,(round(rand()*999999999,0))),
(107, 'Кайсюн', 'ул. Лозунг, 15', 'Западный квартал'										,(round(rand()*999999999,0))),
(107, 'Тайнан', 'ул. Ило, 26', 'Восточный отель'											,(round(rand()*999999999,0))),
(107, 'Тайчжун', 'ул. Синьцзян, 12', 'Еда из яиц'											,(round(rand()*999999999,0))),
(107, 'Туньчань', 'ул. Неба, 23', '815 прозы'												,(round(rand()*999999999,0))),
(107, 'Пиндун' , 'ул. Долина, 10', 'Древнее научное'										,(round(rand()*999999999,0))),
(107, 'Лаочжа' , 'ул. Конгста, 4', 'Тайваньский бутик'										,(round(rand()*999999999,0))),
(107, 'Сюйчжоу' , 'ул. Градская, 11', 'Шедевры'												,(round(rand()*999999999,0))),
(107, 'Шуйчжэн' , 'ул. Секрет, 25', 'Легендарный'											,(round(rand()*999999999,0))),
(107, 'Нантоу' , 'ул. Вопросы, 21', 'Скрипки'												,(round(rand()*999999999,0))),
(111, 'Анкара', 'ул. Ататюрка, 15', 'Исполком'												,(round(rand()*999999999,0))),
(111, 'Стамбул', 'ул. Топкапы, 12', 'Клуб Огонь'											,(round(rand()*999999999,0))),
(111, 'Измир', 'ул. Фирма, 28', 'Общий дом'													,(round(rand()*999999999,0))),
(111, 'Анталья', 'ул. Памуккале, 7', 'Восточные споры'										,(round(rand()*999999999,0))),
(111, 'Бурса', 'ул. Булар, 13', 'Пироги'													,(round(rand()*999999999,0))),
(111, 'Конья', 'ул. Резо, 5', 'Творчество'													,(round(rand()*999999999,0))),
(111, 'Адана', 'ул. Мысва, 8', 'Рынок Адана'												,(round(rand()*999999999,0))),
(111, 'Газипаша', 'ул. Тени, 9', 'Забавы'													,(round(rand()*999999999,0))),
(111, 'Диярбакыр', 'ул. Бильмес, 11', 'Центр Мира'											,(round(rand()*999999999,0))),
(111, 'Самсун', 'ул. Ней әпере, 4', 'Оценивающее'											,(round(rand()*999999999,0))),
(112, 'Кампала', 'ул. Солнечная, 11', 'Подходы'												,(round(rand()*999999999,0))),
(112, 'Нараоби', 'ул. Блийз, 32', 'граница'													,(round(rand()*999999999,0))),
(112, 'Мпиги', 'ул. Эндере, 3', 'Наследия'													,(round(rand()*999999999,0))),
(112, 'Масинди', 'ул. Образовательная, 8', 'Углубление'										,(round(rand()*999999999,0))),
(112, 'Касесе', 'ул. Хейбол, 14', 'Советы'													,(round(rand()*999999999,0))),
(112, 'Лугананго', 'ул. Заходы, 16', 'Социальные действия'									,(round(rand()*999999999,0))),
(112, 'Кампала', 'ул. Жизням, 20', 'Времена'												,(round(rand()*999999999,0))),
(112, 'Касесе', 'ул. Пьяный, 24', 'Семейные истоки'											,(round(rand()*999999999,0))),
(112, 'Калака', 'ул. Параде, 18', 'Парады'													,(round(rand()*999999999,0))),
(112, 'Намалике', 'ул. Мироздания, 14', 'Светлый релакс'									,(round(rand()*999999999,0))),
(121, 'Нджамена', 'ул. Руда, 8', 'Кафе Бонда'												,(round(rand()*999999999,0))),
(121, 'Массауа', 'ул. Партизанскую, 10', 'Фестивали'										,(round(rand()*999999999,0))),
(121, 'Думфур' , 'ул. Тосила, 6', 'Гармония'												,(round(rand()*999999999,0))),
(121, 'Абеше' , 'ул. Лотосная, 11', 'Африканская еда'										,(round(rand()*999999999,0))),
(121, 'Эль-Генина' , 'ул. Гриву, 3', 'Чай'													,(round(rand()*999999999,0))),
(121, 'Касала' , 'ул. Крейдер, 7', 'Суп'													,(round(rand()*999999999,0))),
(121, 'Малам` вильямс' , 'ул. Пригороды, 25', 'Кафе Книги'									,(round(rand()*999999999,0))),
(121, 'Залинда' , 'ул. Взгляда, 17', 'Национальный институт'								,(round(rand()*999999999,0))),
(121, 'Генкава' , 'ул. Золотая, 4', 'Заводы'												,(round(rand()*999999999,0))),
(121, 'Эль-Фашер' , 'ул. Листвиной, 9', 'Стиль'												,(round(rand()*999999999,0))),
(122, 'Прага', 'ул. Вацлава, 11', 'Клуб волшебника'											,(round(rand()*999999999,0))),
(122, 'Чехия', 'ул. Чешская, 2', 'Кафе Комета'												,(round(rand()*999999999,0))),
(122, 'Брно' , 'ул. Хлебная, 20', 'Большой рынок'											,(round(rand()*999999999,0))),
(122, 'Острава' , 'ул. Солнечная, 5', 'Магазин шуток'										,(round(rand()*999999999,0))),
(122, 'Градец-Кралове' , 'ул. Пиларская, 15', 'Ресторан шедевров'							,(round(rand()*999999999,0))),
(122, 'Усти-над-Лабем' , 'ул. Замковая, 29', 'Творчески волшебный'							,(round(rand()*999999999,0))),
(122, 'Ческе-Будеевице' , 'ул. Саженец, 3', 'Кафе Долгожданный'								,(round(rand()*999999999,0))),
(122, 'Пльзень' , 'ул. Лабисьев, 14', 'Майонез'												,(round(rand()*999999999,0))),
(122, 'Гавиржов' , 'ул. Котушка, 6', 'Солостоверный'										,(round(rand()*999999999,0))),
(122, 'Злин' , 'ул. Детский, 23', 'Творится'												,(round(rand()*999999999,0))),
(123, 'Сантьяго', 'ул. Местровая, 17', 'Кладбище'											,(round(rand()*999999999,0))),
(123, 'Вальпараисо', 'ул. Лос-Вайес, 12', 'Круглый зал'										,(round(rand()*999999999,0))),
(123, 'Кунко' , 'ул. Солнечная, 6', 'Снежный крест'											,(round(rand()*999999999,0))),
(123, 'Антофагаста' , 'ул. Мост, 3', 'Торговая линия'										,(round(rand()*999999999,0))),
(123, 'Копьяпо' , 'ул. Травяная, 40', 'Изумруд'												,(round(rand()*999999999,0))),
(123, 'Биябле' , 'ул. Наш дом, 15', 'Дерево'												,(round(rand()*999999999,0))),
(123, 'Талька' , 'ул. Инженерная, 9', 'Поросенок'											,(round(rand()*999999999,0))),
(123, 'Пунта-Аренас' , 'ул. Лючо, 22', 'Артистическая Оборона'								,(round(rand()*999999999,0))),
(123, 'Ла-Серена' , 'ул. Ветра, 8', 'Зайцы'													,(round(rand()*999999999,0))),
(123, 'Арика' , 'ул. Спокойная, 19', 'Арены'												,(round(rand()*999999999,0))),
(125, 'Стокгольм', 'ул. Кунгсгатан, 31', 'Шведский стол'									,(round(rand()*999999999,0))),
(125, 'Гётеборг', 'ул. Амин, 25', 'Бренды'													,(round(rand()*999999999,0))),
(125, 'Мальмё', 'ул. Столькая, 12', 'Торговля'												,(round(rand()*999999999,0))),
(125, 'Уппсала', 'ул. Королевская, 19', 'Польза'											,(round(rand()*999999999,0))),
(125, 'Оре', 'ул. Ласка, 10', 'Магазин'														,(round(rand()*999999999,0))),
(125, 'Лундал', 'ул. Солнечная, 18', 'Суп'													,(round(rand()*999999999,0))),
(125, 'Хельсингборг', 'ул. Синк, 27', 'Причал'												,(round(rand()*999999999,0))),
(125, 'Калмар', 'ул. Мерак, 22', 'Университет'												,(round(rand()*999999999,0))),
(125, 'Эребру', 'ул. Овощ, 4', 'Клубы'														,(round(rand()*999999999,0))),
(125, 'Ландскрон' , 'ул. Теней, 5', 'Гармония'												,(round(rand()*999999999,0))),
(128, 'Таллин', 'ул. Яан, 4', 'Кофейная музеи'												,(round(rand()*999999999,0))),
(128, 'Тарту', 'ул. Уютная, 35', 'Совет'													,(round(rand()*999999999,0))),
(128, 'Калленагр', 'ул. Яфет, 12', 'Гармония'												,(round(rand()*999999999,0))),
(128, 'Лаймагалн' , 'ул. Уютная, 4', 'Огромные непутевцы'									,(round(rand()*999999999,0))),
(128, 'Айра' , 'ул. Ларнака, 15', 'Ларек'													,(round(rand()*999999999,0))),
(128, 'Лучково' , 'ул. Мира, 8', 'Кулинарная'												,(round(rand()*999999999,0))),
(128, 'Хаапсалу' , 'ул. Перева, 17', 'Западный путь'										,(round(rand()*999999999,0))),
(128, 'Салга' , 'ул. Шляхетная, 3', 'Энергия'												,(round(rand()*999999999,0))),
(128, 'Сервис' , 'ул. Разведывательная, 14', 'Гармония'										,(round(rand()*999999999,0))),
(128, 'Серпель' , 'ул. Города, 26', 'Фантики'												,(round(rand()*999999999,0))),
(131, 'Токио', 'ул. Императорская, 1', 'Кафе Сунн'											,(round(rand()*999999999,0))),
(131, 'Осака', 'ул. Зеленые деревья, 3', 'Магазин искусства'								,(round(rand()*999999999,0))),
(131, 'Киото', 'ул. Мира, 9', 'Сун Тэн'														,(round(rand()*999999999,0))),
(131, 'Хиросима', 'ул. Цветочная, 14', 'Цветы Японии'										,(round(rand()*999999999,0))),
(131, 'Нагойя', 'ул. Мелодия, 12', 'Лагерь'													,(round(rand()*999999999,0))),
(131, 'Кавасаки', 'ул. Чудеса, 23', 'Национальный торг'										,(round(rand()*999999999,0))),
(131, 'Фукуока', 'ул. Ооке, 11', 'Дегустация'												,(round(rand()*999999999,0))),
(131, 'Кобе', 'ул. Души, 27', 'Сигурд'														,(round(rand()*999999999,0))),
(131, 'Саппоро', 'ул. Затменье, 8', 'Организация Мирового рынка'                            ,(round(rand()*999999999,0)))


--select * from #t 
drop table if exists #t
create table #t (ID_Branch bigint null,Mail nvarchar(300) null,Phone nvarchar(15) null,Postal_Code int null,[Description] nvarchar(1000) null, flag int null)

declare @q int  =0;
    while @q < = 579
	    begin
            insert into #t  (ID_Branch,Mail,Phone,Postal_Code,[Description],flag) 
			values 
			(
			(@q),
			(case when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yandex.ru'
                  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.ru'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@gmail.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yahoo.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@hotmail.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@icloud.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@moore@mail.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@tutanota.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mydomain.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@dr.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.co.uk'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@sharklasers.com'
            	  when cast(round(rand()*7,0) as nvarchar(10)) = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), NEWID()), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@uol.com.br'
            ELSE N'Email не указан' END),
		   (case when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(912)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(962)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(495)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(928)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(988)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(953)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(374)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(798)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
				 when cast(round(rand()*4,0) as nvarchar(3)) = 4  then '(912)'  + REPLACE(STR(cast((round(rand()*999,0)) as nvarchar(6)),3,0),' ','0') + '-' + REPLACE(STR(cast((round(rand()*99,0)) as nvarchar(2)),2,0),' ','0') + '-' + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0')
			else '' end),
			round(rand()*99999,0),
		   (case  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Отличное место для шопинга!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Персонал всегда дружелюбный и отзывчивый.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Удобное расположение и большой выбор!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Здесь приятно проводить время с семьей.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Качество услуг на высоте!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Все очень быстро и удобно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Приятные акции и скидки!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Чистота и порядок на высшем уровне.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Рекомендую всем, кто любит качественные товары.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Здесь всегда свежие продукты.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Удобный график работы, всем подойдет.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'В этом филиале очень уютно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Вежливый персонал всегда готов помочь.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Мне нравится выбирать подарки здесь.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Выгодные предложения и низкие цены.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Отличное обслуживание, так держать!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Достаточно парковочных мест.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Кассирам требуется немного больше тренировки.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Изменения в интерьере, мне нравится!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Есть все, что нужно для дома.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Там всегда много покупателей - значит, все отлично!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Никогда не бывает длинных очередей.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Покупала здесь продукцию и осталась довольна.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Комфортная атмосфера для покупок.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Безопасно и удобно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Ну очень горячая кулинария, рекомендую!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Приятно находиться в этом филиале.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Уникальные товары, которые не найдешь в других местах.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Ассортимент постоянно обновляется.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Клиенты чувствуют себя здесь как дома.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Хорошей звучание музыки в магазине.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Скорость обслуживания просто впечатляет.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Разнообразие товаров радует глаз.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Уже много лет я постоянный клиент!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Оплата очень удобная и быстрая.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Я всегда нахожу здесь всё, что нужно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Спокойная атмосфера для шопинга.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Были здесь разные альтернативы.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Во время распродаж вообще отлично!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Здесь работают настоящие профессионалы.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Сколько людей, а обслуживают быстро!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Атмосфера очень дружелюбная и расслабляющая.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Всегда приятно возвращаться сюда.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Я часто рекомендую этот филиал своим друзьям.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Много полезных товаров по разумным ценам.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Ассортимент просто невероятный.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Выбор одежды очень порадовал.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Ждем новых поступлений товара!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Всё, что угодно, можно найти здесь.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Посетила с дочкой, остались в восторге!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Все очень аккуратно и организованно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Приходите! Здесь всегда весело.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Иногда бывает многолюдно, но это не страшно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Постоянно появляются новинки, это радует.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Лучшие места для покупок в городе!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Всё организовано удобно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Приятно видеть, что заботятся о клиентах.'
                  when cast(round(rand()*4,0) as nvarchar(3))=100 then'Я счастлива от шопинга здесь.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Здесь можно найти подарки на любой случай.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Проходит много интересных акций и мероприятий.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Заботятся о клиентах, всегда на связи!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Клиентский сервис на высшем уровне.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Санитарные нормы соблюдаются, приятно видеть.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Я часто провожу время здесь, выбирая покупки.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Изобилие выбора по карману каждому.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Приятно заходить не только за покупками.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Некоторые вещи можно купить только здесь!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Хотелось бы больше спортивной одежды.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Сделают всё возможное, чтобы удовлетворить клиента.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Улыбка на лице сотрудников - это приятно.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Супер качественные товары по разумным ценам.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Каждый раз что-то новенькое встречаю.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Какой же широкий выбор игрушек!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Приятно удивлён разнообразием канцелярии.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Эти отделы просто находка для любителей кулинарии.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Очень стильные вещи для современных молодежи.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Большое спасибо за службу поддержки.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Каждый раз такие разнообразные новинки.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Замечательно, что флора и фауна также представлены.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Спокойно делать покупки с маленьким ребёнком.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Доставка тоже работает отлично.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Отличное соотношение качества и цены.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Никогда не покидала ни с пустыми руками.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Легко ориентироваться в магазине.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Я счастлива, что открыли новый филиал.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Эта сеть меня никогда не подводила.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Регулярно открываются новые распродажи.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Магазин удобно расположен рядом с метро.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Не пожалела, что пришла сюда.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Здесь я нашла именно то, что искала.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Товар всегда свежий и качественный.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Всегда много интересных акций.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Отличный сервис на кассе.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Всё для дома под одной крышей!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Приятные бонусы для постоянных клиентов.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Читаю отзывы и спешу повторить покупку.'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Филиал делает настоящие одежды.'
                  when cast(round(rand()*4,0) as nvarchar(3))=5 then'Здесь есть даже оружие для кухни!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'Чудесные лютые распродажи!'
                  when cast(round(rand()*4,0) as nvarchar(3))=4 then'С нетерпением жду следующего визита'
	        else '' end),
			0
            );
			set @q = @q + 1
			print ' Добавлено строк' +  ' - число   ' + convert(nvarchar(10),@q);
	   end;

go



use Magaz_DB
go
set nocount,xact_abort on
go

declare @i int = 0, @s int = 0 , @n varchar(40), @mess varchar(8000), @err varchar(1000)

declare
@ID_Branch       bigint  
,@Id_Country     bigint       
,@City         	 nvarchar(100)
,@Address    	 nvarchar(300)
,@Name_Branch  	 nvarchar(300)
,@Mail           nvarchar(300)
,@Phone          nvarchar(15)
,@Postal_Code    int
,@INN            int	
,@Description    nvarchar(1000)
,@flag           int
declare mycur cursor local fast_forward read_only for

select 
 b.ID_Branch    
,b.Id_Country   
,b.City         
,b.[Address]    
,b.Name_Branch  
,t.Mail         
,t.Phone        
,t.Postal_Code  
,b.INN          
,t.[Description]
,0 as flag 
from #t t inner join Branch b on b.ID_Branch = t.ID_Branch


open mycur
fetch next from mycur into
@ID_Branch   
,@Id_Country 
,@City       
,@Address    
,@Name_Branch
,@Mail       
,@Phone      
,@Postal_Code
,@INN        
,@Description
,@flag 
while @@FETCH_STATUS  = 0
               -- (0,-1,-2,-9) столбец fetch_status функции динамического управления sys.dm_exec_cursors
			   -- 0 Инструкция FETCH была выполнена успешно.
			   ---1	Выполнение инструкции FETCH завершилось неудачно или строка оказалась вне пределов результирующего набора.
			   ---2	Выбранная строка отсутствует.
			   --–9	Курсор не выполняет операцию выборки.
    begin
	  begin try 
			   update   b
			   set Id_Country = @Id_Country from  Branch as b
			   where  Id_Branch = @Id_Branch
			   update   c
			   set City = @City from  Branch as c
			   where  Id_Branch = @Id_Branch
			   update   d
			   set [Address] = @Address from  Branch as d
			   where  Id_Branch = @Id_Branch
			   update   e
			   set Name_Branch = @Name_Branch from  Branch as e
			   where  Id_Branch = @Id_Branch
			   update   f
			   set Mail = @Mail from  Branch as f
			   where  Id_Branch = @Id_Branch
			   update   g
			   set Phone = @Phone from  Branch as g
			   where  Id_Branch = @Id_Branch
			   update   h
			   set Postal_Code = @Postal_Code from  Branch as h
			   where  Id_Branch = @Id_Branch
			   update   j
			   set INN = @INN from  Branch as j
			   where  Id_Branch = @Id_Branch
			   update   k
			   set [Description] = @Description from  Branch as k
			   where  Id_Branch = @Id_Branch
			  set @i =  @i + 1
			  if exists (select * 
			             from Branch 
			             where 1 =1
			             and  Mail = @Mail
						 and  Phone = @Phone
						 and  Postal_Code = @Postal_Code
						 and  [Description] = @Description
						 )  begin update m set flag = 1 from #t  as m where ID_Branch = @ID_Branch and flag = 0 end
          --rollback

			  select @s = count(0) from #t where flag = 0
			  set @n = (select  
			            case  t.flag  when 1 then ' 1  Значения внесены' when 0  then ' 0  Значения не изменились' end  
			            from #t t  where ID_Branch = @ID_Branch)
			  set @mess = @n + ' - > ' +  ' Объект ' + cast(@ID_Branch as varchar)  +  ' --> ' + ' - ' + Cast(@i as varchar) + ' / ' + Cast(@s as varchar)
			  RAISERROR(@mess,0,0) WITH NOWAIT

       end try

	   begin catch
                if @@trancount > 0
                begin
                   rollback;
                end;
                
                set @err = formatmessage(N'ID=%I64d, error - %s', @ID_Branch, error_message());
                print @err;
       end catch;
            	   

	fetch next from mycur into 
	@ID_Branch   
	,@Id_Country 
	,@City       
	,@Address    
	,@Name_Branch
	,@Mail       
	,@Phone      
	,@Postal_Code
	,@INN        
	,@Description
	,@flag
	end
close mycur
deallocate mycur
-------------------------------------------------------66666666666666666666666666666666666666666666666666---------------------------------------------------------------------------------------
go

go
set nocount,xact_abort on
go

	  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Финансовый депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
         else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамен HR',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамент продаж',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Маркетинговый депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Операционный депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамен IT (информационных технологий)',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
			  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Юридический Депортамент',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )
	  insert into  Department (Name_Department,ID_Branch,Department_Сode) 
      values
        (
        'Депортамент службы безопастности',
        (case  when round(rand()*4,0) = 1 then  round(rand()*579,0)
	           when round(rand()*4,0) = 2 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 3 then  round(rand()*579,0)
	    	   when round(rand()*4,0) = 4 then  round(rand()*579,0)
        else  round(rand()*579,0) end),
        (case when round(rand()*4,0) = 1 then  FLOOR(round(rand()*9999999,0))
	           when round(rand()*4,0) = 2 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 3 then  FLOOR(round(rand()*9999999,0))
	    	   when round(rand()*4,0) = 4 then  FLOOR(round(rand()*9999999,0))
	    else  round(rand()*9999999,0)  end) 
	    )

go

-----------------------------------------------77777777777777777777777777777777777777777---------------------------------------------------------
declare @e bigint = 1
declare 
    @e_1 bigint = 0
   ,@e_2 bigint	= 0
   ,@e_3 bigint	= 0
   ,@e_4 bigint	= 0
   ,@e_5 bigint	= 0
   ,@e_6 bigint	= 0
   ,@e_7 bigint	= 0
   ,@e_8 bigint	= 0
while  @e <= 9
   begin
     if (@e_1 = 0)
	  begin
       set  @e_1 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_1 is not null
	       begin
	          set  @e =  @e + 1
	          print  convert(nvarchar(10),@e_1) + ' @e_1 Заполнение переменной'
		   end
	  end
	  else
			break;
	 if (@e_2 = 0)
	  begin
	    set  @e_2 = (select ID_Branch from Department where ID_Department = @e)
		if @e_2 is not null
		    begin
		      set  @e =  @e + 1
		      print  convert(nvarchar(10),@e_2) + ' @e_2 Заполнение переменной'
			end
	  end
	  else
			break;
	 if (@e_3 = 0)
	  begin
	    set  @e_3 = (select ID_Branch from Department where ID_Department = @e)
		if @e_3 is not null
		    begin
		       set  @e =  @e + 1
		       print  convert(nvarchar(10),@e_3) + ' @e_3 Заполнение переменной'
		    end
	  end
	  else
			break;
	if (@e_4 = 0)
	 begin
	  set  @e_4 = (select ID_Branch from Department where ID_Department = @e)
	  if @e_4 is not null
	      begin
	         set  @e =  @e + 1
	         print  convert(nvarchar(10),@e_4) + ' @e_4 Заполнение переменной'
		  end
	 end
	 else
			break;
	if (@e_5 = 0)
	 begin
	   set  @e_5 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_5 is not null
	       begin
		      set  @e =  @e + 1
		      print  convert(nvarchar(10),@e_5) + ' @e_5 Заполнение переменной'
		   end
	 end
	 else
			break;
	if (@e_6 = 0)
	 begin
	   set  @e_6 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_6 is not null
	       begin
		       set  @e =  @e + 1
		       print  convert(nvarchar(10),@e_6) + ' @e_6 Заполнение переменной'
		   end
	 end
	 else
			break;
	if (@e_7 = 0)
	 begin
	    set  @e_7 = (select ID_Branch from Department where ID_Department = @e)
		if @e_7 is not null
		    begin
			    print  convert(nvarchar(10),@e_7) + ' @e_7 Заполнение переменной'
		        set  @e =  @e + 1
			end
	 end
	 else
			break;
	if (@e_8 = 0)
	 begin
	   set  @e_8 = (select ID_Branch from Department where ID_Department = @e)
	   if @e_8 is not null
	       begin
		      set  @e =  @e + 1
		      print  convert(nvarchar(10),@e_8) + ' @e_8 Заполнение переменной'
		   end
	 end
	 else
			break;
 end;




insert into dbo.[Group] (ID_Department,Name_Group,ID_Branch)
 values
--1,'Финансовый депортамент'197
     (1,'Отдел бухгалтерского учёта'              ,@e_1),
     (1,'Отдел финансового планирования и анализа',@e_1),
     (1,'Казначейство'                            ,@e_1),
     (1,'Отдел налогов'                           ,@e_1),
--2,'Депортамен HR'292														   		
     (2,'Отдел подбора персонала'                 ,@e_2),
     (2,'Отдел обучения и развития'               ,@e_2),
     (2,'Отдел компенсаций и льгот'               ,@e_2),
--3,'Депортамент продаж'487													  		,
     (3,'Отдел управления продажами'              ,@e_3),
     (3,'Отдел корпоративных продаж'              ,@e_3),
     (3,'Отдел розничных продаж'                  ,@e_3),
     (3,'Отдел продаж в интернете'                ,@e_3),
--4,'Маркетинговый депортамент'506													   		
     (4,'Отдел исследований и аналитики'          ,@e_4),
     (4,'Отдел стратегического маркетинга'        ,@e_4),
     (4,'Отдел цифрового маркетинга'              ,@e_4),
     (4,'Отдел рекламы и PR'                      ,@e_4),
--5,'Операционный депортамент'129													   		
     (5,'Отдел планирования операций'             ,@e_5),
     (5,'Отдел управления проектами'              ,@e_5),
     (5,'Отдел контроля качества'                 ,@e_5),
     (5,'Отдел информационных технологий'         ,@e_5),
     (5,'Отдел логистики и снабжения'             ,@e_5),
--6,'Депортамен IT (информационных технологий)'556													   		
     (6,'Разработка программного обеспечения'     ,@e_6),
     (6,'Системное администрирование'             ,@e_6),
     (6,'Информационные технологии (IT)'          ,@e_6),
     (6,'Аналитика и бизнес-разведка'             ,@e_6),
     (6,'Управление проектами'                    ,@e_6),
     (6,'Маркетинг и Продажи'                     ,@e_6),
     (6,'Кибербезопасность'                       ,@e_6),
     (6,'Дизайн и пользовательский опыт (UX/UI)'  ,@e_6),
--7,'Юридический Депортамент'395													   	
     (7,'Отдел корпоративного права'              ,@e_7),
     (7,'Отдел гражданского права'                ,@e_7),
     (7,'Отдел уголовного права'                  ,@e_7),
     (7,'Отдел административного права'           ,@e_7),
--8,'Депортамент службы безопастности'127														   		
     (8,'Отдел аналитики и прогнозирования'       ,@e_8),
     (8,'Отдел оперативной поддержки'             ,@e_8),
     (8,'Отдел физической безопасности'           ,@e_8),
     (8,'Отдел аналитики и прогнозирования'       ,@e_8)
 --rollback

go



drop table if exists #t_3
Select ID_Group,null as Department_Сode, 0 flag into #t_3 from dbo.[Group]
go
declare @i_3 int = 0;
declare @s_1 int;
declare @ROWCOUNT_1 int;

declare
 @ID_Group            bigint  
,@Department_Сode     int
,@flag                int
declare mycur_1 cursor local fast_forward read_only for

Select * from #t_3

open  mycur_1
fetch next from  mycur_1 into @ID_Group,@Department_Сode,@flag
 while @@FETCH_STATUS  = 0
    begin
        begin try

              set  @s_1= (case when (round(rand()*4,0)) =1 then round(rand()*9999999,0)
						       when (round(rand()*4,0)) =2 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =3 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =4 then round(rand()*9999999,0)
                           else  round(rand()*9999999,0)  end);
			  print ' Сформировали случайное число -->' + convert(nvarchar(10),@s_1)

			  if ( select top 1 1 
			       from dbo.#t_3  as Gr 
				   where 1 = 1 
				   and Gr.flag = 0 
				   and Gr.ID_Group = @ID_Group 
				   and Gr.Department_Сode is  null)  = 1
			     begin
	                update  Gr
	                set Department_Сode = @s_1 
	                from  dbo.#t_3  as Gr 
			        where  Gr.flag = 0 and  Gr.ID_Group = @ID_Group and Gr.Department_Сode is  null					
					set @ROWCOUNT_1 = @@ROWCOUNT

			        print ' Случайное число внесено в Department_Сode в таблицу dbo.#t_3 --> ' + convert(nvarchar(10),@ID_Group)
                 end
			  
			  if  @ROWCOUNT_1 > 0   
			     begin
			         update m 
			         set flag = 1 
			         from #t_3  as m where   ID_Group = @ID_Group and flag = 0 
					 print ' ID_Group ' +  convert(nvarchar(10),@ID_Group) + ' flag с "0" изменён на "1" в таблице #t_3' 
			     end  
        end try
	    begin catch
	       if xact_state() in (1, -1) -- Функция XACT_STATE сообщает о состоянии пользовательской транзакции текущего выполняемого запроса.
		              /*
		              1 : запрос внутри блока транзакции активен и действителен (не выдал ошибку).
                      0 : запрос не выдаст ошибку (например, запрос select внутри транзакции без запросов update / insert).
                      -1: Запрос внутри транзакции выдал ошибку (при вводе блока catch) и выполнит полный откат
					  (если у нас есть 4 успешных запроса и 1 выдает ошибку ,все 5 запросов будут откатаны ).
		              */
              ROLLBACK TRAN
           SELECT 
             ERROR_NUMBER() AS ErrorNumber,
             ERROR_SEVERITY() AS ErrorSeverity,
             ERROR_STATE() as ErrorState,
             ERROR_PROCEDURE() as ErrorProcedure,
             ERROR_LINE() as ErrorLine,
             ERROR_MESSAGE() as ErrorMessage;
	    end catch
     fetch next from  mycur_1 into @ID_Group,@Department_Сode,@flag
   end
close mycur_1
deallocate mycur_1

declare
 @ID_Group_2            bigint  
,@Department_Сode_2     int
,@flag_2                int;

 if exists (select flag from #t_3 where  not exists ( select flag from #t_3 where flag = 0))
	   begin
			   declare  mycur_2 cursor local fast_forward read_only for 
			   select ID_Group,Department_Сode,flag from  #t_3 
			   open  mycur_2
			     fetch next from  mycur_2 into @ID_Group_2,@Department_Сode_2,@flag_2
			       while @@FETCH_STATUS =  0 
				       begin
					       begin try
						         update Gr_2
								 set Department_Сode = @Department_Сode_2
								 from dbo.[Group] as Gr_2
								 where @ID_Group_2 = ID_Group and @flag_2 = 1
								 print ' По -->  ID_Group ' +  convert(nvarchar(10),@ID_Group_2) + ' Внесены изменения в таблице Group из таблицы #t_3' 
						   end try
						   begin catch
						          if xact_state() in (1, -1)   
								      ROLLBACK TRAN
                                  SELECT 
								    ERROR_NUMBER() AS ErrorNumber,
								    ERROR_SEVERITY() AS ErrorSeverity,
								    ERROR_STATE() as ErrorState,
								    ERROR_PROCEDURE() as ErrorProcedure,
								    ERROR_LINE() as ErrorLine,
								    ERROR_MESSAGE() as ErrorMessage;
						   end catch
                       fetch next from  mycur_2 into @ID_Group_2,@Department_Сode_2,@flag_2
					   end
               close mycur_2
              deallocate mycur_2
            end

------------------------------------------------------------888888888888888888888888888888888888888888888888------------------------------------------------------------------------------------------

insert into The_Subgroup (ID_Group,Name_The_Subgroup,ID_Branch,ID_Parent_The_Subgroup)
values
--(1,'Финансовый депортамент'197)
     --(1,'Отдел бухгалтерского учёта',197),
	      (1,'По учёту основных средств',14,NULL)  
,		  (1,'По учёту расчетов с контрагентами',14,NULL)
,		  (1,'По учёту зарплаты и кадров',14,NULL)
,		  (1,'По подготовке финансовой отчётности',14,NULL)
     --(1,'Отдел финансового планирования и анализа',197),
,	      (2,'По бюджетированию',15,NULL)
,		  (2,'По финансовому моделированию',15,NULL)
,		  (2,'По анализу результатов',15,NULL)
,		  (2,'По управлению рисками',15,NULL)
     --(1,'Казначейство',197),
,	      (3,'По управлению ликвидностью',16,NULL)
,		  (3,'По расчетам и платежам',16,NULL)
,		  (3,'По монетарным операциям',16,NULL)
,		  (3,'По работе с банковскими учреждениями',16,NULL)
     --(1,'Отдел налогов',197),
,	      (4,'По налоговому учету',17,NULL)
,		  (4,'По налоговому планированию',17,NULL)
,		  (4,'По налоговым спорам',17,NULL)
,		  (4,'По подготовке налоговой отчётности',17,NULL)
 --(2,'Депортамен HR'292)														   	
     --(2,'Отдел подбора персонала',292),
,	      (5,'По привлечению кандидатов',17,NULL)
,		  (5,'По проведению собеседований',17,NULL)
,		  (5,'По оценке кандидатов',17,NULL)
,		  (5,'По работе с агентствами',17,NULL)
     --(2,'Отдел обучения и развития',292),
,	      (6,'По разработке учебных программ',18,NULL)
,		  (6,'По оценке эффективности обучения',18,NULL)
,		  (6,'По организационному развитию',18,NULL)
,		  (6,'По наставничеству и коучингу',18,NULL)
     --(2,'Отдел компенсаций и льгот',292),
,	      (7,'По зарплатным проверкам',19,NULL)
,		  (7,'По управлению бонусами',19,NULL)
,		  (7,'По социальным льготам',19,NULL)
,		  (7,'По пенсионным схемам',19,NULL)
 --(3,'Депортамент продаж'487)													  		,
     --(3,'Отдел управления продажами',487),
,	      (8,'По разработке стратегий продаж',20,NULL)
,		  (8,'Планирования и прогнозирования продаж',20,NULL)
,		  (8,'Анализа производительности',20,NULL)
,		  (8,'Управления ключевыми клиентами',20,NULL)
     --(3,'Отдел корпоративных продаж',487),
,	      (9,'По работе с крупными клиентами',21,NULL)
,		  (9,'По акционным предложениям',21,NULL)
,		  (9,'По тендерам и контрактам',21,NULL)
,		  (9,'По развитию партнёрских отношений',21,NULL)
     --(3,'Отдел розничных продаж',487),
,	      (10,'По управлению точками продаж',22,NULL)
,		  (10,'По обучению персонала',22,NULL)
,		  (10,'По мерчандайзингу',22,NULL)
,		  (10,'По клиентскому обслуживанию',22,NULL)
     --(3,'Отдел продаж в интернете',487),
,	      (11,'По оптимизации электронной коммерции',23,NULL)
,		  (11,'По управлению контентом',23,NULL)
,		  (11,'По анализу поведения пользователей на сайте',23,NULL)
,		  (11,'По рекламе и продвижению товаров онлайн',23,NULL)
 --(4,'Маркетинговый депортамент'506)													   	
     --(4,'Отдел исследований и аналитики',506),
,	      (12,'Потребительских исследований',24,NULL)
,		  (12,'Конкурентного анализа',24,NULL)
,		  (12,'Рыночного прогнозирования',24,NULL)
,		  (12,'Анализа данных',24,NULL)
     --(4,'Отдел стратегического маркетинга',506),
,	      (13,'Разработки маркетинговых стратегий',25,NULL)
,		  (13,'Управления брендом',25,NULL)
,		  (13,'Сегментации рынка',25,NULL)
,		  (13,'Планирования продуктов',25,NULL)
     --(4,'Отдел цифрового маркетинга',506),
,	      (14,'SMM (социальные медиа)',26,NULL)
,		  (14,'Контент-маркетинга',26,NULL)
,		  (14,'SEO (поисковая оптимизация)',26,NULL)
,		  (14,'Email-маркетинга',26,NULL)
     --(4,'Отдел рекламы и PR',506),
,	      (15,'Рекламных кампаний',27,NULL)
,		  (15,'PR и медиа-отношений',27,NULL)
,		  (15,'Управления событиями',27,NULL)
,		  (15,'Креативного дизайна',27,NULL)
 --(5,'Операционный депортамент'129)													   	
      --(5,'Отдел планирования операций',129),
,	      (16,'Группа стратегического планирования',28,NULL)
,		  (16,'Группа тактического планирования',28,NULL)
,		  (16,'Группа управления ресурсами',28,NULL)
,		  (16,'Группа анализа результативности',28,NULL)
     --(5,'Отдел управления проектами',129),
,	      (17,'Группа инициации проектов',29,NULL)
,		  (17,'Группа мониторинга и контроля',29,NULL)
,		  (17,'Группа оценки рисков',29,NULL)
,		  (17,'Группа закрытия проектов',29,NULL)
    --(5,'Отдел контроля качества',129),
,	      (18,'Группа внутреннего аудита',30,NULL)
,		  (18,'Группа обеспечения стандартов',30,NULL)
,		  (18,'Группа анализа несоответствий',30,NULL)
,		  (18,'Группа улучшения процессов',30,NULL)
     --(5,'Отдел информационных технологий',129),
,	      (19,'Группа разработки программного обеспечения',31,NULL)
,		  (19,'Группа технической поддержки',31,NULL)
,		  (19,'Группа управления базами данных',31,NULL)
,		  (19,'Группа внедрения новых технологий',31,NULL)
     --(5,'Отдел логистики и снабжения',129),
,	      (20,'Группа управления поставками',32,NULL)
,		  (20,'Группа складского учета',32,NULL)
,		  (20,'Группа доставки и распределения',32,NULL)
,		  (20,'Группа оптимизации запасов',32,NULL)
 --(6,'Депортамен IT (информационных технологий)'556)											   	
     -- (6,'Разработка программного обеспечения',556),
,	      (21,'Отдел фронтенд-разработки',33,NULL)
		     --(21,'Разработка пользовательского интерфейса (UI)
		     --(21,'Разработка пользовательского опыта (UX)
		     --(21,'Верстка и адаптивный дизайн
		     --(21,'Анимации и динамические элементы
,		  (21,'Отдел бэкенд-разработки',33,NULL)
		     --(21,'Разработка RESTful API
		     --(21,'Управление базами данных (DBA)
		     --(21,'Интеграция сторонних сервисов
		     --(21,'Работа с серверной архитектурой и микросервисами
,		  (21,'Отдел мобильной разработки',33,NULL)
		     --(21,'Разработка приложений для iOS
		     --(21,'Разработка приложений для Android
		     --(21,'Кроссплатформенная разработка
		     --(21,'Оптимизация производительности мобильных приложений
,		  (21,'Отдел тестирования и контроля качества',33,NULL)
		     --(21,'Функциональное тестирование
		     --(21,'Автоматизированное тестирование
		     --(21,'Нагрузочное тестирование
    -- (6,'Системное администрирование',556),
,	      (22,'Отдел технической поддержки',34,NULL)
		     --(22,'Обработка запросов от пользователей
		     --(22,'Поддержка программного обеспечения
		     --(22,'Мониторинги поддержка серверов и сетей
		     --(22,'Интеграция с сторонними сервисами
		     --(22,'Настройка автоматизации процессов
,		  (22,'Отдел управления сетями',34,NULL)
		     --(22,'Обработка запросов от пользователей
		     --(22,'Поддержка программного обеспечения
		     --(22,'Мониторинги поддержка серверов и сетей
		     --(22,'Интеграция с сторонними сервисами
		     --(22,'Настройка автоматизации процессов
,		  (22,'Отдел безопасности информационных систем',34,NULL)
		     --(22,'Управление рисками
		     --(22,'Защита данных
		     --(22,'Инцидент-менеджмент
     --(6,'Информационные технологии (IT)',556),
,	      (23,'Отдел разработки IT-стратегий',35,NULL)
		     --(23,'Анализ требований и исследований
		     --(23,'Разработка архитектуры IT-решений
		     --(23,'Управление инновациями
		     --(23,'Планирование и бюджетирование IT-проектов
,		  (23,'Отдел поддержки пользователей и оборудования',35,NULL)
		     --(23,'Поддержка рабочих станций и устройств
		     --(23,'Служба технической поддержки станций и устройств
		     --(23,'Управление инвентаризацией оборудования
		     --(23,'Обучение пользователей по продукту 
,		  (23,'Отдел управления проектами',35,NULL)
		     --(23,'Инициация и планирование проектов
		     --(23,'Контроль выполнения и качества
		     --(23,'Управление рисками и изменениями
     --(6,'Аналитика и бизнес-разведка',556),
,	      (24,'Отдел анализа данных',36,NULL)
		     -- (24,'Моделирование и прогнозирование
		  	  --(24,'Визуализация данных
		  	  --(24,'Анализ больших данных
,		  (24,'Отдел бизнес-анализа',36,NULL)
		     -- (24,'Сбор и анализ бизнес-требований
		  	  --(24,'Оптимизация бизнес-процессов
		  	  --(24,'Оценка экономической эффективности проектов
		  	  --(24,'Подготовка отчетности для руководства
,		  (24,'Отдел финансовой аналитики',36,NULL)
		     -- (24,'Анализ финансовых отчетов
		  	  --(24,'Бюджетирование и прогнозирование доходов
		  	  --(24,'Оценка инвестиционных проектов
     --(6,'Управление проектами',556),
,	      (25,'Отдел управления проектами',37,NULL)
		     -- (25,'Планирование и организация проектов.
		  	  --(25,'Контроль выполнения сроков и бюджета.
		  	  --(25,'Управление рисками и изменениями.
		  	  --(25,'Координация работы команды и коммуникация с заинтересованными сторонами.
,		  (25,'Отдел по работе с клиентами',37,NULL)
		     -- (25,'Обработка запросов и жалоб клиентов.
		  	  --(25,'Поддержка и консультирование клиентов.
		  	  --(25,'Сбор отзывов и улучшение сервиса.
		  	  --(25,'Установление долгосрочных отношений с клиентами.
,		  (25,'Отдел долгосрочного планирования',37,NULL)
		     -- (25,'Разработка стратегических планов компании.
		  	  --(25,'Анализ рыночных тенденций и условий.
		  	  --(25,'Оценка ресурсных потребностей на будущее.
		  	  --(25,'Подготовка сценариев и планов на случай непредвиденных обстоятельств.
     --(6,'Маркетинг и Продажи',556),
,	      (26,'Отдел цифрового маркетинга',38,NULL)
		   -- (26,'Разработка и реализация стратегий онлайн-продвижения.
		  	--(26,'Управление рекламными кампаниями в социальных сетях и поисковых системах.
		  	--(26,'Анализ результатов маркетинговых активностей и оптимизация кампаний.
		  	--(26,'Создание контента для веб-сайтов, блогов и социальных платформ.
,		  (26,'Отдел продаж продуктов',38,NULL)
		   -- (26,'Организация процессов продаж и взаимодействия с клиентами.
		  	--(26,'Поиск и привлечение новых клиентов.
		  	--(26,'Поддержка существующих клиентов и развитие долгосрочных отношений.
		  	--(26,'Проведение тренингов для команды продаж и мониторинг их эффективности.
,		  (26,'Отдел по работе с клиентами',38,NULL)
		   -- (26,'Обработка запросов и динамическое реагирование на потребности клиентов.
		  	--(26,'Обеспечение высокого уровня сервиса и удовлетворенности клиентов.
		  	--(26,'Сбор отзывов для дальнейшего улучшения продукта и сервиса.
		  	--(26,'Содействие в решении конфликтных ситуаций между компанией и клиентами.
    --(6,'Кибербезопасность',556),
,	    (27,'Отдел реагирования на инциденты',39,NULL)
		 --   (27,'Команда мониторинга событий безопасности (SIEM) 
			--(27,'Команда по анализу инцидентов                   
			--(27,'Команда восстановления после инцидентов         
			--(27,'Команда обучения и осведомленности              
,		(27,'Отдел анализа уязвимостей',39,NULL)
		 --   (27,'Команда сканирования уязвимостей
			--(27,'Команда оценки рисков           
			--(27,'Команда управления уязвимостями 
			--(27,'Команда мониторинга новых угроз
,		(27,'Отдел обеспечения безопасности данных',39,NULL)
		 --   (27,'Команда управления доступом             
			--(27,'Команда шифрования и защиты данных      
			--(27,'Команда соответствия стандартам и нормам
			--(27,'Команда по реагированию на утечки данных
     --(6,'Дизайн и пользовательский опыт (UX/UI)',556),
,	    (28,'Отдел графического дизайна',40,NULL)
		 --   (28,'Команда иллюстрации
			--(28,'Команда веб-дизайна
			--(28,'Команда типографики
			--(28,'Команда брендинга
,		(28,'Отдел UX-исследований',40,NULL)
		    --(28,'Команда пользовательских интервью
			--(28,'Команда юзабилити-тестирования
			--(28,'Команда анализа данных
			--(28,'Команда создания персонажей (персон)
,		(28,'Отдел прототипирования и вайрфрейминга',40,NULL)
		 --   (28,'Команда низкой четкости (low-fidelity) прототипов
			--(28,'Команда высокой четкости (high-fidelity) прототипов
			--(28,'Команда тестирования прототипов
--7,'Юридический Депортамент'395)													   	
     --(7,'Отдел корпоративного права',395),
,	        (29,'Секретариат совета директоров',42,NULL)  
,	        (29,'Контрактного управления',42,NULL)  
,	        (29,'Соблюдения корпоративного законодательства',42,NULL)
,	        (29,'Защиты интеллектуальной собственности',42,NULL) 
     --(7,'Отдел гражданского права',395),
,	        (30,'Споров о собственности',43,NULL)  
,			(30,'По делам о банкротстве',43,NULL)   
,			(30,'Договорных обязательств',43,NULL)  
,			(30,'Защиты прав потребителей',43,NULL) 
     --(7,'Отдел уголовного права',395),
,	        (31,'Расследования уголовных дел',44,NULL)   
,			(31,'Защиты обвиняемых',44,NULL)  
,			(31,'Судебного преследования',44,NULL)  
,			(31,'По правам жертв преступлений',44,NULL) 
     --(7,'Отдел административного права',395),
,	        (32,'Правовой поддержки государственных органов',45,NULL)  
,			(32,'Надзорных производств',45,NULL)   
,			(32,'По контролю за соблюдением норм законодательства',45,NULL)  
,			(32,'Обжалования административных решений',45,NULL)   
--8,'Депортамент службы безопастности'127)											   		
     --(8,'Отдел аналитики и прогнозирования',127),
,	        (33,'Прогнозирования угроз',46,NULL) 
,			(33,'Анализа рисков',46,NULL)
,			(33,'Работы с открытыми источниками',46,NULL)
,			(33,'Межведомственного взаимодействия',46,NULL)
     --(8,'Отдел оперативной поддержки',127),
,	        (34,'По координации действий с другими службами',47,NULL)
,			(34,'По работе с информаторами',47,NULL)
,			(34,'Сбора и анализа данных',47,NULL)
     --(8,'Отдел физической безопасности',127),
,	        (35,'Охраны объектов',48,NULL)
,			(35,'Контроля видеонаблюдения',48,NULL)
,			(35,'Проверки сотрудников',48,NULL)
,			(35,'Реагирования на угрозы',48,NULL)
     --(8,'Отдел аналитики и прогнозирования',127)
,	        (36,'Прогнозирования угроз',49,NULL)
,			(36,'Анализа рисков',49,NULL)
,			(36,'Работы с открытыми источниками',49,NULL)
,			(36,'Межведомственного взаимодействия',49,NULL)

go

insert into The_Subgroup (ID_Group,Name_The_Subgroup,ID_Branch,ID_Parent_The_Subgroup)
values
--(1,'Финансовый депортамент'197)
     --(1,'Отдел бухгалтерского учёта',197),
	   --   (1,'По учёту основных средств',14,NULL)  
		  --(1,'По учёту расчетов с контрагентами',14,NULL)
		  --(1,'По учёту зарплаты и кадров',14,NULL)
		  --(1,'По подготовке финансовой отчётности',14,NULL)
     --(1,'Отдел финансового планирования и анализа',197),
	   --   (2,'По бюджетированию',15,NULL)
		  --(2,'По финансовому моделированию',15,NULL)
		  --(2,'По анализу результатов',15,NULL)
		  --(2,'По управлению рисками',15,NULL)
     --(1,'Казначейство',197),
	   --   (3,'По управлению ликвидностью',16,NULL)
		  --(3,'По расчетам и платежам',16,NULL)
		  --(3,'По монетарным операциям',16,NULL)
		  --(3,'По работе с банковскими учреждениями',16,NULL)
     --(1,'Отдел налогов',197),
	   --   (4,'По налоговому учету',17,NULL)
		  --(4,'По налоговому планированию',17,NULL)
		  --(4,'По налоговым спорам',17,NULL)
		  --(4,'По подготовке налоговой отчётности',17,NULL)
 --(2,'Депортамен HR'292)														   	
     --(2,'Отдел подбора персонала',292),
	   --   (5,'По привлечению кандидатов',17,NULL)
		  --(5,'По проведению собеседований',17,NULL)
		  --(5,'По оценке кандидатов',17,NULL)
		  --(5,'По работе с агентствами',17,NULL)
     --(2,'Отдел обучения и развития',292),
	   --   (6,'По разработке учебных программ',18,NULL)
		  --(6,'По оценке эффективности обучения',18,NULL)
		  --(6,'По организационному развитию',18,NULL)
		  --(6,'По наставничеству и коучингу',18,NULL)
     --(2,'Отдел компенсаций и льгот',292),
	   --   (7,'По зарплатным проверкам',19,NULL)
		  --(7,'По управлению бонусами',19,NULL)
		  --(7,'По социальным льготам',19,NULL)
		  --(7,'По пенсионным схемам',19,NULL)
 --(3,'Депортамент продаж'487)													  		,
     --(3,'Отдел управления продажами',487),
	   --   (8,'По разработке стратегий продаж',20,NULL)
		  --(8,'Планирования и прогнозирования продаж',20,NULL)
		  --(8,'Анализа производительности',20,NULL)
		  --(8,'Управления ключевыми клиентами',20,NULL)
     --(3,'Отдел корпоративных продаж',487),
	   --   (9,'По работе с крупными клиентами',21,NULL)
		  --(9,'По акционным предложениям',21,NULL)
		  --(9,'По тендерам и контрактам',21,NULL)
		  --(9,'По развитию партнёрских отношений',21,NULL)
     --(3,'Отдел розничных продаж',487),
	   --   (10,'По управлению точками продаж',22,NULL)
		  --(10,'По обучению персонала',22,NULL)
		  --(10,'По мерчандайзингу',22,NULL)
		  --(10,'По клиентскому обслуживанию',22,NULL)
     --(3,'Отдел продаж в интернете',487),
	   --   (11,'По оптимизации электронной коммерции',23,NULL)
		  --(11,'По управлению контентом',23,NULL)
		  --(11,'По анализу поведения пользователей на сайте',23,NULL)
		  --(11,'По рекламе и продвижению товаров онлайн',23,NULL)
 --(4,'Маркетинговый депортамент'506)													   	
     --(4,'Отдел исследований и аналитики',506),
	   --   (12,'Потребительских исследований',24,NULL)
		  --(12,'Конкурентного анализа',24,NULL)
		  --(12,'Рыночного прогнозирования',24,NULL)
		  --(12,'Анализа данных',24,NULL)
     --(4,'Отдел стратегического маркетинга',506),
	   --   (13,'Разработки маркетинговых стратегий',25,NULL)
		  --(13,'Управления брендом',25,NULL)
		  --(13,'Сегментации рынка',25,NULL)
		  --(13,'Планирования продуктов',25,NULL)
     --(4,'Отдел цифрового маркетинга',506),
	   --   (14,'SMM (социальные медиа)',26,NULL)
		  --(14,'Контент-маркетинга',26,NULL)
		  --(14,'SEO (поисковая оптимизация)',26,NULL)
		  --(14,'Email-маркетинга',26,NULL)
     --(4,'Отдел рекламы и PR',506),
	   --   (15,'Рекламных кампаний',27,NULL)
		  --(15,'PR и медиа-отношений',27,NULL)
		  --(15,'Управления событиями',27,NULL)
		  --(15,'Креативного дизайна',27,NULL)
 --(5,'Операционный депортамент'129)													   	
      --(5,'Отдел планирования операций',129),
	   --   (16,'Группа стратегического планирования',28,NULL)
		  --(16,'Группа тактического планирования',28,NULL)
		  --(16,'Группа управления ресурсами',28,NULL)
		  --(16,'Группа анализа результативности',28,NULL)
     --(5,'Отдел управления проектами',129),
	   --   (17,'Группа инициации проектов',29,NULL)
		  --(17,'Группа мониторинга и контроля',29,NULL)
		  --(17,'Группа оценки рисков',29,NULL)
		  --(17,'Группа закрытия проектов',29,NULL)
    --(5,'Отдел контроля качества',129),
	   --   (18,'Группа внутреннего аудита',30,NULL)
		  --(18,'Группа обеспечения стандартов',30,NULL)
		  --(18,'Группа анализа несоответствий',30,NULL)
		  --(18,'Группа улучшения процессов',30,NULL)
     --(5,'Отдел информационных технологий',129),
	   --   (19,'Группа разработки программного обеспечения',31,NULL)
		  --(19,'Группа технической поддержки',31,NULL)
		  --(19,'Группа управления базами данных',31,NULL)
		  --(19,'Группа внедрения новых технологий',31,NULL)
     --(5,'Отдел логистики и снабжения',129),
	   --   (20,'Группа управления поставками',32,NULL)
		  --(20,'Группа складского учета',32,NULL)
		  --(20,'Группа доставки и распределения',32,NULL)
		  --(20,'Группа оптимизации запасов',32,NULL)
 --(6,'Депортамен IT (информационных технологий)'556)											   	
     -- (6,'Разработка программного обеспечения',556),
	      --(21,'Отдел фронтенд-разработки',33,NULL)
		          (21,'Разработка пользовательского интерфейса (UI)',33,81)
,		          (21,'Разработка пользовательского опыта (UX)',33,81)
,		          (21,'Верстка и адаптивный дизайн',33,81)
,		          (21,'Анимации и динамические элементы',33,81)
		  --(21,'Отдел бэкенд-разработки',33,NULL)
,		          (21,'Разработка RESTful API',33,82)
,		          (21,'Управление базами данных (DBA)',33,82)
,		          (21,'Интеграция сторонних сервисов',33,82)
,		          (21,'Работа с серверной архитектурой и микросервисами',33,82)
		  --(21,'Отдел мобильной разработки',33,NULL)
,		          (21,'Разработка приложений для iOS',33,83)
,		          (21,'Разработка приложений для Android',33,83)
,		          (21,'Кроссплатформенная разработка',33,83)
,		          (21,'Оптимизация производительности мобильных приложений',33,83)
		  --(21,'Отдел тестирования и контроля качества',33,NULL)
,		          (21,'Функциональное тестирование',33,84)
,		          (21,'Автоматизированное тестирование',33,84)
,		          (21,'Нагрузочное тестирование',33,84)
    -- (6,'Системное администрирование',556),
	      --(22,'Отдел технической поддержки',34,NULL)
,		     (22,'Обработка запросов от пользователей',34,85)
,		     (22,'Поддержка программного обеспечения',34,85)
,		     (22,'Мониторинги поддержка серверов и сетей',34,85)
,		     (22,'Интеграция с сторонними сервисами',34,85)
,		     (22,'Настройка автоматизации процессов',34,85)
		  --(22,'Отдел управления сетями',34,NULL)
,		     (22,'Обработка запросов от пользователей',34,86)
,		     (22,'Поддержка программного обеспечения',34,86)
,		     (22,'Мониторинги поддержка серверов и сетей',34,86)
,		     (22,'Интеграция с сторонними сервисами',34,86)
,		     (22,'Настройка автоматизации процессов',34,86)
		  --(22,'Отдел безопасности информационных систем',34,NULL)
,		     (22,'Управление рисками',34,87)
,		     (22,'Защита данных',34,87)
,		     (22,'Инцидент-менеджмент',34,87)
     --(6,'Информационные технологии (IT)',556),
	      --(23,'Отдел разработки IT-стратегий',35,NULL)
,		     (23,'Анализ требований и исследований',35,88)
,		     (23,'Разработка архитектуры IT-решений',35,88)
,		     (23,'Управление инновациями',35,88)
,		     (23,'Планирование и бюджетирование IT-проектов',35,88)
		  --(23,'Отдел поддержки пользователей и оборудования',35,NULL)
,		     (23,'Поддержка рабочих станций и устройств',35,89)
,		     (23,'Служба технической поддержки станций и устройств',35,89)
,		     (23,'Управление инвентаризацией оборудования',35,89)
,		     (23,'Обучение пользователей по продукту',35,89) 
		  --(23,'Отдел управления проектами',35,NULL)
,		     (23,'Инициация и планирование проектов',35,90)
,		     (23,'Контроль выполнения и качества',35,90)
,		     (23,'Управление рисками и изменениями',35,90)
     --(6,'Аналитика и бизнес-разведка',556),
	      --(24,'Отдел анализа данных',36,NULL)
,		     (24,'Моделирование и прогнозирование',36,91)
,		  	 (24,'Визуализация данных',36,91)
,		  	 (24,'Анализ больших данных',36,91)
		  --(24,'Отдел бизнес-анализа',36,NULL)
,		     (24,'Сбор и анализ бизнес-требований',36,92)
,		  	 (24,'Оптимизация бизнес-процессов',36,92)
,		  	 (24,'Оценка экономической эффективности проектов',36,92)
,		  	 (24,'Подготовка отчетности для руководства',36,92)
		  --(24,'Отдел финансовой аналитики',36,NULL)
,		     (24,'Анализ финансовых отчетов',36,93)
,		  	 (24,'Бюджетирование и прогнозирование доходов',36,93)
,		  	 (24,'Оценка инвестиционных проектов',36,93)
     --(6,'Управление проектами',556),
	      --(25,'Отдел управления проектами',37,NULL)
,		     (25,'Планирование и организация проектов',37,94)
,		  	 (25,'Контроль выполнения сроков и бюджета',37,94)
,		  	 (25,'Управление рисками и изменениями',37,94)
,		  	 (25,'Координация работы команды и коммуникация с заинтересованными сторонами',37,94)
		  --(25,'Отдел по работе с клиентами',37,NULL)
,		     (25,'Обработка запросов и жалоб клиентов',37,95)
,		  	 (25,'Поддержка и консультирование клиентов',37,95)
,		  	 (25,'Сбор отзывов и улучшение сервиса',37,95)
,		  	 (25,'Установление долгосрочных отношений с клиентами',37,95)
		  --(25,'Отдел долгосрочного планирования',37,NULL)
,		     (25,'Разработка стратегических планов компании',37,96)
,		  	 (25,'Анализ рыночных тенденций и условий',37,96)
,		  	 (25,'Оценка ресурсных потребностей на будущее',37,96)
,		  	 (25,'Подготовка сценариев и планов на случай непредвиденных обстоятельств',37,96)
     --(6,'Маркетинг и Продажи',556),
	      --(26,'Отдел цифрового маркетинга',38,NULL)
,		      (26,'Разработка и реализация стратегий онлайн-продвижения',38,97)
,		  	  (26,'Управление рекламными кампаниями в социальных сетях и поисковых системах',38,97)
,		  	  (26,'Анализ результатов маркетинговых активностей и оптимизация кампаний',38,97)
,		  	  (26,'Создание контента для веб-сайтов, блогов и социальных платформ',38,97)
		  --(26,'Отдел продаж продуктов',38,NULL)
,		      (26,'Организация процессов продаж и взаимодействия с клиентами',38,98)
,		  	  (26,'Поиск и привлечение новых клиентов',38,98)
,		  	  (26,'Поддержка существующих клиентов и развитие долгосрочных отношений',38,98)
,		  	  (26,'Проведение тренингов для команды продаж и мониторинг их эффективности',38,98)
		  --(26,'Отдел по работе с клиентами',38,NULL)
,		       (26,'Обработка запросов и динамическое реагирование на потребности клиентов',38,99)
,		       (26,'Обеспечение высокого уровня сервиса и удовлетворенности клиентов',38,99)
,		       (26,'Сбор отзывов для дальнейшего улучшения продукта и сервиса',38,99)
,		       (26,'Содействие в решении конфликтных ситуаций между компанией и клиентами',38,99)
    --(6,'Кибербезопасность',556),
	    --(27,'Отдел реагирования на инциденты',39,NULL)
,		      (27,'Команда мониторинга событий безопасности (SIEM)',39,100) 
,			  (27,'Команда по анализу инцидентов',39,100)                    
,			  (27,'Команда восстановления после инцидентов',39,100)          
,			  (27,'Команда обучения и осведомленности',39,100)               
		--(27,'Отдел анализа уязвимостей',39,NULL)
,		      (27,'Команда сканирования уязвимостей',39,101) 
,			  (27,'Команда оценки рисков',39,101)            
,			  (27,'Команда управления уязвимостями',39,101)  
,			  (27,'Команда мониторинга новых угроз',39,101) 
		--(27,'Отдел обеспечения безопасности данных',39,NULL)
,		      (27,'Команда управления доступом',39,102)              
,			  (27,'Команда шифрования и защиты данных',39,102)      
,			  (27,'Команда соответствия стандартам и нормам',39,102)
,			  (27,'Команда по реагированию на утечки данных',39,102)
     --(6,'Дизайн и пользовательский опыт (UX/UI)',556),
	    --(28,'Отдел графического дизайна',40,NULL)
,		      (28,'Команда иллюстрации',40,103)
,		      (28,'Команда веб-дизайна',40,103)
,		      (28,'Команда типографики',40,103)
,		      (28,'Команда брендинга',40,103)
		--(28,'Отдел UX-исследований',40,NULL)
,		      (28,'Команда пользовательских интервью',40,104)
,			  (28,'Команда юзабилити-тестирования',40,104)
,			  (28,'Команда анализа данных',40,104)
,			  (28,'Команда создания персонажей (персон)',40,104)
		--(28,'Отдел прототипирования и вайрфрейминга',40,NULL)
,		      (28,'Команда низкой четкости (low-fidelity) прототипов',40,105)
,			  (28,'Команда высокой четкости (high-fidelity) прототипов',40,105)
,			  (28,'Команда тестирования прототипов',40,105)
   --7,'Юридический Депортамент'395)													   	
     --(7,'Отдел корпоративного права',395),
	        --(29,'Секретариат совета директоров',42,NULL)  
	        --(29,'Контрактного управления',42,NULL)  
	        --(29,'Соблюдения корпоративного законодательства',42,NULL)
	        --(29,'Защиты интеллектуальной собственности',42,NULL) 
     --(7,'Отдел гражданского права',395),
	        --(30,'Споров о собственности',43,NULL)  
			--(30,'По делам о банкротстве',43,NULL)   
			--(30,'Договорных обязательств',43,NULL)  
			--(30,'Защиты прав потребителей',43,NULL) 
     --(7,'Отдел уголовного права',395),
	        --(31,'Расследования уголовных дел',44,NULL)   
			--(31,'Защиты обвиняемых',44,NULL)  
			--(31,'Судебного преследования',44,NULL)  
			--(31,'По правам жертв преступлений',44,NULL) 
     --(7,'Отдел административного права',395),
	        --(32,'Правовой поддержки государственных органов',45,NULL)  
			--(32,'Надзорных производств',45,NULL)   
			--(32,'По контролю за соблюдением норм законодательства',45,NULL)  
			--(32,'Обжалования административных решений',45,NULL)   
  --8,'Депортамент службы безопастности'127)											   		
     --(8,'Отдел аналитики и прогнозирования',127),
	        --(33,'Прогнозирования угроз',46,NULL) 
			--(33,'Анализа рисков',46,NULL)
			--(33,'Работы с открытыми источниками',46,NULL)
			--(33,'Межведомственного взаимодействия',46,NULL)
     --(8,'Отдел оперативной поддержки',127),
	        --(34,'По координации действий с другими службами',47,NULL)
			--(34,'По работе с информаторами',47,NULL)
			--(34,'Сбора и анализа данных',47,NULL)
     --(8,'Отдел физической безопасности',127),
	        --(35,'Охраны объектов',48,NULL)
			--(35,'Контроля видеонаблюдения',48,NULL)
			--(35,'Проверки сотрудников',48,NULL)
			--(35,'Реагирования на угрозы',48,NULL)
     --(8,'Отдел аналитики и прогнозирования',127)
	        --(36,'Прогнозирования угроз',49,NULL)
			--(36,'Анализа рисков',49,NULL)
			--(36,'Работы с открытыми источниками',49,NULL)
			--(36,'Межведомственного взаимодействия',49,NULL)

go

drop table if exists #t_3
Select ID_The_Subgroup,null as Department_Сode, 0 flag into #t_3 from dbo.The_Subgroup
go
declare @i_3 int = 0;
declare @s_1 int;
declare @ROWCOUNT_1 int;

declare
 @ID_The_Subgroup     bigint  
,@Department_Сode     int
,@flag                int
declare mycur_3 cursor local fast_forward read_only for

Select * from #t_3

open  mycur_3
fetch next from  mycur_3 into @ID_The_Subgroup,@Department_Сode,@flag
 while @@FETCH_STATUS  = 0
    begin
        begin try

              set  @s_1= (case when (round(rand()*4,0)) =1 then round(rand()*9999999,0)
						       when (round(rand()*4,0)) =2 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =3 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =4 then round(rand()*9999999,0)
                           else  round(rand()*9999999,0)  end);
			  print ' Сформировали случайное число -->' + convert(nvarchar(10),@s_1)

			  if ( select top 1 1 
			       from dbo.#t_3  as Gr 
				   where 1 = 1 
				   and Gr.flag = 0 
				   and Gr.ID_The_Subgroup = @ID_The_Subgroup 
				   and Gr.Department_Сode is  null)  = 1
			     begin
	                update  Gr
	                set Department_Сode = @s_1 
	                from  dbo.#t_3  as Gr 
			        where  Gr.flag = 0 and  Gr.ID_The_Subgroup = @ID_The_Subgroup and Gr.Department_Сode is  null					
					set @ROWCOUNT_1 = @@ROWCOUNT

			        print ' Случайное число внесено в Department_Сode в таблицу dbo.#t_3 --> ' + convert(nvarchar(10),@ID_The_Subgroup)
                 end
			  
			  if  @ROWCOUNT_1 > 0   
			     begin
			         update m 
			         set flag = 1 
			         from #t_3  as m where  ID_The_Subgroup = @ID_The_Subgroup and flag = 0 
					 print ' ID_Group ' +  convert(nvarchar(10),@ID_The_Subgroup) + ' flag с "0" изменён на "1" в таблице #t_3' 
			     end  
        end try
	    begin catch
	       if xact_state() in (1, -1) -- Функция XACT_STATE сообщает о состоянии пользовательской транзакции текущего выполняемого запроса.
		              /*
		              1 : запрос внутри блока транзакции активен и действителен (не выдал ошибку).
                      0 : запрос не выдаст ошибку (например, запрос select внутри транзакции без запросов update / insert).
                      -1: Запрос внутри транзакции выдал ошибку (при вводе блока catch) и выполнит полный откат
					  (если у нас есть 4 успешных запроса и 1 выдает ошибку ,все 5 запросов будут откатаны ).
		              */
              ROLLBACK TRAN
           SELECT 
             ERROR_NUMBER() AS ErrorNumber,
             ERROR_SEVERITY() AS ErrorSeverity,
             ERROR_STATE() as ErrorState,
             ERROR_PROCEDURE() as ErrorProcedure,
             ERROR_LINE() as ErrorLine,
             ERROR_MESSAGE() as ErrorMessage;
	    end catch
     fetch next from  mycur_3 into @ID_The_Subgroup,@Department_Сode,@flag
   end
close mycur_3
deallocate mycur_3

declare
 @ID_The_Subgroup_2            bigint  
,@Department_Сode_2     int
,@flag_2                int;

 if exists (select flag from #t_3 where  not exists ( select flag from #t_3 where flag = 0))
	   begin
			   declare  mycur_4 cursor local fast_forward read_only for 
			   select ID_The_Subgroup,Department_Сode,flag from  #t_3 
			   open  mycur_4
			     fetch next from  mycur_4 into @ID_The_Subgroup_2,@Department_Сode_2,@flag_2
			       while @@FETCH_STATUS =  0 
				       begin
					       begin try
						         update Gr_2
								 set Department_Сode = @Department_Сode_2
								 from dbo.[The_Subgroup] as Gr_2
								 where @ID_The_Subgroup_2 = ID_The_Subgroup and @flag_2 = 1
								 print ' По -->  ID_Group ' +  convert(nvarchar(10),@ID_The_Subgroup_2) + ' Внесены изменения в таблице Group из таблицы #t_3' 
						   end try
						   begin catch
						          if xact_state() in (1, -1)   
								      ROLLBACK TRAN
                                  SELECT 
								    ERROR_NUMBER() AS ErrorNumber,
								    ERROR_SEVERITY() AS ErrorSeverity,
								    ERROR_STATE() as ErrorState,
								    ERROR_PROCEDURE() as ErrorProcedure,
								    ERROR_LINE() as ErrorLine,
								    ERROR_MESSAGE() as ErrorMessage;
						   end catch
                       fetch next from  mycur_4 into @ID_The_Subgroup_2,@Department_Сode_2,@flag_2
					   end
               close mycur_4
              deallocate mycur_4
            end
----------------------------------------------------------------------99999999999999999999999999999999999999999999999999999------------------------------------------

insert into Post (Name_Post,ID_Department,ID_Group,ID_The_Subgroup)
values
 ('Главный бухгалтер по учёту основных средств'                                    ,1,1,1)
,('Специалист по учёту основных средств'										   ,1,1,1)
,('Аналитик по учёту основных средств'											   ,1,1,1)
,('Менеджер по учёту основных средств'											   ,1,1,1)
,('Специалист по расчетам с контрагентами'										   ,1,1,2)
,('Аналитик по расчетам с контрагентами'										   ,1,1,2)
,('Менеджер по работе с контрагентами'											   ,1,1,2)
,('Юрист по расчетам с контрагентами'											   ,1,1,2)
,('Специалист по учёту зарплаты'												   ,1,1,3)
,('Кадровик'																	   ,1,1,3)
,('Аналитик по кадрам'															   ,1,1,3)
,('Менеджер по персоналу'														   ,1,1,3)
,('Финансовый аналитик по подготовке отчётности'								   ,1,1,4)
,('Специалист по финансовой отчётности'											   ,1,1,4)
,('Бухгалтер по финансовой отчётности'											   ,1,1,4)
,('Главный бухгалтер по отчётности'												   ,1,1,4)
,('Бюджетный аналитик'															   ,1,1,5)
,('Специалист по бюджетированию'												   ,1,1,5)
,('Финансовый менеджер по бюджету'												   ,1,1,5)
,('Менеджер по управлению бюджетом'												   ,1,1,5)
,('Финансовый аналитик по моделированию'										   ,1,1,6)
,('Специалист по финансовому моделированию'										   ,1,1,6)
,('Экономист по моделированию'													   ,1,1,6)
,('Менеджер проектов по моделированию'											   ,1,1,6)
,('Аналитик по анализу результатов'												   ,1,1,7)
,('Специалист по анализу эффективности'											   ,1,1,7)
,('Финансовый контролер'														   ,1,1,7)
,('Менеджер по результатам анализа'												   ,1,1,7)
,('Специалист по управлению рисками'											   ,1,1,8)
,('Аналитик по рискам'															   ,1,1,8)
,('Менеджер по рискам'															   ,1,1,8)
,('Финансовый консультант по рискам'											   ,1,1,8)
,('Специалист по управлению ликвидностью'										   ,1,1,9)
,('Аналитик по ликвидности'														   ,1,1,9)
,('Менеджер по ликвидности'														   ,1,1,9)
,('Финансовый оператор по ликвидности'											   ,1,1,9)
,('Специалист по расчетам и платежам'											   ,1,1,10)
,('Аналитик по платежам'														   ,1,1,10)
,('Менеджер по расчетам'														   ,1,1,10)
,('Бухгалтер по расчетам и платежам'											   ,1,1,10)
,('Специалист по монетарным операциям'											   ,1,1,11)
,('Аналитик монетарных операций'												   ,1,1,11)
,('Финансовый менеджер по монетарным операциям'									   ,1,1,11)
,('Кассир'																		   ,1,1,11)
,('Специалист по работе с банками'												   ,1,1,12)
,('Банк-менеджер'																   ,1,1,12)
,('Финансовый аналитик по банковским услугам'									   ,1,1,12)
,('Кредитный специалист'														   ,1,1,12)
,('Налоговый консультант'														   ,1,1,13)
,('Специалист по налоговому учету'												   ,1,1,13)
,('Налоговый аналитик'															   ,1,1,13)
,('Бухгалтер по налоговому учету'												   ,1,1,13)
,('Налоговый консультант по планированию'										   ,1,1,14)
,('Аналитик по налоговому планированию'											   ,1,1,14)
,('Специалист по налоговому планированию'										   ,1,1,14)
,('Менеджер по налоговому планированию'											   ,1,1,14)
,('Юрист по налоговым спорам'													   ,1,1,15)
,('Специалист по налоговым спорам'												   ,1,1,15)
,('Аналитик по налоговым спорам'												   ,1,1,15)
,('Налоговый консультант по спорам'												   ,1,1,15)
,('Бухгалтер по подготовке налоговой отчётности'								   ,1,1,16)
,('Специалист по налоговой отчётности'											   ,1,1,16)
,('Аналитик по налоговой отчётности'											   ,1,1,16)
,('Менеджер по налоговой отчётности'											   ,1,1,16)
,('HR-менеджер по привлечению кандидатов'										   ,1,1,17)
,('Специалист по привлечению кандидатов'										   ,1,1,17)
,('Аналитик по заказам на кандидатов'											   ,1,1,17)
,('Рекрутер'																	   ,1,1,17)
,('HR-менеджер по проведению собеседований'										   ,1,1,18)
,('Специалист по собеседованиям'												   ,1,1,18)
,('Аналитик по оценке собеседований'											   ,1,1,18)
,('Рекрутер-собеседник'															   ,1,1,18)
,('Специалист по оценке кандидатов'												   ,1,1,19)
,('Аналитик по оценке)'															   ,1,1,19)
,('Менеджер по оценке кандидатов'												   ,1,1,19)
,('Кадровый специалист'															   ,1,1,19)
,('HR-менеджер по работе с агентствами'											   ,1,1,20)
,('Специалист по взаимодействию с агентствами'									   ,1,1,20)
,('Аналитик по работе с агентствами'											   ,1,1,20)
,('Рекрутер по агентствам'														   ,1,1,20)
,('Специалист по работе с агентствами'  										   ,1,1,20)
,('Менеджер по работе с агентствами'  											   ,1,1,20)
,('Координатор по работе с агентствами'  										   ,1,1,20)
,('Аналитик по работе с агентствами'  											   ,1,1,20)
,('Методист учебных программ'  													   ,1,1,21)
,('Специалист по разработке образовательного контента'  						   ,1,1,21)
,('Координатор учебного процесса'  												   ,1,1,21)
,('Эксперт по образовательным стандартам'  										   ,1,1,21)
,('Аналитик по оценке эффективности'  											   ,1,1,22)
,('Специалист по оценке результатов обучения'  									   ,1,1,22)
,('Консультант по обучению'  													   ,1,1,22)
,('Разработчик методик оценки'  												   ,1,1,22)
,('Специалист по организационному развитию'  									   ,1,1,23)
,('Консультант по управлению изменениями'  										   ,1,1,23)
,('Аналитик организационной структуры'  										   ,1,1,23)
,('Руководитель проектов по развитию'  											   ,1,1,23)
,('Наставник'  																	   ,1,1,24)
,('Коуч'  																		   ,1,1,24)
,('Инструктор по наставничеству'  												   ,1,1,24)
,('Специалист по профессиональному развитию'  									   ,1,1,24)
,('Аналитик по зарплатным проверкам'  											   ,1,1,25)
,('Специалист по кадровым документам'  											   ,1,1,25)
,('Консультант по компенсациям'  												   ,1,1,25)
,('Менеджер по HR-отчетности'  													   ,1,1,25)
,('Специалист по управлению бонусами'  											   ,1,1,26)
,('Аналитик по системе компенсаций'  											   ,1,1,26)
,('Консультант по мотивации персонала'  										   ,1,1,26)
,('Менеджер по схемам вознаграждений'  											   ,1,1,26)
,('Специалист по социальным льготам'  											   ,1,1,27)
,('Консультант по корпоративным льготам'  										   ,1,1,27)
,('Менеджер по социальным программам'  											   ,1,1,27)
,('Аналитик по охране труда'  													   ,1,1,27)
,('Консультант по пенсионным схемам'  											   ,1,1,28)
,('Специалист по пенсионному обеспечению'  										   ,1,1,28)
,('Аналитик по пенсионным накоплениям'  										   ,1,1,28)
,('Менеджер по пенсионному планированию'  										   ,1,1,28)
,('Специалист по разработке стратегий продаж'  									   ,1,1,29)
,('Аналитик по продажам'  														   ,1,1,29)
,('Консультант по развитию продаж'  											   ,1,1,29)
,('Менеджер по продуктовой стратегии'  											   ,1,1,29)
,('Специалист по планированию продаж'  											   ,1,1,30)
,('Аналитик по прогнозированию'  												   ,1,1,30)
,('Менеджер по продажам'  														   ,1,1,30)
,('Консультант по методам планирования'  										   ,1,1,30)
,('Аналитик производительности'  												   ,1,1,31)
,('Специалист по оценке KPI'  													   ,1,1,31)
,('Консультант по оптимизации процессов'  										   ,1,1,31)
,('Менеджер по эффективности'  													   ,1,1,31)
,('Ключевой менеджер по клиентам'  												   ,1,1,32)
,('Специалист по работе с ключевыми аккаунтами'  								   ,1,1,32)
,('Аналитик по управлению клиентами'  											   ,1,1,32)
,('Консультант по стратегическому управлению'  									   ,1,1,32)
,('Менеджер по работе с крупными клиентами'  									   ,1,1,33)
,('Специалист по корпоративным клиентам'  										   ,1,1,33)
,('Аналитик по торговым отношениям'  											   ,1,1,33)
,('Консультант по клиентским стратегиям'  										   ,1,1,33)
,('Менеджер по акционным предложениям'  										   ,1,1,34)
,('Аналитик по акции и распродажам'  											   ,1,1,34)
,('Специалист по рекламе'  														   ,1,1,34)
,('Консультант по промо-мероприятиям'  											   ,1,1,34)
,('Специалист по тендерам'  													   ,1,1,35)
,('Аналитик по контрактам'  													   ,1,1,35)
,('Менеджер по государственных закупкам'  										   ,1,1,35)
,('Консультант по тендерному управлению'  										   ,1,1,35)
,('Менеджер по развитию партнёрских отношений'  								   ,1,1,36)
,('Специалист по сотрудничеству'  												   ,1,1,36)
,('Координатор партнёрских программ'  											   ,1,1,36)
,('Аналитик по стратегическим партнёрам'  										   ,1,1,36)
,('Специалист по управлению точками продаж'  									   ,1,1,37)
,('Менеджер по ритейлу'  														   ,1,1,37)
,('Аналитик по продажам'  														   ,1,1,37)
,('Координатор по торговле'  													   ,1,1,37)
,('Тренер по обучению персонала'  												   ,1,1,38)
,('Менеджер по образовательным программам'  									   ,1,1,38)
,('Координатор по обучению'  													   ,1,1,38)
,('Консультант по развитию персонала'  											   ,1,1,38)
,('Специалист по мерчандайзингу'  												   ,1,1,39)
,('Менеджер по выставке продукции'  											   ,1,1,39)
,('Аналитик по распределению товара'  											   ,1,1,39)
,('Консультант по системам мерчандайзинга'  									   ,1,1,39)
,('Специалист по клиентскому обслуживанию'  									   ,1,1,40)
,('Аналитик по работе с клиентами'  											   ,1,1,40)
,('Менеджер по сервису'  														   ,1,1,40)
,('Консультант по клиентской поддержке'											   ,1,1,40)
,('Специалист по электронной коммерции'  										   ,1,1,41)
,('Менеджер по оптимизации сайтов'  											   ,1,1,41)
,('Аналітик по цифровым продажам'  												   ,1,1,41)
,('Координатор онлайн-акций'  													   ,1,1,41)
,('Менеджер контента'  															   ,1,1,42)
,('Редактор контента'  															   ,1,1,42)
,('Специалист по UX/UI дизайну'  												   ,1,1,42)
,('Копирайтер'  																   ,1,1,42)
,('Аналитик пользовательского опыта'  											   ,1,1,43)
,('Специалист по A/B-тестированию'  											   ,1,1,43)
,('Менеджер по аналитике веб-трафика'  											   ,1,1,43)
,('Аналитик пользовательских данных'  											   ,1,1,43)
,('Специалист по интернет-рекламе'  											   ,1,1,44)
,('Менеджер по продвижению в соцсетях'  										   ,1,1,44)
,('Копирайтер для рекламных материалов'  										   ,1,1,44)
,('Специалист по PPC-кампаниям'  												   ,1,1,44)
,('Маркетолог по потребительским исследованиям'  								   ,1,1,45)
,('Аналитик покупательского поведения'  										   ,1,1,45)
,('Специалист по опросам и анкетированиям'  									   ,1,1,45)
,('Исследователь рынка'  														   ,1,1,45)
,('Аналитик конкурентной среды'  												   ,1,1,46)
,('Маркетинговый исследователь'  												   ,1,1,46)
,('Специалист по сравнительному анализу'  										   ,1,1,46)
,('Консультант по конкурентным стратегиям'  									   ,1,1,46)
,('Экономист-аналитик'  														   ,1,1,47)
,('Специалист по прогнозированию продаж'  										   ,1,1,47)
,('Аналитик рынка'  															   ,1,1,47)
,('Стратег по рыночным тенденциям'  											   ,1,1,47)
,('Аналитик данных'  															   ,1,1,48)
,('Специалист по обработке данных'  											   ,1,1,48)
,('Разработчик бизнес-аналитики'  												   ,1,1,48)
,('Консультант по биг-дата'  													   ,1,1,48)
,('Специалист по маркетинговым стратегиям'  									   ,1,1,49)
,('Аналитик маркетинговых кампаний'  											   ,1,1,49)
,('Менеджер по внедрению стратегий'  											   ,1,1,49)
,('Консультант по брендированию'  												   ,1,1,49)
,('Бренд-менеджер'  															   ,1,1,50)
,('Специалист по управлению брендом'  											   ,1,1,50)
,('Консультант по имиджу бренда'  												   ,1,1,50)
,('Креативный директор'  														   ,1,1,50)
,('Маркетолог по сегментации'  													   ,1,1,51)
,('Аналитик по целевой аудитории'  												   ,1,1,51)
,('Специалист по позиционированию продукта'  									   ,1,1,51)
,('Консультант по маркетингу'  													   ,1,1,51)
,('Менеджер по продуктам'  														   ,1,1,52)
,('Специалист по разработке продуктов'  										   ,1,1,52)
,('Аналитик по жизненному циклу продукта'  										   ,1,1,52)
,('Координатор по запуску продуктов'  											   ,1,1,52)
,('Специалист по SMM'  															   ,1,1,53)
,('Менеджер по социальным сетям'  												   ,1,1,53)
,('Контент-менеджер в социальных медиа'  										   ,1,1,53)
,('Аналитик SMM-показателей'  													   ,1,1,53)
,('Контент-менеджер'  															   ,1,1,54)
,('Специалист по стратегическому контенту'  									   ,1,1,54)
,('Копирайтер для контент-маркетинга'  											   ,1,1,54)
,('Аналитик успешности контента'  												   ,1,1,54)
,('SEO-специалист'  															   ,1,1,55)
,('Аналитик SEO-показателей'  													   ,1,1,55)
,('Менеджер по оптимизации контента'  											   ,1,1,55)
,('Копирайтер по SEO'  															   ,1,1,55)
,('Менеджер по email-маркетингу'  												   ,1,1,56)
,('Аналитик email-кампаний'  													   ,1,1,56)
,('Специалист по автоматизации email-рассылок'  								   ,1,1,56)
,('Копирайтер для email-кампаний'  												   ,1,1,56)
,('Менеджер рекламных кампаний'  												   ,1,1,57)
,('Аналитик эффективности кампаний'  											   ,1,1,57)
,('Специалист по креативу в рекламе'  											   ,1,1,57)
,('Координатор маркетинговых мероприятий'  										   ,1,1,57)
,('PR-менеджер'  																   ,1,1,58)
,('Специалист по медийному взаимодействию'  									   ,1,1,58)
,('Аналитик PR-активностей'  													   ,1,1,58)
,('Координатор общественных отношений'  										   ,1,1,58)
,('Менеджер мероприятий'  														   ,1,1,59)
,('Координатор событий'  														   ,1,1,59)
,('Специалист по организации мероприятий'  										   ,1,1,59)
,('Аналитик эффективности мероприятий'  										   ,1,1,59)
,('Креативный директор'  														   ,1,1,60)
,('Дизайнер'  																	   ,1,1,60)
,('Специалист по графическому дизайну'  										   ,1,1,60)
,('Арт-директор'																   ,1,1,60)
,('Аналитик стратегического планирования'										   ,1,1,61)
,('Специалист по стратегическому планированию'									   ,1,1,61)
,('Менеджер проектов'															   ,1,1,61)
,('Консультант по стратегическому управлению'									   ,1,1,61)
,('Аналитик тактического планирования'											   ,1,1,62)
,('Специалист по операционному планированию'									   ,1,1,62)
,('Координатор проектов'														   ,1,1,62)
,('Консультант по управления проектами'											   ,1,1,62)
,('Специалист по управлению ресурсами'											   ,1,1,63)
,('Аналитик ресурсного обеспечения'												   ,1,1,63)
,('Менеджер по персоналу'														   ,1,1,63)
,('Координатор внутренней логистики'											   ,1,1,63)
,('Аналитик результативности'													   ,1,1,64)
,('Специалист по оценке эффективности'											   ,1,1,64)
,('Менеджер по качеству'														   ,1,1,64)
,('Консультант по результативности'												   ,1,1,64)
,('Инициатор проектов'															   ,1,1,65)
,('Специалист по запуску проектов'												   ,1,1,65)
,('Менеджер по инициации'														   ,1,1,65)
,('Консультант по проектам'														   ,1,1,65)
,('Аналитик мониторинга'														   ,1,1,66)
,('Специалист по контролю проектов'												   ,1,1,66)
,('Менеджер по мониторингу'														   ,1,1,66)
,('Консультант по контролю'														   ,1,1,66)
,('Аналитик рисков'																   ,1,1,67)
,('Специалист по оценке рисков'													   ,1,1,67)
,('Менеджер по управлению рисками'												   ,1,1,67)
,('Консультант по рисковому менеджменту'										   ,1,1,67)
,('Специалист по закрытию проектов'												   ,1,1,68)
,('Аналитик по завершению проектов'												   ,1,1,68)
,('Менеджер по закрытию'														   ,1,1,68)
,('Консультант по проектам'														   ,1,1,68)
,('Аудитор'																		   ,1,1,69)
,('Специалист по внутреннему аудиту'											   ,1,1,69)
,('Менеджер по внутреннему контролю'											   ,1,1,69)
,('Консультант по аудиту'														   ,1,1,69)
,('Специалист по стандартам'													   ,1,1,70)
,('Аналитик стандартов качества'												   ,1,1,70)
,('Менеджер по стандартам'														   ,1,1,70)
,('Консультант по сертификации'													   ,1,1,70)
,('Аналитик несоответствий'														   ,1,1,71)
,('Специалист по качеству'														   ,1,1,71)
,('Менеджер по исправлению несоответствий'										   ,1,1,71)
,('Консультант по нормативам'													   ,1,1,71)
,('Аналитик по улучшению процессов'												   ,1,1,72)
,('Специалист по процессам'														   ,1,1,72)
,('Менеджер по оптимизации'														   ,1,1,72)
,('Консультант по процессам'													   ,1,1,72)
,('Разработчик программного обеспечения'										   ,1,1,73)
,('Аналитик ПО'																	   ,1,1,73)
,('Инженер по программированию'													   ,1,1,73)
,('Консультант по разработке'													   ,1,1,73)
,('Технический специалист'														   ,1,1,74)
,('Инженер технической поддержки'												   ,1,1,74)
,('Менеджер по поддержке'														   ,1,1,74)
,('Консультант по технической поддержке'										   ,1,1,74)
,('Администратор баз данных'													   ,1,1,75)
,('Специалист по управлению данными'											   ,1,1,75)
,('Аналитик данных'																   ,1,1,75)
,('Консультант по базам данных'													   ,1,1,75)
,('Менеджер по новым технологиям'												   ,1,1,76)
,('Специалист по внедрению технологий'											   ,1,1,76)
,('Аналитик новых технологий'													   ,1,1,76)
,('Технический эксперт по технологиям'											   ,1,1,76)
,('Менеджер по управлению поставками'											   ,1,1,77)
,('Специалист по логистике'														   ,1,1,77)
,('Аналитик по поставкам'														   ,1,1,77)
,('Координатор по работе с поставщиками'										   ,1,1,77)
,('Менеджер по складскому учету'												   ,1,1,78)
,('Операционист склада'															   ,1,1,78)
,('Специалист по inventory management'											   ,1,1,78)
,('Аналитик по учету товаров'													   ,1,1,78)
,('Менеджер по доставке'														   ,1,1,79)
,('Курьер'																		   ,1,1,79)
,('Специалист по логистике'														   ,1,1,79)
,('Диспетчер по доставке'														   ,1,1,79)
,('Аналитик по оптимизации запасов'												   ,1,1,80)
,('Специалист по управлению запасами'											   ,1,1,80)
,('Менеджер по запасам'															   ,1,1,80)
,('Координатор по логистике'													   ,1,1,80)
,( 'Секретарь совета директоров'												   ,1,1,106)
,( 'Аналітик бюджета'															   ,1,1,106)
,( 'Специалист по документообороту'												   ,1,1,106)
,( 'Помощник директора'															   ,1,1,106)
,( 'Менеджер по контрактам'														   ,1,1,107)
,( 'Специалист по работе с контрактами'											   ,1,1,107)
,( 'Юрист по контрактному праву'												   ,1,1,107)
,( 'Аналитик по контрактам'														   ,1,1,107)
,( 'Юрист по корпоративному праву'												   ,1,1,108)
,( 'Специалист по требованиям законодательства'									   ,1,1,108)
,( 'Консультант по корпоративным вопросам'										   ,1,1,108)
,( 'Аналитик по соблюдению нормативов'											   ,1,1,108)
,( 'Юрист по интеллектуальной собственности'									   ,1,1,109)
,( 'Специалист по защите ИП'													   ,1,1,109)
,( 'Аналитик по спорам о собственности'											   ,1,1,109)
,( 'Консультант по авторским правам'											   ,1,1,109)
,( 'Юрист по делам о банкротстве'												   ,1,1,110)
,( 'Специалист по банкротству'													   ,1,1,110)
,( 'Аналитик по финансовым вопросам'											   ,1,1,110)
,( 'Консультант по юридическим вопросам'										   ,1,1,110)
,( 'Юрист по договорным обязательствам'											   ,1,1,111)
,( 'Специалист по отказам по договорам'											   ,1,1,111)
,( 'Аналитик по договорам'														   ,1,1,111)
,( 'Консультант по юридическим вопросам'										   ,1,1,111)
,( 'Юрист по защите прав потребителей'											   ,1,1,112)
,( 'Специалист по потребительским правам'										   ,1,1,112)
,( 'Аналитик по потребительским жалобам'										   ,1,1,112)
,( 'Консультант по правам потребителей'											   ,1,1,112)
,( 'Следователь по уголовным делам'												   ,1,1,113)
,( 'Аналитик по уголовным делам'												   ,1,1,113)
,( 'Специалист по уголовной практике'											   ,1,1,113)
,( 'Юрист по уголовным делам'													   ,1,1,113)
,( 'Адвокат по защите обвиняемых'												   ,1,1,114)
,( 'Юрист по уголовным делам'													   ,1,1,114)
,( 'Специалист по защите прав обвиняемых'										   ,1,1,114)
,( 'Аналитик по уголовным делам'												   ,1,1,114)
,( 'Юридический консультант'  													   ,1,1,115)
,( 'Защитник'  																	   ,1,1,115)
,( 'Адвокат'  																	   ,1,1,115)
,( 'Специалист по уголовному праву'  											   ,1,1,115)
,( 'Судебный следователь'														   ,1,1,116)
,( 'Адвокат по уголовным делам'													   ,1,1,116)
,( 'Специалист по правам человека'												   ,1,1,116)
,( 'Следователь по делам о преступлениях'										   ,1,1,116)
,( 'Психолог для жертв'															   ,1,1,117)
,( 'Консультант по правам жертв'												   ,1,1,117)
,( 'Юрист по уголовным делам'													   ,1,1,117)
,( 'Секретарь по правам жертв'													   ,1,1,117)
,( 'Юридический консультант'													   ,1,1,118)
,( 'Специалист по государственным закупкам'										   ,1,1,118)
,( 'Эксперт в области адвокатуры'												   ,1,1,118)
,( 'Юрист по административным вопросам'											   ,1,1,118)
,( 'Судебный контролер'															   ,1,1,119)
,( 'Специалист по делам о надзорных производствах'								   ,1,1,119)
,( 'Консультант по соблюдению норм'												   ,1,1,119)
,( 'Юрист по аппеляционным делам'												   ,1,1,119)
,( 'Специалист по законодательству'												   ,1,1,120)
,( 'Юрист по правовым вопросам'													   ,1,1,120)
,( 'Эксперт по нормативным актам'												   ,1,1,120)
,( 'Консультант по правоприменению'												   ,1,1,120)
,( 'Юрист по обжалованию'														   ,1,1,121)
,( 'Специалист по правам субъектов'												   ,1,1,121)
,( 'Адвокат по административным делам'											   ,1,1,121)
,( 'Консультант по апелляциям'													   ,1,1,121)
,( 'Аналитик по угрозам'														   ,1,1,122)
,( 'Специалист по прогнозированию'												   ,1,1,122)
,( 'Консультант по безопасности'												   ,1,1,122)
,( 'Эксперт по рискам'															   ,1,1,122)
,( 'Аналитик рисков'															   ,1,1,123)
,( 'Специалист по оценке рисков'												   ,1,1,123)
,( 'Консультант по страхованию'													   ,1,1,123)
,( 'Юрист по рисковой деятельности'												   ,1,1,123)
,( 'Специалист по открытым данным'												   ,1,1,124)
,( 'Аналитик открытых источников'												   ,1,1,124)
,( 'Консультант по медиа'														   ,1,1,124)
,( 'Юрист по информации'														   ,1,1,124)
,( 'Координатор межведомственного взаимодействия'								   ,1,1,125)
,( 'Специалист по сотрудничеству'												   ,1,1,125)
,( 'Консультант по взаимодействию'												   ,1,1,125)
,( 'Аналитик по интеграции'														   ,1,1,125)
,( 'Координатор между службами'													   ,1,1,126)
,( 'Специалист по сотрудничеству'												   ,1,1,126)
,( 'Эксперт по взаимодействию'													   ,1,1,126)
,( 'Консультант по командной работе'											   ,1,1,126)
,( 'Оперативный работник с информаторами'										   ,1,1,127)
,( 'Специалист по обращению с информаторами'									   ,1,1,127)
,( 'Юрист по защите информаторов'												   ,1,1,127)
,( 'Аналитик по работе с информаторами'											   ,1,1,127)
,( 'Аналитик информации'														   ,1,1,128)
,( 'Специалист по сбору данных'													   ,1,1,128)
,( 'Консультант по обработке данных'											   ,1,1,128)
,( 'Юрист по конфиденциальности'												   ,1,1,128)
,( 'Секретарь по охране объектов'												   ,1,1,129)
,( 'Оператор безопасности'														   ,1,1,129)
,( 'Специалист по охране'														   ,1,1,129)
,( 'Координатор безопасности объектов'											   ,1,1,129)
,( 'Техник по видеонаблюдению'													   ,1,1,130)
,( 'Специалист по контролю видеонаблюдения'										   ,1,1,130)
,( 'Аналитик по видеонаблюдению'												   ,1,1,130)
,( 'Координатор видеосистем'													   ,1,1,130)
,( 'Специалист по проверке сотрудников'  										   ,1,1,131)
,( 'Аналитик по безопасности'  													   ,1,1,131)
,( 'Эксперт по внутреннему контролю'  											   ,1,1,131)
,( 'Менеджер по соблюдению норм и правил'  										   ,1,1,131)
,( 'Специалист по реагированию на инциденты'  									   ,1,1,132)
,( 'Аналитик по угрозам'  														   ,1,1,132)
,( 'Менеджер по безопасности'  													   ,1,1,132)
,( 'Инженер по информационной безопасности'  									   ,1,1,132)
,( 'Аналитик по прогнозированию угроз'  										   ,1,1,133)
,( 'Специалист по оценке рисков'  												   ,1,1,133)
,( 'Консультант по безопасности'  												   ,1,1,133)
,( 'Моделировщик угроз'  														   ,1,1,133)
,( 'Аналитик рисков'  															   ,1,1,134)
,( 'Специалист по оценке уязвимостей'  											   ,1,1,134)
,( 'Консультант по управлению рисками'  										   ,1,1,134)
,( 'Менеджер по безопасности информации'  										   ,1,1,134)
,( 'Специалист по работе с открытыми источниками'  								   ,1,1,135)
,( 'Аналитик по разведке'  														   ,1,1,135)
,( 'Исследователь угроз'  														   ,1,1,135)
,( 'Консультант по сбору информации'  											   ,1,1,135)
,( 'Специалист по межведомственному взаимодействию'  							   ,1,1,136)
,( 'Координатор проектов безопасности'  										   ,1,1,136)
,( 'Аналитик по политике и взаимодействию'  									   ,1,1,136)
,( 'Менеджер по сотрудничеству'  												   ,1,1,136)
,( 'UI-дизайнер'  																   ,1,1,137)
,( 'Разработчик интерфейсов'  													   ,1,1,137)
,( 'Специалист по пользовательскому интерфейсу'  								   ,1,1,137)
,( 'Графический дизайнер'  														   ,1,1,137)
,( 'UX-дизайнер'  																   ,1,1,138)
,( 'Исследователь пользовательского опыта'  									   ,1,1,138)
,( 'Специалист по дизайну взаимодействия'  										   ,1,1,138)
,( 'Аналитик пользовательского опыта'  											   ,1,1,138)
,( 'Верстальщик'  																   ,1,1,139)
,( 'Web-разработчик'  															   ,1,1,139)
,( 'Дизайнер интерфейсов'  														   ,1,1,139)
,( 'Специалист по адаптивному дизайну'  										   ,1,1,139)
,( 'Аниматор'  																	   ,1,1,140)
,( 'Дизайнер анимации'  														   ,1,1,140)
,( 'Специалист по динамическим элементам'  										   ,1,1,140)
,( 'Web-аниматор'  																   ,1,1,140)
,( 'Разработчик API'  															   ,1,1,141)
,( 'Инженер по интеграции'  													   ,1,1,141)
,( 'Специалист по архитектуре API'  											   ,1,1,141)
,( 'Консультант по RESTful API'  												   ,1,1,141)
,( 'Администратор баз данных'  													   ,1,1,142)
,( 'Разработчик баз данных'  													   ,1,1,142)
,( 'Инженер по данным'  														   ,1,1,142)
,( 'Специалист по оптимизации БД'  												   ,1,1,142)
,( 'Инженер по интеграции'  													   ,1,1,143)
,( 'Специалист по сторонним сервисам'  											   ,1,1,143)
,( 'Разработчик API'  															   ,1,1,143)
,( 'Консультант по интеграции'  												   ,1,1,143)
,( 'Архитектор ПО'  															   ,1,1,144)
,( 'Разработчик микросервисов'  												   ,1,1,144)
,( 'Специалист по серверной архитектуре'  										   ,1,1,144)
,( 'Инженер по DevOps'  														   ,1,1,144)
,( 'iOS-разработчик'  															   ,1,1,145)
,( 'Специалист по мобильным приложениям'  										   ,1,1,145)
,( 'Инженер по мобильной разработке'  											   ,1,1,145)
,( 'Консультант по iOS'  														   ,1,1,145)
,( 'Программист Android'                                                           ,1,1,146)
,( 'Тестировщик мобильных приложений'											   ,1,1,146)
,( 'Архитектор мобильных решений'												   ,1,1,146)
,( 'Менеджер проектов в сфере мобильной разработки'								   ,1,1,146)
,( 'Кроссплатформенный разработчик'												   ,1,1,147)
,( 'Координатор проектов'														   ,1,1,147)
,( 'UI/UX дизайнер'																   ,1,1,147)
,( 'Специалист по интеграции'													   ,1,1,147)
,( 'Специалист по производительности'											   ,1,1,148)
,( 'Тестировщик приложений'														   ,1,1,148)
,( 'Аналитик производительности'												   ,1,1,148)
,( 'Инженер по оптимизации'														   ,1,1,148)
,( 'Тестировщик функциональности'												   ,1,1,149)
,( 'Аналитик тестирования'														   ,1,1,149)
,( 'Менеджер качества'															   ,1,1,149)
,( 'Специалист по тестированной документации'									   ,1,1,149)
,( 'Автоматизатор тестирования'													   ,1,1,150)
,( 'Разработчик тестов'															   ,1,1,150)
,( 'Инженер по автоматизации'													   ,1,1,150)
,( 'Аудитор тестирования'														   ,1,1,150)
,( 'Специалист по нагрузочному тестированию'									   ,1,1,151)
,( 'Аналитик нагрузки'															   ,1,1,151)
,( 'Инженер по производительности'												   ,1,1,151)
,( 'Консультант по нагрузочному тестированию'									   ,1,1,151)
,( 'Специалист по работе с клиентами'											   ,1,1,152)
,( 'Менеджер по поддержке пользователей'										   ,1,1,152)
,( 'Консультант по запросам'													   ,1,1,152)
,( 'Инженер по поддержке приложений'											   ,1,1,152)
,( 'Специалист по сопровождению ПО'												   ,1,1,153)
,( 'Технический писатель'														   ,1,1,153)
,( 'Координатор поддержки'														   ,1,1,153)
,( 'Инженер по поддержке'														   ,1,1,153)
,( 'Системный администратор'													   ,1,1,154)
,( 'Инженер по мониторингу'														   ,1,1,154)
,( 'Администратор сетей'														   ,1,1,154)
,( 'Специалист по управлению сетевой инфраструктурой'							   ,1,1,154)
,( 'Инженер по интеграции'														   ,1,1,155)
,( 'Разработчик API'															   ,1,1,155)
,( 'Специалист по middleware'													   ,1,1,155)
,( 'Менеджер интеграционных проектов'											   ,1,1,155)
,( 'Специалист по автоматизации процессов'										   ,1,1,156)
,( 'Инженер по DevOps'															   ,1,1,156)
,( 'Аналитик процессов'															   ,1,1,156)
,( 'Консультант по оптимизации процессов'										   ,1,1,156)
,( 'Специалист по запросам пользователей'										   ,1,1,157)
,( 'Менеджер по обработке обращений'											   ,1,1,157)
,( 'Аналитик запросов'															   ,1,1,157)
,( 'Инженер по взаимодействию с клиентами'										   ,1,1,157)
,( 'Инженер по поддержке ПО'													   ,1,1,158)
,( 'Технический консультант'													   ,1,1,158)
,( 'Координатор по техническому обслуживанию'									   ,1,1,158)
,( 'Менеджер по продуктам'														   ,1,1,158)
,( 'Сетевой администратор'														   ,1,1,159)
,( 'Специалист по мониторингу'													   ,1,1,159)
,( 'Инженер по сетевой безопасности'											   ,1,1,159)
,( 'Аналитик сетевого трафика'													   ,1,1,159)
,( 'Специалист по интеграции сервисов'											   ,1,1,160)
,( 'Разработчик сторонних приложений'											   ,1,1,160)
,( 'Инженер по API'																   ,1,1,160)
,( 'Менеджер по данным интеграции'												   ,1,1,160)
,( 'Специалист по автоматизации'												   ,1,1,161)
,( 'Аналитик бизнес-процессов'													   ,1,1,161)
,( 'Консультант по процессам'													   ,1,1,161)
,( 'Инженер по автоматизации'													   ,1,1,161)
,( 'Специалист по управлению рисками'											   ,1,1,162)
,( 'Аналитик по рискам'															   ,1,1,162)
,( 'Консультант по безопасности'												   ,1,1,162)
,( 'Менеджер по рискам'															   ,1,1,162)
,( 'Специалист по защите данных'												   ,1,1,163)
,( 'Аудитор по безопасности'													   ,1,1,163)
,( 'Аналитик по защите информации'												   ,1,1,163)
,( 'Консультант по защите данных'												   ,1,1,163)
,( 'Специалист по инцидент-менеджменту'											   ,1,1,164)
,( 'Аналитик инцидентов'														   ,1,1,164)
,( 'Менеджер по инцидентам'														   ,1,1,164)
,( 'Консультант по реагированию на инциденты'									   ,1,1,164)
,( 'Аналитик требований'														   ,1,1,165)
,( 'Исследователь рынков'														   ,1,1,165)
,( 'Консультант по требованиям'													   ,1,1,165)
,( 'Специалист по анализу данных'												   ,1,1,165)
,( 'Архитектор IT-решений'														   ,1,1,166)
,( 'Инженер по архитектуре'														   ,1,1,166)
,( 'Консультант по архитектуре'													   ,1,1,166)
,( 'Аналитик архитектуры'														   ,1,1,166)
,( 'Менеджер по инновациям'														   ,1,1,167)
,( 'Специалист по инновациям'													   ,1,1,167)
,( 'Консультант по технологиям'													   ,1,1,167)
,( 'Исследователь инноваций'													   ,1,1,167)
,( 'Специалист по планированию IT-проектов'										   ,1,1,168)
,( 'Менеджер по бюджетированию'													   ,1,1,168)
,( 'Аналитик проектов'															   ,1,1,168)
,( 'Консультант по проектам'													   ,1,1,168)
,( 'Специалист по поддержке рабочих станций'									   ,1,1,169)
,( 'Инженер по технической поддержке'											   ,1,1,169)
,( 'Менеджер по поддержке'														   ,1,1,169)
,( 'Консультант по оборудованию'												   ,1,1,169)
,( 'Специалист службы технической поддержки'									   ,1,1,170)
,( 'Инженер по технической поддержке'											   ,1,1,170)
,( 'Аналитик поддержки'															   ,1,1,170)
,( 'Системный администратор'													   ,1,1,170)
,( 'Менеджер по инвентаризации'													   ,1,1,171)
,( 'Специалист по учету оборудования'											   ,1,1,171)
,( 'Аналитик инвентаризации'													   ,1,1,171)
,( 'Консультант по инвентарю'													   ,1,1,171)
,( 'Тренер по продукту'															   ,1,1,172)
,( 'Специалист по обучению'														   ,1,1,172)
,( 'Консультант по обучению'													   ,1,1,172)
,( 'Аналитик по обучению'														   ,1,1,172)
,( 'Менеджер по проектам'														   ,1,1,173)
,( 'Специалист по инициации'													   ,1,1,173)
,( 'Консультант по планированию'												   ,1,1,173)
,( 'Аналитик по проектам'														   ,1,1,173)
,( 'Специалист по контролю качества'											   ,1,1,174)
,( 'Инспектор по выполнению'													   ,1,1,174)
,( 'Аналитик контроля'															   ,1,1,174)
,( 'Менеджер по качеству'														   ,1,1,174)
,( 'Специалист по управлению изменениями'										   ,1,1,175)
,( 'Аналитик по рискам изменений'												   ,1,1,175)
,( 'Менеджер по изменениями'													   ,1,1,175)
,( 'Консультант по управлению'													   ,1,1,175)
,( 'Аналитик данных'  															   ,1,1,176)
,( 'Прогнозист'  																   ,1,1,176)
,( 'Специалист по моделированию'  												   ,1,1,176)
,( 'Бизнес-аналитик'  															   ,1,1,176)
,( 'Визуализатор данных'  														   ,1,1,177)
,( 'Специалист по BI'  															   ,1,1,177)
,( 'Датамайнер'  																   ,1,1,177)
,( 'Дизайнер отчетов'  															   ,1,1,177)
,( 'Аналитик больших данных'  													   ,1,1,178)
,( 'Специалист по аналитике'  													   ,1,1,178)
,( 'Инженер по данным'  														   ,1,1,178)
,( 'Учёный данных'  															   ,1,1,178)
,( 'Бизнес-аналитик'  															   ,1,1,179)
,( 'Специалист по требованиям'  												   ,1,1,179)
,( 'Консультант по бизнес-процессам'  											   ,1,1,179)
,( 'Аналитик бизнес-процессов'  												   ,1,1,179)
,( 'Специалист по оптимизации'  												   ,1,1,180)
,( 'Бизнес-консультант'  														   ,1,1,180)
,( 'Аналитик по улучшению'  													   ,1,1,180)
,( 'Эксперт по бизнес-процессам'  												   ,1,1,180)
,( 'Финансовый аналитик'  														   ,1,1,181)
,( 'Экономист'  																   ,1,1,181)
,( 'Оценщик проектов'  															   ,1,1,181)
,( 'Специалист по экономике'  													   ,1,1,181)
,( 'Аналитик отчетности'  														   ,1,1,182)
,( 'Специалист по подготовке отчетов'  											   ,1,1,182)
,( 'Финансовый контролер'  														   ,1,1,182)
,( 'Аудитор'  																	   ,1,1,182)
,( 'Финансовый аналитик'  														   ,1,1,183)
,( 'Бухгалтер'  																   ,1,1,183)
,( 'Аудитор'  																	   ,1,1,183)
,( 'Специалист по отчетности'  													   ,1,1,183)
,( 'Бюджетный аналитик'  														   ,1,1,184)
,( 'Финансовый планировщик'  													   ,1,1,184)
,( 'Эксперт по бюджетированию'  												   ,1,1,184)
,( 'Специалист по прогнозированию'  											   ,1,1,184)
,( 'Инвестиционный аналитик'  													   ,1,1,185)
,( 'Оценщик инвестиционных проектов'  											   ,1,1,185)
,( 'Финансовый консультант'  													   ,1,1,185)
,( 'Специалист по оценке'  														   ,1,1,185)
,( 'Менеджер проектов'  														   ,1,1,186)
,( 'Координатор проектов'  														   ,1,1,186)
,( 'Специалист по проектному управлению'  										   ,1,1,186)
,( 'Планировщик проектов'  														   ,1,1,186)
,( 'Контролер проектов'  														   ,1,1,187)
,( 'Специалист по контролю'  													   ,1,1,187)
,( 'Аналитик по бюджету'  														   ,1,1,187)
,( 'Управляющий проектами'  													   ,1,1,187)
,( 'Менеджер по рискам'  														   ,1,1,188)
,( 'Аналитик по рискам'  														   ,1,1,188)
,( 'Специалист по управлению изменениями'  										   ,1,1,188)
,( 'Консультант по рискам'  													   ,1,1,188)
,( 'Менеджер по коммуникациям'  												   ,1,1,189)
,( 'Координатор команды'  														   ,1,1,189)
,( 'Специалист по взаимодействию'  												   ,1,1,189)
,( 'Аналитик заинтересованных сторон'  											   ,1,1,189)
,( 'Специалист по работе с клиентами'  											   ,1,1,190)
,( 'Менеджер по обращениям'  													   ,1,1,190)
,( 'Аналитик по запросам клиентов'  											   ,1,1,190)
,( 'Специалист по обслуживанию клиентов'  										   ,1,1,190)
,( 'Менеджер по поддержке клиентов'  											   ,1,1,191)
,( 'Специалист по консультациям'  												   ,1,1,191)
,( 'Координатор клиентского опыта'  											   ,1,1,191)
,( 'Александр по работе с клиентами'  											   ,1,1,191)
,( 'Аналитик по сбору отзывов'  												   ,1,1,192)
,( 'Специалист по улучшению сервиса'  											   ,1,1,192)
,( 'Менеджер по качеству'  														   ,1,1,192)
,( 'Координатор обратной связи'  												   ,1,1,192)
,( 'Менеджер по работе с клиентами'  											   ,1,1,193)
,( 'Специалист по управлению отношениями'  										   ,1,1,193)
,( 'Консультант по долгосрочным проектам'  										   ,1,1,193)
,( 'Аналитик по отзывам клиентов'  												   ,1,1,193)
,( 'Стратегический консультант'  												   ,1,1,194)
,( 'Менеджер по стратегическому планированию'  									   ,1,1,194)
,( 'Специалист по бизнес-стратегиям'  											   ,1,1,194)
,( 'Аналитик стратегического развития'  										   ,1,1,194)
,( 'Маркетолог'  																   ,1,1,195)
,( 'Аналитик рыночных тенденций'  												   ,1,1,195)
,( 'Специалист по исследованиям рынка'  										   ,1,1,195)
,( 'Консультант по рыночной аналитике'  										   ,1,1,195)
,( 'Аналитик по ресурсам'  														   ,1,1,196)
,( 'Менеджер по планированию ресурсов'  										   ,1,1,196)
,( 'Специалист по управлению ресурсами'  										   ,1,1,196)
,( 'Координатор ресурсных нужд'  												   ,1,1,196)
,( 'Менеджер по кризисному управлению'  										   ,1,1,197)
,( 'Аналитик по сценариям'  													   ,1,1,197)
,( 'Специалист по планированию на случай непредвиденных обстоятельств'  		   ,1,1,197)
,( 'Консультант по рискам'  													   ,1,1,197)
,( 'Специалист по online-маркетингу'  											   ,1,1,198)
,( 'Менеджер по социальным медиа'  												   ,1,1,198)
,( 'Аналитик по digital-стратегиям'  											   ,1,1,198)
,( 'Консультант по онлайн-продвижению'  										   ,1,1,198)
,( 'Менеджер по рекламе в социальных сетях'  									   ,1,1,199)
,( 'Специалист по PPC-рекламе'  												   ,1,1,199)
,( 'Аналитик рекламных кампаний'  												   ,1,1,199)
,( 'Координатор социальных медиа'  												   ,1,1,199)
,( 'Аналитик маркетинговых данных'  											   ,1,1,200)
,( 'Специалист по оптимизации кампаний'  										   ,1,1,200)
,( 'Менеджер по результатам маркетинга'  										   ,1,1,200)
,( 'Консультант по эффективности рекламы'										   ,1,1,200)
,( 'Контент-менеджер'  															   ,1,1,201)
,( 'Копирайтер'  																   ,1,1,201)
,( 'SMM-специалист'  															   ,1,1,201)
,( 'Дизайнер'  																	   ,1,1,201)
,( 'Менеджер по продажам'  														   ,1,1,202)
,( 'Специалист по работе с клиентами'  											   ,1,1,202)
,( 'Аналитик продаж'  															   ,1,1,202)
,( 'Координатор проектов'  														   ,1,1,202)
,( 'Менеджер по привлечению клиентов'  											   ,1,1,203)
,( 'Специалист по рекламе'  													   ,1,1,203)
,( 'Маркетолог'  																   ,1,1,203)
,( 'Координатор маркетинговых кампаний'  										   ,1,1,203)
,( 'Менеджер по работе с клиентами'  											   ,1,1,204)
,( 'Специалист по поддержке клиентов'  											   ,1,1,204)
,( 'Аккаунт-менеджер'  															   ,1,1,204)
,( 'Консультант'  																   ,1,1,204)
,( 'Тренер по продажам'  														   ,1,1,205)
,( 'Координатор тренингов'  													   ,1,1,205)
,( 'Специалист по обучению'  													   ,1,1,205)
,( 'Аналитик эффективности'  													   ,1,1,205)
,( 'Специалист по клиентскому сервису'  										   ,1,1,206)
,( 'Оператор колл-центра'  														   ,1,1,206)
,( 'Менеджер по работе с запросами'  											   ,1,1,206)
,( 'Консультант по продажам'  													   ,1,1,206)
,( 'Специалист по сервису'  													   ,1,1,207)
,( 'Менеджер по качеству обслуживания'  										   ,1,1,207)
,( 'Аналитик удовлетворенности клиентов'  										   ,1,1,207)
,( 'Координатор сервиса'  														   ,1,1,207)
,( 'Специалист по сбору отзывов'  												   ,1,1,208)
,( 'Аналитик по улучшению сервиса'  											   ,1,1,208)
,( 'Маркетолог по продукту'  													   ,1,1,208)
,( 'Менеджер по продуктам'  													   ,1,1,208)
,( 'Переговорщик'  																   ,1,1,209)
,( 'Специалист по разрешению конфликтов'  										   ,1,1,209)
,( 'Медиатор'  																	   ,1,1,209)
,( 'Консультант по работе с клиентами'  										   ,1,1,209)
,( 'Аналитик безопасности'														   ,1,1,210)
,( 'Специалист по реагированию на инциденты'									   ,1,1,210)
,( 'Тестировщик SIEM'															   ,1,1,210)
,( 'Администратор системы безопасности'										       ,1,1,210)
,( 'Инженер по анализу инцидентов'												   ,1,1,211)
,( 'Специалист по цифровым криминалистическим исследованиям'					   ,1,1,211)
,( 'Консультант по безопасности'												   ,1,1,211)
,( 'Менеджер по инцидентам'													       ,1,1,211)
,( 'Инженер по восстановлению систем'											   ,1,1,212)
,( 'Специалист по управлению инцидентами'										   ,1,1,212)
,( 'Аналитик по инцидентам и восстановлению'									   ,1,1,212)
,( 'Координатор по восстановлению данных'										   ,1,1,212)
,( 'Тренер по безопасности'													       ,1,1,213)
,( 'Специалист по образовательным программам'									   ,1,1,213)
,( 'Медийный консультант'														   ,1,1,213)
,( 'Менеджер по осведомленности'												   ,1,1,213)
,( 'Специалист по тестированию уязвимостей'									       ,1,1,214)
,( 'Аналитик по кибербезопасности'												   ,1,1,214)
,( 'Инженер по сканированию'													   ,1,1,214)
,( 'Консультант по уязвимостям'												       ,1,1,214)
,( 'Аналитик по оценке рисков'													   ,1,1,215)
,( 'Консультант по управлению рисками'											   ,1,1,215)
,( 'Специалист по аудиту рисков'												   ,1,1,215)
,( 'Менеджер по оценке угроз'													   ,1,1,215)
,( 'Инженер по управлению уязвимостями'										       ,1,1,216)
,( 'Аналитик по безопасности приложений'										   ,1,1,216)
,( 'Специалист по патч-менеджменту'											       ,1,1,216)
,( 'Консультант по уязвимостям'												       ,1,1,216)
,( 'Аналитик по новым угрозам'													   ,1,1,217)
,( 'Специалист по исследованию угроз'											   ,1,1,217)
,( 'Консультант по противодействию угрозам'									       ,1,1,217)
,( 'Менеджер по новым угрозам'													   ,1,1,217)
,( 'Специалист по управлению доступом'											   ,1,1,218)
,( 'Аналитик по контролю доступа'												   ,1,1,218)
,( 'Инженер по аутентификации'													   ,1,1,218)
,( 'Менеджер по привилегиям'													   ,1,1,218)
,( 'Инженер по шифрованию'														   ,1,1,219)
,( 'Специалист по защите данных'												   ,1,1,219)
,( 'Аналитик по безопасности данных'											   ,1,1,219)
,( 'Консультант по шифрованию'													   ,1,1,219)
,( 'Специалист по соответствию'												       ,1,1,220)
,( 'Аналитик по соблюдению норм'												   ,1,1,220)
,( 'Консультант по комплаенсу'													   ,1,1,220)
,( 'Менеджер по стандартам безопасности'										   ,1,1,220)
,( 'Специалист по реагированию на утечки'										   ,1,1,221)
,( 'Аналитик по инцидентам утечек'												   ,1,1,221)
,( 'Консультант по информированной безопасности'								   ,1,1,221)
,( 'Менеджер по реагированию на инциденты'										   ,1,1,221)
,( 'Дизайнер'																	   ,1,1,222)
,( 'Иллюстратор'																   ,1,1,222)
,( 'Креативный директор'														   ,1,1,222)
,( 'Специалист по визуальным коммуникациям'									       ,1,1,222)
,( 'Веб-дизайнер'																   ,1,1,223)
,( 'UX/UI дизайнер'															       ,1,1,223)
,( 'Специалист по адаптивному дизайну'											   ,1,1,223)
,( 'Аналитик по веб-оптимизации'												   ,1,1,223)
,( 'Типограф'																	   ,1,1,224)
,( 'Дизайнер шрифтов'															   ,1,1,224)
,( 'Аналитик по типографике'													   ,1,1,224)
,( 'Консультант по типографическим решениям'									   ,1,1,224)
,( 'Бренд-менеджер'															       ,1,1,225)
,( 'Специалист по позиционированию бренда'										   ,1,1,225)
,( 'Креативный маркетолог'													       ,1,1,225)
,( 'Консультант по разработке бренда'											   ,1,1,225)
,( 'Наставник интервьюирования'													   ,1,1,226)
,( 'Аналитик пользовательского опыта'											   ,1,1,226)
,( 'Модератор интервью'															   ,1,1,226)
,( 'Специалист по исследованию пользователей'									   ,1,1,226)
,( 'Эксперт по юзабилити'														   ,1,1,227)
,( 'Аналитик юзабилити-тестирования'											   ,1,1,227)
,( 'Модератор юзабилити-тестов'													   ,1,1,227)
,( 'Тестировщик интерфейсов'													   ,1,1,227)
,( 'Аналитик данных'															   ,1,1,228)
,( 'Специалист по визуализации данных'											   ,1,1,228)
,( 'Исследователь данных'														   ,1,1,228)
,( 'Специалист по статистике'													   ,1,1,228)
,( 'Дизайнер персонажей'														   ,1,1,229)
,( 'Исследователь пользовательских профилей'									   ,1,1,229)
,( 'Создатель персонажей'														   ,1,1,229)
,( 'Аналитик пользовательских образов'											   ,1,1,229)
,( 'Дизайнер прототипов'														   ,1,1,230)
,( 'Разработчик низкой четкости'												   ,1,1,230)
,( 'Аналитик низкой четкости'													   ,1,1,230)
,( 'Специалист по концептуальному дизайну'										   ,1,1,230)
,( 'Дизайнер высокой четкости'													   ,1,1,231)
,( 'Разработчик высоких прототипов'												   ,1,1,231)
,( 'Аналитик высокой четкости'													   ,1,1,231)
,( 'Специалист по интерактивным прототипам'										   ,1,1,231)
,( 'Тестировщик прототипов'														   ,1,1,232)
,( 'Аналитик тестирования'														   ,1,1,232)
,( 'Модератор тестирования'														   ,1,1,232)
,( 'Специалист по оценке прототипов'											   ,1,1,232)

go

-----------------------------------------------------------------------Предстовление требуется для 9 скрипта-------------------------------------------
create view All_Otdel
as
select 
d.ID_Department		   as 'ID_Депортамента'
,d.Name_Department	   as 'Наименование_Депортамента'
,g.ID_Group			   as 'ID_Группыили_отдела'
,g.Name_Group		   as 'Наименование отдела'
,t.ID_The_Subgroup	   as 'ID_Группы'
,t.Name_The_Subgroup   as 'Наименование_группы'
,t2.ID_The_Subgroup	   as 'ID_подгруппы'
,t2.Name_The_Subgroup  as 'Наименование_подгруппы'
from Department d 
left join  [Group] as g on g.ID_Department = d.ID_Department
left join  The_Subgroup as t on t.[ID_Group] = g.[ID_Group] and t.[ID_Parent_The_Subgroup] is null
left join  The_Subgroup as t2 on t2.[ID_Parent_The_Subgroup] = t.[ID_The_Subgroup] 
go
----------------------------------------------------------------------Представление--------------------------------------------------------------------
drop table if exists #t_4
go
with s as
(
select 
[ID_подгруппы]
,[Наименование_подгруппы]
,[ID_Группы]	
,[Наименование_группы]
,[ID_Группыили_отдела]
,[Наименование отдела]
,[ID_Депортамента]	
,[Наименование_Депортамента]
from All_Otdel  
where [ID_подгруппы] is  null
union all
select 
[ID_подгруппы]
,[Наименование_подгруппы]
,[ID_Группы]	
,[Наименование_группы]
,[ID_Группыили_отдела]
,[Наименование отдела]
,[ID_Депортамента]	
,[Наименование_Депортамента]
from All_Otdel  
where [ID_подгруппы] is  not null
),
s_2 as
(
select
 s.[ID_подгруппы]
,s.[ID_Группы]
,s.[ID_Группыили_отдела]
,s.[ID_Депортамента]
,p.ID_Post
,p.[Name_Post]
from s as s 
left join  post p on  p.ID_The_Subgroup = s.ID_подгруппы
),
s_3 as
(
select
 s.[ID_подгруппы]
,s.[ID_Группы]
,s.[ID_Группыили_отдела]
,s.[ID_Депортамента]
,p.ID_Post
,p.[Name_Post]
from s as s 
left join  post p on  p.ID_The_Subgroup = s.ID_Группы
),
s_4 as
(
select * from s_2
union all
select * from s_3
)
select 
ID_Post
,Name_Post
,ID_Группыили_отдела	as 'ID_Group'
,ID_Депортамента        as 'ID_Department'
,0 flag
into #t_4
from s_4 
where ID_Post is not null order by  ID_Post

declare @i int = 0, @s int = 0 , @n varchar(40), @mess varchar(8000), @err varchar(1000);

declare
    @rowcount_1 int,
	@rowcount_2 int;

declare
 @ID_Post	        bigint
,@Name_Post	        nvarchar(400)
,@ID_Group	        bigint
,@ID_Department     bigint
,@flag              int;

declare mycur_9 cursor local fast_forward read_only for

select  
ID_Post
,Name_Post
,ID_Group
,ID_Department
,flag
from #t_4  order by  ID_Post

open  mycur_9
fetch next from mycur_9 into @ID_Post,@Name_Post,@ID_Group,@ID_Department,@flag 
   while @@FETCH_STATUS = 0 
      begin
        begin try
		     update a_9
			 set ID_Group = @ID_Group
			 from Post as a_9
			 where  ID_Post = @ID_Post and  Name_Post = @Name_Post
			 set @rowcount_1 = @@rowcount

			 update b_9
			 set ID_Department = @ID_Department
			 from Post as b_9
			 where  ID_Post = @ID_Post and  Name_Post = @Name_Post
			 set @rowcount_2 = @@rowcount


			 if  (@rowcount_1 = 1 and @rowcount_2 = 1)
			     begin
			       set @i =  @i + 1
			       
			       update c_9 
			       set flag = 1 
			       from #t_4  as c_9 
			       where ID_Post = @ID_Post and flag = 0
                 end
			 else if ((@rowcount_1 = 0 and @rowcount_2 = 1) or(@rowcount_1 = 1 and @rowcount_2 = 0))
				 begin
				      print 'Одно из полей не было записано в ' + convert(nvarchar(10),@ID_Post) 
				 end
			 else
			     begin
				      print 'В поле вообще ничего не было записано --> ' + convert(nvarchar(10),@ID_Post) 
				 end
				
			 select @s = count(0) from #t_4 where flag = 0
			 set @n = (select  
			           case  t.flag  when 1 then '--> 1  Значения изменены' when 0  then '--> 0  Значения не изменялись' end  
			           from #t_4 t  where ID_Post = @ID_Post)
			 set @mess = @n + ' - > ' +  ' Объект ' + cast(@ID_Post as varchar) + ' -- > '  + Cast(@i as varchar) + ' / ' + Cast(@s as varchar) +  ' -- >  Изменения внесены в Должность ' +  convert(nvarchar(10),@ID_Post)+ ' Изменён Отдел на ' + convert(nvarchar(10),@ID_Group) +  ' Изменён Депортамент на ' + convert(nvarchar(10),@ID_Department) + ' ' + '-- В таблице  Post'
			 RAISERROR(@mess,0,0) WITH NOWAIT 

		end try
		begin catch
		     if xact_state() in (1, -1) -- Функция XACT_STATE сообщает о состоянии пользовательской транзакции текущего выполняемого запроса.
		              /*
		              1 : запрос внутри блока транзакции активен и действителен (не выдал ошибку).
                      0 : запрос не выдаст ошибку (например, запрос select внутри транзакции без запросов update / insert).
                      -1: Запрос внутри транзакции выдал ошибку (при вводе блока catch) и выполнит полный откат
					  (если у нас есть 4 успешных запроса и 1 выдает ошибку ,все 5 запросов будут откатаны ).
		              */
              ROLLBACK TRAN
           SELECT 
             ERROR_NUMBER() AS ErrorNumber,
             ERROR_SEVERITY() AS ErrorSeverity,
             ERROR_STATE() as ErrorState,
             ERROR_PROCEDURE() as ErrorProcedure,
             ERROR_LINE() as ErrorLine,
             ERROR_MESSAGE() as ErrorMessage;

		   set @err = formatmessage(N'ID=%I64d, error - %s', @ID_Group, error_message());
		   print @err;
		end catch

      fetch next from mycur_9 into @ID_Post,@Name_Post,@ID_Group,@ID_Department,@flag 
	end
close mycur_9
deallocate mycur_9


commit


go

use Magaz_DB
go
begin tran

---------------------------------------------------------------------------Сначала_Функции_для_представлений_по_заданию----------------------------------------
go
CREATE FUNCTION dbo.RandomName
(
  @gender int
)
RETURNS nvarchar(max)
as
begin
 declare  @names_f table (
  id        int            NOT NULL identity(1,1),
  firstname nvarchar(255)  DEFAULT NULL,
  gender    int            DEFAULT NULL  check(gender in (1,2))
) 

INSERT INTO @names_f (firstname,gender)
VALUES
	('Александр',1),
	('Александра',1),
	('Алексей',1),
	('Альберт',1),
	('Анатолий',1),
	('Андрей',1),
	('Антон',1),
	('Артем',1),
	('Артур',1),
	('Афанасий',1),
	('Богдан',1),
	('Борис',1),
	('Вадим',1),
	('Валентин',1),
	('Валерий',1),
	('Василий',1),
	('Виктор',1),
	('Винер',1),
	('Виталий',1),
	('Владимир',1),
	('Владислав',1),
	('Власий',1),
	('Всеволод',1),
	('Вячеслав',1),
	('Геннадий',1),
	('Георгий',1),
	('Григорий',1),
	('Данила',1),
	('Денис',1),
	('Дмитрий',1),
	('Евгений',1),
	('Егор',1),
	('Емельян',1),
	('Захар',1),
	('Иван',1),
	('Игорь',1),
	('Илья',1),
	('Касьян',1),
	('Кирилл',1),
	('Константин',1),
	('Ксенофонт',1),
	('Кузьма',1),
	('Лев',1),
	('Леонид',1),
	('Леопольд',1),
	('Макар',1),
	('Максим',1),
	('Михаил',1),
	('Никита',1),
	('Никифор',1),
	('Николай',1),
	('Олег',1),
	('Павел',1),
	('Пётр',1),
	('Платон',1),
	('Радик',1),
	('Расиль',1),
	('Ринат',1),
	('Роман',1),
	('Руслан',1),
	('Светлана',1),
	('Сергей',1),
	('Станислав',1),
	('Степан',1),
	('Тимофей',1),
	('Тимур',1),
	('Трофим',1),
	('Фёдор',1),
	('Федот',1),
	('Фома',1),
	('Эдуард',1),
	('Юрий',1),
	('Яков',1),
	('Авдотья',2),
	('Акулина',2),
	('Александра',2),
	('Алена',2),
	('Алина',2),
	('Альфия',2),
	('Анастасия',2),
	('Ангелика',2),
	('Анеля',2),
	('Анна',2),
	('Антонина',2),
	('Валентина',2),
	('Варвара',2),
	('Вера',2),
	('Вероника',2),
	('Владимир',2),
	('Галина',2),
	('Евгения',2),
	('Евдокия',2),
	('Екатерина',2),
	('Елена',2),
	('Елизавета',2),
	('Ефросиния',2),
	('Жанна',2),
	('Инесса',2),
	('Инна',2),
	('Ираида',2),
	('Ирина',2),
	('Клавдия',2),
	('Кристина',2),
	('Ксения',2),
	('Лада',2),
	('Лариса',2),
	('Лена',2),
	('Лидия',2),
	('Лилианна',2),
	('Лилия',2),
	('Лия',2),
	('Любовь',2),
	('Людмила',2),
	('Люсия',2),
	('Маргарита',2),
	('Марина',2),
	('Мария',2),
	('Милана',2),
	('Надежда',2),
	('Наталья',2),
	('Нина',2),
	('Оксана',2),
	('Оксинья',2),
	('Ольга',2),
	('Пелагея',2),
	('Полина',2),
	('Прасковья',2),
	('Раиса',2),
	('Римма',2),
	('Рита',2),
	('Светлана',2),
	('Степанида',2),
	('Таисья',2),
	('Тамара',2),
	('Татьяна',2),
	('Фёкла',2),
	('Хевронья',2),
	('Элеонора',2),
	('Эльвира',2),
	('Юлия',2);
 declare @names_f_2 nvarchar(max) = (SELECT  STRING_AGG(Cast(firstname as nvarchar(max)),',')  AS Result FROM @names_f where gender = @gender)
 RETURN  @names_f_2
end

go

CREATE FUNCTION dbo.RandomLastname
(
  @gender int
)
RETURNS nvarchar(max)
as
begin
declare @names_l table  (
  id       int           NOT NULL identity(1,1),
  lastname nvarchar(255) DEFAULT NULL,
  gender   int           DEFAULT NULL check(gender in (1,2))
) 

INSERT INTO @names_l (lastname, gender) VALUES
	('Мысин',1),
	('Муравлёв',1),
	('Дягилев',1),
	('Бабаев',1),
	('Мичурин',1),
	('Микифоров',1),
	('Кунцев',1),
	('Лесин',1),
	('Бахолдин',1),
	('Евлашин',1),
	('Недосказов',1),
	('Муштаков',1),
	('Миханкин',1),
	('Витютиев',1),
	('Станкова',1),
	('Богдашкин',1),
	('Евлашов',1),
	('Мингалёв',1),
	('Грызлов',1),
	('Волков',1),
	('Жеребин',1),
	('Миронов',1),
	('Демихов',1),
	('Неприн',1),
	('Дондов',1),
	('Девятов',1),
	('Дедов',1),
	('Дежнев',1),
	('Наровчатов',1),
	('Гриньков',1),
	('Поварницин',1),
	('Будаев',1),
	('Ларюхин',1),
	('Корубин',1),
	('Голованев',1),
	('Чунов',1),
	('Сюткин',1),
	('Каймаков',1),
	('Мещеряков',1),
	('Назимов',1),
	('Архипов',1),
	('Дёмин',1),
	('Малахов',1),
	('Недозевин',1),
	('Смирнов',1),
	('Трубачёв',1),
	('Бершов',1),
	('Кадышев',1),
	('Лихачёв',1),
	('Викторов',1),
	('Бабин',1),
	('Скворцов',1),
	('Абрамцев',1),
	('Бахтияров',1),
	('Глазьев',1),
	('Ерашев',1),
	('Ковальков',1),
	('Карпушкин',1),
	('Нечаев',1),
	('Тимофеев',1),
	('Карпеев',1),
	('Благинин',1),
	('Спиридонов',1),
	('Моржеретов',1),
	('Бурмистров',1),
	('Задерихин',1),
	('Злобин',1),
	('Балашов',1),
	('Золотавин',1),
	('Листратов',1),
	('Беспалов',1),
	('Лихарев',1),
	('Евдокимов',1),
	('Астафьев',1),
	('Капшуль',1),
	('Федоров',1),
	('Брума',1),
	('Крылов',1),
	('Андреев',1),
	('Близнюков',1),
	('Наговицын',1),
	('Романов',1),
	('Нистратов',1),
	('Нежданов',1),
	('Перумов',1),
	('Гамзулин',1),
	('Бутаков',1),
	('Бестужев',1),
	('Булатов',1),
	('Недокучаев',1),
	('Загудалов',1),
	('Панов',1),
	('Морозов',1),
	('Лешуков',1),
	('Евланов',1),
	('Чумаков',1),
	('Лутошников',1),
	('Журавлёв',1),
	('Медвенцев',1),
	('Краснощёков',1),
	('Степаньков',1),
	('Королёв',1),
	('Березин',1),
	('Лунин',1),
	('Мишухин',1),
	('Вострокопытов',1),
	('Долматов',1),
	('Буконин',1),
	('Ермошкин',1),
	('Вышеславцев',1),
	('Надежин',1),
	('Бабаков',1),
	('Шулаев',1),
	('Абакумов',1),
	('Недобоев',1),
	('Новомлинцев',1),
	('Бузунов',1),
	('Веденяпин',1),
	('Касьянов',1),
	('Макаров',1),
	('Бутусов',1),
	('Недосейкин',1),
	('Шамешев',1),
	('Ирошников',1),
	('Голямов',1),
	('Евсенчев',1),
	('Кравцов',1),
	('Бабанин',1),
	('Нагайцев',1),
	('Буянтуев',1),
	('Ларин',1),
	('Дюкарев',1),
	('Киселёв',1),
	('Оськин',1),
	('Кириллов',1),
	('Ахряпов',1),
	('Лохтин',1),
	('Тукмаков',1),
	('Сидоров',1),
	('Брыкин',1),
	('Бахорин',1),
	('Чернозёмов',1),
	('Девятаев',1),
	('Свердлов',1),
	('Нагибин',1),
	('Дебособров',1),
	('Лаушкин',1),
	('Нохрин',1),
	('Оношкин',1),
	('Выжлецов',1),
	('Алампиев',1),
	('Мишакин',1),
	('Витин',1),
	('Лызлов',1),
	('Бушмин',1),
	('Любимов',1),
	('Ликунов',1),
	('Молостнов',1),
	('Богданов',1),
	('Зенкин',1),
	('Недовесов',1),
	('Винокуров',1),
	('Мишукин',1),
	('Кузьмин',1),
	('Степанов',1),
	('Буробин',1),
	('Галиев',1),
	('Дорохов',1),
	('Аривошкин',1),
	('Васнецов',1),
	('Александров',1),
	('Негодяев',1),
	('Дьяков',1),
	('Дианов',1),
	('Недоплясов',1),
	('Недочётов',1),
	('Ненашкин',1),
	('Демидов',1),
	('Екимов',1),
	('Годунов',1),
	('Дахнов',1),
	('Карагодин',1),
	('Карпиков',1),
	('Каганцев',1),
	('Веньчаков',1),
	('Беглов',1),
	('Медведев',1),
	('Мишенин',1),
	('Брежнев',1),
	('Соколов',1),
	('Горетов',1),
	('Григорьев',1),
	('Харланов',1),
	('Охохонин',1),
	('Барашков',1),
	('Ногаев',1),
	('Румянцев',1),
	('Лексиков',1),
	('Астахов',1),
	('Евсеев',1),
	('Бакунин',1),
	('Лемяхов',1),
	('Олейников',1),
	('Недачин',1),
	('Капустин',1),
	('Мынкин',1),
	('Божков',1),
	('Мишкин',1),
	('Занозин',1),
	('Ефимочкин',1),
	('Арчаков',1),
	('Мельгунов',1),
	('Сорокин',1),
	('Рыбаков',1),
	('Михайлин',1),
	('Горюнов',1),
	('Ляхов',1),
	('Недоростков',1),
	('Карпунин',1),
	('Горохов',1),
	('Мурин',1),
	('Мутылин',1),
	('Дориков',1),
	('Михалищев',1),
	('Дорожкин',1),
	('Пугачев',1),
	('Рыбин',1),
	('Недожоров',1),
	('Молоканов',1),
	('Мушкетов',1),
	('Ворошилов',1),
	('Захаров',1),
	('Балябин',1),
	('Зюряев',1),
	('Лукшин',1),
	('Калинин',1),
	('Кандауров',1),
	('Воронин',1),
	('Поливанов',1),
	('Мишагин',1),
	('Зырянов',1),
	('Михалин',1),
	('Лозбинев',1),
	('Аушев',1),
	('Новожилов',1),
	('Лутошкин',1),
	('Ковалёв',1),
	('Дураков',1),
	('Некрасов',1),
	('Харламов',1),
	('Наврузов',1),
	('Закащиков',1),
	('Железняков',1),
	('Недошивин',1),
	('Булыгин',1),
	('Назаров',1),
	('Цветков',1),
	('Микулин',1),
	('Нагульнов',1),
	('Охромеев',1),
	('Замятин',1),
	('Нестеров',1),
	('Варлов',1),
	('Черкесов',1),
	('Дымов',1),
	('Шлякотин',1),
	('Карпычев',1),
	('Звенигородцев',1),
	('Беляев',1),
	('Важенин',1),
	('Михалкин',1),
	('Лютов',1),
	('Бибиков',1),
	('Молоснов',1),
	('Мишанин',1),
	('Буков',1),
	('Гмырин',1),
	('Вельмукин',1),
	('Ветошников',1),
	('Недодаев',1),
	('Зарудин',1),
	('Мишуточкин',1),
	('Ломовцев',1),
	('Мишин',1),
	('Лабазанов',1),
	('Марков',1),
	('Анохин',1),
	('Шляпкин',1),
	('Заказчиков',1),
	('Гуров',1),
	('Мишуров',1),
	('Бессарабов',1),
	('Минеев',1),
	('Васин',1),
	('Мячин',1),
	('Чудинов',1),
	('Лабзин',1),
	('Галанин',1),
	('Батраков',1),
	('Девяткин',1),
	('Сидоркин',1),
	('Пушкин',1),
	('Новиков',1),
	('Недогадов',1),
	('Остапов',1),
	('Москвичёв',1),
	('Коновалов ',1),
	('Мелехов',1),
	('Мусатов',1),
	('Свеженцев',1),
	('Синельников',1),
	('Мирошкин',1),
	('Наслузов',1),
	('Еськов',1),
	('Колесников',1),
	('Откупщиков',1),
	('Недомеров',1),
	('Михалков',1),
	('Осташков',1),
	('Забродин',1),
	('Степанцов',1),
	('Левышев',1),
	('Беклов',1),
	('Михлин',1),
	('Залыгин',1),
	('Недопекин',1),
	('Никулин',1),
	('Ларюшкин',1),
	('Щелчков',1),
	('Мызников',1),
	('Арзамасцев',1),
	('Каманин',1),
	('Неофидов',1),
	('Ларионов',1),
	('Воргин',1),
	('Поваров',1),
	('Базулин',1),
	('Булгаков',1),
	('Силкин',1),
	('Егин',1),
	('Ширилов',1),
	('Галанкин',1),
	('Амелякин',1),
	('Мухортов',1),
	('Бронников',1),
	('Митряев',1),
	('Еранцев',1),
	('Воронов',1),
	('Ванслов',1),
	('Атиков',1),
	('Забусов',1),
	('Дроздов',1),
	('Нездольев',1),
	('Чернышёв',1),
	('Акиншин',1),
	('Трофимов',1),
	('Гамаюнов',1),
	('Муратов',1),
	('Вересаев',1),
	('Мишутин',1),
	('Недомолвин',1),
	('Доверов',1),
	('Солонин',1),
	('Ерошин',1),
	('Зверев',1),
	('Ларюшин',1),
	('Братухин',1),
	('Недогонов',1),
	('Мишунькин',1),
	('Осминин',1),
	('Буздырин',1),
	('Коркин',1),
	('Алексеев',1),
	('Карамышев',1),
	('Щедрин',1),
	('Казанцев',1),
	('Михайлов',1),
	('Карпушин',1),
	('Степашин',1),
	('Недосеев',1),
	('Асадов',1),
	('Лошкомоев',1),
	('Янин',1),
	('Алюшников',1),
	('Зайцев',1),
	('Балахонов',1),
	('Гордеев',1),
	('Болгов',1),
	('Ледяйкин',1),
	('Донцов',1),
	('Мусаков',1),
	('Таныгин',1),
	('Кабанов',1),
	('Майоров',1),
	('Фролов',1),
	('Истифеев',1),
	('Мадаев',1),
	('Девятнин',1),
	('Майков',1),
	('Амилеев',1),
	('Четвериков',1),
	('Рыков',1),
	('Лексин',1),
	('Родин',1),
	('Баратаев',1),
	('Недоглядов',1),
	('Наследышев',1),
	('Басалаев',1),
	('Никуличев',1),
	('Изотов',1),
	('Шустров',1),
	('Мишечкин',1),
	('Калашников',1),
	('Бочаров',1),
	('Калабухов',1),
	('Лалетин',1),
	('Авдеев',1),
	('Добин',1),
	('Лядов',1),
	('Найдёнов',1),
	('Гагарин',1),
	('Непомнящев',1),
	('Манихин',1),
	('Галимов',1),
	('Клейменов',1),
	('Ермаков',1),
	('Столяров',1),
	('Бавин',1),
	('Киров',1),
	('Бражников',1),
	('Дерябин',1),
	('Мещеринов',1),
	('Михалычев',1),
	('Рычков',1),
	('Огуреев',1),
	('Муравцев',1),
	('Давыдов',1),
	('Горбачёв',1),
	('Гандурин',1),
	('Зимин',1),
	('Артемьев',1),
	('Ляков',1),
	('Гузеев',1),
	('Абрамов',1),
	('Насонов',1),
	('Евтухов',1),
	('Вахромеев',1),
	('Черномырдин',1),
	('Ваганов',1),
	('Веденеев',1),
	('Михалев',1),
	('Недосекин',1),
	('Шехин',1),
	('Ерастов',1),
	('Авлов',1),
	('Осьмухин',1),
	('Андрианов',1),
	('Бывшев',1),
	('Чанов',1),
	('Кадомцев',1),
	('Ипутатов',1),
	('Максутов',1),
	('Лисицын',1),
	('Миханькин',1),
	('Дементьев',1),
	('Окладников',1),
	('Галамов',1),
	('Денисов',1),
	('Бабушкин',1),
	('Бандурин',1),
	('Илларионов',1),
	('Жернов',1),
	('Бунин',1),
	('Истратов',1),
	('Бармин',1),
	('Верьянов',1),
	('Вуколов',1),
	('Дедушкин',1),
	('Мишаков',1),
	('Федчин',1),
	('Наседкин',1),
	('Тихомиров',1),
	('Жуков',1),
	('Паньшин',1),
	('Лариошкин',1),
	('Евлампиев',1),
	('Рогозин',1),
	('Гнатов',1),
	('Халтурин',1),
	('Самашов',1),
	('Авлуков',1),
	('Големов',1),
	('Примаков',1),
	('Ванюлин',1),
	('Долгов',1),
	('Лисин',1),
	('Мотовилов',1),
	('Власов',1),
	('Глухов',1),
	('Комолов',1),
	('Чичварин',1),
	('Новодерёжкин',1),
	('Волокитин',1),
	('Лесанов',1),
	('Мишурин',1),
	('Гаврилов',1),
	('Душечкин',1),
	('Лялин',1),
	('Мишулин',1),
	('Алаев',1),
	('Меркулов',1),
	('Кашеваров',1),
	('Вергизов',1),
	('Бакланов',1),
	('Калганов',1),
	('Кашицын',1),
	('Каёхтин',1),
	('Ошурков',1),
	('Ларьков',1),
	('Воеводин',1),
	('Михаев',1),
	('Истомин',1),
	('Башуткин',1),
	('Максаков',1),
	('Федотов',1),
	('Ергин',1),
	('Усиков',1),
	('Недобитов',1),
	('Душкин',1),
	('Алымов',1),
	('Нефёдочкин',1),
	('Попов',1),
	('Бурнашов',1),
	('Дорин',1),
	('Ряхов',1),
	('Безруков',1),
	('Дежнов',1),
	('Бородин',1),
	('Фрыгин',1),
	('Бектуганов',1),
	('Пахомов',1),
	('Останин',1),
	('Андросов',1),
	('Новокшонов',1),
	('Ожгибесов',1),
	('Никульшин',1),
	('Бурмистов',1),
	('Казаков',1),
	('Верижников',1),
	('Капитонов',1),
	('Серов',1),
	('Платонов',1),
	('Еманов',1),
	('Голицын',1),
	('Лескин',1),
	('Лимарев',1),
	('Охрютин',1),
	('Ламзин',1),
	('Железнов',1),
	('Нахабин',1),
	('Бухаров',1),
	('Бадыгин',1),
	('Асланов',1),
	('Панкратов',1),
	('Недотыкин',1),
	('Евстафьев',1),
	('Лешаков',1),
	('Ивашов',1),
	('Ерошкин',1),
	('Невьянцев',1),
	('Ляпичев',1),
	('Дятлов',1),
	('Лисовин',1),
	('Лындяев',1),
	('Минакин',1),
	('Белоглазов',1),
	('Лазлов',1),
	('Ларькин',1),
	('Лобанов',1),
	('Коробов',1),
	('Логинов',1),
	('Недокукин',1),
	('Кадыков',1),
	('Винаров',1),
	('Тряпичкин',1),
	('Рябикин',1),
	('Маёров',1),
	('Каракозов',1),
	('Варакин',1),
	('Мазуров',1),
	('Смехов',1),
	('Кадыров',1),
	('Ломов',1),
	('Момотов',1),
	('Юдин',1),
	('Лыткин',1),
	('Нижегородцев',1),
	('Чернов',1),
	('Батманов',1),
	('Малышкин',1),
	('Недозрелов',1),
	('Мишунин',1),
	('Наточнев',1),
	('Акиньшин',1),
	('Мурхабинов',1),
	('Юлдашев',1),
	('Хабибуллин',1),
	('Лашманов',1),
	('Карпов',1),
	('Ососков',1),
	('Визгалов',1),
	('Ахрамеев',1),
	('Второв',1),
	('Дронин',1),
	('Лемешев',1),
	('Аршинников',1),
	('Щербатов',1),
	('Балдин',1),
	('Вешняков',1),
	('Ерлыченков',1),
	('Егошин',1),
	('Бухонин',1),
	('Меланьин',1),
	('Амченцев',1),
	('Лялькин',1),
	('Антонов',1),
	('Багин',1),
	('Нарышкин',1),
	('Лындин',1),
	('Осьминин',1),
	('Ахмадуллина',1),
	('Нехаев',1),
	('Кузнецов',1),
	('Комаров',1),
	('Ворохобин',1),
	('Неёлов',1),
	('Гурьянов',1),
	('Лапин',1),
	('Неретин',1),
	('Елпидин',1),
	('Шестаков',1),
	('Малашкин',1),
	('Шанов',1),
	('Тункин',1),
	('Жулидов',1),
	('Монахов',1),
	('Яньков',1),
	('Аверин',1),
	('Гоглачёв',1),
	('Гонохов',1),
	('Мамонтов',1),
	('Нагаев',1),
	('Буданов',1),
	('Бабкин',1),
	('Клочков',1),
	('Максютов',1),
	('Зотов',1),
	('Закутин',1),
	('Острокопытов',1),
	('Кабин',1),
	('Леонтьев',1),
	('Карпичев',1),
	('Иринархов',1),
	('Малафеев',1),
	('Недохлебов',1),
	('Мирошников',1),
	('Баландин',1),
	('Маклаков',1),
	('Шебалкин',1),
	('Десятов',1),
	('Лямин',1)

INSERT INTO @names_l (lastname, gender) VALUES
	('Мижурин',1),
	('Дерюгин',1),
	('Нефёдов',1),
	('Ненашев',1),
	('Говендяев',1),
	('Кудрин',1),
	('Близняков',1),
	('Батюшков',1),
	('Гладышев',1),
	('Завражнов',1),
	('Слюдачёв',1),
	('Агуреев',1),
	('Позолотин',1),
	('Недоспасов',1),
	('Петров',1),
	('Вырошников',1),
	('Баранов',1),
	('Щербаков',1),
	('Скороходов',1),
	('Митрошкин',1),
	('Калюгин',1),
	('Напалков',1),
	('Минин',1),
	('Мишуткин',1),
	('Ерёмин',1),
	('Леонов',1),
	('Лаптев',1),
	('Митрохин',1),
	('Астапов',1),
	('Сладков',1),
	('Майданов',1),
	('Аратов',1),
	('Недожогин',1),
	('Проханов',1),
	('Однодворцев',1),
	('Мурсякаев',1),
	('Шашурин',1),
	('Недоквасов',1),
	('Шумаков',1),
	('Аношкин',1),
	('Бабурин',1),
	('Доможиров',1),
	('Морюнин',1),
	('Евлахов',1),
	('Волосатов',1),
	('Голоднов',1),
	('Тихоходов',1),
	('Ширяев',1),
	('Любимцев',1),
	('Осьминкин',1),
	('Ерохин',1),
	('Маркин',1),
	('Вараксин',1),
	('Недокладов',1),
	('Недоносков',1),
	('Бакулин',1),
	('Носаев',1),
	('Синякин',1),
	('Нефедьев',1),
	('Белоярцев',1),
	('Багаев',1),
	('Веретинов',1),
	('Лутошин',1),
	('Наточеев',1),
	('Лёвочкин',1),
	('Закатов',1),
	('Онегин',1),
	('Дюжев',1),
	('Надеин',1),
	('Деревятин',1),
	('Лалитин',1),
	('Выростов',1),
	('Минаев',1),
	('Гандыбин',1),
	('Андронников',1),
	('Куликов',1),
	('Осьмаков',1),
	('Лутохин',1),
	('Зюганов',1),
	('Егоров',1),
	('Беднов',1),
	('Арутюнов',1),
	('Качулин',1),
	('Гаршин',1),
	('Мымликов',1),
	('Неделин',1),
	('Дробышев',1),
	('Волостнов',1),
	('Желваков',1),
	('Башутин',1),
	('Белов',1),
	('Евланин',1),
	('Жаринов',1),
	('Алимов',1),
	('Оплетаев',1),
	('Жмакин',1),
	('Исаев',1),
	('Васильев',1),
	('Ноговицын',1),
	('Проханова',2),
	('Абрамцева',2),
	('Годунова',2),
	('Бадыгина',2),
	('Каймакова',2),
	('Недошивина',2),
	('Ламзина',2),
	('Башутина',2),
	('Батманова',2),
	('Лындяева',2),
	('Лешакова',2),
	('Журавлёва',2),
	('Арзамасцева',2),
	('Ермакова',2),
	('Бабакова',2),
	('Ошуркова',2),
	('Мотовилова',2),
	('Чернышёва',2),
	('Десятова',2),
	('Лалитина',2),
	('Слюдачёва',2),
	('Карпичева',2),
	('Шебалкина',2),
	('Девятова',2),
	('Найдёнова',2),
	('Евланина',2),
	('Мишакова',2),
	('Романова',2),
	('Визгалова',2),
	('Лемяхова',2),
	('Девятаева',2),
	('Атикова',2),
	('Оськина',2),
	('Маннапова',2),
	('Тарханова',2),
	('Новокшонова',2),
	('Истомина',2),
	('Лютова',2),
	('Минина',2),
	('Лешукова',2),
	('Занозина',2),
	('Бакулина',2),
	('Лякова',2),
	('Ногаева',2),
	('Дерябина',2),
	('Недоросткова',2),
	('Мазурова',2),
	('Беспалова',2),
	('Баранова',2),
	('Багаева',2),
	('Чичварина',2),
	('Леонова',2),
	('Дедушкина',2),
	('Дорикова',2),
	('Янина',2),
	('Мусакова',2),
	('Нестерова',2),
	('Недосеева',2),
	('Злобина',2),
	('Евлашова',2),
	('Выжлецова',2),
	('Еманова',2),
	('Евдокимова',2),
	('Задерихина',2),
	('Ванюлина',2),
	('Бибикова',2),
	('Недокукина',2),
	('Вышеславцева',2),
	('Маркова',2),
	('Айдуллина',2),
	('Бочарова',2),
	('Бухонина',2),
	('Михайлина',2),
	('Мусатова',2),
	('Витина',2),
	('Лялина',2),
	('Гоглачёва',2),
	('Богданова',2),
	('Долматова',2),
	('Вешнякова',2),
	('Големова',2),
	('Архипова',2),
	('Тукмакова',2),
	('Недоноскова',2),
	('Мадаева',2),
	('Баратаева',2),
	('Багдасарян',2),
	('Глаголева',2),
	('Бунина',2),
	('Белова',2),
	('Ерошкина',2),
	('Неретина',2),
	('Бронникова',2),
	('Носаева',2),
	('Андросова',2),
	('Забродина',2),
	('Закутина',2),
	('Киселёва',2),
	('Анохина',2),
	('Щербатова',2),
	('Столярова',2),
	('Сергеева',2),
	('Вострокопытова',2),
	('Недомолвина',2),
	('Мызникова',2),
	('Нечаева',2),
	('Забусова',2),
	('Лапина',2),
	('Дюкарева',2),
	('Нохрина',2),
	('Голицына',2),
	('Недосекина',2),
	('Румянцева',2),
	('Откупщикова',2),
	('Железнякова',2),
	('Осьминина',2),
	('Гандурина',2),
	('Мазова',2),
	('Мишутина',2),
	('Дедова',2),
	('Благинина',2),
	('Душечкина',2),
	('Малахова',2),
	('Недозевина',2),
	('Жмакина',2),
	('Михлина',2),
	('Щелчкова',2),
	('Молостнова',2),
	('Васина',2),
	('Лексикова',2),
	('Попова',2),
	('Веретинова',2),
	('Александрова',2),
	('Харламова',2),
	('Лозбинева',2),
	('Капитонова',2),
	('Голоднова',2),
	('Беглова',2),
	('Галамова',2),
	('Бектуганова',2),
	('Бестужева',2),
	('Мишечкина',2),
	('Мишурова',2),
	('Еськова',2),
	('Карпочкина',2),
	('Майкова',2),
	('Ликунова',2),
	('Желвакова',2),
	('Силкина',2),
	('Денисова',2),
	('Закатова',2),
	('Шехина',2),
	('Кадомцева',2),
	('Охромеева',2),
	('Андрианова',2),
	('Тимофеева',2),
	('Екимова',2),
	('Астапова',2),
	('Ерёмина',2),
	('Ковалёва',2),
	('Воронова',2),
	('Остроушко',2),
	('Мишунина',2),
	('Ларюхина',2),
	('Мухортова',2),
	('Недожорова',2),
	('Мушкетова',2),
	('Нефедьева',2),
	('Минакина',2),
	('Новодерёжкина',2),
	('Дежнова',2),
	('Мымликова',2),
	('Демидова',2),
	('Карпеева',2),
	('Алексеева',2),
	('Мелехова',2),
	('Ларина',2),
	('Любимова',2),
	('Дорожкина',2),
	('Михайлова',2),
	('Лариошкина',2),
	('Ларюшина',2),
	('Винарова',2),
	('Майорова',2),
	('Базулина',2),
	('Буробина',2),
	('Наследышева',2),
	('Нефёдова',2),
	('Калинина',2),
	('Белоярцева',2),
	('Ряхова',2),
	('Еранцева',2),
	('Авлукова',2),
	('Ерошина',2),
	('Ванслова',2),
	('Михалычева',2),
	('Бутусова',2),
	('Васильева',2),
	('Недоквасова',2),
	('Наровчатова',2),
	('Нистратова',2),
	('Березина',2),
	('Егина',2),
	('Волокитина',2),
	('Лобанова',2),
	('Мишурина',2),
	('Вуколова',2),
	('Ососкова',2),
	('Синякина',2),
	('Лескина',2),
	('Доможирова',2),
	('Нагульнова',2),
	('Бахтиярова',2),
	('Важенина',2),
	('Лашманова',2),
	('Макарова',2),
	('Горбачёва',2),
	('Бершова',2),
	('Недогонова',2),
	('Арутюнова',2),
	('Нехаева',2),
	('Недовесова',2),
	('Дорохова',2),
	('Евлашина',2),
	('Шашурина',2),
	('Логинова',2),
	('Викторова',2),
	('Близнякова',2),
	('Мишагина',2),
	('Ергина',2),
	('Муравлёва',2),
	('Зюганова',2),
	('Ожгибесова',2),
	('Галимова',2),
	('Карпунина',2),
	('Четверикова',2),
	('Ермошкина',2),
	('Ширилова',2),
	('Ломовцева',2),
	('Цветкова',2),
	('Шлякотина',2),
	('Митрохина',2),
	('Бакунина',2),
	('Наврузова',2),
	('Лимарева',2),
	('Лисина',2),
	('Степашина',2),
	('Кашицына',2),
	('Пушкина',2),
	('Григорьева',2),
	('Юдина',2),
	('Асланова',2),
	('Демихова',2),
	('Максютова',2),
	('Примакова',2),
	('Воронина',2),
	('Астафьева',2),
	('Арчакова',2),
	('Тихоходова',2),
	('Листратова',2),
	('Любимцева',2),
	('Каёхтина',2),
	('Казакова',2),
	('Лесанова',2),
	('Ерлыченкова',2),
	('Непомнящева',2),
	('Верижникова',2),
	('Балашова',2),
	('Дахнова',2),
	('Напалкова',2),
	('Ларюшкина',2),
	('Мичурина',2),
	('Михаева',2),
	('Клочкова',2),
	('Вергизова',2),
	('Добина',2),
	('Вараксина',2),
	('Недоспасова',2),
	('Майданова',2),
	('Лызлова',2),
	('Недопекина',2),
	('Микулина',2),
	('Трубачёва',2),
	('Сорокина',2),
	('Солонина',2),
	('Лалетина',2),
	('Калганова',2),
	('Андронникова',2),
	('Башуткина',2),
	('Зарудина',2),
	('Соколова',2),
	('Самашова',2),
	('Сюткина',2),
	('Мещеринова',2),
	('Лутошкина',2),
	('Лисицына',2),
	('Лындина',2),
	('Исаева',2),
	('Бакланова',2),
	('Лялькина',2),
	('Кадырова',2),
	('Максутова',2),
	('Паньшина',2),
	('Однодворцева',2),
	('Муштакова',2),
	('Маклакова',2),
	('Дягилева',2),
	('Горетова',2),
	('Дёмина',2),
	('Митряева',2),
	('Ларькина',2),
	('Кузнецова',2),
	('Ларькова',2),
	('Изотова',2),
	('Коробова',2),
	('Алюшникова',2),
	('Янькова',2),
	('Букова',2),
	('Гурьянова',2),
	('Доверова',2),
	('Дронина',2),
	('Давыдова',2),
	('Кравцова',2),
	('Наточнева',2),
	('Гладышева',2),
	('Гурова',2),
	('Мирошкина',2),
	('Мишуточкина',2),
	('Беклова',2),
	('Мурина',2),
	('Васнецова',2),
	('Бабанина',2),
	('Недогадова',2),
	('Дымова',2),
	('Зверева',2),
	('Фролова',2),
	('Дебособрова',2),
	('Голованева',2),
	('Гонохова',2),
	('Зюряева',2),
	('Тихомирова',2),
	('Аушева',2),
	('Мурсякаева',2),
	('Бородина',2),
	('Бабина',2),
	('Нездольева',2),
	('Меркулова',2),
	('Алымова',2),
	('Гринькова',2),
	('Лутошина',2),
	('Осташкова',2),
	('Комолова',2),
	('Ерастова',2),
	('Маркина',2),
	('Лутошникова',2),
	('Щербакова',2),
	('Ишмухаметова',2),
	('Мингалёва',2),
	('Гандыбина',2),
	('Беляева',2),
	('Мишкина',2),
	('Петрова',2),
	('Спиридонова',2),
	('Назарова',2),
	('Воргина',2),
	('Миронова',2),
	('Михалева',2),
	('Карагодина',2),
	('Молоканова',2),
	('Зайцева',2),
	('Мирошникова',2),
	('Ваганова',2),
	('Рогозина',2),
	('Чумакова',2),
	('Бражникова',2),
	('Кудрина',2),
	('Дежнева',2),
	('Панкратова',2),
	('Гамаюнова',2),
	('Малафеева',2),
	('Чернозёмова',2),
	('Куликова',2),
	('Недобитова',2),
	('Лаушкина',2),
	('Лемешева',2),
	('Муратова',2),
	('Каманина',2),
	('Звенигородцева',2),
	('Буконина',2),
	('Медвенцева',2),
	('Ломова',2),
	('Шаймарданова',2),
	('Балахонова',2),
	('Останина',2),
	('Недоглядова',2),
	('Амченцева',2),
	('Сидорова',2),
	('Лазлова',2),
	('Бармина',2),
	('Бессарабова',2),
	('Амелякина',2),
	('Безрукова',2),
	('Истифеева',2),
	('Максакова',2),
	('Миханькина',2),
	('Недосказова',2),
	('Бузунова',2),
	('Жулидова',2),
	('Ветошникова',2),
	('Свердлова',2),
	('Недосейкина',2),
	('Железнова',2),
	('Веньчакова',2),
	('Бывшева',2),
	('Ворошилова',2),
	('Лёвочкина',2),
	('Аратова',2),
	('Усикова',2),
	('Ерашева',2),
	('Лабазанова',2),
	('Золотавина',2),
	('Щедрина',2),
	('Дюжева',2),
	('Крылова',2),
	('Недокладова',2),
	('Лаптева',2),
	('Харланова',2),
	('Неприна',2),
	('Заказчикова',2),
	('Нагайцева',2),
	('Ворохобина',2),
	('Малышкина',2),
	('Донцова',2),
	('Дятлова',2),
	('Пугачева',2),
	('Ерохина',2),
	('Наточеева',2),
	('Братухина',2),
	('Авлова',2),
	('Нежданова',2),
	('Охохонина',2),
	('Елпидина',2),
	('Акиншина',2),
	('Мынкина',2),
	('Лабзина',2),
	('Рыбина',2),
	('Недоплясова',2),
	('Шляпкина',2),
	('Недочётова',2),
	('Наговицына',2),
	('Капустина',2),
	('Дробышева',2),
	('Евсеева',2),
	('Нагаева',2),
	('Леонтьева',2),
	('Второва',2),
	('Кашеварова',2),
	('Ивашова',2),
	('Выростова',2),
	('Ляхова',2),
	('Рябикина',2),
	('Сладкова',2),
	('Галанина',2),
	('Чунова',2),
	('Гаршина',2),
	('Евланова',2),
	('Казанцева',2),
	('Рыбакова',2),
	('Горохова',2),
	('Михалищева',2),
	('Бабаева',2),
	('Вересаева',2),
	('Гамзулина',2),
	('Михалкова',2),
	('Дианова',2),
	('Мишухина',2),
	('Басалаева',2),
	('Никулина',2),
	('Лаврова',2),
	('Веденяпина',2),
	('Забирова',2),
	('Лихарева',2),
	('Новомлинцева',2),
	('Егорова',2),
	('Винокурова',2),
	('Евлампиева',2),
	('Сидоркина',2),
	('Кириллова',2),
	('Бурнашова',2),
	('Некрасова',2),
	('Балябина',2),
	('Жаринова',2),
	('Бутакова',2),
	('Михалкина',2),
	('Поварницина',2),
	('Жукова',2),
	('Мишина',2),
	('Левышева',2),
	('Каракозова',2),
	('Мишанина',2),
	('Мишукина',2),
	('Новикова',2),
	('Закащикова',2),
	('Качулина',2),
	('Богдашкина',2),
	('Брыкина',2),
	('Меланьина',2),
	('Карпушина',2),
	('Недомерова',2),
	('Лямина',2),
	('Волосатова',2),
	('Варлова',2),
	('Бухарова',2),
	('Мишакина',2),
	('Жеребина',2),
	('Нарышкина',2),
	('Булгакова',2),
	('Буданова',2),
	('Родина',2),
	('Евлахова',2),
	('Баглай',2),
	('Поварова',2),
	('Ирошникова',2),
	('Кадышева',2),
	('Дуракова',2),
	('Колесникова',2),
	('Осьмакова',2),
	('Багина',2),
	('Неёлова',2),
	('Верьянова',2),
	('Говендяева',2),
	('Кирова',2),
	('Федчина',2),
	('Карпова',2),
	('Молоснова',2),
	('Черномырдина',2),
	('Глазьева',2),
	('Демичева',2),
	('Оплетаева',2),
	('Гузеева',2),
	('Чудинова',2),
	('Зырянова',2),
	('Онегина',2),
	('Наслузова',2),
	('Федотова',2),
	('Недокучаева',2),
	('Морозова',2),
	('Шустрова',2),
	('Осминина',2),
	('Шумакова',2),
	('Агуреева',2),
	('Окладникова',2),
	('Глухова',2),
	('Оношкина',2),
	('Дерюгина',2),
	('Недачина',2),
	('Зенкина',2),
	('Неофидова',2),
	('Синельникова',2),
	('Алаева',2),
	('Карпикова',2),
	('Алампиева',2),
	('Краснощёкова',2),
	('Варакина',2),
	('Девятнина',2),
	('Мамонтова',2),
	('Батракова',2),
	('Никульшина',2),
	('Залыгина',2),
	('Нижегородцева',2),
	('Вельмукина',2),
	('Бабурина',2),
	('Гагарина',2),
	('Осьминкина',2),
	('Недожогина',2),
	('Астахова',2),
	('Минеева',2),
	('Булыгина',2),
	('Ипутатова',2),
	('Дорина',2),
	('Нахабина',2),
	('Карамышева',2),
	('Поливанова',2),
	('Вырошникова',2),
	('Малашкина',2),
	('Насонова',2),
	('Кунцева',2),
	('Лядова',2),
	('Никуличева',2),
	('Морюнина',2),
	('Евтухова',2),
	('Неделина',2),
	('Алимова',2),
	('Вахромеева',2),
	('Черкесова',2),
	('Фрыгина',2),
	('Лошкомоева',2),
	('Антонова',2),
	('Жернова',2),
	('Чанова',2),
	('Корубина',2),
	('Бурмистрова',2),
	('Рычкова',2),
	('Москвичёва',2),
	('Наседкина',2),
	('Болгова',2),
	('Воеводина',2),
	('Барашкова',2),
	('Лохтина',2),
	('Гнатова',2),
	('Новожилова',2),
	('Момотова',2),
	('Бавина',2),
	('Лутохина',2),
	('Кузьмина',2),
	('Осьмухина',2),
	('Недозрелова',2),
	('Миханкина',2),
	('Мишулина',2),
	('Булатова',2),
	('Галанкина',2),
	('Смехова',2),
	('Кадыкова',2),
	('Мишуткина',2),
	('Егошина',2),
	('Загудалова',2),
	('Карпушкина',2),
	('Ноговицына',2),
	('Мещерякова',2),
	('Рыкова',2),
	('Королёва',2),
	('Деревятина',2),
	('Тряпичкина',2),
	('Ковалькова',2),
	('Гималетдинова',2),
	('Бабкина',2),
	('Мячина',2),
	('Степанцова',2),
	('Лунина',2),
	('Митрошкина',2),
	('Авдеева',2),
	('Волостнова',2),
	('Буздырина',2),
	('Иринархова',2),
	('Бурмистова',2),
	('Маёрова',2),
	('Лисовина',2),
	('Душкина',2),
	('Охрютина',2),
	('Ширяева',2),
	('Баландина',2),
	('Захарова',2),
	('Степанькова',2),
	('Трофимова',2),
	('Панова',2),
	('Илларионова',2),
	('Нефёдочкина',2),
	('Ахряпова',2),
	('Скороходова',2),
	('Минаева',2),
	('Грызлова',2),
	('Абрамова',2),
	('Горюнова',2),
	('Ненашкина',2),
	('Шанова',2),
	('Медведева',2),
	('Калашникова',2),
	('Амилеева',2),
	('Моржеретова',2),
	('Негодяева',2),
	('Аривошкина',2),
	('Артемьева',2),
	('Нагибина',2),
	('Надежина',2),
	('Михалина',2),
	('Ефимочкина',2),
	('Балдина',2),
	('Витютиева',2),
	('Мельгунова',2),
	('Лесун',2),
	('Евсенчева',2),
	('Лукшина',2),
	('Евстафьева',2),
	('Гмырина',2),
	('Касьянова',2),
	('Клейменова',2),
	('Ледяйкина',2),
	('Гаврилова',2),
	('Ермолина',2),
	('Аношкина',2),
	('Близнюкова',2),
	('Недотыкина',2),
	('Огуреева',2),
	('Дьякова',2),
	('Салимова',2),
	('Шестакова',2),
	('Недохлебова',2),
	('Монахова',2),
	('Мысина',2),
	('Гордеева',2),
	('Лесина',2),
	('Ненашева',2),
	('Будаева',2),
	('Перумова',2),
	('Андреева',2),
	('Завражнова',2),
	('Ляпичева',2),
	('Назимова',2),
	('Бушмина',2),
	('Недодаева',2),
	('Кабанова',2),
	('Муравцева',2),
	('Ахрамеева',2),
	('Зимина',2),
	('Чернова',2),
	('Лексина',2),
	('Зотова',2),
	('Девяткина',2),
	('Долгова',2),
	('Позолотина',2),
	('Невьянцева',2),
	('Бахолдина',2),
	('Микифорова',2),
	('Веденеева',2),
	('Волкова',2),
	('Платонова',2),
	('Каганцева',2),
	('Голямова',2),
	('Буянтуева',2),
	('Божкова',2),
	('Недобоева',2),
	('Лихачёва',2),
	('Остапова',2),
	('Асадова',2),
	('Надеина',2),
	('Мутылина',2),
	('Бабушкина',2),
	('Власова',2),
	('Кандаурова',2),
	('Лыткина',2),
	('Олейникова',2),
	('Замятина',2),
	('Смирнова',2),
	('Острокопытова',2),
	('Мижурина',2),
	('Бахорина',2),
	('Мишенина',2),
	('Манихина',2),
	('Аршинникова',2),
	('Калюгина',2),
	('Свеженцева',2),
	('Калабухова',2),
	('Мишунькина',2),
	('Дементьева',2),
	('Комарова',2),
	('Батюшкова',2);

 declare @names_l_2 nvarchar(max) = (SELECT  STRING_AGG(Cast(lastname as nvarchar(max)),',') AS Result FROM @names_l where gender = @gender)
 RETURN  @names_l_2
end

go


CREATE FUNCTION dbo.RandomMiddlename
(
  @gender int
)
RETURNS nvarchar(max)
as
begin

declare  @names_m TABLE (
  id         int           NOT NULL identity(1,1),
  middlename nvarchar(255) DEFAULT NULL,
  gender     int           DEFAULT NULL check(gender in (1,2))
) 

INSERT INTO @names_m (middlename, gender)
VALUES
	('Александрович',1),
	('Алексеевич',1),
	('Альбертович',1),
	('Анатольевич',1),
	('Андреевич',1),
	('Антонович',1),
	('Арсланович',1),
	('Афанасьевич',1),
	('Богданович',1),
	('Борисович',1),
	('Вадимович',1),
	('Валентинович',1),
	('Валерьевич',1),
	('Васильевич',1),
	('Викторович',1),
	('Витальевич',1),
	('Владимирович',1),
	('Владимировна',1),
	('Владиславович',1),
	('Власиевич',1),
	('Всеволодович',1),
	('Вячеславович',1),
	('Геннадьевич',1),
	('Георгиевич',1),
	('Григорьевич',1),
	('Данилович',1),
	('Даянович',1),
	('Денисович',1),
	('Дмитриевич',1),
	('Евгеньевич',1),
	('Егорович',1),
	('Емельянович',1),
	('Захарович',1),
	('Иванович',1),
	('Игоревич',1),
	('Ильич',1),
	('Касьянович',1),
	('Кириллович',1),
	('Константинович',1),
	('Ксенофонтович',1),
	('Кузьмич',1),
	('Леонидович',1),
	('Леопольдович',1),
	('Львович',1),
	('Макарович',1),
	('Максимович',1),
	('Михайлович',1),
	('Мусеевна',1),
	('Никитич',1),
	('Никифорович',1),
	('Николаевич',1),
	('Олегович',1),
	('Павлович',1),
	('Петрович',1),
	('Платонович',1),
	('Романович',1),
	('Русланович',1),
	('Сергеевич',1),
	('Станиславович',1),
	('Степанович',1),
	('Тимофеевич',1),
	('Тимурович',1),
	('Трофимович',1),
	('Фанисович',1),
	('Фёдорович',1),
	('Федотович',1),
	('Фомич',1),
	('Эдуардович',1),
	('Юрьевич',1),
	('Яковлевич',1),
	('Александрович',2),
	('Александровна',2),
	('Алексеевна',2),
	('Альбертовна',2),
	('Анатольевна',2),
	('Андреевна',2),
	('Антоновна',2),
	('Аркадьевна',2),
	('Афанасьевна',2),
	('Богдановна',2),
	('Борисовна',2),
	('Вадимовна',2),
	('Валентиновна',2),
	('Валерьевна',2),
	('Васильевна',2),
	('Викторовна',2),
	('Витальевна',2),
	('Владимировна',2),
	('Владиславовна',2),
	('Власиевна',2),
	('Всеволодовна',2),
	('Вячеславовна',2),
	('Геннадьевна',2),
	('Георгиевна',2),
	('Григорьевна',2),
	('Даниловна',2),
	('Денисовна',2),
	('Дмитриевна',2),
	('Евгеньевна',2),
	('Егоровна',2),
	('Емельяновна',2),
	('Захаровна',2),
	('Ивановна',2),
	('Игоревна',2),
	('Ильинична',2),
	('Касьяновна',2),
	('Кирилловна',2),
	('Константиновна',2),
	('Ксенофонтовна',2),
	('Кузьминична',2),
	('Леонидовна',2),
	('Леопольдовна',2),
	('Львовна',2),
	('Макаровна',2),
	('Максимовна',2),
	('Маратовна',2),
	('Михайловна',2),
	('Никитична',2),
	('Никифоровна',2),
	('Николаевна',2),
	('Олеговна',2),
	('Павловна',2),
	('Петровна',2),
	('Платоновна',2),
	('Рамилевна',2),
	('Романовна',2),
	('Руслановна',2),
	('Саматовна',2),
	('Сергеевна',2),
	('Станиславовна',2),
	('Степановна',2),
	('Султангалиевна',2),
	('Суреновна',2),
	('Тимофеевна',2),
	('Тимуровна',2),
	('Трифоновна',2),
	('Трофимовна',2),
	('Фёдоровна',2),
	('Федотовна',2),
	('Фоминична',2),
	('Эдуардовна',2),
	('Юрьевна',2),
	('Явдатовна',2),
	('Яковлевна',2);
 declare @names_m_2 nvarchar(max) = (SELECT  STRING_AGG(Cast(middlename as nvarchar(max)),',') AS Result FROM @names_m where gender = @gender)
 RETURN  @names_m_2
end

go

create  function RandomDate
(
  @StartDate date,
  @EndDate date
)
returns nvarchar(max)
as
begin
declare @DateRange table (DateValue date);

;with DateGenerator as (
    select @StartDate as DateValue
    union all
    select DATEADD(DAY, 1, DateValue)
    from DateGenerator
    where DATEADD(DAY, 1, DateValue) <= @EndDate
)
insert into @DateRange
select DateValue
from DateGenerator
option (maxrecursion  0);

 declare @Date nvarchar(max) = (SELECT  STRING_AGG(Cast(DateValue as nvarchar(max)),',')  AS Result FROM @DateRange)
 RETURN  @Date
end


go
--------------------------------------------------------------Представления по функциям выше------------------------------------------------------------------

create view RandomFIO_G  
as
select 
(
select 
e.Name 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Name 
from STRING_SPLIT(dbo.RandomName(2),',') order by NEWID()) as e) as Name
,
(select 
e_2.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomLastname(2),',') order by NEWID()) as e_2) as Lastname 
,
(select 
e_3.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomMiddlename(2),',') order by NEWID()) as e_3) as Middlename
GO

create view RandomFIO_W   
as
select 
(
select 
e.Name 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Name 
from STRING_SPLIT(dbo.RandomName(1),',') order by NEWID()) as e) as Name
,
(select 
e_2.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomLastname(1),',') order by NEWID()) as e_2) as Lastname 
,
(select 
e_3.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomMiddlename(1),',') order by NEWID()) as e_3) as Middlename
GO

create view RandomDate_View  
as
select 
(
select 
e.Name 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Name 
from STRING_SPLIT(dbo.RandomDate('19440101','20240110'),',') order by NEWID()) as e) as Name

go


------------------------------------------------------------------------И теперь конечные функции с представлениями и фуункциями выше--------------------------------

create  function  RandomFIO_Name
(
   @gender     int
 -- ,@Name       nvarchar(50)
  --,@Lastname   nvarchar(50)
  --,@Middlename nvarchar(50)
)
returns nvarchar(50)
as 
begin
declare @Name  nvarchar(50)
set @Name = (select 
case when @gender = 1  then (select [Name] from RandomFIO_W)
     when @gender = 2  then (select [Name] from RandomFIO_G)
	 else ' Нужно ввести 1 или 2' end as Name)
return @Name
end;

go

create  function  RandomFIO_Lastname
(
   @gender     int
 -- ,@Name       nvarchar(50)
  --,@Lastname   nvarchar(50)
  --,@Middlename nvarchar(50)
)
returns nvarchar(50)
as 
begin
declare @Lastname   nvarchar(50)
set @Lastname = (select 
case when @gender = 1  then (select Lastname from RandomFIO_W)
     when @gender = 2  then (select Lastname from RandomFIO_G)
	 else ' Нужно ввести 1 или 2' end as Name)
return @Lastname
end;

go

create  function  RandomFIO_Middlename
(
   @gender     int
 -- ,@Name       nvarchar(50)
  --,@Lastname   nvarchar(50)
  --,@Middlename nvarchar(50)
)
returns nvarchar(50)
as 
begin
declare @Middlename  nvarchar(50)
set @Middlename = (select 
case when @gender = 1  then (select Middlename from RandomFIO_W)
     when @gender = 2  then (select Middlename from RandomFIO_G)
	 else ' Нужно ввести 1 или 2' end as Name)
return @Middlename
end;

go

create function RandomDate_View_function
(
)
Returns date
as 
begin
declare @RandomDate date
set @RandomDate = cast((select *  from RandomDate_View) as date)
return @RandomDate
end;

go
---------------------------------------------------------------------Процедуры---------------------------------------------------------------------------------

create procedure InsertEmployee

 @ID_Department					 bigint        	     
,@ID_Group						 bigint        	   	 
,@ID_The_Subgroup				 bigint        	   	 
,@ID_Passport					 bigint        	   	 
,@ID_Branch						 bigint        	   	 
,@ID_Post						 bigint        	   	 
,@ID_Status_Employee			 bigint        	   	 
,@ID_Connection_String			 bigint        	   	 
,@ID_Chief						 bigint        	   	 
,@Name							 nvarchar(100) 	   	 
,@SurName						 nvarchar(100) 	   	 
,@LastName						 nvarchar(100) 	   	 
,@Date_Of_Hiring				 datetime      	   	      	   	 
,@Residential_Address			 nvarchar(400) 	   	 
,@Home_Phone					 nvarchar(30)           	   	 
,@Cell_Phone					 nvarchar(30)           	   	 
,@Image_Employees				 varbinary(max)	   	 
,@Work_Phone					 nvarchar(30)           	   	 
,@Mail							 nvarchar(150) 	   	 
,@Pol							 char(1)       	   	 
,@Date_Of_Dismissal				 datetime      	   	 
,@Date_Of_Birth					 datetime      	   	 
,@Description					 nvarchar(1000)	   	 
as
		
Declare
 @2_ID_Department					 bigint        	  
,@2_ID_Group						 bigint        	  
,@2_ID_The_Subgroup				     bigint        	  
,@2_ID_Passport					     bigint        	  
,@2_ID_Branch						 bigint        	  
,@2_ID_Post						     bigint        	  
,@2_ID_Status_Employee			     bigint        	  
,@2_ID_Connection_String			 bigint        	  
,@2_ID_Chief						 bigint        	  
,@2_Name							 nvarchar(100) 	  
,@2_SurName						     nvarchar(100) 	  
,@2_LastName						 nvarchar(100) 	  
,@2_Date_Of_Hiring				     datetime      	       	  
,@2_Residential_Address			     nvarchar(400) 	  
,@2_Home_Phone					     nvarchar(30)           	  
,@2_Cell_Phone					     nvarchar(30)           	  
,@2_Image_Employees				     varbinary(max)	  
,@2_Work_Phone					     nvarchar(30)           	  
,@2_Mail							 nvarchar(150) 	  
,@2_Pol							     char(1)       	  
,@2_Date_Of_Dismissal				 datetime      	  
,@2_Date_Of_Birth					 datetime      	  
,@2_Description					     nvarchar(1000)	  

declare @Insert table
(
ID_Department              bigint         null      ,
ID_Group                   bigint         null      ,
ID_The_Subgroup            bigint         null      ,
ID_Passport                bigint         not null  ,
ID_Branch                  bigint         null      ,
ID_Post                    bigint         null      ,
ID_Status_Employee         bigint         null      ,
ID_Connection_String       bigint         null      ,
ID_Chief                   bigint         null      ,
Name                       nvarchar(100)  null      ,
SurName                    nvarchar(100)  null      ,
LastName                   nvarchar(100)  null      ,
Date_Of_Hiring             datetime       not null  ,
Residential_Address        nvarchar(400)  null      ,
Home_Phone                 nvarchar(30)   null      ,
Cell_Phone                 nvarchar(30)   null      ,
Image_Employees            varbinary(max) null      ,    
Work_Phone                 nvarchar(30)   null      ,
Mail                       nvarchar(150)  null      ,
Pol                        char(1)        not null  , 
Date_Of_Dismissal          datetime       null      ,
Date_Of_Birth              datetime       not null  ,
[Description]              nvarchar(1000) null       				
)


insert into  @Insert (
ID_Department				
,ID_Group					
,ID_The_Subgroup			    
,ID_Passport				    
,ID_Branch					
,ID_Post					    
,ID_Status_Employee			
,ID_Connection_String		
,ID_Chief					
,Name						
,SurName					    
,LastName					
,Date_Of_Hiring				
,Residential_Address		    
,Home_Phone					
,Cell_Phone					
,Image_Employees			    
,Work_Phone					
,Mail						
,Pol						    
,Date_Of_Dismissal			
,Date_Of_Birth				
,Description	
)
values
(
 @ID_Department				         
,@ID_Group					         
,@ID_The_Subgroup				 
,@ID_Passport					 
,@ID_Branch					         
,@ID_Post						 
,@ID_Status_Employee				     
,@ID_Connection_String		         
,@ID_Chief					         
,@Name						         
,@SurName						 
,@LastName					         
,@Date_Of_Hiring					     	     
,@Residential_Address			 
,@Home_Phone						     
,@Cell_Phone						     
,@Image_Employees				 
,@Work_Phone						     
,@Mail						         
,@Pol							 
,@Date_Of_Dismissal			         
,@Date_Of_Birth				         
,@Description	)				 



declare mycur_Insert cursor local fast_forward read_only for

select 
 ID_Department				
,ID_Group					
,ID_The_Subgroup			
,ID_Passport				
,ID_Branch					
,ID_Post					
,ID_Status_Employee		
,ID_Connection_String		
,ID_Chief					
,Name						
,SurName					
,LastName					
,Date_Of_Hiring			
,Residential_Address		
,Home_Phone				
,Cell_Phone				
,Image_Employees			
,Work_Phone				
,Mail						
,Pol						
,Date_Of_Dismissal			
,Date_Of_Birth				
,Description				
from @Insert

  
open  mycur_Insert

fetch next from mycur_Insert into 
           @2_ID_Department				
		  ,@2_ID_Group					
		  ,@2_ID_The_Subgroup				
		  ,@2_ID_Passport					
		  ,@2_ID_Branch					
		  ,@2_ID_Post						
		  ,@2_ID_Status_Employee			
		  ,@2_ID_Connection_String		
		  ,@2_ID_Chief					
		  ,@2_Name						
		  ,@2_SurName						
		  ,@2_LastName					
		  ,@2_Date_Of_Hiring				
		  ,@2_Residential_Address			
		  ,@2_Home_Phone					
		  ,@2_Cell_Phone					
		  ,@2_Image_Employees				
		  ,@2_Work_Phone					
		  ,@2_Mail						
		  ,@2_Pol							
		  ,@2_Date_Of_Dismissal			
		  ,@2_Date_Of_Birth				
		  ,@2_Description					
       
   while @@FETCH_STATUS = 0 
      begin
        begin try
		    insert into  Employees 
			(
                ID_Department				
			   ,ID_Group					
			   ,ID_The_Subgroup			
			   ,ID_Passport				
			   ,ID_Branch					
			   ,ID_Post					
			   ,ID_Status_Employee		
			   ,ID_Connection_String		
			   ,ID_Chief					
			   ,Name						
			   ,SurName					
			   ,LastName					
			   ,Date_Of_Hiring			
			   ,Residential_Address		
			   ,Home_Phone				
			   ,Cell_Phone				
			   ,Image_Employees			
			   ,Work_Phone				
			   ,Mail						
			   ,Pol						
			   ,Date_Of_Dismissal			
			   ,Date_Of_Birth				
			   ,Description				
			)
			 values
            (
			   @2_ID_Department				
			  ,@2_ID_Group					
			  ,@2_ID_The_Subgroup				
			  ,@2_ID_Passport					
			  ,@2_ID_Branch					
			  ,@2_ID_Post						
			  ,@2_ID_Status_Employee			
			  ,@2_ID_Connection_String		
			  ,@2_ID_Chief					
			  ,@2_Name						
			  ,@2_SurName						
			  ,@2_LastName					
			  ,@2_Date_Of_Hiring				
			  ,@2_Residential_Address			
			  ,@2_Home_Phone					
			  ,@2_Cell_Phone					
			  ,@2_Image_Employees				
			  ,@2_Work_Phone					
			  ,@2_Mail						
			  ,@2_Pol							
			  ,@2_Date_Of_Dismissal			
			  ,@2_Date_Of_Birth				
			  ,@2_Description					
		    )
		end try
		begin catch
		    if xact_state() in (1, -1)
			   ROLLBACK TRAN
			SELECT 
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage;
		end catch
      fetch next from mycur_Insert into               
		  @2_ID_Department				
		 ,@2_ID_Group					
		 ,@2_ID_The_Subgroup				
		 ,@2_ID_Passport					
		 ,@2_ID_Branch					
		 ,@2_ID_Post						
		 ,@2_ID_Status_Employee			
		 ,@2_ID_Connection_String		
		 ,@2_ID_Chief					
		 ,@2_Name						
		 ,@2_SurName						
		 ,@2_LastName					
		 ,@2_Date_Of_Hiring				
		 ,@2_Residential_Address			
		 ,@2_Home_Phone					
		 ,@2_Cell_Phone					
		 ,@2_Image_Employees				
		 ,@2_Work_Phone					
		 ,@2_Mail						
		 ,@2_Pol							
		 ,@2_Date_Of_Dismissal			
		 ,@2_Date_Of_Birth				
		 ,@2_Description					
	end
close mycur_Insert
deallocate mycur_Insert

go

create procedure UpdateEmployee
 @ID_Employee                    bigint         
,@ID_Department					 bigint        	     
,@ID_Group						 bigint        	   	 
,@ID_The_Subgroup				 bigint        	   	 
,@ID_Passport					 bigint        	   	 
,@ID_Branch						 bigint        	   	 
,@ID_Post						 bigint        	   	 
,@ID_Status_Employee			 bigint        	   	 
,@ID_Connection_String			 bigint        	   	 
,@ID_Chief						 bigint        	   	 
,@Name							 nvarchar(100) 	   	 
,@SurName						 nvarchar(100) 	   	 
,@LastName						 nvarchar(100) 	   	 
,@Date_Of_Hiring				 datetime      	   	      	   	 
,@Residential_Address			 nvarchar(400) 	   	 
,@Home_Phone					 nvarchar(30)           	   	 
,@Cell_Phone					 nvarchar(30)           	   	 
,@Image_Employees				 varbinary(max)	   	 
,@Work_Phone					 nvarchar(30)           	   	 
,@Mail							 nvarchar(150) 	   	 
,@Pol							 char(1)       	   	 
,@Date_Of_Dismissal				 datetime      	   	 
,@Date_Of_Birth					 datetime      	   	 
,@Description					 nvarchar(1000)	   	 
as
		
Declare
 @2_ID_Employee                      bigint
,@2_ID_Department					 bigint        	  
,@2_ID_Group						 bigint        	  
,@2_ID_The_Subgroup				     bigint        	  
,@2_ID_Passport					     bigint        	  
,@2_ID_Branch						 bigint        	  
,@2_ID_Post						     bigint        	  
,@2_ID_Status_Employee			     bigint        	  
,@2_ID_Connection_String			 bigint        	  
,@2_ID_Chief						 bigint        	  
,@2_Name							 nvarchar(100) 	  
,@2_SurName						     nvarchar(100) 	  
,@2_LastName						 nvarchar(100) 	  
,@2_Date_Of_Hiring				     datetime      	       	  
,@2_Residential_Address			     nvarchar(400) 	  
,@2_Home_Phone					     nvarchar(30)           	  
,@2_Cell_Phone					     nvarchar(30)           	  
,@2_Image_Employees				     varbinary(max)	  
,@2_Work_Phone					     nvarchar(30)           	  
,@2_Mail							 nvarchar(150) 	  
,@2_Pol							     char(1)       	  
,@2_Date_Of_Dismissal				 datetime      	  
,@2_Date_Of_Birth					 datetime      	  
,@2_Description					     nvarchar(1000)	  

declare @Update table
(
ID_Employee                bigint         null      ,
ID_Department              bigint         null      ,
ID_Group                   bigint         null      ,
ID_The_Subgroup            bigint         null      ,
ID_Passport                bigint         not null  ,
ID_Branch                  bigint         null      ,
ID_Post                    bigint         null      ,
ID_Status_Employee         bigint         null      ,
ID_Connection_String       bigint         null      ,
ID_Chief                   bigint         null      ,
Name                       nvarchar(100)  null      ,
SurName                    nvarchar(100)  null      ,
LastName                   nvarchar(100)  null      ,
Date_Of_Hiring             datetime       not null  ,
Residential_Address        nvarchar(400)  null      ,
Home_Phone                 nvarchar(30)   null      ,
Cell_Phone                 nvarchar(30)   null      ,
Image_Employees            varbinary(max) null      ,    
Work_Phone                 nvarchar(30)   null      ,
Mail                       nvarchar(150)  null      ,
Pol                        char(1)        not null  , 
Date_Of_Dismissal          datetime       null      ,
Date_Of_Birth              datetime       not null  ,
[Description]              nvarchar(1000) null       				
)


insert into  @Update (
ID_Employee 
,ID_Department				
,ID_Group					
,ID_The_Subgroup			    
,ID_Passport				    
,ID_Branch					
,ID_Post					    
,ID_Status_Employee			
,ID_Connection_String		
,ID_Chief					
,Name						
,SurName					    
,LastName					
,Date_Of_Hiring				
,Residential_Address		    
,Home_Phone					
,Cell_Phone					
,Image_Employees			    
,Work_Phone					
,Mail						
,Pol						    
,Date_Of_Dismissal			
,Date_Of_Birth				
,Description	
)
values
(
@ID_Employee 
,@ID_Department				         
,@ID_Group					         
,@ID_The_Subgroup				 
,@ID_Passport					 
,@ID_Branch					         
,@ID_Post						 
,@ID_Status_Employee				     
,@ID_Connection_String		         
,@ID_Chief					         
,@Name						         
,@SurName						 
,@LastName					         
,@Date_Of_Hiring					     	     
,@Residential_Address			 
,@Home_Phone						     
,@Cell_Phone						     
,@Image_Employees				 
,@Work_Phone						     
,@Mail						         
,@Pol							 
,@Date_Of_Dismissal			         
,@Date_Of_Birth				         
,@Description	
)				 



declare mycur_Update cursor local fast_forward read_only for

select 
ID_Employee 
,ID_Department				
,ID_Group					
,ID_The_Subgroup			
,ID_Passport				
,ID_Branch					
,ID_Post					
,ID_Status_Employee		
,ID_Connection_String		
,ID_Chief					
,Name						
,SurName					
,LastName					
,Date_Of_Hiring			
,Residential_Address		
,Home_Phone				
,Cell_Phone				
,Image_Employees			
,Work_Phone				
,Mail						
,Pol						
,Date_Of_Dismissal			
,Date_Of_Birth				
,Description				
from @Update

  
open  mycur_Update

fetch next from mycur_Update into 
           @2_ID_Employee 
          ,@2_ID_Department				
		  ,@2_ID_Group					
		  ,@2_ID_The_Subgroup				
		  ,@2_ID_Passport					
		  ,@2_ID_Branch					
		  ,@2_ID_Post						
		  ,@2_ID_Status_Employee			
		  ,@2_ID_Connection_String		
		  ,@2_ID_Chief					
		  ,@2_Name						
		  ,@2_SurName						
		  ,@2_LastName					
		  ,@2_Date_Of_Hiring				
		  ,@2_Residential_Address			
		  ,@2_Home_Phone					
		  ,@2_Cell_Phone					
		  ,@2_Image_Employees				
		  ,@2_Work_Phone					
		  ,@2_Mail						
		  ,@2_Pol							
		  ,@2_Date_Of_Dismissal			
		  ,@2_Date_Of_Birth				
		  ,@2_Description					
       
   while @@FETCH_STATUS = 0 
      begin
        begin try
		    update s
			  set   ID_Department		  =  @2_ID_Department				,
			        ID_Group			  =  @2_ID_Group					,
			        ID_The_Subgroup		  =  @2_ID_The_Subgroup				,
			        ID_Passport			  =  @2_ID_Passport					,
			        ID_Branch			  =  @2_ID_Branch					,
			        ID_Post				  =  @2_ID_Post						,
			        ID_Status_Employee	  =  @2_ID_Status_Employee			,
			        ID_Connection_String  =  @2_ID_Connection_String		,
			        ID_Chief			  =  @2_ID_Chief					,
			        Name				  =  @2_Name						,
			        SurName				  =  @2_SurName						,
			        LastName			  =  @2_LastName					,
			        Date_Of_Hiring		  =  @2_Date_Of_Hiring				,
			        Residential_Address	  =  @2_Residential_Address			,
			        Home_Phone			  =  @2_Home_Phone					,
			        Cell_Phone			  =  @2_Cell_Phone					,
			        Image_Employees		  =  @2_Image_Employees				,
			        Work_Phone			  =  @2_Work_Phone					,
			        Mail				  =  @2_Mail						,
			        Pol					  =  @2_Pol							,
			        Date_Of_Dismissal	  =  @2_Date_Of_Dismissal			,
			        Date_Of_Birth		  =  @2_Date_Of_Birth				,
			        Description	          =  @2_Description					
			  from   Employees as s
              where ID_Employee =  @2_ID_Employee
		end try
		begin catch
		    if xact_state() in (1, -1)
			   ROLLBACK TRAN
			SELECT 
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage;
		end catch
      fetch next from mycur_Update into 
	      @2_ID_Employee
		 ,@2_ID_Department				
		 ,@2_ID_Group					
		 ,@2_ID_The_Subgroup				
		 ,@2_ID_Passport					
		 ,@2_ID_Branch					
		 ,@2_ID_Post						
		 ,@2_ID_Status_Employee			
		 ,@2_ID_Connection_String		
		 ,@2_ID_Chief					
		 ,@2_Name						
		 ,@2_SurName						
		 ,@2_LastName					
		 ,@2_Date_Of_Hiring				
		 ,@2_Residential_Address			
		 ,@2_Home_Phone					
		 ,@2_Cell_Phone					
		 ,@2_Image_Employees				
		 ,@2_Work_Phone					
		 ,@2_Mail						
		 ,@2_Pol							
		 ,@2_Date_Of_Dismissal			
		 ,@2_Date_Of_Birth				
		 ,@2_Description					
	end
close mycur_Update
deallocate mycur_Update

go

create procedure RandomFIO
@gender int   
as
select 
(
select 
e.Name 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Name 
from STRING_SPLIT(dbo.RandomName(@gender),',') order by NEWID()) as e) as Name
,
(select 
e_2.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomLastname(@gender),',') order by NEWID()) as e_2) as Lastname 
,
(select 
e_3.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomMiddlename(@gender),',') order by NEWID()) as e_3) as Middlename
go

-----------------------------------------------------------------Ну и ещё одно представление на всякий---------------------------------------------------------------

create view All_Endpoints_Grops
as
with s as(
select distinct 
ID_Parent_The_Subgroup
from The_Subgroup 
where  ID_Parent_The_Subgroup is not null
), 
s_2 as
(
select
d.ID_The_Subgroup,
f.ID_Parent_The_Subgroup
from s as f 
full outer join The_Subgroup as d on d.ID_The_Subgroup  = f.ID_Parent_The_Subgroup
where  f.ID_Parent_The_Subgroup is null
)
select 
d.ID_The_Subgroup
,d.ID_Parent_The_Subgroup
,d.Name_The_Subgroup
from The_Subgroup as d inner join  s_2 as s on  s.ID_The_Subgroup =  d.ID_The_Subgroup  

go

--rollback
commit


go

create view All_Branch
as
select 
b.ID_Branch	           as 'ID_Филиала'
,b.Id_Country		   as 'ID_Страны'
,c.Name_Country		   as 'Наименование_страны'
,c.Name_English		   as 'Наименование_на_английском'
,c.Cod_Country_Phone   as 'Телефонный_код_страны'
,b.City				   as 'Наименование_города_где_находится_филиал'
,b.Address			   as 'Адрес_где_находится_филиал'
,b.Name_Branch		   as 'Наименование_филиала'
,b.Mail				   as 'Электроная_почта_филиала'
,b.Phone			   as 'Телефон_филиала'
,b.Postal_Code		   as 'Почтовый_индекс'
,b.INN				   as 'ИНН'
,b.Description         as 'Комментарии_к_филиалу'
from Branch as b
inner join Country as c on c.ID_Country = b.ID_Country


go

create view All_Post_Department
as
select 
 p.ID_Post                                as 'ID_Должности'
,p.Name_Post                              as 'Наименование_должности'
,p.ID_Department                          as 'ID_депортамента'
,d.Name_Department 						  as 'Наименование_депортамента'
,p.ID_Group                               as 'ID_Группы'
,g.Name_Group							  as 'Наименование_группы'
,p.ID_The_Subgroup                        as 'ID_ПодГруппы'   
,eg.Name_The_Subgroup					  as 'Наименование_подгруппы'
from Post p 
inner join All_Endpoints_Grops as eg on  eg.ID_The_Subgroup       = p.ID_The_Subgroup
inner join Department as d           on  d.ID_Department          = p.ID_Department
inner join [Group] as g              on  g.ID_Group               = p.ID_Group
go


create view AllEmployees
as
select
e.ID_Employee                             as 'ID_Сотрудника'
,d.Name_Department 						  as 'Наименование_депортамента'
,g.Name_Group							  as 'Наименование_группы'
,tg.Name_The_Subgroup					  as 'Наименование_подгруппы'
,p.Number_Series						  as 'Номер_серия_паспорта'
,p.Date_Of_Issue						  as 'Дата_выдачи'
,p.Department_Code						  as 'Код_депортамента'
,p.Issued_By_Whom						  as 'Кем_выдан'
,p.Registration							  as 'Регистрация'
,p.Military_Duty						  as 'Прохождение_военной_службы'
,b.City									  as 'Город_филиала'
,b.Address								  as 'Адрес_филиала'
,b.Name_Branch							  as 'Наименование_филиала'
,ps.Name_Post							  as 'Наименование_должности'
,c.Password								  as 'Пароль_УЗ'
,c.Login								  as 'Логин_УЗ'
,c.Date_Сreated							  as 'Дата_заведения_УЗ'
,e.ID_Chief								  as 'Руководитель'
,e.Name									  as 'Имя'
,e.SurName								  as 'Фамилия'
,e.LastName								  as 'Отчество'
,e.Date_Of_Hiring						  as 'Дата_создания_карты_работника'
,e.Date_Сard_Сreated_Employee			  as 'Дата_приема_на_работу'
,e.Residential_Address					  as 'Адрес_проживания'
,e.Home_Phone							  as 'Домашний_телефон'
,e.Cell_Phone							  as 'Сотовый_телефон'
,e.Image_Employees						  as 'Фотография_сотрудника'
,e.Work_Phone							  as 'Рабочий_телефон'
,e.Mail									  as 'Электронная_почта_сотрудника'
,e.Pol									  as 'Пол'
,e.Date_Of_Dismissal					  as 'Дата_увольнения'
,e.Date_Of_Birth 						  as 'Дата_Рождения'
,s.Name_Status_Employee                   as 'Статус_карточки_сотрудника'
from Employees as e
inner join Department as d              on d.ID_Department          = e.ID_Department
inner join [Group] as g                 on g.ID_Group               = e.ID_Group
inner join All_Endpoints_Grops as tg    on tg.ID_The_Subgroup       = e.ID_The_Subgroup
inner join Passport as p                on p.ID_Passport            = e.ID_Passport
inner join Branch as b                  on b.ID_Branch              = e.ID_Branch
inner join Post as ps                   on ps.ID_Post               = e.ID_Post
inner join Connection_String as c       on c.ID_Connection_String   = e.ID_Connection_String
inner join Status_Employee   as s       on s.ID_Status_Employee     = e.ID_Status_Employee
go
