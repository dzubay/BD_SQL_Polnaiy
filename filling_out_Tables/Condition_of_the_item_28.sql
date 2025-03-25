
-- Cформированный через  https://chat.deepseek.com/
/*  
Добавь к данному слову - SysNameConditionTypeOfTheItem,  продолжение на логическом умозаключении через "_",
к каждой строчке ниже , на английском языке, исходя из названия строки.
Продан
,Просрочен
,Задублирован
,На отгрузке
,На складе
,Ожидает возврата
,Потерян
,На проверке
,Ожидает отгрузки
,Зарезервирован
,В пути
,Бракованный
,Возвращён пользователем
,Уценён
,Продан в рассрочку
,Не полностью оплачен по рассрочке
,Испорчен
,Срок годности просрочен
,Ожидает на пункте выдачи
,Ожидает курьера
,Черновик
,Редактируется
,Найдены несоответствия в карточке товара
,Перерасчёт цен
Сделай пожалуйста всё в три столбца, названия в одинарных кавычках, и через запятую, третий столбец заканчивается на null,
перый столбец должен быть наименования статусов , который я приложил выше.
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
	  	WHERE object_id = OBJECT_ID('dbo.Condition_of_the_item') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Condition_of_the_item', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Condition_of_the_item

--delete from  Condition_of_the_item where ID_Condition_of_the_item is not null


begin tran
insert into  Condition_of_the_item(Name_Condition_of_the_item,SysNameConditionTypeOfTheItem,[Description]) values 
('Продан', 'SysNameConditionTypeOfTheItem_Sold', null),
('Просрочен', 'SysNameConditionTypeOfTheItem_Expired', null),
('Задублирован', 'SysNameConditionTypeOfTheItem_Duplicated', null),
('На отгрузке', 'SysNameConditionTypeOfTheItem_Shipping', null),
('На складе', 'SysNameConditionTypeOfTheItem_InStock', null),
('Ожидает возврата', 'SysNameConditionTypeOfTheItem_AwaitingReturn', null),
('Потерян', 'SysNameConditionTypeOfTheItem_Lost', null),
('На проверке', 'SysNameConditionTypeOfTheItem_UnderInspection', null),
('Ожидает отгрузки', 'SysNameConditionTypeOfTheItem_AwaitingShipment', null),
('Зарезервирован', 'SysNameConditionTypeOfTheItem_Reserved', null),
('В пути', 'SysNameConditionTypeOfTheItem_InTransit', null),
('Бракованный', 'SysNameConditionTypeOfTheItem_Defective', null),
('Возвращён пользователем', 'SysNameConditionTypeOfTheItem_ReturnedByCustomer', null),
('Уценён', 'SysNameConditionTypeOfTheItem_Discounted', null),
('Продан в рассрочку', 'SysNameConditionTypeOfTheItem_SoldInInstallments', null),
('Не полностью оплачен по рассрочке', 'SysNameConditionTypeOfTheItem_PartiallyPaidInstallment', null),
('Испорчен', 'SysNameConditionTypeOfTheItem_Damaged', null),
('Срок годности просрочен', 'SysNameConditionTypeOfTheItem_ExpiredShelfLife', null),
('Ожидает на пункте выдачи', 'SysNameConditionTypeOfTheItem_AwaitingPickup', null),
('Ожидает курьера', 'SysNameConditionTypeOfTheItem_AwaitingCourier', null),
('Черновик', 'SysNameConditionTypeOfTheItem_Draft', null),
('Редактируется', 'SysNameConditionTypeOfTheItem_Editing', null),
('Найдены несоответствия в карточке товара', 'SysNameConditionTypeOfTheItem_ProductCardMismatch', null),
('Перерасчёт цен', 'SysNameConditionTypeOfTheItem_PriceRecalculation', null);
--rollback
commit