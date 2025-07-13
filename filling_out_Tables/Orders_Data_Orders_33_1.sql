
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
	  	WHERE object_id = OBJECT_ID('dbo.Data_Orders') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Data_Orders', RESEED, 0)
	  end
--rollback
commit
go
*/


begin tran
/*
--1	 Продан										 	--1	 Завершена                        1,28
--2	 Просрочен									 	--2	 В ожидании						  27,4
--3	 Задублирован								 	--3	 В ожидании оплаты				  34,15
--4	 На отгрузке								    --4	 На уточнении у Контрагента		  2,6,12,14,26,17,5,31,27,23
--5	 На складе									 	--5	 Бухгалтерский контроль			  5,24,27
--6	 Ожидает возврата							 	--6	 Оплачен						  33,15 
--7	 Потерян									 	--7	 На исправлении					  14,15,16,34,7,8,12,17,5,9,11,19,20,23,29,2,3,6,31,27,4,10
--8	 На проверке								 	--8	 На проверки Аудиторов		      9,11,16,19,23,29,2,17,3,31,27,4,5,10,9,7,34 
--9	 Ожидает отгрузки							 	--9	 В движении						  30,11,25,4,19,26
--10 Зарезервирован								    --10 На складе						  5,9
--11 В пути										    --11 В сборке						  4,10
--12 Бракованный								 	--12 В ожидании отправки			  20,19,9,4
--13 Возвращён пользователем					 	--13 На проверке SOX				  14,15,16,34,7,8,12,17,5,9,11,19,20,23,29,2,3,6,31,27,4,10
--14 Уценён										    --14 Отменён					      9,11,16,19,23,29,2,17,3,31,27,4,5,10,9,7,34  
--15 Продан в рассрочку                             --15 Возврат					      32,13	 
--16 Не полностью оплачен по рассрочке			 
--17 Испорчен									 
--18 Срок годности просрочен					 
--19 Ожидает на пункте выдачи					 
--20 Ожидает курьера							    --По товарам 2,11,10,3,14,8  --Заводится время оплаты 6,12,9,1,5,7,13,15  --7 
--21 Черновик									    --По услугам 2,4,3,14,8,     --Заводится время оплаты 6,9,1,5,7,13,15     --7
--22 Редактируется								 
--23 Найдены несоответствия в карточке товара	    --Экземпляры без мтатуса заявки 18,21,22,24
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
(2,'27,4'),	
(3,'34,15'),	
(4,'2,6,12,14,26,17,5,31,27,23'),	
(5,'5,24,27'),	
(6,'33,15'),	
(7,'14,15,16,34,7,8,12,17,5,9,11,19,20,23,29,2,3,6,31,27,4,10'),	
(8,'9,11,16,19,23,29,2,17,3,31,27,4,5,10,9,7,34'),	
(9,'30,11,25,4,19,26'),	
(10,'5,9'),
(11,'4,10'),
(12,'20,19,9,4'),
(13,'14,15,16,34,7,8,12,17,5,9,11,19,20,23,29,2,3,6,31,27,4,10'),
(14,'9,11,16,19,23,29,2,17,3,31,27,4,5,10,9,7,34'),
(15,'32,13');



declare @i int = 1, @status nvarchar(300)
while @i <= 15
      begin
	    set @status = (select all_status from #Orders_status where id_status_order = @i)

		insert into #Orders_status_2(id_status_order,all_status)
		select @i,* from STRING_SPLIT(@status,',')  


	    set @i = @i + 1
	  end

go
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

*/

--Для проверки

/*
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


*/



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

go


/* Для правильной сортировки */
drop index if exists index_t_cla on #t
drop index if exists index_t_cla_2 on #t_2

create clustered index index_t_cla on #t([Нумерация])
create clustered index index_t_cla_2 on #t_2([Нумерация])


drop table if exists #t_3


select * 
into #t_3
from
(select 
t.*
, ROW_NUMBER() OVER (PARTITION BY t.ID_Exemplar ORDER BY  NEWID()) as 'Случайная_нумерация'
from #t t where t.id_status_order = 15) as t_1
where t_1.[Случайная_нумерация] = 1

go

drop table if exists #t_3_1


select *
into  #t_3_1
from
(select 
t.*
, ROW_NUMBER() OVER (PARTITION BY t.ID_Exemplar ORDER BY  NEWID()) as 'Случайная_нумерация'
from #t_2 t where t.id_status_order = 15) as t_1
where t_1.[Случайная_нумерация] = 1



go
/*Формирование заказов с статусом 15 */

/*
Выборка групировка по дням , учитывая статус заказа 15 и групмровка групп экземпляров по Дате_возврата и по Валюте, со статусами экземпляров 32, 13  
то есть собирвем в одну кипу экземляры которые могут быть в одном заказе по времени возврата , но с одинаковой валютой, если  дата возврата 
будет одна и таже в разных валютах, то экземпляр с другой валютой переходит в другую кипу 
*/


drop table if exists #t_4;

WITH BaseGroups AS (
    SELECT 
        CONVERT(date, Дата_возврата) AS Дата,
		ID_Currency,
        CASE 
            WHEN Наименование_статуса_экземпляра IN ('Возвращён пользователем', 'Услуга возвращена') THEN 'Возвращён пользователем + Услуга возвращена'
            ELSE Наименование_статуса_экземпляра
        END AS Группа_статусов,
        id_status_order AS Статус_заказа,
        COUNT(ID_Exemplar) AS Количество_экземпляров,
        SUM(Цена_без_НДС_экземпляра) AS Цена_без_НДС_экземпляра,
		SUM(Цена_экземпляра_с_НДС) AS Общая_стоимость_с_НДС,
		SUM(Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис) AS Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис,
		SUM(Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис) AS Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
    FROM #t_3
    GROUP BY GROUPING SETS (
        (CONVERT(date, Дата_возврата), 
        CASE WHEN Наименование_статуса_экземпляра IN ('Возвращён пользователем', 'Услуга возвращена') THEN 'Возвращён пользователем + Услуга возвращена'
		ELSE Наименование_статуса_экземпляра END,				    
        id_status_order,ID_Currency
        ),
        (CONVERT(date, Дата_возврата), id_status_order,ID_Currency),
        (CONVERT(date, Дата_возврата),ID_Currency)
    )
)
SELECT 
    bg.Дата, 
	bg.ID_Currency,
    bg.Группа_статусов,
    bg.Статус_заказа,
    bg.Количество_экземпляров,
    ids.Список_ID,
	bg.Цена_без_НДС_экземпляра,
    bg.Общая_стоимость_с_НДС,
	bg.Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис,
	bg.Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
	into #t_4
FROM BaseGroups bg
OUTER APPLY (
    SELECT STRING_AGG(CAST(t.ID_Exemplar AS VARCHAR), ', ') AS Список_ID
    FROM #t_3 t
    WHERE 
        (bg.Дата IS NULL OR CONVERT(date, t.Дата_возврата) = bg.Дата)
        AND (bg.Группа_статусов IS NULL OR 
             CASE WHEN t.Наименование_статуса_экземпляра IN ('Возвращён пользователем', 'Услуга возвращена') THEN 'Возвращён пользователем + Услуга возвращена' 
                  ELSE t.Наименование_статуса_экземпляра END = bg.Группа_статусов)
        AND (bg.Статус_заказа IS NULL OR t.id_status_order = bg.Статус_заказа)
		and bg.ID_Currency = ID_Currency
) ids
--where  Статус_заказа = 15
ORDER BY 
    bg.Дата,
    bg.Группа_статусов,
    bg.Статус_заказа;


go

drop table if exists #t_4_1;

WITH BaseGroups AS (
    SELECT 
        CONVERT(date, Дата_возврата) AS Дата,
		ID_Currency,
        CASE 
            WHEN Наименование_статуса_экземпляра IN ('Возвращён пользователем', 'Услуга возвращена') THEN 'Возвращён пользователем + Услуга возвращена'
            ELSE Наименование_статуса_экземпляра
        END AS Группа_статусов,
        id_status_order AS Статус_заказа,
        COUNT(ID_Exemplar) AS Количество_экземпляров,
        SUM(Цена_без_НДС_экземпляра) AS Цена_без_НДС_экземпляра,
		SUM(Цена_экземпляра_с_НДС) AS Общая_стоимость_с_НДС,
		SUM(Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис) AS Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис,
		SUM(Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис) AS Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
    FROM #t_3_1
    GROUP BY GROUPING SETS (
        (CONVERT(date, Дата_возврата), 
        CASE WHEN Наименование_статуса_экземпляра IN ('Возвращён пользователем', 'Услуга возвращена') THEN 'Возвращён пользователем + Услуга возвращена'
		ELSE Наименование_статуса_экземпляра END,				    
        id_status_order,ID_Currency
        ),
        (CONVERT(date, Дата_возврата), id_status_order,ID_Currency),
        (CONVERT(date, Дата_возврата),ID_Currency)
    )
)
SELECT 
    bg.Дата, 
	bg.ID_Currency,
    bg.Группа_статусов,
    bg.Статус_заказа,
    bg.Количество_экземпляров,
    ids.Список_ID,
	bg.Цена_без_НДС_экземпляра,
    bg.Общая_стоимость_с_НДС,
	bg.Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис,
	bg.Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
	into #t_4_1
FROM BaseGroups bg
OUTER APPLY (
    SELECT STRING_AGG(CAST(t.ID_Exemplar AS VARCHAR), ', ') AS Список_ID
    FROM #t_3_1 t
    WHERE 
        (bg.Дата IS NULL OR CONVERT(date, t.Дата_возврата) = bg.Дата)
        AND (bg.Группа_статусов IS NULL OR 
             CASE WHEN t.Наименование_статуса_экземпляра IN ('Возвращён пользователем', 'Услуга возвращена') THEN 'Возвращён пользователем + Услуга возвращена' 
                  ELSE t.Наименование_статуса_экземпляра END = bg.Группа_статусов)
        AND (bg.Статус_заказа IS NULL OR t.id_status_order = bg.Статус_заказа)
		and bg.ID_Currency = ID_Currency
) ids
--where  Статус_заказа = 15
ORDER BY 
    bg.Дата,
    bg.Группа_статусов,
    bg.Статус_заказа;

go

/*Убираем ненужные строки с NULL, ну и за одно  пронумеровываем их, не особо важно, но не стал заморачиваться*/

	drop table if exists #t_5
	 
    select
	row_number() over (partition by t.Группа_статусов order by t.Дата) as 'Нумерация'
	,t.* 
	into #t_5
	from(
	select *
	from #t_4  t
	where Статус_заказа = 15 and Количество_экземпляров = 1 and Группа_статусов is not null
	Union all
	select * 
	from #t_4  
	where Статус_заказа = 15 and Количество_экземпляров > 1 and Группа_статусов is not null
	Union all
	select *
	from #t_4_1  t
	where Статус_заказа = 15 and Количество_экземпляров = 1 and Группа_статусов is not null
	Union all
	select * 
	from #t_4_1  
	where Статус_заказа = 15 and Количество_экземпляров > 1 and Группа_статусов is not null
	) as t order by t.Дата,t.Количество_экземпляров


go


/*Теперь дополнительно к каждой нумерации сформированных кип, добавляем эти же ID экземпляров и услуг, что бы сформировать по каждой кипе заказ, и по каждому заказу в таблицу Orders_data строки,
к какому заказу относится, тот или иной экземпляр */

   
   drop table if exists  #Razgrupirovka

   create table #Razgrupirovka 
   (
   Нумерация	int              null
   ,ID          bigint           null
   ,flag        int              null    DEFAULT 0  -- <- Здесь устанавливаем значение по умолчанию
   )

   declare @Summ int = (select count(Нумерация) from #t_5)

   declare @e int = 1,   @Id_5 nvarchar(500)
   declare @e_1 int = 1, @Id_6 nvarchar(500),@kolichestvo int = 0
   declare @tab table (nomer int, id bigint)

   while @e <= @Summ
      begin
	    set @Id_5 = (select Список_ID from #t_5 where Нумерация = @e)
		set @kolichestvo = (select Количество_экземпляров from #t_5 where Нумерация = @e) 

		if @kolichestvo = 1
		     begin 
		       	insert into #Razgrupirovka(Нумерация,ID)
		        select @e,*  from STRING_SPLIT(@Id_5,',')
				
		     end
        else
		     begin	
			     delete from @tab;
			     
			     
			     set @Id_6 = (select Список_ID from #t_5 where Нумерация = @e )

				 insert into @tab
			     select @e,* from STRING_SPLIT(@Id_6,',')

                 insert into #Razgrupirovka(Нумерация,ID) 
				 select * from @tab    
				 
			 end 
		 set @e = @e + 1
	  end

go
	
	  /*Добавляем к дате возврата конечное время, и отбрасываем ненужные строки дубликаты*/

drop table if exists #t_6


select 
 t_2.Нумерация 
,t.Статус_заказа
,t.ID_Currency
,t_2.ID
,t_3.Дата_создания_карточки_товара
,t_3.Дата_заведения_экземпляра_в_систему	
,CAST(CAST(t.Дата AS date) AS datetime) + CAST('23:59:59.997' AS datetime) AS 'Дата_возврата'		
,t.Группа_статусов		
,t.Количество_экземпляров	
,t.Список_ID	
,t.Цена_без_НДС_экземпляра	
,t.Общая_стоимость_с_НДС	
,t.Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	
,t.Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
,0 flag
into #t_6
from  #t_5  t 
left join  #Razgrupirovka t_2 on t.Нумерация = t_2.Нумерация
left join  All_Data_Exemplar t_3 on t_3.ID_Exemplar = t_2.ID
order by T_2.Нумерация

go

/*Формируем единственную строку по нумерации из одинвкоывого количества строк нумерации*/
drop table if exists #t_7


select 
t_2.*
into #t_7
from
(select  distinct Нумерация from #t_6 ) as t
outer apply (select top 1 * from #t_6 where Нумерация = t.Нумерация )  as t_2
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------Заполнение временных таблиц, сформированные строки по заказам и экземплярам---------------------------------------------------------------------------------------------
----------------------УЧИТЫВАЕМ ГЛАВНОЙ МОМЕНТ, ДАТА ВОЗВРАТА СЧИТАЕТСЯ КАК ДАТА, ВРЕМЯ НЕ УЧИТЫВАЕТСЯ, ЛОГИКА ТАКАЯ ПРОСТОЯ!!!!!!!!!----------------------------------------------------
------------------------------------------ПО ЭТОМУ МЫ ВСЕМ ДАТАМ ВОЗВРАТА ДОБАВЛЯЕМ КОНЕЧНОЕ ВРЕМЯ  '23:59:59.997'-----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


declare @i_2 int = 0, @s  int = 0 , @n varchar(40), @mess varchar(8000), @err varchar(1000)

drop table if exists #Orders

create table #Orders                                       
(
ID_Orders          bigint          not null,
ID_status          bigint          not null,
ID_TypeOrders      bigint          not null,
ID_Currency        bigint          not null,
ID_OrderAssignment BIGINT          NOT NULL,
ID_OrderCategory   BIGINT          NULL,
Date               datetime        null,
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
@Нумерация                                                      int           
,@ID                                                            bigint		  
,@Дата_создания_карточки_товара                                 datetime	  
,@Дата_заведения_экземпляра_в_систему                           datetime	  
,@Дата_возврата                                                 datetime	  
,@ID_Currency	                                                bigint		  
,@Группа_статусов	                                            nvarchar(500) 
,@Статус_заказа	                                                bigint		  
,@Количество_экземпляров	                                    int			  
,@Список_ID	                                                    nvarchar(1000)
,@Цена_без_НДС_экземпляра	                                    decimal(15,2) 
,@Общая_стоимость_с_НДС	                                        decimal(15,2) 
,@Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	    decimal(15,2) 
,@Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис   decimal(15,2) 
,@flag                                                          int;


declare 
@ID_OrderAssignment bigint
,@ID_OrderCategory  bigint
,@Date              datetime, @RandomDateTime datetime, @RandomDate datetime
,@Payment_Date      datetime
,@date_raznica      datetime, @Date_Refund  datetime  
,@RandomDate_2      datetime
,@num               nvarchar(50)
,@RandomLogin       nvarchar(10)


declare Cur cursor  local fast_forward for


select * from #t_7 

open Cur

fetch next from Cur into
 @Нумерация 
 ,@Статус_заказа
 ,@ID_Currency	
 ,@ID                                                         
 ,@Дата_создания_карточки_товара                              
 ,@Дата_заведения_экземпляра_в_систему                        
 ,@Дата_возврата                                                                                           
 ,@Группа_статусов	                                          	                                             
 ,@Количество_экземпляров	                                 
 ,@Список_ID	                                                 
 ,@Цена_без_НДС_экземпляра	                                 
 ,@Общая_стоимость_с_НДС	                                     
 ,@Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	 
 ,@Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
 ,@flag                                                       
while @@FETCH_STATUS = 0
     begin
	    begin try
		     

			 set @ID_OrderAssignment = (select top 1 ID_OrderAssignment from Order_Assignment order by NEWID())
			 set @ID_OrderCategory  = (select top 1 ID_OrderCategory from Order_category order by NEWID())
			 
			 set @RandomDate = null
			 set @date = null
			 set @RandomDateTime = null
			 set @date_raznica = null
			 set @Payment_Date = null
			 /*
			 Проверяем, если дата заведения экземпляра меньше даты возврата, то формируем 
			 случаную дату с временем в диапозоне этих двух одинаковых дат, для формирования даты создания Заявки
			 */
			 if  (@Дата_заведения_экземпляра_в_систему < @Дата_возврата)
			   begin
			       /*Формируем дату и время для даты создания заказа  - @date*/
			       exec GetRandomDateTimeBetween @Дата_заведения_экземпляра_в_систему,@Дата_возврата, @RandomDate output

				   set @date = @RandomDate

				   /*
				   Если вновь сформированная дата создания заказа равна Дате возврата то минус 100 секунд
				   */
				   if  (@RandomDate = @Дата_возврата)
				       begin 
					       set @RandomDate = dateadd (SECOND, -100,@RandomDate)
						   set @date = @RandomDate 
					   end 

                   
			    end
            
			/*
			Если дата создания заказа не равняется Null, то начинаем формировать дату оплаты заказа
			которая должна лежать в диапозоне от даты содания заказа, до даты возврата
			*/
			if @date is not null
			    begin
				    set @RandomDate = null
					/*Формируем случайную дату оплаты заказа , в диапозоне от даты содания заказа, до даты возврата*/
				    exec GetRandomDateTimeBetween @date,@Дата_возврата, @RandomDate output

				    set @Payment_Date = @RandomDate	
					/*
					Если дата и время - Дата оплаты заказа  равна  Дате создания заказа, то прибовляем 100 секунд к Дате оплаты заказа,
					так как она должна быть больше Даты создания заявки, но меньше Даты возврата
					*/
					if  (@Payment_Date = @date )
					   begin
					        set @Payment_Date = dateadd (SECOND, 100,@Payment_Date);	
					   end 
                    /*
					Здесь наоборот - Дата оплаты заказа  равна  Дате возврата, то минусуем 100 секунд от Даты оплата заказа,
					так как она должна быть меньше Даты Возврата, но Даты создания заявки
					*/
					else if (@Payment_Date = @Дата_возврата )
					   begin
					         set @Payment_Date = dateadd (second, -100,@Payment_Date)
					   end
			    end
             
             exec RandomLogin_RUS_AlF 2,0,  @RandomLogin output
 
			 set @num = (select  cast(round(rand()* 999999,0)as nvarchar(50)))
			 
			 set @num =CONCAT(@RandomLogin,@num)

			 insert into #Orders(ID_Orders,ID_status,ID_TypeOrders,ID_Currency,ID_OrderAssignment,ID_OrderCategory,[Date]
			 ,Payment_Date,Amount,AmountCurr,AmountNDS,AmountCurrNDS,Num,[Description],flag) values
			 (
			  @Нумерация
			  ,@Статус_заказа
			  ,2                   -- Это тип "Возвратный заказ" - 2
			  ,@ID_Currency
			  ,@ID_OrderAssignment
			  ,@ID_OrderCategory
			  ,@date
			  ,@Payment_Date
			  ,@Цена_без_НДС_экземпляра
			  ,@Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
			  ,@Общая_стоимость_с_НДС	                                  
			  ,@Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис
			  ,@num
			  ,null
			  ,@flag
			 )


			 
			 

			 if exists (select a.flag from #t_7  as a where @Нумерация = a.Нумерация and a.flag = @flag)
			 begin 
			      set @i_2 =  @i_2 + 1
			         update a set a.flag = 1 from #t_7  as a where @Нумерация = a.Нумерация  and a.flag = @flag 
			 end
			 
			 set @s =  (select  count(*) from #t_7 where flag = 0)
			 
			  set @n = (select  
			            case  t.flag  when 1 then ' 1  Значения изменены' when 0  then ' 0  Значения не изменялись' end  
			            from #t_7 t  where @Нумерация = t.Нумерация )
			  set @mess = @n + ' - > ' + ' ID_Order '  + Cast(@Нумерация as varchar)  + ' --> ' + Cast(@i_2 as varchar) + ' / ' + Cast(@s as varchar)
			  RAISERROR(@mess,0,0) WITH NOWAIT
		end try

		begin catch
		       if xact_state() in (1, -1) 
		          begin
			        ROLLBACK TRAN
			      end
               SELECT 
		        	ERROR_NUMBER() AS ErrorNumber,
		        	ERROR_SEVERITY() AS ErrorSeverity,
		        	ERROR_STATE() as ErrorState,
		        	ERROR_PROCEDURE() as ErrorProcedure,
		        	ERROR_LINE() as ErrorLine,
		        	ERROR_MESSAGE() as ErrorMessage;
		end catch
	  
	    fetch next from Cur into
         @Нумерация  
		 ,@Статус_заказа
         ,@ID_Currency	
		 ,@ID                                                         
		 ,@Дата_создания_карточки_товара                              
		 ,@Дата_заведения_экземпляра_в_систему                        
		 ,@Дата_возврата                                              	                                             
		 ,@Группа_статусов	                                         	                                             
		 ,@Количество_экземпляров	                                 
		 ,@Список_ID	                                                 
		 ,@Цена_без_НДС_экземпляра	                                 
		 ,@Общая_стоимость_с_НДС	                                     
		 ,@Цена_экземпляра_с_НДС_после_начисления_коммисии_за_сервис	 
		 ,@Цена_экземпляра_без_НДС_после_начисления_коммисии_за_сервис
		 ,@flag                                                       
	 end
close Cur
deallocate Cur

/*Проверка Дат в временной таблице */
/*
select 
id_orders
,t_3.ID
,o.ID_OrderCategory
from  
#Orders as o
inner join 
(select 
t_2.*
from
(select  distinct Нумерация from #t_6 ) as t
outer apply (select top 1 * from #t_6 where Нумерация = t.Нумерация )  as t_2)as o_2 
on o_2.Нумерация = o.ID_Orders
inner join #Razgrupirovka t_3 on t_3.Нумерация = o.ID_Orders
*/


go


------------------------------------------------------------Заполняем таблицу Data_Orders имеющимеся временными данными из временных таблиц-------------------------------------------------

declare @i_3 int = 0 ,@s_2 int = 0 , @n_2 varchar(40), @mess_2 varchar(8000), @err_2 varchar(1000)

drop table if exists #Data_Orders

create table  #Data_Orders
(
Id_Data_Orders          bigint          not null identity (1,1)
,ID_Employee            bigint          null
,ID_Orders              bigint          not null
,Id_buyer               bigint          not null
,ID_Exemplar            bigint          not null
,ID_Transaction         bigint          null
,Date_Data_Orders       datetime        not null  default getdate()
,[Description]          nvarchar(4000)  null
);

declare 
@Нумерация_2  bigint
,@id_2        bigint
,@Flag_2      int

declare
@ID_Employee_2         bigint    
,@Id_buyer_2           bigint  
,@Date_Data_Orders_2   datetime



declare Cur_2 cursor  local fast_forward for

/*
Данный запрос выбирает случайного сотрудника из двух отделов и добавляет столбец с его ID
, если у нескольких строк один заказ, то и сотрудник по ним будет один. Аналогично и по клиентам.
*/
select 
t.Нумерация	
,t.ID
,emp_2.ID_Сотрудника
,emp_2.Id_buyer
,t.flag
from #Razgrupirovka t
left join
    (
    SELECT  o.*,
    CASE 
        WHEN o.ID_OrderCategory IN (2,3,4) THEN emp.ID_Сотрудника
        WHEN o.ID_OrderCategory = 1 THEN NULL
    END AS ID_Сотрудника,
	emp_3.Id_buyer
    FROM #Orders o
    OUTER APPLY (
                 SELECT TOP 1 ID_Сотрудника 
                 FROM AllEmployees 
                 WHERE  Наименование_депортамента = 'Депортамен IT (информационных технологий)' AND 
				 Наименование_подгруппы in ('Поддержка и консультирование клиентов','Поддержка существующих клиентов и развитие долгосрочных отношений')
                 AND o.ID_Orders = o.ID_Orders  
                 ORDER BY NEWID()
                 ) as emp
	OUTER APPLY ( select top 1 Id_buyer from Buyer where o.ID_Orders = o.ID_Orders order by NEWID()) as emp_3
	
    ) as emp_2 on t.Нумерация = emp_2.ID_Orders

open Cur_2

fetch next from Cur_2 into
 @Нумерация_2
 ,@id_2 
 ,@ID_Employee_2  
 ,@Id_buyer_2    
 ,@Flag_2
 while @@FETCH_STATUS = 0
     begin
	    begin try
 
			 

			 /*Берём дату создания заказа, и будем её вставлять в таблицу - Данные по заказу, в столбец дата создания  данной строки*/
			 set @Date_Data_Orders_2 = (
			 			                select top 1
                                        o.[Date]
                                        from  
                                        #Orders as o
                                        inner join 
                                        (select 
                                        t_2.*
                                        from
                                        (select  distinct Нумерация from #t_6 ) as t
                                        outer apply (select top 1 * from #t_6 where Нумерация = t.Нумерация )  as t_2)as o_2 
                                        on o_2.Нумерация = o.ID_Orders
                                        inner join #Razgrupirovka t_3 on t_3.Нумерация = o.ID_Orders
										where  id_orders = @Нумерация_2 and  @id_2 = t_3.ID
										order by t_3.Нумерация                                     
										)

			 insert into #Data_Orders(ID_Employee,ID_Orders,Id_buyer,ID_Exemplar,ID_Transaction,Date_Data_Orders,[Description]) values 
			 (
			  @ID_Employee_2 
			  ,@Нумерация_2
			  ,@Id_buyer_2
			  ,@id_2
			  ,null
			  ,@Date_Data_Orders_2
			  ,null
			 )
			 

			 if exists (select a.flag from #Razgrupirovka  as a where @Нумерация_2 = a.Нумерация and a.ID = @id_2 and a.flag = @flag_2)
			 begin 
			      set @i_3 =  @i_3 + 1
			         update a set a.flag = 1 from #Razgrupirovka  as a where @Нумерация_2 = a.Нумерация and a.ID = @id_2 and a.flag = @flag_2 
			 end
			 
			 set @s_2 =  (select  count(0) from #Razgrupirovka where flag = 0)
			 
			  set @n_2 = (select  
			            case  t.flag  when 1 then ' 1  Значения изменены' when 0  then ' 0  Значения не изменялись' end  
			            from #Razgrupirovka t  where @Нумерация_2 = t.Нумерация  and t.ID = @id_2)
			  set @mess_2 = @n_2 + ' - > ' + ' ID_Order '  + Cast(@Нумерация_2 as varchar)  +  ' ID_Exemplar  ' + cast(@id_2 as varchar) +' --> ' + Cast(@i_3 as varchar) + ' / ' + Cast(@s_2 as varchar)
			  RAISERROR(@mess_2,0,0) WITH NOWAIT
		end try

		begin catch
			  if xact_state() in (1, -1) 
		          begin
			        ROLLBACK TRAN
			      end
               SELECT 
		        	ERROR_NUMBER() AS ErrorNumber,
		        	ERROR_SEVERITY() AS ErrorSeverity,
		        	ERROR_STATE() as ErrorState,
		        	ERROR_PROCEDURE() as ErrorProcedure,
		        	ERROR_LINE() as ErrorLine,
		        	ERROR_MESSAGE() as ErrorMessage;
		end catch
        fetch next from Cur_2 into
        @Нумерация_2
        ,@id_2 
		,@ID_Employee_2  
        ,@Id_buyer_2    
		,@Flag_2      
     end
close Cur_2
deallocate Cur_2

--SET IDENTITY_INSERT Data_Orders ON;  -- Разрешаем вставку ID вручную

insert into Orders(ID_status,ID_TypeOrders,ID_Currency,ID_OrderAssignment,ID_OrderCategory,[Date]
,Payment_Date,Amount,AmountCurr,AmountNDS,AmountCurrNDS,Num,[Description])
select ID_status,ID_TypeOrders,ID_Currency,ID_OrderAssignment,ID_OrderCategory,[Date]
,Payment_Date,Amount,AmountCurr,AmountNDS,AmountCurrNDS,Num,[Description] from  #Orders



insert into Data_Orders(ID_Employee,ID_Orders,Id_buyer,ID_Exemplar,ID_Transaction,Date_Data_Orders,[Description])
select ID_Employee,ID_Orders,Id_buyer,ID_Exemplar,ID_Transaction,Date_Data_Orders,[Description] from #Data_Orders

--SET IDENTITY_INSERT Data_Orders OFF;  -- Возвращаем автоинкремент



drop index if exists index_t_cla on #t
drop index if exists index_t_cla_2 on #t_2

drop table if exists #Orders_status_2 
drop table if exists #Orders_status

drop table if exists #t 
drop table if exists #t_2
drop table if exists #t_3
drop table if exists #t_3_1
drop table if exists #t_4
drop table if exists #t_4_1
drop table if exists #t_5
drop table if exists  #Razgrupirovka
drop table if exists #t_6
drop table if exists #t_7

drop table if exists #Orders
drop table if exists #Data_Orders

/*



create table  Data_Orders                                                    --Вспомогательная таблицца, данные о заказе
(
Id_Data_Orders         bigint          not null identity (1,1) check(ID_Data_Orders !=0),  -- ID данных о заказе
ID_Employee            bigint          not null,                                           -- ID Сотрудника или бота
ID_Orders              bigint          not null,                                           -- ID Заказа
Id_buyer               bigint          not null,	                                       -- ID Покупателя
ID_Exemplar            bigint          not null,                                           -- ID Экземпляра
ID_Transaction         bigint          null,                                               -- ID Тразанкции
Date_Data_Orders       datetime        not null  default getdate(),                        -- Дата создания данныйх о заказе
[Description]          nvarchar(4000)  null
)


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

commit
--rollback
go