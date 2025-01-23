--каждый файл создаётся на отдельный жёсткий диск , для быстро действия.
create database Magaz_DB
on primary -- явное задание первичной группы файлов(не обязательно).
(
name =  Magaz_DB_Root,-- первичный файл данных
filename ='c:\Users\dzubay\source\BD\Magaz_DB_Root\Magaz_DB_Root.mdf', --Указываем физическоеполное имя файла Бд.
size = 50 mb ,--Задаём начальный размер файла БД.
maxsize = 5000 mb, --Задаём максимальный размкр файла БД.
filegrowth = 50 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
filegroup  Costomers_Group --группа файлов для данных по клиентам
(
name =  Customers_Data_1,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Costomers_Group_1\Customers_Data_1.ndf', --Указываем физическоеполное имя файла Бд.
size = 25 mb ,--Задаём начальный размер файла БД.
maxsize = 250 mb, --Задаём максимальный размкр файла БД.
filegrowth = 25 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
(
name =  Customers_Data_2,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Costomers_Group_1\Customers_Data_2.ndf', --Указываем физическоеполное имя файла Бд.
size = 25 mb ,--Задаём начальный размер файла БД.
maxsize = 250 mb, --Задаём максимальный размкр файла БД.
filegrowth = 25 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
filegroup  Products_Group --Вторая группа файлов для данных по товарам
(
name =  Product_Data_1,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Products_Group_2\Product_Data_1.ndf', --Указываем физическоеполное имя файла Бд.
size = 50 mb ,--Задаём начальный размер файла БД.
maxsize = 1000 mb, --Задаём максимальный размкр файла БД.
filegrowth = 50 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
(
name =  Product_Data_2,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Products_Group_2\Product_Data_2.ndf', --Указываем физическоеполное имя файла Бд.
size = 50 mb ,--Задаём начальный размер файла БД.
maxsize = 1000 mb, --Задаём максимальный размкр файла БД.
filegrowth = 50 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
filegroup  Orders_Group --Третья группа фалов для данных по заказам
(
name =  Orders_Data_1,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Orders_Group_3\Orders_Data_1.ndf', --Указываем физическоеполное имя файла Бд.
size = 75 mb ,--Задаём начальный размер файла БД.
maxsize = 750 mb, --Задаём максимальный размкр файла БД.
filegrowth = 75 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
(
name =  Orders_Data_2,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Orders_Group_3\Orders_Data_2.ndf', --Указываем физическоеполное имя файла Бд.
size = 75 mb ,--Задаём начальный размер файла БД.
maxsize = 750 mb, --Задаём максимальный размкр файла БД.
filegrowth = 75 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
filegroup  Employee_Group -- Четвёртая группа файлов для сотрудников
(
name =  Employee_Data_1,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Employee_Group_4\Employee_Data_1.ndf', --Указываем физическоеполное имя файла Бд.
size = 25 mb ,--Задаём начальный размер файла БД.
maxsize = 250 mb, --Задаём максимальный размкр файла БД.
filegrowth = 25 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
),
(
name =  Employee_Data_2,-- вторичный файл данных
filename ='c:\Users\dzubay\source\BD\Employee_Group_4\Employee_Data_2.ndf', --Указываем физическоеполное имя файла Бд.
size = 25 mb ,--Задаём начальный размер файла БД.
maxsize = 250 mb, --Задаём максимальный размкр файла БД.
filegrowth = 25 mb  -- Задаём значение, на которое будет увеличиваться размер файла БД.
)
log on --Задаём параметры журнала базы данных.
(
name ='Log_Data',-- Указываем логическое имя журнала транзакций БД (Используется при обращении к БД)
filename = 'c:\Users\dzubay\source\BD\Log_Data\Log_Data.ldf',--Указываем физическоеполное имя файла журнала транзакций Бд. 
size = 20mb,-- Задаём начальный размер файла журнала БД.
maxsize =1200mb, --Задаём максимальный размкр файла журнала БД.
filegrowth = 40mb  -- Задаём значение, на которое будет увеличиваться размер файла журнала БД.
)
collate Cyrillic_General_CI_AS --задаём кодировку для БД по умолчаниючанию
go


ALTER DATABASE Magaz_DB  -- Изменение протоколирования БД,
SET RECOVERY FULL        -- FULL | SIMPLE | BULK_LOGGED. Указываем модель полного восстановления (Full) 
go



CREATE PARTITION FUNCTION PF_PartFuncDate (DateTime)
AS RANGE LEFT FOR VALUES ('01.01.2022', '01.01.2024', '01.01.2026');
go
CREATE PARTITION SCHEME PF_PartFuncDate
AS PARTITION PF_PartFuncDate
TO (Costomers_Group,Orders_Group,Products_Group,Employee_Group)
go   -- Секционирование по Дате создания объектов 

--select * from  sys.partition_functions  Просмотр функции Секционирования
--select * from sys.partition_schemes  Просмотр схем Секционирования

--Сначала удаляем схему секционирования, а то функция не удалится.
--DROP PARTITION SCHEME PF_PartFuncDate
--А потом уже саму функцию
--DROP PARTITION FUNCTION  PF_PartFuncDate
-------------------------------------------------------------------------------------------------------------------------
/*
Далее при создании таблиц, можно указывать в какую файловую группу  её создавать.
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
-- ПРИМЕР ИЗМЕНЕНИЯ СОЗДАННЫХ РАЗМЕРОВ  В УКАЗАННЫХ ВЫШЕ ФАЙЛАХ.
-- ПРИ ПЕРЕПОЛНЕНИИ ДАННЫМИ.
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

--------------------------------------------------------------------ЕСЛИ ВОЗНИКЛИ ОШИБКИ КАК УКАЗАНО НИЖЕ-------------------------------------------------------------
/*
Сообщение 5133, уровень 16, состояние 1, строка 2
Поиск каталога для файла "c:\Users\dzubay\source\BD\Magaz_DB_Root\Magaz_DB_Root.mdf" не удался, вызвав ошибку операционной системы 5(Отказано в доступе.).
Сообщение 1802, уровень 16, состояние 1, строка 2
Ошибка операции CREATE DATABASE. Некоторые из перечисленных имен файлов не были созданы. Проверьте связанные ошибки.
Сообщение 5011, уровень 14, состояние 5, строка 83
Пользователь не обладает разрешением на изменение базы данных "Magaz_DB", либо эта база данных не существует или находится в состоянии, не допускающем проверку доступа.
Сообщение 5069, уровень 16, состояние 1, строка 83
Не удалось выполнить инструкцию ALTER DATABASE.
*/
/*
Значит нет доступа у службы SQL SERVER
Учётные записи можно посмотреть с помощью запроса ниже. Находим нужную для нас УЗ и в свойствах папки в вкладке "Безопастность" добавляем эту УЗ
в моём случае это "Service\MSSQL$SQLEXPRESS", и после этого всё работает, даже без перезагрузки.

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


-------------------------------------------------------------Можно так же менять дополнительные параметры БД-------------------------------------------------------

/*
Следующий пример разрешает доступ только одному пользователю:
ALTER DATABASE TestDatabase
SET SINGLE_USER 

Доступ только только пользователям ролей db_owner, dbcreator или sysadmin:
ALTER DATABASE TestDatabase
SET RESTRICTED_USER

Возвращаем нормальный многопользовательский режим:
ALTER DATABASE TestDatabase
SET MULTI_USER

Вывести базу данных в off-line, т.е. доступ будет запрещен всем пользователям:
ALTER DATABASE TestDatabase
SET OFFLINE

Возобновить доступ к базе данных:
ALTER DATABASE TestDatabase
SET ONLINE

Перевести базу данных в режим только для чтения, любые изменения будут отклонены:
ALTER DATABASE TestDatabase
SET READ_ONLY 

Вернуть базе данных полный доступ на запись и чтение:
ALTER DATABASE TestDatabase
SET READ_WRITE

По завершении транзакции (принятии или откате) все открытые курсоры будут закрываться:
ALTER DATABASE TestDatabase
SET CURSOR_CLOSE_ON_COMMIT ON

Установить полную модель восстановления:
ALTER DATABASE TestDatabase
SET RECOVERY FULL

Установить модель восстановления BULK_LOGGED:
ALTER DATABASE TestDatabase
SET BULK_LOGGED 

Установить простую модель восстановления:
ALTER DATABASE TestDatabase
SET SIMPLE

И последнее, что нам предстоит узнать – это возможность изменения раскладки (кодировки) по умолчанию для базы данных. Для этого выполняется команда:
ALTER DATABASE Имя_базы
COLLATE имя_кодировки
*/





/* -- можно определить, сколько примерно записей находится в секциях

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