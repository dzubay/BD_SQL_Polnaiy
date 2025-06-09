
use Magaz_DB_Poln_test

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
	  	WHERE object_id = OBJECT_ID('dbo.Orders') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Orders', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Orders

--select * from  dbo.Orders_audit

--delete from  Orders where ID_Orders is not null

begin tran
/*
--1	 Продан										 	--1	 Завершена                        1,28
--2	 Просрочен									 	--2	 В ожидании						  27,4,5
--3	 Задублирован								 	--3	 В ожидании оплаты				  34,5
--4	 На отгрузке								    --4	 На уточнении у Контрагента		  2,6,12,14,26,17,5,31,27,23
--5	 На складе									 	--5	 Бухгалтерский контроль			  5,24,27
--6	 Ожидает возврата							 	--6	 Оплачен						  33,15,25 
--7	 Потерян									 	--7	 На исправлении					  14,15,16,34,7,8,12,17,5,9,11,19,20,23,29,2,3,6,31,27
--8	 На проверке								 	--8	 На проверки Аудиторов		      14,15,16,34,7,8,12,17,5,31
--9	 Ожидает отгрузки							 	--9	 В движении						  30,11,25,4,19
--10 Зарезервирован								    --10 На складе						  5,9,7
--11 В пути										    --11 В сборке						  4,10
--12 Бракованный								 	--12 В ожидании отправки			  26,27,20
--13 Возвращён пользователем					 	--13 На проверке SOX				  2,3,6,7,8,12,14,17,31,27,23
--14 Уценён										    --14 Отменён					      9,11,16,19,20,23,29,2,17,3,34,31,27  
--15 Продан в рассрочку                             --15 Возврат					      32,13,16	 
--16 Не полностью оплачен по рассрочке			 
--17 Испорчен									 
--18 Срок годности просрочен					 
--19 Ожидает на пункте выдачи					 
--20 Ожидает курьера							 
--21 Черновик									 
--22 Редактируется								 
--23 Найдены несоответствия в карточке товара	 
--24 Перерасчёт цен								 
--25 Услуга активна								 
--26 Услуга ожидает активации					 
--27 Услуга приостановлена						 
--28 Услуга завершена                              
--29 Услуга отменена							 
--30 Услуга в процессе выполнения				 
--31 Услуга просрочена							 
--32 Услуга возвращена							 
--33 Услуга оплачена							 
--34 Услуга не оплачена		
*/

drop table if exists #Orders_status

create table #Orders_status 
(
id_status_order bigint  not null,
all_status  nvarchar(300) not null
);

drop table if exists #Orders_status_2

create table #Orders_status_2 
(
id_status_order bigint  not null,
all_status  nvarchar(300) not null
);


/*Примерно формируем данные по статусам экземляров, которые могут быть, в той или иной заявке в указанном статусе заказа (первый стобец)*/
insert into #Orders_status values
(1,'1,28'),	
(2,'27,4,5'),	
(3,'34,5'),	
(4,'2,6,12,14,26,17,5,31,27,23'),	
(5,'5,24,27'),	
(6,'33,15,25'),	
(7,'14,15,16,34,7,8,12,17,5,9,11,19,20,23,29,2,3,6,31,27'),	
(8,'14,15,16,34,7,8,12,17,5,31'),	
(9,'30,11,25,4,19'),	
(10,'5,9,7'),
(11,'4,10'),
(12,'26,27,20'),
(13,'2,3,6,7,8,12,14,17,31,27,23'),
(14,'9,11,16,19,20,23,29,2,17,3,34,31,27'),
(15,'32,13,16');



declare @i int = 1, @status nvarchar(300)
while @i <= 15
      begin
	    set @status = (select all_status from #Orders_status where id_status_order = @i)

		insert into #Orders_status_2(id_status_order,all_status)
		select @i,* from STRING_SPLIT(@status,',')  


	    set @i = @i + 1
	  end

select * from Exemplar

select
c_2.*
,e.ID_Exemplar
,e.Old_Price_no_NDS                 as 'Цена_без_НДС_экземпляра'
,e.Old_Price_NDS					as 'Цена_экземпляра_с_НДС'
,e.New_Price_NDS					as 'Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис'
,e.New_Price_no_NDS					as 'Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис'
,e.Date_Refund                      as 'Дата_возврата'
,e.Date_Created                     as 'Дата_заведения_экземпляра_в_систему'
,e.ID_Condition_of_the_item
,e_2.Name_Condition_of_the_item     as 'Наименование_статуса_экземпляра'
,e.Id_Item             
,e_3.Name_Item                      as 'Наименование_карточки_товара'
,e_3.Manufacturer                   as 'Наименование_производителя'
,e_3.Country                        as 'Страна_производителя'
,e_3.City							as 'Город_производителя'
,e_3.Adress							as 'Адрес_производителя'
,e.ID_Currency
,c.Full_name_rus                    as 'Наименование_валюты_на_русском'
,e_3.Quantity                       as 'Количество_товара'
,e_3.Date_Created                   as 'Дата_создания_карточки_товара'
,e_3.ID_product_measurement    
,t.Product_measurement_Name         as 'Тип_измерения_товара'
,e_3.ID_TypeItem
,t_2.TypeItemName                   as 'Тип_товара'
,e_3.ID_Species_Item
,t_3.SpeciesItemName                as 'Вид_товара'
,e_3.Id_Item_Status
,i.ItemStatus                       as 'Наименование_статуса_товара'
,e.ID_Storage_location          
,s.Name                             as 'Наименование_места_хранения'
,s.ID_Type_Storage_location
,s_2.Name_Type_Storage_location     as 'Наименование_типа_места_хранения'
,s.Id_Status
,s_3.TypeStoragelocationName        as 'Статус_места_хранения'
,s.Id_Country
,co.Name_Country                    as 'Наименование_страны_места_хранения'
,s.City                             as 'Город_места_хранения'
,s.Adress                           as 'Адрес_места_хранения'
from Exemplar  e
left join Condition_of_the_item as e_2          on e_2.ID_Condition_of_the_item = e.ID_Condition_of_the_item 
left join item as e_3                           on e_3.ID_item                  = e.ID_item 
left join Currency as c                         on c.ID_Currency                = e.ID_Currency
left join Type_of_product_measurement as t      on t.ID_product_measurement     = e_3.ID_product_measurement
left join TypeItem as t_2                       on t_2.Id_TypeItem              = e_3.ID_TypeItem
left join Species_Item as t_3                   on t_3.ID_Species_Item          = e_3.ID_Species_Item 
left join Item_status as i                      on i.Id_Item_Status             = e_3.Id_Item_Status
left join Storage_location as s                 on s.ID_Storage_location        = e.ID_Storage_location
left join Type_Storage_location as s_2          on s_2.ID_Type_Storage_location = s.ID_Type_Storage_location
left join Storage_location_status as s_3        on s_3.Id_Status                = s.Id_Status
left join Country as co                         on co.Id_Country                = s.Id_Country
left join #Orders_status_2 as c_2               on c_2.all_status               = e.ID_Condition_of_the_item


--select * from All_Data_Exemplar

--select * from  #Orders_status_2 order by id_status_order,all_status


					 



/*
create table Orders                                                                 --Заказ
(
ID_Orders          bigint          not null identity (1,1)  check(Id_Orders !=0),      -- ID заказа
ID_status          bigint          not null,                                           -- ID статуса заказа
ID_TypeOrders      bigint          not null,                                           -- ID Типа заказа
ID_Currency        bigint          not null,                                           -- ID Валюта заказа
ID_OrderAssignment BIGINT          NOT NULL,                                           -- ID_Принадлежности_заказа_к_системе
ID_OrderCategory   BIGINT          NOT NULL,                                           -- ID Категории заказа
Date               datetime        not null default  getDate(),                        -- Дата создания заказа
Payment_Date       datetime        null,                                               -- Дата Оплаты заказа
Amount             decimal(10,2)   null,                                               -- Сумма заказа
AmountCurr         decimal(10,2)   null,                                               -- Сумма заказа c начислением коммисии 
AmountNDS          decimal(10,2)   null,                                               -- Сумма заказа c начисленным НДС
AmountCurrNDS      decimal(10,2)   null,                                               -- Сумма заказа c начислением коммисии и НДС
Num                nvarchar(50)    not null,                                           -- Номер заказа
[Description]      nvarchar(4000)  null,                                               -- Комментарий
constraint  PK_ID_Orders               primary key (ID_Orders)
)  on Orders_Group
go

*/

