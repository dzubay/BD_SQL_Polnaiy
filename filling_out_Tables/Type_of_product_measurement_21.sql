
-- Cформированный через  https://chat.deepseek.com/
/*  
Первый столбец должен быть с наименованием на русском. 
Добавь к данному слову - SysProductMeasurementName,  продолжение на логическом умозаключении, на английском во втором столбце. 
к каждой строчке ниже , исходя из названия строки.
Объём,
Количество,
Вес,
Длина,
Время,
Количество в упаковках,
Количество в палетах, 
Нестандартный, 
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
	  	WHERE object_id = OBJECT_ID('dbo.Type_of_product_measurement') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Type_of_product_measurement', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Type_of_product_measurement

--delete from  Type_of_product_measurement where ID_product_measurement is not null


begin tran
insert into  Type_of_product_measurement(Product_measurement_Name,SysProductMeasurementName,Description) values 
('Объём', 'SysProductMeasurementVolume', null),
('Количество', 'SysProductMeasurementQuantity', null),
('Вес', 'SysProductMeasurementWeight', null),
('Длина', 'SysProductMeasurementLength', null),
('Время', 'SysProductMeasurementTime', null),
('Количество в упаковках', 'SysProductMeasurementPackQuantity', null),
('Количество в палетах', 'SysProductMeasurementPalletQuantity', null),
('Нестандартный', 'SysProductMeasurementNonStandard', null)
--rollback
commit
