
-- Cформированный через  https://chat.deepseek.com/
/*  
Составить список статусов для Места хранения, через запятую в столбик, на русском языке.
Добавь к данному слову - SysTypeStoragelocationName,  продолжение на логическом умозаключении,
к каждой строчке сформированным выше в первом предложении, исходя из названия строки.

Сделай пожалуйста всё в три столбца, названия в одинарных кавычках, и через запятую, третий столбец заканчивается на null,
и возьми каждую строчку в скобки.  Более больше чем в запросе выше. Так же добавить  одно из статусов, Транзитное
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
	  	WHERE object_id = OBJECT_ID('dbo.Storage_location_status') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Storage_location_status', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Storage_location_status

--delete from  Storage_location_status where Id_Status is not null


begin tran
insert into  Storage_location_status(TypeStoragelocationName,SysTypeStoragelocationName,Description) values 
('Активно', 'SysTypeStoragelocationNameActive', null)
,('Неактивно', 'SysTypeStoragelocationNameInactive', null)
,('Зарезервировано', 'SysTypeStoragelocationNameReserved', null)
,('Заблокировано', 'SysTypeStoragelocationNameBlocked', null)
,('На обслуживании', 'SysTypeStoragelocationNameUnderMaintenance', null)
,('Заполнено', 'SysTypeStoragelocationNameFull', null)
,('Временное', 'SysTypeStoragelocationNameTemporary', null)
,('Архивировано', 'SysTypeStoragelocationNameArchived', null)
,('Транзитное', 'SysTypeStoragelocationNameTransit', null)
,('Карантин', 'SysTypeStoragelocationNameQuarantine', null)
,('Резервное', 'SysTypeStoragelocationNameReserve', null)
,('Ограниченный доступ', 'SysTypeStoragelocationNameRestrictedAccess', null)
,('На инвентаризации', 'SysTypeStoragelocationNameUnderInventory', null)
,('На утилизации', 'SysTypeStoragelocationNameUnderDisposal', null)
,('На ремонте', 'SysTypeStoragelocationNameUnderRepair', null)
,('На перемещении', 'SysTypeStoragelocationNameInTransit', null)
,('На комплектации', 'SysTypeStoragelocationNameUnderAssembly', null)
,('На проверке', 'SysTypeStoragelocationNameUnderInspection', null)
,('На распределении', 'SysTypeStoragelocationNameUnderDistribution', null)
--rollback
commit
