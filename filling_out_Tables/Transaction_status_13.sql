
-- Cформированный через  https://chat.deepseek.com/
/*  
Добавь к данному слову - SysTypeTransactionName,  продолжение на логическом умозаключении,
к каждой строчке ниже , исходя из названия строки.
'Создана',
'Отправлена',
'Получена',
'В обработке',
'На валидации',
'Валидация успешна',
'Валидация не пройдена',
'На маршрутизации',
'Маршрутизация завершена',
'На выполнении',
'Выполнена успешно',
'Выполнена с ошибкой',
'Отменена',
'Возвращена',
'На повторной обработке',
'В ожидании ответа',
'Ответ получен',
'Ответ не получен',
'На проверке консистентности',
'Консистентность подтверждена',
'Консистентность нарушена',
'Заблокирована',
'Дублирована',
'Частично выполнена',
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
	  	WHERE object_id = OBJECT_ID('dbo.Transaction_status') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Transaction_status', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Transaction_status

--delete from  Transaction_status where ID_Transaction_status is not null


begin tran
insert into  Transaction_status(TypeTransactionName,SysTypeTransactionName,Description) values 
('Создана', 'SysTypeTransactionName_Created', null)
,('Отправлена', 'SysTypeTransactionName_Sent', null)
,('Получена', 'SysTypeTransactionName_Received', null)
,('В обработке', 'SysTypeTransactionName_InProgress', null)
,('На валидации', 'SysTypeTransactionName_ValidationPending', null)
,('Валидация успешна', 'SysTypeTransactionName_ValidationSuccess', null)
,('Валидация не пройдена', 'SysTypeTransactionName_ValidationFailed', null)
,('На маршрутизации', 'SysTypeTransactionName_RoutingPending', null)
,('Маршрутизация завершена', 'SysTypeTransactionName_RoutingCompleted', null)
,('На выполнении', 'SysTypeTransactionName_ExecutionPending', null)
,('Выполнена успешно', 'SysTypeTransactionName_ExecutionSuccess', null)
,('Выполнена с ошибкой', 'SysTypeTransactionName_ExecutionFailed', null)
,('Отменена', 'SysTypeTransactionName_Canceled', null)
,('Возвращена', 'SysTypeTransactionName_Returned', null)
,('На повторной обработке', 'SysTypeTransactionName_RetryInProgress', null)
,('В ожидании ответа', 'SysTypeTransactionName_AwaitingResponse', null)
,('Ответ получен', 'SysTypeTransactionName_ResponseReceived', null)
,('Ответ не получен', 'SysTypeTransactionName_ResponseNotReceived', null)
,('На проверке консистентности', 'SysTypeTransactionName_ConsistencyCheckPending', null)
,('Консистентность подтверждена', 'SysTypeTransactionName_ConsistencyConfirmed', null)
,('Консистентность нарушена', 'SysTypeTransactionName_ConsistencyViolated', null)
,('Заблокирована', 'SysTypeTransactionName_Blocked', null)
,('Дублирована', 'SysTypeTransactionName_Duplicated', null)
,('Частично выполнена', 'SysTypeTransactionName_PartiallyCompleted', null)
--rollback
commit
