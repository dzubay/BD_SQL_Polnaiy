
-- Cформированный через  https://chat.deepseek.com/
/*  
Первый столбец должен быть с наименованием на русском. 
Добавь к данному слову - SysItemStatusName,  продолжение на логическом умозаключении, на английском во втором столбце. 
к каждой строчке ниже , исходя из названия строки.
'Черновик',
'На проверке',
'Активный',
'Неактивный',
'Архивный',
'На модерации',
'Отклонён',
'В процессе обновления',
'Заблокирован',
'Ожидает подтверждения',
'Ожидает карретировки',
'Задублированная карточка',

Сделай пожалуйста всё в три столбца, названия в одинарных кавычках, и через запятую, третий столбец заканчивается на null,
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
	  	WHERE object_id = OBJECT_ID('dbo.Item_status') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Item_status', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Item_status

--delete from  Item_status where Id_Item_Status is not null


begin tran
insert into  Item_status(ItemStatus,SysItemStatusName,Description) values 
('Черновик', 'SysItemStatusDraft', null),
('На проверке', 'SysItemStatusUnderReview', null),
('Активный', 'SysItemStatusActive', null),
('Неактивный', 'SysItemStatusInactive', null),
('Архивный', 'SysItemStatusArchived', null),
('На модерации', 'SysItemStatusUnderModeration', null),
('Отклонён', 'SysItemStatusRejected', null),
('В процессе обновления', 'SysItemStatusUpdating', null),
('Заблокирован', 'SysItemStatusBlocked', null),
('Ожидает подтверждения', 'SysItemStatusAwaitingConfirmation', null),
('Ожидает корректировки', 'SysItemStatusAwaitingCorrection', null),
('Задублированная карточка', 'SysItemStatusDuplicated', null)
--rollback
commit
