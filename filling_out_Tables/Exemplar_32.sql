use Magaz_DB_Poln
go
set nocount,xact_abort on;
go


--/*

/*
 --Если с самого начала создаётся на с ID равным = 1, то можно обновить таблицу с помощью процы, и заполнить таблицу.
begin tran
if exists 
	  (	  
	  	SELECT * 
	  	FROM sys.identity_columns 
	  	WHERE object_id = OBJECT_ID('dbo.Exemplar') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Exemplar', RESEED, 0)
	  end
--rollback
commit
go
*/

/*
select * from  Exemplar

select distinct ID_Exemplar from  Exemplar order by ID_Exemplar

select * from  Exemplar_audit

delete from  Exemplar where ID_Exemplar < 999999
*/

-- Создаем временную таблицу с весами для каждого типа

drop table if exists  #RandomSelectedRows

create table #RandomSelectedRows
(
Id_Item                    bigint          not null,  
ID_product_measurement     bigint          not null,                                      
ID_TypeItem                bigint          not null,                                      
ID_Species_Item            bigint          not null,                                      
Id_Item_Status             bigint          not null,                                      
Article_number             nvarchar(300)   null,                                          
Name_Item                  nvarchar(500)   null,                                          
Image_Item                 varbinary(max)  null,                                          
Manufacturer               nvarchar(500)   null,                                          
Country                    nvarchar(200)   null,                                          
City                       nvarchar(200)   null,                                          
Adress                     nvarchar(800)   null,                                          
Mail                       nvarchar(250)   null,                                          
Phone                      nvarchar(30)    null,                                          
Logo                       varbinary(max)  null,                                          
Date_Created               datetime        not null  default GetDate(),                   
Quantity                   int             null,                                          
[Description]              nvarchar(4000)  null,
SelectionSequence          float           NULL, -- Добавлен недостающий столбец
flag                       int             null
)


DECLARE @TypeWeights TABLE (
    Id_RowType bigint,
    RowType nVARCHAR(150),
    Weight FLOAT
);


-- Задаем веса (чем больше число, тем чаще будет выбираться)
INSERT INTO @TypeWeights VALUES 
 (1,'Продукты питания',(50.0)										 )
,(2,'Одежда и обувь',(25.0)										     )
,(3,'Электроника',(5.0)											     )
,(4,'Бытовая техника',(3.0)										     )
,(5,'Декор и товары для дома',(2.0)								     )
,(6,'Косметика и парфюмерия',(3.5)								     )
,(7,'Спортивные товары',(1.0)										 )
,(8,'Игрушки и игры',(2.0)										     )
,(9,'Автомобили и запчасти',(1.0)								     )
,(10,'Мебель',(1.0)												     )
,(11,'Книги и канцтовары',(2.0)									     )
,(12,'Ювелирные изделия',(0.5)									     )
,(13,'Товары для дачи и сада',(0.5)								     )
,(14,'Художественные материалы',(1.0)								 )
,(15,'Товары для животных',(1.0)									 )
,(16,'Услуги связи (интернет, телефон)',(0.2)						 )
,(17,'Услуги транспортировки (такси, грузоперевозки)',(0.2)		     )
,(18,'Образовательные услуги (курсы, тренинги)',(0.2)				 )
,(19,'Медицинские услуги (консультации, лечение)',(0.2)			     )
,(20,'Услуги по ремонту и обслуживанию',(0.2)						 )
,(21,'Туристические услуги (экскурсии, туры)',(0.4)				     )
,(22,'Услуги красоты (парикмахерские, спа)',(0.6)					 )
,(23,'Финансовые услуги (банкинг, консалтинг)',(0.2)				 )
,(24,'Юридические услуги (консультации, документооборот)',(0.1)	     )
,(25,'Услуги проживания (гостиницы, аренда квартир)',(0.2)		     )
,(26,'Бронирование билетов (самолеты, поезда, мероприятия)',(0.1)	 )
,(27,'Услуги по организации мероприятий (свадьбы, корпоративы)',(0.2))
,(28,'Услуги по дизайну (графический, интерьерный)',(0.2)            )
,(29,'Услуги рекламы и маркетинга',(0.2)                             )
 


DECLARE @i INT = 1;
DECLARE @MaxSequence float = 0;
declare @flag_3 int = 0

WHILE @i <= 25000 
BEGIN
    -- Получаем текущее максимальное значение Sequence
    SELECT @MaxSequence = ISNULL(MAX(SelectionSequence), 0) FROM #RandomSelectedRows;
    
    -- Вставляем по одному элементу за шаг с явным указанием столбцов
    INSERT INTO #RandomSelectedRows (
        Id_Item, ID_product_measurement, ID_TypeItem, ID_Species_Item, 
        Id_Item_Status, Article_number, Name_Item, Image_Item, 
        Manufacturer, Country, City, Adress, Mail, Phone, Logo, 
        Date_Created, Quantity, [Description], SelectionSequence, flag
    )
    SELECT TOP 1
        t.Id_Item,
        t.ID_product_measurement,
        t.ID_TypeItem,
        t.ID_Species_Item,
        t.Id_Item_Status,
        t.Article_number,
        t.Name_Item,
        t.Image_Item,
        t.Manufacturer,
        t.Country,
        t.City,
        t.Adress,
        t.Mail,
        t.Phone,
        t.Logo,
        t.Date_Created,
        t.Quantity,
        t.[Description],
        @MaxSequence + 1.0,
		@flag_3
    FROM Item t
    JOIN @TypeWeights w ON t.ID_TypeItem = w.Id_RowType --and w.Id_RowType <= 15
    ORDER BY -LOG(RAND(CHECKSUM(NEWID())))/ w.Weight;
	 
    
    SET @i = @i + 1;
    
    -- Оптимизация: периодически выводим прогресс
    IF @i % 1000 = 0
        PRINT 'Processed ' + CAST(@i AS VARCHAR) + ' rows';
END

drop table if exists #Exemplar

create table #Exemplar                                                                   
(
ID_Exemplar               bigint          not null   identity (1,1),    
Id_Item                   bigint          not null,                                               
ID_Currency               bigint          not null,											      
ID_Storage_location       bigint          not null,                                               
KeySource                 bigint          null,                                                   
Serial_number             nvarchar(500)   null,                                               
ID_Condition_of_the_item  bigint          null,                                               
Old_Price_no_NDS          decimal(10,2)   null,                                               
Refund                    bit             null,                                               
Date_Refund               datetime        null,                                                   
Return_Note               nvarchar(4000)  null,                                                   
Old_Price_NDS             decimal(10,2)   null,                                               
JSON_Size_Volume          nvarchar(max)   null      check(isjson(JSON_Size_Volume)>0),            
New_Price_NDS             decimal(10,2)   null,                                               
New_Price_no_NDS          decimal(10,2)   null,                                               
Date_Created              datetime        null  default GetDate(),                            
[Description]             nvarchar(4000)  null,
flag                      int             null
) 
declare
@ID_Currency               bigint        ,
@ID_Storage_location       bigint        ,
@Serial_number             nvarchar(500) ,
@ID_Condition_of_the_item  bigint        ,
@Old_Price_no_NDS          decimal(10,2) ,
@Refund                    bit           ,
@Date_Refund               datetime      ,
@Date_Refund_2             datetime      ,
@Old_Price_NDS             decimal(10,2) ,
@New_Price_NDS             decimal(10,2) ,
@New_Price_no_NDS          decimal(10,2) ,
@Date_Created_2            datetime      


declare @NDS               decimal(10,2)
declare @date_Item         datetime
declare @date_Item_raznica int

declare
@SelectionSequence       int    ,
@Id_Item				 bigint ,
@ID_TypeItem             bigint ,
@flag	                 int




declare @i_2 int = 0,@s_2  int = 0 , @n_2 varchar(40), @mess_2 varchar(8000), @err_2 varchar(1000)


declare Mycur cursor local fast_forward for 

select 
u.SelectionSequence,u.Id_Item,ID_TypeItem,flag
from #RandomSelectedRows u order by u.SelectionSequence desc


open Mycur



fetch next from Mycur into 
@SelectionSequence      
,@Id_Item
,@ID_TypeItem
,@flag	                                   
while @@FETCH_STATUS = 0
     begin
	    begin try
		   /*Указываю порядок записи ID валюты, по типу товара*/
		     if (@ID_TypeItem = 1)
			     begin
				      set @ID_Currency = 115			          
			     end
			 else if (@ID_TypeItem <= 15)
				 begin 
				      set @ID_Currency =  (select top 1 ID_Currency from Currency where ID_Currency in (6,5,115,36) order by NEWID())
				 end
			 else if (@ID_TypeItem > 15)
			     begin
				      set @ID_Currency =  (select top 1 ID_Currency from Currency   order by NEWID())
				 end
           /*Указываю порядок записи стоимости товара, исходя  по типу товара*/
			 if  (@ID_TypeItem = 1)
			     begin
				      set @Old_Price_no_NDS =  convert(decimal(10,2),round(rand()*999 +100,2))			          
			     end
			 else if (@ID_TypeItem > 1) and (@ID_TypeItem <= 15)
				 begin 
				      set @Old_Price_no_NDS = convert(decimal(10,2),round(rand()*555 +50,2))
				 end
			 else if (@ID_TypeItem  > 15)
			     begin
				      set @Old_Price_no_NDS = convert(decimal(10,2),round(rand()*55555 +10000,0))
				 end

			 set @ID_Storage_location = (select top 1 ID_Storage_location from Storage_location order by NEWID())
			 set @Serial_number = cast(FORMAT(Round(rand()*10000000000000 + 1000000000000,0),'0') as nvarchar(500))

			 /*
			 Проверка, для присвоения статуса экземпляров, учитывая тип товара. для типов <= 15, указывает статус от 1 до 24 включительно,
			 и для типов >15, будут добавляться статусы от 25 до 34
			 */
			 if (@ID_TypeItem <= 15)
			    begin
			        set @ID_Condition_of_the_item = (select top 1 ID_Condition_of_the_item from Condition_of_the_item 
					                                 where ID_Condition_of_the_item between 1 and 24 order by newid())
				end
			 else if (@ID_TypeItem > 15)
			    begin
				    set @ID_Condition_of_the_item = (select top 1 ID_Condition_of_the_item from Condition_of_the_item 
					                                 where ID_Condition_of_the_item between 25 and 34 order by newid())
				end
             
			 if @ID_Condition_of_the_item in (32,13)
			       begin
			           set @Refund = 1
                   end
             else
			       begin
				       set @Refund = 0
				   end

			 /*Проверка, если есть указатель на возврат, то формируем дату*/
			 if(@Refund = 1)
			     begin 
				     exec RandomDateNew  '20240101','20250601', @Date_Refund output
					        /*
			                Проверка, если в таблице Item, дата  создания карточки товара , больше чем дата возврата, то находим разницу между датами и прибавляем к этой разнице 45 дней
			                после чего вычисляем эту сумму дней из вновь сформированной даты @Date_Refund
			                */
			         if exists (select * from Item where Id_Item = @Id_Item  and Date_Created > @Date_Refund)
			               begin 
			                    set @date_Item =  (select Date_Created from Item where Id_Item = @Id_Item)
			                    set @date_Item_raznica = (DATEDIFF(day,@Date_Refund,@date_Item)) + 45
			                    set @Date_Refund =  DATEADD(day, @date_Item_raznica, @Date_Refund)
			               end
				 end
			 /*Обнуляем вспомогательные переменные, которые нам понадобятся ниже в провеках*/
			 set @date_Item   = null;
			 set @date_Item_raznica  = null;
			 
			 /*расчёт сумм с НДС , и присвоение случайного НДС переменной @NDS*/
			 set @NDS = (select case when round(1+rand()*3,0) = 1 then convert(decimal(10,2),20.00)
			                         when round(1+rand()*3,0) = 2 then convert(decimal(10,2),10.00)
			                         when round(1+rand()*3,0) = 3 then convert(decimal(10,2),12.00)
			                         when round(1+rand()*3,0) = 4 then convert(decimal(10,2),5.00)
			                         else convert(decimal(10,2),10.00) end)
             set @Old_Price_NDS = (@NDS*@Old_Price_no_NDS/100) + @Old_Price_no_NDS
			 set @New_Price_NDS = (7.00*@Old_Price_NDS/100) + @Old_Price_NDS
			 set @New_Price_no_NDS = (7.00*@Old_Price_no_NDS/100) + @Old_Price_no_NDS

			 /*Проверка, если в переменной @Date_Refund нет данных, и @Refund возврата не было, то формируем дату @Date_Created_2 "заведения экземляра в систему"*/
			 if @Date_Refund is null and @Refund = 0
			    begin 
				    
					exec RandomDateNew  '20240101','20250601', @Date_Created_2 output
					/*
					Если сформированная @Date_Created_2 "заведения экземляра в систему", больше чем в таблице Item, дата  создания карточки товара,
					то то находим разницу между датами и прибавляем к этой разнице 45 дней
			        после чего вычисляем эту сумму дней из вновь сформированной даты @Date_Created_2
					*/
				    if exists (select * from Item where Id_Item = @Id_Item  and Date_Created > @Date_Created_2)
			            begin 
				              set @date_Item =  (select Date_Created from Item where Id_Item = @Id_Item)
					          set @date_Item_raznica = (DATEDIFF(day,@Date_Created_2,@date_Item)) + 45
				              set @Date_Created_2 =  DATEADD(day,@date_Item_raznica, @Date_Created_2)
				        end
				end 
			  else
			     begin	
				     /*Проверка (или), взврат был, и сформирована уже дата возврата. То берём эту дату возврата и вычитаем из неё рандомное число дней от 1 до 30 */
				    -- set @Date_Refund_2 =  DATEADD(day, round(-rand()*30,0), @Date_Refund)
					 set @Date_Created_2 = null;
					 

					 declare @date_Item_2 datetime
					 set @date_Item_2 =  (select Date_Created from Item where Id_Item = @Id_Item)

					 
					 exec RandomDateNew  @date_Item_2,@Date_Refund, @Date_Created_2 output

					 /*Если дата возврата, и дата создания карточки товара равны, то дату возврата указываем  в дату заведения экземпляра*/
					 if @date_Item_2 = @Date_Refund
					      begin
						       set @Date_Created_2 = @Date_Refund
						  end

				 end 
             
			 
			 /*Обнуляем дату возврата, и дату внесения экземпляра в систему*/

		     insert into #Exemplar values 
			 (
			 @Id_Item,
			 @ID_Currency,
			 @ID_Storage_location,
			 null,
			 @Serial_number,
			 @ID_Condition_of_the_item,
			 @Old_Price_no_NDS,
			 @Refund,
			 @Date_Refund,
			 null,
			 @Old_Price_NDS,
			 null,
			 @New_Price_NDS,
			 @New_Price_no_NDS,
			 @Date_Created_2,
			 null,
			 0
			 )
			 set @Date_Refund = null;
			 
			 if exists (select a.flag from #RandomSelectedRows  as a where @Id_Item = a.Id_Item and @SelectionSequence = a.SelectionSequence and a.flag = 0)
					       begin 
					            set @i_2 =  @i_2 + 1
			                    update a set flag = 1 from #RandomSelectedRows  as a where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence and flag = 0 
						   end

			  select @s_2 = count(0) from #RandomSelectedRows where flag = 0
			  set @n_2 = (select  
			            case  t.flag  when 1 then ' 1  Значения изменены' when 0  then ' 0  Значения не изменялись' end  
			            from #RandomSelectedRows t  where t.SelectionSequence = @SelectionSequence)
			  set @mess_2 = @n_2 + ' - > ' + ' ID_Exemplar '  + Cast(@SelectionSequence as varchar)  + ' Id_Item '  + Cast(@Id_Item as varchar)  + ' --> ' + ' - ' + Cast(@i_2 as varchar) + ' / ' + Cast(@s_2 as varchar)
			  RAISERROR(@mess_2,0,0) WITH NOWAIT
		end  try
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

	 fetch next from Mycur into 
     @SelectionSequence      
	 ,@Id_Item
	 ,@ID_TypeItem
	 ,@flag	                
   end
close Mycur
deallocate Mycur



insert into  Exemplar(
Id_Item,ID_Currency,ID_Storage_location,KeySource,Serial_number,ID_Condition_of_the_item,Old_Price_no_NDS,Refund                
,Date_Refund,Return_Note,Old_Price_NDS,JSON_Size_Volume,New_Price_NDS,New_Price_no_NDS,Date_Created,[Description]           
)
select 
Id_Item,ID_Currency,ID_Storage_location,KeySource,Serial_number,ID_Condition_of_the_item,Old_Price_no_NDS,Refund,Date_Refund,Return_Note,Old_Price_NDS                    
,JSON_Size_Volume,New_Price_NDS,New_Price_no_NDS,Date_Created,[Description]         
from  #Exemplar order by ID_Exemplar,Id_Item



/*Заполнение столбца Quantity в таблице Item из #RandomSelectedRows_2*/
declare @i_3 int = 0,@s_3  int = 0 , @n_3 varchar(40), @mess_3 varchar(8000), @err_3 varchar(1000)

declare
@id_item_2	     bigint,
@ID_TypeItem_2	 bigint,
@OrderCount_2    int,
@flag_2          int

drop table if exists  #RandomSelectedRows_2

SELECT 
 soh.id_item
,soh.ID_TypeItem
,count(soh.id_item) as OrderCount
,0 flag
into #RandomSelectedRows_2
--,replicate('|',count(soh.id_item)/4) as orderCount_Bar
FROM #RandomSelectedRows soh
where soh.ID_TypeItem <= 15
group by soh.id_item,ID_TypeItem
order by soh.ID_TypeItem

declare mycur_2 cursor local fast_forward for

select * from #RandomSelectedRows_2

open mycur_2

fetch next from mycur_2 into 
@id_item_2	  
,@ID_TypeItem_2
,@OrderCount_2 
,@flag_2       
while @@FETCH_STATUS = 0
   begin
      begin try	     
		        update b
				set Quantity = @OrderCount_2
				from Item b
				where id_Item = @id_item_2 and @ID_TypeItem_2 = ID_TypeItem
		 

		  if exists (select a.flag from #RandomSelectedRows_2  as a where @Id_Item_2 = a.Id_Item and @ID_TypeItem_2 = ID_TypeItem and a.flag = 0)
				begin 
				     set @i_3 =  @i_3 + 1
			         update a set flag = 1 from #RandomSelectedRows_2  as a where @Id_Item_2 = a.Id_Item  and @ID_TypeItem_2 = ID_TypeItem and a.flag = 0 
				end

		  select @s_3 = count(0) from #RandomSelectedRows_2 where flag = 0
			  set @n_3 = (select  
			            case  t.flag  when 1 then ' 1  Значения изменены' when 0  then ' 0  Значения не изменялись' end  
			            from #RandomSelectedRows_2 t  where t.id_item = @id_item_2)
			  set @mess_3 = @n_3 + ' - > ' + ' Order_Count_Item '  + Cast(@OrderCount_2 as varchar)  + ' Id_Item '  + Cast(@id_item_2 as varchar)  + ' --> ' + ' - ' + Cast(@i_3 as varchar) + ' / ' + Cast(@s_3 as varchar)
			  RAISERROR(@mess_3,0,0) WITH NOWAIT			  
	  end try
	  begin catch 
	      if XACT_STATE() in  (1,-1)
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
	  fetch next from mycur_2 into 
	  @id_item_2	  
     ,@ID_TypeItem_2
     ,@OrderCount_2 
     ,@flag_2  
   end
close mycur_2
deallocate mycur_2 

drop table if exists #RandomSelectedRows
drop table if exists #RandomSelectedRows_2
drop table if exists #Exemplar

 --select * from Item
 --select * from Exemplar
 --select * from Currency where ID_Currency in (6,5,115,36)
 --select * from Storage_location
 --select * from Condition_of_the_item

 -- select * from Exemplar
--select * from #RandomSelectedRows
--select * from Type_of_product_measurement	
--select * from TypeItem	
--select * from Species_Item

go
