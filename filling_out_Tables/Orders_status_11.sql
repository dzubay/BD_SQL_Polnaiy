
-- Cформированный через  https://chat.deepseek.com/
/*  
Добавь к данному слову - SysTypeOrderStatusName,  продолжение на логическом умозаключении,
к каждой строчке ниже , исходя из названия строки.
 ('Завершена')
,('В ожидании')
,('В ожидании оплаты')
,('На уточнении у Контрагента')
,('Бухгалтерский контроль')
,('Оплачен')
,('На исправлении')
,('На проверки Аудиторов')
,('В движении')
,('На складе')
,('В сборке')
,('В ожидании отправки')
,('На проверке SOX')
,('Отменён')
,('Возврат')
Сделай пожалуйста всё в три столбца, названия в одинарных ковычках, и через запятую, третий столбец заканчивается на null,
и возьми каждую строчку в скобки.
*/


--select * from  dbo.Orders_status

--delete from  Orders_status where Id_Status is not null



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
	  	WHERE object_id = OBJECT_ID('dbo.Orders_status') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Orders_status', RESEED, 0)
	  end
--rollback
commit
go
*/
begin tran 
insert into  Orders_status(Name,SysTypeOrderStatusName,Description)
values 
('Завершена', 'SysTypeOrderStatusName_Completed', null)
,('В ожидании', 'SysTypeOrderStatusName_Pending', null)
,('В ожидании оплаты', 'SysTypeOrderStatusName_AwaitingPayment', null)
,('На уточнении у Контрагента', 'SysTypeOrderStatusName_ClarificationWithCounterparty', null)
,('Бухгалтерский контроль', 'SysTypeOrderStatusName_AccountingControl', null)
,('Оплачен', 'SysTypeOrderStatusName_Paid', null)
,('На исправлении', 'SysTypeOrderStatusName_CorrectionInProgress', null)
,('На проверки Аудиторов', 'SysTypeOrderStatusName_AuditReview', null)
,('В движении', 'SysTypeOrderStatusName_InTransit', null)
,('На складе', 'SysTypeOrderStatusName_InWarehouse', null)
,('В сборке', 'SysTypeOrderStatusName_AssemblyInProgress', null)
,('В ожидании отправки', 'SysTypeOrderStatusName_AwaitingShipment', null)
,('На проверке SOX', 'SysTypeOrderStatusName_SOXReview', null)
,('Отменён', 'SysTypeOrderStatusName_Canceled', null)
,('Возврат', 'SysTypeOrderStatusName_Returned', null)
--rollback
commit
