-------------------------------------------------------------------------------------------------------------------------

--Создаём диопазонное секционирование.

--У Вас всегда будет одна секция (крайне правая для LEFT-функции, или крайне левая для RIGHT-функции)
--, у которой не будет явно заданной граничной точки.
--Например, у нас указано 4  файловые группы. значит. Значит нам нужно указать 3 граничные точки 
--При диапазонном секционировании вначале определяют граничные точки. Если Вы определяете пять секции,
--то потребуются только четыре граничные точки.
-- Для того чтобы разделить данные на пять групп, Вы определяете четыре граничных значения для секций, а затем определяете,
--какой из секций будет принадлежать каждое из этих значений: первой (LEFT) или второй (RIGHT).
/*
Для LEFT:
1-ая секция - диапазон данных <= '20001001'
2-ая секция - диапазон данных > '20001001'
Для RIGHT:
1-ая секция - диапазон данных < '20001001'
2-ая секция - диапазон данных => '20001001'
*/

--Кроме того, поскольку данные, вероятно, будут добавляться и удаляться из секции, вам потребуется последняя пустая секция,
--которую вы сможете постоянно "расщеплять", выделяя тем самым место для новой секции данных.
--В нашем случае крайняя правая, так как указано LEFT
--Эта последняя секция будет всегда оставаться пустой, находясь в ожидании новых записей,
--которые вы будете периодически в нее включать.



--Примичание 
/*
Примечание : Использование типа данных datetime добавляет сложности, поскольку Вы должны будете удостовериться в том,
что установили правильные граничные значения. В случае с RIGHT-функцией все предельно просто, т.к. 
время по умолчанию равняется 12:00:00.000am. Для LEFT дополнительная сложность обусловлена точностью типа данных datetime.
Причина, по которой вы ДОЛЖНЫ выбирать в качестве граничного значения 23:59:59.997, состоит в том,
что тип данных datetime не гарантирует точность в 1 миллисекунду. Вместо этого,
datetime-данные абсолютно точны в пределах 3.33 миллисекунд.
Значение такта таймера процессора (tick) равное 23:59:59.999 не доступно для SQL Server,
вместо этого значение округляется до ближайшего такта, которым является 12:00:00.000am следующего дня.
Из-за такого округления границы могут быть неверно определены.
Проявляйте осмотрительность при задании значений в миллисекундах для типа данных datetime.

Примечание : Функции секционирования также позволяют в качестве определения использовать другие функции.
Вы можете использовать функцию DATEADD (ms,-3, '20010101') вместо явного определения '20001231 23:59:59.997'.
*/

--Запрос ниже позволяет показать какикие таблицы на данный момент секционированы

--/* --просмотр секций сеционирования для таблицы из тригера Employee_Audit
select distinct  t.name, p.partition_number
from sys.partitions p 
inner join sys.tables t 
on p.object_id = t.object_id 
where p.partition_number <> 1

-- можно определить, сколько примерно записей находится в секциях

SELECT
     tbl.name tbl_name,
      --idx.type_desc idx_type,
      --idx.name idx_name,
      --dts.name + ISNULL('-> ' + dts2.name, '') dts_name,
      dts.type_desc + ISNULL('-> ' + dts2.type_desc, '') dts_type,
      prt.partition_number,
      prt.rows,
      prv.value low_boundary,
      prs.name part_scheme_name,
      pfs.name part_func_name
FROM sys.tables tbl
JOIN sys.indexes idx ON idx.object_id = tbl.object_id
JOIN sys.data_spaces dts ON dts.data_space_id = idx.data_space_id
JOIN sys.partitions prt ON prt.object_id = tbl.object_id AND prt.index_id = idx.index_id
LEFT JOIN sys.partition_schemes prs ON prs.data_space_id = dts.data_space_id
LEFT JOIN sys.partition_functions pfs ON pfs.function_id = prs.function_id
LEFT JOIN sys.partition_range_values prv ON
      prv.function_id = pfs.function_id AND prv.boundary_id = prt.partition_number - 1
LEFT JOIN sys.destination_data_spaces dds ON
      dds.partition_scheme_id = prs.data_space_id    AND dds.destination_id = prt.partition_number
LEFT JOIN sys.data_spaces dts2 ON dts2.data_space_id = dds.data_space_id




--  Создаём файловую группу ID_Employee_Audit_PARTITION
use Magaz_DB
go
Alter database [Magaz_DB] add filegroup [ID_Employee_Audit_PARTITION] 
go
Alter database [Magaz_DB] add file
(
 name = N'ID_Employee_Audit_PARTITION'                    --Наименование name должно будет тоже самое что и  FileName а то будет ошибка
,FileName = N'd:\Repa\BD_Magaz\PARTITION\ID_Employee_Audit_PARTITION.ndf'
,size	 = 50 mb
,maxsize = 5000 mb,															
filegrowth = 50 mb	
)  TO FILEGROUP ID_Employee_Audit_PARTITION
go --  Создаём файловую группу ID_Employee_Audit_PARTITION


CREATE PARTITION FUNCTION PF_PartFuncDate_LEFT (int)  --В основном LEFt делается на данные из столбца с int 
AS RANGE LEFT FOR VALUES (
1000,
2000,
3000,
4000);
go

CREATE PARTITION SCHEME SH_PartFuncDate_LEFT
AS PARTITION PF_PartFuncDate_LEFT
all TO (ID_Employee_Audit_PARTITION) -- Всё в одну файловую группу
go   

--go
--ALTER DATABASE magaz_db
--ADD FILE (
--    NAME = 'ID_Employee_Audit_PARTITION.ndf',
--    FILENAME = N'd:\Repa\BD_Magaz\PARTITION\ID_Employee_Audit_PARTITION.ndf'
--) TO FILEGROUP ID_Employee_Audit_PARTITION;



----------------------------------------------------------------------------------------------------------------------------------
-----------Нелязя указывать схему при создании таблицы к столбцу с датами, которые не входят в уникальный ключь-------------------
----будет вот такая ошибка - Столбец "Date_Сard_Сreated_Employee" является столбцом секционирования индекса "PK_ID_Employee".----- 
--------------------Столбцы секционирования уникального индекса должны быть подмножеством ключа индекса.--------------------------
----------------------------И внести никак нельзя, гужно создавать таблицу без ключей видимо--------------------------------------
----------------------------------------нужно потом разобраться-------------------------------------------------------

--Alter database [Magaz_DB] add filegroup [Employee_Сreated_DateTime_PARTITION]
--go
--Alter database [Magaz_DB] add file
--(
-- name = N'Employee_Сreated_DateTime'
--,FileName = N'd:\Repa\BD_Magaz\PARTITION\Employee_Сreated_DateTime.ndf'
--,size	 = 50 mb
--,maxsize = 5000 mb,															
--filegrowth = 50 mb	
--)
--go


--Схема
--CREATE PARTITION FUNCTION PF_PartFuncDate_Right (DateTime) --В основном Right делается на данные из столбца с date 
--AS RANGE Right FOR VALUES (
--N'01.01.2022 23:59:59.997',
--N'01.01.2023 23:59:59.997',
--N'01.01.2024 23:59:59.997',
--N'01.01.2025 23:59:59.997',
--N'01.01.2026 23:59:59.997');
--go

--CREATE PARTITION SCHEME SH_PartFuncDate_Right
--AS PARTITION PF_PartFuncDate_Right
--all TO (Employee_Сreated_DateTime_PARTITION) -- всё в одну файловую группу
--go   

------------------------------------------------------------------------------------------------


--*/


--select * from sys.partitions
--select * from sys.partition_functions  -- Просмотр функции Секционирования
--select * from sys.partition_schemes    -- Просмотр схем Секционирования
 
--Сначала удаляем схему секционирования, а то функция не удалится.

--DROP PARTITION SCHEME SH_PartFuncDate_LEFT 
--DROP PARTITION SCHEME SH_PartFuncDate_Right
--А потом уже саму функцию

--DROP PARTITION FUNCTION  PF_PartFuncDate_LEFT
--DROP PARTITION FUNCTION 	PF_PartFuncDate_Right


SELECT
     tbl.name tbl_name,
      idx.type_desc idx_type,
      idx.name idx_name,
      dts.name + ISNULL('-> ' + dts2.name, '') dts_name,
      dts.type_desc + ISNULL('-> ' + dts2.type_desc, '') dts_type,
      prt.partition_number,
      prt.rows,
      prv.value low_boundary,
      prs.name part_scheme_name,
      pfs.name part_func_name
FROM sys.tables tbl
JOIN sys.indexes idx ON idx.object_id = tbl.object_id
JOIN sys.data_spaces dts ON dts.data_space_id = idx.data_space_id
JOIN sys.partitions prt ON prt.object_id = tbl.object_id AND prt.index_id = idx.index_id
LEFT JOIN sys.partition_schemes prs ON prs.data_space_id = dts.data_space_id
LEFT JOIN sys.partition_functions pfs ON pfs.function_id = prs.function_id
LEFT JOIN sys.partition_range_values prv ON
      prv.function_id = pfs.function_id AND prv.boundary_id = prt.partition_number - 1
LEFT JOIN sys.destination_data_spaces dds ON
      dds.partition_scheme_id = prs.data_space_id    AND dds.destination_id = prt.partition_number
LEFT JOIN sys.data_spaces dts2 ON dts2.data_space_id = dds.data_space_id





SELECT
    sc.name + N'.' + so.name as [Schema.Table],
    si.index_id as [Index ID],
    si.type_desc as [Structure],
    si.name as [Index],
    stat.row_count AS [Rows],
    stat.in_row_reserved_page_count * 8./1024./1024. as [In-Row GB],
    stat.lob_reserved_page_count * 8./1024./1024. as [LOB GB],
    p.partition_number AS [Partition #],
    pf.name as [Partition Function],
    CASE pf.boundary_value_on_right
        WHEN 1 then 'Right / Lower'
        ELSE 'Left / Upper'
    END as [Boundary Type],
    prv.value as [Boundary Point],
    fg.name as [Filegroup]
FROM sys.partition_functions AS pf
JOIN sys.partition_schemes as ps on ps.function_id=pf.function_id
JOIN sys.indexes as si on si.data_space_id=ps.data_space_id
JOIN sys.objects as so on si.object_id = so.object_id
JOIN sys.schemas as sc on so.schema_id = sc.schema_id
JOIN sys.partitions as p on 
    si.object_id=p.object_id 
    and si.index_id=p.index_id
LEFT JOIN sys.partition_range_values as prv on prv.function_id=pf.function_id
    and p.partition_number= 
        CASE pf.boundary_value_on_right WHEN 1
            THEN prv.boundary_id + 1
        ELSE prv.boundary_id
        END
        /* For left-based functions, partition_number = boundary_id, 
           for right-based functions we need to add 1 */
JOIN sys.dm_db_partition_stats as stat on stat.object_id=p.object_id
    and stat.index_id=p.index_id
    and stat.index_id=p.index_id and stat.partition_id=p.partition_id
    and stat.partition_number=p.partition_number
JOIN sys.allocation_units as au on au.container_id = p.hobt_id
    and au.type_desc ='IN_ROW_DATA' 
        /* Avoiding double rows for columnstore indexes. */
        /* We can pick up LOB page count from partition_stats */
JOIN sys.filegroups as fg on fg.data_space_id = au.data_space_id
ORDER BY [Schema.Table], [Index ID], [Partition Function], [Partition #];








/*

--Для переноса данных из одной любой секции требуется, создать такую же таблицу со всеми теми же индексами

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
Date_Card_Created_Employee datetime       null,
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

*/



--select * from Employees_Audit
--select * from Employees_Audit_6

--drop table dbo.[Employees_Audit_6]


create clustered index index_Employees_Audit_1 on Employees_Audit(AuditID) on SH_PartFuncDate_LEFT(AuditID)
create clustered index index_Employees_Audit_2 on Employees_Audit_6(AuditID) on SH_PartFuncDate_LEFT(AuditID)

--можно так
create nonclustered index index_Employees_Audit_1_n on Employees_Audit(AuditID,ID_Employee) --on SH_PartFuncDate_LEFT(AuditID)
create nonclustered index index_Employees_Audit_2_n on Employees_Audit_6(AuditID,ID_Employee) --on SH_PartFuncDate_LEFT(AuditID)
-- можнои так
/*--Всё равно будут переносится
create nonclustered index index_Employees_Audit_1_n on Employees_Audit(AuditID,ID_Employee) on SH_PartFuncDate_LEFT(AuditID)
create nonclustered index index_Employees_Audit_2_n on Employees_Audit_6(AuditID,ID_Employee) on SH_PartFuncDate_LEFT(AuditID)
*/
drop index index_Employees_Audit_1 on Employees_Audit
drop index index_Employees_Audit_2 on Employees_Audit_6

drop index index_Employees_Audit_1_n on Employees_Audit
drop index index_Employees_Audit_2_n on Employees_Audit_6

--Индексы удаляются вместе с таблицыми, пр  их удалении
--select * from sys.indexes



-- Можно посмотреть индексы имеющиеся в таблицах
/*
select o.name tblName, i.name indexName, c.name columnName, ic.is_included_column
from sys.indexes i
join sys.objects o on i.object_id = o.object_id
join sys.index_columns ic on ic.object_id = i.object_id and ic.index_id = i.index_id
join sys.columns c on ic.column_id = c.column_id and o.object_id = c.object_id 
where o.name in ('Employees_Audit', 'Employees_Audit_2','Employees_Audit_5','Employees_Audit_6') -- указываем таблицы
*/

--Для добавления секции с ограничениями в нужную функцию
SET STATISTICS TIME, IO ON; 

alter partition scheme SH_PartFuncDate_LEFT
next used [ID_Employee_Audit_PARTITION];  -- Объявляем что новая секцмя будет сделанна в файловой группу ID_Employee_Audit_PARTITION

alter partition function PF_PartFuncDate_LEFT() split range (10000); --Добавляем новую границу в функцию PF_PartFuncDate_LEFT

SET STATISTICS TIME, IO OFF;

--Удалить секцию можно с помощью запроса ниже----------------------------------------------------

--SET STATISTICS TIME, IO ON;
--alter partition function PF_PartFuncDate_LEFT() merge range (3000); --Указываем границу
--SET STATISTICS TIME, IO OFF;

/*
Для переключения (switch) секции в таблицу и обратно, нам требуется пустая таблица, 
в которой созданы все те же ограничения и индексы, что и на нашей секционированной таблице.
Таблица должна быть в той же файловой группе, что и секция, которую мы хотим туда «переключить».
*/
-----------------Переключение-------------------------------------------------------------------
SET STATISTICS TIME, IO ON;

alter table Employees_Audit  switch partition   $partition.PF_PartFuncDate_LEFT(2000)  to Employees_Audit_6   partition   $partition.PF_PartFuncDate_LEFT(2000)

SET STATISTICS TIME, IO OFF;

-- Обратно
SET STATISTICS TIME, IO ON;

alter table Employees_Audit_6  switch partition   $partition.PF_PartFuncDate_LEFT(2000)  to Employees_Audit   partition   $partition.PF_PartFuncDate_LEFT(2000)

SET STATISTICS TIME, IO OFF;
----------------------------------------------------------------Более простая аналогия----------------------------------------------------------------------------

------------------------------------------------------------------Или так, аналогично-----------------------------------------------------------------------------

SET STATISTICS TIME, IO ON;

alter table Employees_Audit switch partition 2 to Employees_Audit_6 partition 2

SET STATISTICS TIME, IO OFF;



--Переключение обратно

SET STATISTICS TIME, IO ON;

alter table Employees_Audit_6 switch partition 2 to Employees_Audit partition 2

SET STATISTICS TIME, IO OFF;

--------------------------------------Пример ошибки-----------------------------------------------------------------------------
--Не удалось выполнить инструкцию ALTER TABLE SWITCH. Проверочные ограничения исходной таблицы "Magaz_DB.dbo.Employees_Audit_2"
--принимают значения, которые не допускаются диапазоном, определенным секцией 3 в целевой таблице "Magaz_DB.dbo.Employees_Audit".
--------------------------------------Причина, и как исправить её---------------------------------------------------------------
--Дядька Sql server ругается, дляи этого нужно создать ограничения на таблице издателя
--и указать ограничения такие же как и в целевой таблице

alter table Employees_Audit_2
add constraint check_dk check ((AuditiD <= 3000) and (AuditiD > 2000))

alter table Employees_Audit_5  
add constraint  check_dk_1 check ((AuditiD <= 20000) AND (AuditiD > 10000))

alter table Employees_Audit_2 
add constraint  check_dk_2 check ((AuditiD <= 20000) AND (AuditiD > 10000))

/* -- Просмотр ограничений
SELECT * 
FROM sys.check_constraints 
WHERE parent_object_id = OBJECT_ID('Magaz_DB.dbo.Employees_Audit_2') -- Указываем полное наименование таблицы
*/

--И после установленного ограничения, можно снова пробовать переносить данные в целевую таблицу, если ограничения правильны значит всё хорошо. 


-------------------------------------------------------------------------------------------------



   SELECT 
       ID_Employee, 
       ID_Group,
       RANK() OVER (ORDER BY ID_Group DESC) AS ID_Group_Rank
   FROM 
       Employees;

     SELECT 
       AuditID, 
       ID_Group,
	   ROW_NUMBER() OVER (PARTITION BY ID_Group ORDER BY AuditID ) AS RowNum,
       DENSE_RANK() OVER (ORDER BY ID_Group DESC) AS ID_Group_Rank
   FROM 
       Employees_Audit;


      SELECT 
       ID_Employee, 
       ID_Group,
	   Date_Of_Hiring,
       count(*) OVER (PARTITION BY Date_Of_Hiring ORDER BY Date_Of_Hiring ) AS Date_Of_Hiring_count  --Указывает сколько сотрудников относятся ка данной дате
   FROM 
       Employees;