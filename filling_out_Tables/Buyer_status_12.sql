
-- Cформированный через  https://chat.deepseek.com/
/*  
Добавь к данному слову - SysTypeBuyerStatusName,  продолжение на логическом умозаключении через "_",
к каждой строчке ниже , на английском языке, исходя из названия строки.
Активный,
Неактивный,
Заблокирован,
На проверке СБ,
Задублированный,
Ожидает Подтверждения,
Подтвержден,
Приостановлен,
На Удержании,
Архивный,
Отклонен,
Ограниченный доступ
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
	  	WHERE object_id = OBJECT_ID('dbo.Buyer_status') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Buyer_status', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Buyer_status

--select * from  dbo.Buyer_status_audit

--delete from  Buyer_status where Id_Status is not null


begin tran
insert into  Buyer_status(Name,SysTypeBuyerStatusName,Description) values 
('Активный', 'SysTypeBuyerStatusName_Active', null),  
('Неактивный', 'SysTypeBuyerStatusName_Inactive', null),  
('Заблокирован', 'SysTypeBuyerStatusName_Blocked', null),  
('На проверке СБ', 'SysTypeBuyerStatusName_UnderSecurityReview', null),  
('Задублированный', 'SysTypeBuyerStatusName_Duplicated', null),  
('Ожидает Подтверждения', 'SysTypeBuyerStatusName_PendingVerification', null),  
('Подтвержден', 'SysTypeBuyerStatusName_Verified', null),  
('Приостановлен', 'SysTypeBuyerStatusName_Suspended', null),  
('На Удержании', 'SysTypeBuyerStatusName_OnHold', null),  
('Архивный', 'SysTypeBuyerStatusName_Archived', null),  
('Отклонен', 'SysTypeBuyerStatusName_Rejected', null), 
('Ограниченный доступ', 'SysTypeBuyerStatusName_LimitedAccess', 'Учётка для тестов')
--rollback
commit




--премиум 
--Резидент не резидент 
