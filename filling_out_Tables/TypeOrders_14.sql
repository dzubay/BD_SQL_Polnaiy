
-- Cформированный через  https://chat.deepseek.com/

/*
Добавь к данному слову - TypeOrdersSysName,  продолжение на логическом умозаключении,
к каждой строчке ниже , исходя из названия строки.
('Предварительный заказ')		  
,('Возвратный заказ')			  
,('Заказ на доставку')			  
,('Самовывоз')					  
,('Международный заказ')	
,('Заказ на услуги')
,('Стандарный заказ')
,('Заказ с ограничением времени')
,('Заказ в рассрочку')
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
	  	WHERE object_id = OBJECT_ID('dbo.TypeOrders') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.TypeOrders', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.TypeOrders

--delete from  TypeOrders where ID_TypeOrders is not null



begin tran
Insert into TypeOrders(TypeOrdersName,TypeOrdersSysName,[Description]) values           
('Предварительный заказ', 'TypeOrdersSysName_PreOrder', NULL)
,('Возвратный заказ', 'TypeOrdersSysName_ReturnOrder', NULL)
,('Заказ на доставку', 'TypeOrdersSysName_DeliveryOrder', NULL)
,('Самовывоз', 'TypeOrdersSysName_PickupOrder', NULL)
,('Международный заказ', 'TypeOrdersSysName_InternationalOrder', NULL)
,('Заказ на услуги', 'TypeOrdersSysName_ServiceOrder', NULL)
,('Стандартный заказ', 'TypeOrdersSysName_StandardOrder', NULL)
,('Заказ с ограничением времени', 'TypeOrdersSysName_TimeBoundOrder', NULL)
,('Заказ в рассрочку', 'TypeOrdersSysName_InstallmentOrder', NULL)
commit
--rollback