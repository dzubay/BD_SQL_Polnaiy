

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
	  	WHERE object_id = OBJECT_ID('dbo.Order_category') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Order_category', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Order_category

--select * from  dbo.Order_category_audit

--delete from  Order_category where ID_OrderCategory is not null




begin tran 
insert into Order_category(OrderCategoryName,Abbreviation,OrderCategorySysName,[Description]) values
('Заказ оформлен с приложения или сайта','ЗОПС','OrderCategorySysName_OnlineOrAppOrder',null)
,('Закас оформлен по телефону','ЗОТ','OrderCategorySysName_PhoneOrder',null)
,('Заказ оформлен сотрудником','ЗОС','OrderCategorySysName_EmployeeOrder',null) 
,('Заказ оформлен в офисе компании','ЗОС','OrderCategorySysName_InPersonOrder',null)
--rollback
commit
