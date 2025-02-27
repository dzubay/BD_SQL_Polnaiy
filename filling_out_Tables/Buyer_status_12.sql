
-- Cформированный через  https://chat.deepseek.com/
/*  
Добавь к данному слову - SysTypeBuyerStatusName,  продолжение на логическом умозаключении,
к каждой строчке ниже , исходя из названия строки.
('Действующий')
,('В архиве')
,('Заблокирован')
,('В ожидании проверки СБ')
,('На согласовании')
,('Задублированный')
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

--delete from  Buyer_status where Id_Status is not null


begin tran 
insert into  Buyer_status(Name,SysTypeBuyerStatusName,Description)
values 
('Действующий', 'SysTypeBuyerStatusName_Active', null),
('В архиве', 'SysTypeBuyerStatusName_Archived', null),
('Заблокирован', 'SysTypeBuyerStatusName_Blocked', null),
('В ожидании проверки СБ', 'SysTypeBuyerStatusName_AwaitingSecurityCheck', null),
('На согласовании', 'SysTypeBuyerStatusName_ApprovalInProgress', null),
('Задублированный', 'SysTypeBuyerStatusName_Duplicated', null)
--rollback
commit
