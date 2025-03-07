
-- Cформированный через  https://chat.deepseek.com/
/*  
Добавь к данному слову - SysTypeBuyerTypeName,  продолжение на логическом умозаключении через "_",
к каждой строчке ниже , на английском языке, исходя из названия строки.
Физическое лицо,  
Юридическое лицо,  
Индивидуальный предприниматель,   
Государственные или муниципальные предприятия,
Кооперативы,
Некоммерческие организации,
Корпоративный клиент,        
Партнер,  
Гость,  
Пробный пользователь,  
Агент,  
(Оптовый поставщик)Дистрибьютор,  
(Перекуп)Реселлер,  
(Пустоперекуп)Дропшиппер,  
(Портнёр по реализации)Аффилиат,   
Анонимный покупатель,  
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
	  	WHERE object_id = OBJECT_ID('dbo.Buyer_Type') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Buyer_Type', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Buyer_Type

--select * from  dbo.Buyer_Type_audit

--delete from  Buyer_Type where Id_Buyer_Type is not null


begin tran
insert into  Buyer_Type(Name,SysTypeBuyerTypeName,Description) values 
('Физическое лицо', 'SysTypeBuyerTypeName_Individual', null),  
('Юридическое лицо', 'SysTypeBuyerTypeName_LegalEntity', null),  
('Индивидуальный предприниматель', 'SysTypeBuyerTypeName_Entrepreneur', null),  
('Государственные или муниципальные предприятия', 'SysTypeBuyerTypeName_StateEnterprise', null),  
('Кооперативы', 'SysTypeBuyerTypeName_Cooperative', null),  
('Некоммерческие организации', 'SysTypeBuyerTypeName_NonProfit', null),  
('Корпоративный клиент', 'SysTypeBuyerTypeName_Corporate', null),  
('Партнер', 'SysTypeBuyerTypeName_Partner', null),  
('Гость', 'SysTypeBuyerTypeName_Guest', null),  
('Пробный пользователь', 'SysTypeBuyerTypeName_TrialUser', null),  
('Агент', 'SysTypeBuyerTypeName_Agent', null),  
('(Оптовый поставщик)Дистрибьютор', 'SysTypeBuyerTypeName_Distributor', null),  
('(Перекуп)Реселлер', 'SysTypeBuyerTypeName_Reseller', null),  
('(Пустоперекуп)Дропшиппер', 'SysTypeBuyerTypeName_Dropshipper', null),  
('(Партнёр по реализации)Аффилиат', 'SysTypeBuyerTypeName_Affiliate', null),  
('Анонимный покупатель', 'SysTypeBuyerTypeName_Anonymous', null)
--rollback
commit




--премиум 
--Резидент не резидент 
