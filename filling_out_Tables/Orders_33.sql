
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
--15 Продан в рассрочку                             --15 Возврат					      32,13	 
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
(15,'32,13');



declare @i int = 1, @status nvarchar(300)
while @i <= 15
      begin
	    set @status = (select all_status from #Orders_status where id_status_order = @i)

		insert into #Orders_status_2(id_status_order,all_status)
		select @i,* from STRING_SPLIT(@status,',')  


	    set @i = @i + 1
	  end


/*
drop table if exists  #Orders_prioritet;

create table #Orders_prioritet 
(
ID_status_orders bigint   not null identity(1,1),
Name_orders nvarchar(200) not null              ,
Prioritet  float          null
);

drop table if exists  #Orders_prioritet_2;

create table #Orders_prioritet_2 
(
ID_orders        bigint   not null identity(1,1),
ID_status_orders bigint   not null,
Name_orders nvarchar(200) null              
);

insert into #Orders_prioritet(Name_orders,Prioritet) values 
 ('Завершена'                 ,20)     
,('В ожидании'				  ,10)		
,('В ожидании оплаты'		  ,5.5)		
,('На уточнении у Контрагента',5)		
,('Бухгалтерский контроль'	  ,0.5)		
,('Оплачен'					  ,5)	
,('На исправлении'			  ,2.5)		
,('На проверки Аудиторов'	  ,5)	    
,('В движении'				  ,10)		
,('На складе'				  ,3)		
,('В сборке'				  ,3)	
,('В ожидании отправки'		  ,5)	
,('На проверке SOX'			  ,2)	
,('Отменён'					  ,5)   
,('Возврат'					  ,5)   


declare @i_1 int = 1

while @i_1 <= 15000
     begin
	     insert into #Orders_prioritet_2(ID_status_orders,Name_orders)
		 select top 1 ID_status_orders,Name_orders
		 from #Orders_prioritet 
		 order by -log(rand(CHECKSUM(newid())))/ Prioritet

	     set @i_1 = @i_1 + 1

	 end


select
a_2.ID_status_orders
,a_2.Name_orders
,a_2.[Количество]
,a_2.[Визуалка]
,sum(a_2.[Количество]) over (order by a_2.ID_status_orders ) as 'Пошаговое_суммирование'
from 
     (select 
     a.Name_orders
	 ,a.ID_status_orders
     ,max(a.[rank]) as 'Количество'
	 ,REPLICATE('|',count(a.[rank])/50)   as 'Визуалка'
     from
          (select 
          Name_orders
		  ,ID_status_orders
          ,DENSE_RANK() over (partition by Name_orders order by  ID_orders)  as [rank]
          from #Orders_prioritet_2 
		  ) as a 
     group by  a.Name_orders,a.ID_status_orders) as a_2

--select * from #Orders_status_2

--select * from #Orders_prioritet_2

*/

select 
a.ID_Currency	
,a.[Колличество_по_одной_валюте]		
,a_2.[Самая_минимальная_дата]	
,a_2.[Самая_максимальная дата]
from
(
  select
  ID_Currency, 
  count(ID_Currency_Rate) as 'Колличество_по_одной_валюте'
  from Currency_Rate
  group by ID_Currency) as a
join 
(
  select 
  ID_Currency
  ,min(Valid_from) as 'Самая_минимальная_дата'
  ,max(Valid_to) as 'Самая_максимальная дата'
  from  Currency_Rate as a_2 
  group  by ID_Currency
) as a_2 on a_2.ID_Currency = a.ID_Currency 


select 
a.ID_product_measurement
,a.[Количество экземпляров]
,sum(a.[Количество экземпляров]) over (order by a.[Количество экземпляров] ) as 'Пошаговое_суммирование'
from 
(
select 
ID_product_measurement
,count(ID_Exemplar) as 'Количество экземпляров'
from All_Data_Exemplar
group by ID_product_measurement
) as a



select
ROW_NUMBER() over (order by a.ID_Exemplar asc) as 'Нумерация'
,rank() over (partition by a.ID_Exemplar order by a_2.id_status_order) as 'Нумерация_по_идентификатору'
,a.ID_Exemplar
,a.ID_Condition_of_the_item
,a.[Наименование_статуса_экземпляра]
,a_2.all_status
,a_2.id_status_order
,a_3.Name
,a.ID_product_measurement	
,a.[Тип_измерения_товара]
,a.Дата_создания_карточки_товара
,a.Дата_заведения_экземпляра_в_систему
,a.Дата_возврата
,a.ID_Currency
,a.Наименование_валюты_на_русском
--into #t_2
from All_Data_Exemplar as a
left join #Orders_status_2 as a_2 on a_2.all_status = a.ID_Condition_of_the_item
left join Orders_status as a_3         on a_3.Id_Status  = a_2.id_status_order    --Убираем экземпляры у которых статус не позволяет быть в заказах
where a_2.all_status  is null






drop table if exists #t

select
ROW_NUMBER() over (order by a.ID_Exemplar asc) as 'Нумерация'
,rank() over (partition by a.ID_Exemplar order by a_2.id_status_order) as 'Нумерация_по_идентификатору'
,a.ID_Exemplar
,a.ID_Condition_of_the_item
,a.[Наименование_статуса_экземпляра]
,a_2.all_status
,a_2.id_status_order
,a_3.Name
,a.ID_product_measurement	
,a.[Тип_измерения_товара]
,a.Дата_создания_карточки_товара
,a.Дата_заведения_экземпляра_в_систему
,a.Дата_возврата
,a.ID_Currency
,a.Наименование_валюты_на_русском
,a.Цена_без_НДС_экземпляра	
,a.Цена_экземпляра_с_НДС	
,a.Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	
,a.Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
into #t
from All_Data_Exemplar as a
left join #Orders_status_2 as a_2 on a_2.all_status = a.ID_Condition_of_the_item
join Orders_status as a_3         on a_3.Id_Status  = a_2.id_status_order    --Убираем экземпляры у которых статус не позволяет быть в заказах
where ID_product_measurement  = 5

drop table if exists #t_2

select
ROW_NUMBER() over (order by a.ID_Exemplar asc) as 'Нумерация'
,rank() over (partition by a.ID_Exemplar order by a_2.id_status_order) as 'Нумерация_по_идентификатору'
,a.ID_Exemplar
,a.ID_Condition_of_the_item
,a.[Наименование_статуса_экземпляра]
,a_2.all_status
,a_2.id_status_order
,a_3.Name
,a.ID_product_measurement	
,a.[Тип_измерения_товара]
,a.Дата_создания_карточки_товара
,a.Дата_заведения_экземпляра_в_систему
,a.Дата_возврата
,a.ID_Currency
,a.Наименование_валюты_на_русском
,a.Цена_без_НДС_экземпляра	
,a.Цена_экземпляра_с_НДС	
,a.Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	
,a.Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
into #t_2
from All_Data_Exemplar as a
left join #Orders_status_2 as a_2 on a_2.all_status = a.ID_Condition_of_the_item
join Orders_status as a_3         on a_3.Id_Status  = a_2.id_status_order    --Убираем экземпляры у которых статус не позволяет быть в заказах
where ID_product_measurement  != 5



drop index if exists index_t_cla on #t
drop index if exists index_t_cla_2 on #t_2

create clustered index index_t_cla on #t([Нумерация])
create clustered index index_t_cla_2 on #t_2([Нумерация])


drop table if exists #t_3

select
* 
into #t_3
from
(
select * from
(select 
t.*
, ROW_NUMBER() OVER (PARTITION BY t.ID_Exemplar ORDER BY  NEWID()) as 'Случайная_нумерация'
from #t t) as t_1
where t_1.[Случайная_нумерация] = 1
union all
select * from
(select 
t.*
, ROW_NUMBER() OVER (PARTITION BY t.ID_Exemplar ORDER BY  NEWID()) as 'Случайная_нумерация'
from #t_2 t) as t_1
where t_1.[Случайная_нумерация] = 1
) as a



declare @i_2 int = 0, @s  int = 0 , @n varchar(40), @mess varchar(8000), @err varchar(1000)

create table #Orders                                       
(
ID_Orders          bigint          not null identity (1,1),
ID_status          bigint          not null,
ID_TypeOrders      bigint          not null,
ID_Currency        bigint          not null,
ID_OrderAssignment BIGINT          NOT NULL,
ID_OrderCategory   BIGINT          NOT NULL,
Date               datetime        not null,
Payment_Date       datetime        null,    
Amount             decimal(15,2)   null,    
AmountCurr         decimal(15,2)   null,    
AmountNDS          decimal(15,2)   null,    
AmountCurrNDS      decimal(15,2)   null,    
Num                nvarchar(50)    not null,
[Description]      nvarchar(4000)  null, 
flag               int             null
);

declare
@ID_Exemplar                                                  bigint
,@ID_Condition_of_the_item                                    bigint
,@Наименование_статуса_экземпляра                             nvarchar(300)
,@all_status                                                  bigint
,@id_status_order                                             bigint
,@Name	                                                      nvarchar(300)
,@ID_product_measurement	                                  bigint
,@Тип_измерения_товара                                        nvarchar(50)	 
,@Дата_создания_карточки_товара                               datetime
,@Дата_заведения_экземпляра_в_систему                         datetime	
,@Дата_возврата	                                              datetime
,@ID_Currency                                                 bigint	
,@Наименование_валюты_на_русском                              nvarchar(200)
,@Цена_без_НДС_экземпляра	                                  decimal(15,2)
,@Цена_экземпляра_с_НДС	                                      decimal(15,2)
,@Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	  decimal(15,2)
,@Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис decimal(15,2)



declare Cur cursor  local fast_forward for

select  
 ID_Exemplar
,ID_Condition_of_the_item
,Наименование_статуса_экземпляра
,all_status
,id_status_order	
,[Name]	
,ID_product_measurement	
,Тип_измерения_товара	
,Дата_создания_карточки_товара	
,Дата_заведения_экземпляра_в_систему	
,Дата_возврата	
,ID_Currency	
,Наименование_валюты_на_русском
,Цена_без_НДС_экземпляра	
,Цена_экземпляра_с_НДС	
,Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	
,Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
from #t_3 
--where  Дата_возврата is not null and ID_product_measurement = 5
order by ID_Exemplar

open Cur

fetch next from Cur into
    @ID_Exemplar                                                 
	,@ID_Condition_of_the_item                                   
	,@Наименование_статуса_экземпляра                            
	,@all_status                                                 
	,@id_status_order                                            
	,@Name	                                                     
	,@ID_product_measurement	                                 
	,@Тип_измерения_товара                                       
	,@Дата_создания_карточки_товара                              
	,@Дата_заведения_экземпляра_в_систему                        
	,@Дата_возврата	                                             
	,@ID_Currency                                                
	,@Наименование_валюты_на_русском                             
	,@Цена_без_НДС_экземпляра	                                 
	,@Цена_экземпляра_с_НДС	                                     
	,@Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	 
	,@Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
while @@FETCH_STATUS = 0
     begin
	    begin try
		     
			 if @ID_product_measurement = 5
			     begin 
				     if @id_status_order = 15 and @Дата_возврата is not null
					    begin
						    
						end
				 end 

		     insert into #Orders(ID_status,ID_TypeOrders,ID_Currency,ID_OrderAssignment,ID_OrderCategory,[Date]              
			 ,Payment_Date,Amount,AmountCurr,AmountNDS,AmountCurrNDS,Num,[Description],flag) values
			 (

			 )
		    
			 --if exists (select a.flag from #RandomSelectedRows_2  as a where @Id_Item_2 = a.Id_Item and @ID_TypeItem_2 = ID_TypeItem and a.flag = 0)
			 --begin 
			 --     set @i_3 =  @i_3 + 1
			 --        update a set flag = 1 from #RandomSelectedRows_2  as a where @Id_Item_2 = a.Id_Item  and @ID_TypeItem_2 = ID_TypeItem and a.flag = 0 
			 --end

			 --select @s = count(0) from #RandomSelectedRows_2 where flag = 0
			 -- set @n = (select  
			 --           case  t.flag  when 1 then ' 1  Значения изменены' when 0  then ' 0  Значения не изменялись' end  
			 --           from #RandomSelectedRows_2 t  where t.id_item = @id_item_2)
			 -- set @mess = @n + ' - > ' + ' Order_Count_Item '  + Cast(@OrderCount_2 as varchar)  + ' Id_Item '  + Cast(@id_item_2 as varchar)  + ' --> ' + ' - ' + Cast(@i_2 as varchar) + ' / ' + Cast(@s as varchar)
			 -- RAISERROR(@mess,0,0) WITH NOWAIT
		end try

		begin catch

		end catch
	  
	    fetch next from Cur into
		@ID_Exemplar                                                 
		,@ID_Condition_of_the_item                                   
		,@Наименование_статуса_экземпляра                            
		,@all_status                                                 
		,@id_status_order                                            
		,@Name	                                                     
		,@ID_product_measurement	                                 
		,@Тип_измерения_товара                                       
		,@Дата_создания_карточки_товара                              
		,@Дата_заведения_экземпляра_в_систему                        
		,@Дата_возврата	                                             
		,@ID_Currency                                                
		,@Наименование_валюты_на_русском                             
		,@Цена_без_НДС_экземпляра	                                 
		,@Цена_экземпляра_с_НДС	                                     
		,@Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	 
		,@Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
	 end
close Cur
deallocate Cur



select * from #t_3


select  
 ID_Exemplar
,ID_Condition_of_the_item
,Наименование_статуса_экземпляра
,all_status
,id_status_order	
,[Name]	
,ID_product_measurement	
,Тип_измерения_товара	
,Дата_создания_карточки_товара	
,Дата_заведения_экземпляра_в_систему	
,Дата_возврата	
,ID_Currency	
,Наименование_валюты_на_русском
,Цена_без_НДС_экземпляра	
,Цена_экземпляра_с_НДС	
,Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	
,Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
from #t_3 
where 1 = 1 
--and ID_product_measurement = 5 
--and id_status_order = 15
and all_status in (32,13,16)

order by ID_Exemplar



		 --select top 1 ID_status_orders,Name_orders
		 --from #Orders_prioritet 
		 --order by -log(rand(CHECKSUM(newid())))/ Prioritet
---select * from Condition_of_the_item

select * from All_Data_Exemplar  
where 1=1 
--and ID_Exemplar = 265
and ID_Condition_of_the_item in (32,13,16)

select * from Exemplar
where  ID_Condition_of_the_item in (32,13,16)					
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

