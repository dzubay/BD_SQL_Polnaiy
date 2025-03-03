
-- Cформированный через  https://chat.deepseek.com/
/*  
Добавь к данному слову - SysNameTypeStoragelocation,  продолжение на логическом умозаключении,
к каждой строчке ниже , исходя из названия строки.
Основной склад,
Склад клиента,
Транзитный склад,
Возвратный склад,
Сезонный склад,
Арендованный склад,
Резервный склад,
Производственный склад,
Распределительный склад,
Склад временного хранения,
Склад опасных грузов,
Сделай пожалуйста всё в три столбца, названия в одинарных ковычках, и через запятую, третий столбец заканчивается на null,
и возьми каждую строчку в скобки.
*/

use Magaz_DB_Poln
go
set nocount,xact_abort on;
go
/*
-- Если с самого начала создаётся на с ID равным = 1, то можно обновить таблицу с помощью процы, и заполнить таблицу.
begin tran
if exists 
	  (	  
	  	SELECT * 
	  	FROM sys.identity_columns 
	  	WHERE object_id = OBJECT_ID('dbo.Type_Storage_location') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Type_Storage_location', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Type_Storage_location

--delete from  Type_Storage_location where ID_Type_Storage_location is not null


begin tran
insert into  Type_Storage_location(Name_Type_Storage_location,SysNameTypeStoragelocation,Description) values 
('Основной склад', 'SysNameTypeStoragelocationMainWarehouse', null),
('Склад клиента', 'SysNameTypeStoragelocationCustomerWarehouse', null),
('Транзитный склад', 'SysNameTypeStoragelocationTransitWarehouse', null),
('Возвратный склад', 'SysNameTypeStoragelocationReturnWarehouse', null),
('Сезонный склад', 'SysNameTypeStoragelocationSeasonalWarehouse', null),
('Арендованный склад', 'SysNameTypeStoragelocationRentedWarehouse', null),
('Резервный склад', 'SysNameTypeStoragelocationReserveWarehouse', null),
('Производственный склад', 'SysNameTypeStoragelocationProductionWarehouse', null),
('Распределительный склад', 'SysNameTypeStoragelocationDistributionWarehouse', null),
('Склад временного хранения', 'SysNameTypeStoragelocationTemporaryStorage', null),
('Склад опасных грузов', 'SysNameTypeStoragelocationHazardousMaterialsWarehouse', null)
--rollback
commit
