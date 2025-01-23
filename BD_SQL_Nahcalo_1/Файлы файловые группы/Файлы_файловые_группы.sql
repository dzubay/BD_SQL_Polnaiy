--������ ���� �������� �� ��������� ������ ���� , ��� ������ ��������.
create database Magaz_DB
on primary -- ����� ������� ��������� ������ ������(�� �����������).
(
name =  Magaz_DB_Root,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Magaz_DB_Root\Magaz_DB_Root.mdf', --��������� ���������������� ��� ����� ��.
size = 50 mb ,--����� ��������� ������ ����� ��.
maxsize = 5000 mb, --����� ������������ ������ ����� ��.
filegrowth = 50 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Costomers_Group --������ ������ ��� ������ �� ��������
(
name =  Customers_Data_1,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Costomers_Group_1\Customers_Data_1.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Customers_Data_2,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Costomers_Group_1\Customers_Data_2.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Products_Group --������ ������ ������ ��� ������ �� �������
(
name =  Product_Data_1,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Products_Group_2\Product_Data_1.ndf', --��������� ���������������� ��� ����� ��.
size = 50 mb ,--����� ��������� ������ ����� ��.
maxsize = 1000 mb, --����� ������������ ������ ����� ��.
filegrowth = 50 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Product_Data_2,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Products_Group_2\Product_Data_2.ndf', --��������� ���������������� ��� ����� ��.
size = 50 mb ,--����� ��������� ������ ����� ��.
maxsize = 1000 mb, --����� ������������ ������ ����� ��.
filegrowth = 50 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Orders_Group --������ ������ ����� ��� ������ �� �������
(
name =  Orders_Data_1,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Orders_Group_3\Orders_Data_1.ndf', --��������� ���������������� ��� ����� ��.
size = 75 mb ,--����� ��������� ������ ����� ��.
maxsize = 750 mb, --����� ������������ ������ ����� ��.
filegrowth = 75 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Orders_Data_2,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Orders_Group_3\Orders_Data_2.ndf', --��������� ���������������� ��� ����� ��.
size = 75 mb ,--����� ��������� ������ ����� ��.
maxsize = 750 mb, --����� ������������ ������ ����� ��.
filegrowth = 75 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
filegroup  Employee_Group -- �������� ������ ������ ��� �����������
(
name =  Employee_Data_1,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Employee_Group_4\Employee_Data_1.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
),
(
name =  Employee_Data_2,-- ��������� ���� ������
filename ='c:\Users\dzubay\source\BD\Employee_Group_4\Employee_Data_2.ndf', --��������� ���������������� ��� ����� ��.
size = 25 mb ,--����� ��������� ������ ����� ��.
maxsize = 250 mb, --����� ������������ ������ ����� ��.
filegrowth = 25 mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ��.
)
log on --����� ��������� ������� ���� ������.
(
name ='Log_Data',-- ��������� ���������� ��� ������� ���������� �� (������������ ��� ��������� � ��)
filename = 'c:\Users\dzubay\source\BD\Log_Data\Log_Data.ldf',--��������� ���������������� ��� ����� ������� ���������� ��. 
size = 20mb,-- ����� ��������� ������ ����� ������� ��.
maxsize =1200mb, --����� ������������ ������ ����� ������� ��.
filegrowth = 40mb  -- ����� ��������, �� ������� ����� ������������� ������ ����� ������� ��.
)
collate Cyrillic_General_CI_AS --����� ��������� ��� �� �� ��������������
go


ALTER DATABASE Magaz_DB  -- ��������� ���������������� ��,
SET RECOVERY FULL        -- FULL | SIMPLE | BULK_LOGGED. ��������� ������ ������� �������������� (Full) 
go



CREATE PARTITION FUNCTION PF_PartFuncDate (DateTime)
AS RANGE LEFT FOR VALUES ('01.01.2022', '01.01.2024', '01.01.2026');
go
CREATE PARTITION SCHEME PF_PartFuncDate
AS PARTITION PF_PartFuncDate
TO (Costomers_Group,Orders_Group,Products_Group,Employee_Group)
go   -- ��������������� �� ���� �������� �������� 

--select * from  sys.partition_functions  �������� ������� ���������������
--select * from sys.partition_schemes  �������� ���� ���������������

--������� ������� ����� ���������������, � �� ������� �� ��������.
--DROP PARTITION SCHEME PF_PartFuncDate
--� ����� ��� ���� �������
--DROP PARTITION FUNCTION  PF_PartFuncDate
-------------------------------------------------------------------------------------------------------------------------
/*
����� ��� �������� ������, ����� ��������� � ����� �������� ������  � ���������.
create table T1
(
...
) on FG1

create table T2
(
...
) on FG2
*/
-------------------------------------------------------------------------------------------------------------------------
-- ������ ��������� ��������� ��������  � ��������� ���� ������.
-- ��� ������������ �������.
/*
ALTER DATABASE AdventureWorks2012
MODIFY FILE (NAME = 'AdventureWorks2012_data',
FILEGROWTH = 1024MB)
GO
ALTER DATABASE AdventureWorks2012
MODIFY FILE (NAME = 'AdventureWorks2012_log',
FILEGROWTH = 256MB)
GO
*/

--------------------------------------------------------------------���� �������� ������ ��� ������� ����-------------------------------------------------------------
/*
��������� 5133, ������� 16, ��������� 1, ������ 2
����� �������� ��� ����� "c:\Users\dzubay\source\BD\Magaz_DB_Root\Magaz_DB_Root.mdf" �� ������, ������ ������ ������������ ������� 5(�������� � �������.).
��������� 1802, ������� 16, ��������� 1, ������ 2
������ �������� CREATE DATABASE. ��������� �� ������������� ���� ������ �� ���� �������. ��������� ��������� ������.
��������� 5011, ������� 14, ��������� 5, ������ 83
������������ �� �������� ����������� �� ��������� ���� ������ "Magaz_DB", ���� ��� ���� ������ �� ���������� ��� ��������� � ���������, �� ����������� �������� �������.
��������� 5069, ������� 16, ��������� 1, ������ 83
�� ������� ��������� ���������� ALTER DATABASE.
*/
/*
������ ��� ������� � ������ SQL SERVER
������� ������ ����� ���������� � ������� ������� ����. ������� ������ ��� ��� �� � � ��������� ����� � ������� "�������������" ��������� ��� ��
� ��� ������ ��� "Service\MSSQL$SQLEXPRESS", � ����� ����� �� ��������, ���� ��� ������������.

SELECT  DSS.servicename,
        DSS.startup_type_desc,
        DSS.status_desc,
        DSS.last_startup_time,
        DSS.service_account,
        DSS.is_clustered,
        DSS.cluster_nodename,
        DSS.filename,
        DSS.startup_type,
        DSS.status,
        DSS.process_id
FROM    sys.dm_server_services AS DSS;
*/


-------------------------------------------------------------����� ��� �� ������ �������������� ��������� ��-------------------------------------------------------

/*
��������� ������ ��������� ������ ������ ������ ������������:
ALTER DATABASE TestDatabase
SET SINGLE_USER 

������ ������ ������ ������������� ����� db_owner, dbcreator ��� sysadmin:
ALTER DATABASE TestDatabase
SET RESTRICTED_USER

���������� ���������� ��������������������� �����:
ALTER DATABASE TestDatabase
SET MULTI_USER

������� ���� ������ � off-line, �.�. ������ ����� �������� ���� �������������:
ALTER DATABASE TestDatabase
SET OFFLINE

����������� ������ � ���� ������:
ALTER DATABASE TestDatabase
SET ONLINE

��������� ���� ������ � ����� ������ ��� ������, ����� ��������� ����� ���������:
ALTER DATABASE TestDatabase
SET READ_ONLY 

������� ���� ������ ������ ������ �� ������ � ������:
ALTER DATABASE TestDatabase
SET READ_WRITE

�� ���������� ���������� (�������� ��� ������) ��� �������� ������� ����� �����������:
ALTER DATABASE TestDatabase
SET CURSOR_CLOSE_ON_COMMIT ON

���������� ������ ������ ��������������:
ALTER DATABASE TestDatabase
SET RECOVERY FULL

���������� ������ �������������� BULK_LOGGED:
ALTER DATABASE TestDatabase
SET BULK_LOGGED 

���������� ������� ������ ��������������:
ALTER DATABASE TestDatabase
SET SIMPLE

� ���������, ��� ��� ��������� ������ � ��� ����������� ��������� ��������� (���������) �� ��������� ��� ���� ������. ��� ����� ����������� �������:
ALTER DATABASE ���_����
COLLATE ���_���������
*/





/* -- ����� ����������, ������� �������� ������� ��������� � �������

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
where tbl.object_id=object_id('dbo.tbl_part1')
*/