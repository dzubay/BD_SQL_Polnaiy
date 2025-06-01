use Magaz_DB_Poln_test
go
set nocount,xact_abort on;
go

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

--select * from Item

--select * from Type_of_product_measurement	
--select * from TypeItem	
--select * from Species_Item


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
SelectionSequence          float             NULL -- Добавлен недостающий столбец
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
,(16,'Услуги связи (интернет, телефон)',(0)						 )
,(17,'Услуги транспортировки (такси, грузоперевозки)',(0)		     )
,(18,'Образовательные услуги (курсы, тренинги)',(0)				 )
,(19,'Медицинские услуги (консультации, лечение)',(0)			     )
,(20,'Услуги по ремонту и обслуживанию',(0)						 )
,(21,'Туристические услуги (экскурсии, туры)',(0)				     )
,(22,'Услуги красоты (парикмахерские, спа)',(0)					 )
,(23,'Финансовые услуги (банкинг, консалтинг)',(0)				 )
,(24,'Юридические услуги (консультации, документооборот)',(0)	     )
,(25,'Услуги проживания (гостиницы, аренда квартир)',(0)		     )
,(26,'Бронирование билетов (самолеты, поезда, мероприятия)',(0)	 )
,(27,'Услуги по организации мероприятий (свадьбы, корпоративы)',(0))
,(28,'Услуги по дизайну (графический, интерьерный)',(0)            )
,(29,'Услуги рекламы и маркетинга',(0)                             )
 


DECLARE @i INT = 1;
DECLARE @MaxSequence float = 0;

WHILE @i <= 20000 
BEGIN
    -- Получаем текущее максимальное значение Sequence
    SELECT @MaxSequence = ISNULL(MAX(SelectionSequence), 0) FROM #RandomSelectedRows;
    
    -- Вставляем по одному элементу за шаг с явным указанием столбцов
    INSERT INTO #RandomSelectedRows (
        Id_Item, ID_product_measurement, ID_TypeItem, ID_Species_Item, 
        Id_Item_Status, Article_number, Name_Item, Image_Item, 
        Manufacturer, Country, City, Adress, Mail, Phone, Logo, 
        Date_Created, Quantity, [Description], SelectionSequence
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
        @MaxSequence + 1.0
    FROM Item t
    JOIN @TypeWeights w ON t.ID_TypeItem = w.Id_RowType and w.Id_RowType <= 15
    ORDER BY -LOG(RAND(CHECKSUM(NEWID()))) / w.Weight;
	 
    
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
@Old_Price_NDS             decimal(10,2) ,
@New_Price_NDS             decimal(10,2) ,
@New_Price_no_NDS          decimal(10,2) ,
@Date_Created_2            datetime      


declare @NDS float

declare
@SelectionSequence       int            ,
@Id_Item				 bigint        	,
@ID_product_measurement	 bigint        	,
@ID_TypeItem			 bigint        	,
@ID_Species_Item		 bigint        	,
@Id_Item_Status			 bigint        	,
@Article_number			 nvarchar(300) 	,
@Name_Item				 nvarchar(500) 	,
@Image_Item				 varbinary(max)	,
@Manufacturer			 nvarchar(500) 	,
@Country				 nvarchar(200) 	,
@City					 nvarchar(200) 	,
@Adress					 nvarchar(800) 	,
@Mail					 nvarchar(250) 	,
@Phone					 nvarchar(30)  	,
@Logo					 varbinary(max)	,
@Date_Created			 datetime      	,
@Quantity				 int           	,
@Description		     nvarchar(4000)	,
@flag	                 int




declare @i_2 int = 0,@s_2  int = 0 , @n_2 varchar(40), @mess_2 varchar(8000), @err_2 varchar(1000)


declare Mycur cursor local fast_forward for 

select 
u.SelectionSequence,u.Id_Item,u.ID_product_measurement,u.ID_TypeItem,u.ID_Species_Item,u.Id_Item_Status,u.Article_number,	
u.Name_Item,u.Image_Item,u.Manufacturer,u.Country,u.City,u.Adress,u.Mail,u.Phone,u.Logo,	
u.Date_Created,u.Quantity,u.[Description],0 flag
from #RandomSelectedRows u order by u.SelectionSequence


open Mycur



fetch next from Mycur into 
@SelectionSequence      
,@Id_Item				
,@ID_product_measurement	
,@ID_TypeItem			
,@ID_Species_Item		
,@Id_Item_Status			
,@Article_number			
,@Name_Item				
,@Image_Item				
,@Manufacturer			
,@Country				
,@City					
,@Adress					
,@Mail					
,@Phone					
,@Logo					
,@Date_Created			
,@Quantity				
,@Description		    
,@flag	                                   
while @@FETCH_STATUS = 0
     begin
	    begin try
		     if  (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) = 1
			     begin
				      set @ID_Currency = 115			          
			     end
			 else if (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) > 1 and  
			         (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) <= 15
				 begin 
				      set @ID_Currency =  (select top 1 ID_Currency from Currency where ID_Currency in (6,5,115,36) order by NEWID())
				 end
			 else if (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) > 15
			     begin
				      set @ID_Currency =  (select top 1 ID_Currency from Currency   order by NEWID())
				 end
             
			 if  (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) = 1
			     begin
				      set @Old_Price_no_NDS = round(rand()*999 +100,2)			          
			     end
			 else if (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) > 1 and  
			         (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) <= 15
				 begin 
				      set @Old_Price_no_NDS = round(rand()*555 +50,2)
				 end
			 else if (select ID_TypeItem from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence ) > 15
			     begin
				      set @Old_Price_no_NDS = round(rand()*55555 +10000,0)
				 end

			 set @ID_Storage_location = (select top 1 ID_Storage_location from Storage_location order by NEWID())
			 set @Serial_number = cast((select Round(rand()*10000000000000 + 1000000000000,0)) as nvarchar(500))
			 set @ID_Condition_of_the_item = (select top 1 ID_Condition_of_the_item from Condition_of_the_item order by newid())
			 set @Refund = round(rand()*1,0)

			 if exists (select * from #RandomSelectedRows where @Id_Item = Id_Item and @SelectionSequence = SelectionSequence and  @Refund = 1)
			     begin 
				     exec RandomDateNew  '20240101','20241101', @Date_Refund output
				 end
			
			 set @NDS = (select case when round(1+rand()*3,0) = 1 then 0.2
			                         when round(1+rand()*3,0) = 2 then 0.1
			                         when round(1+rand()*3,0) = 3 then 0.12
			                         when round(1+rand()*3,0) = 4 then 0.05
			                         else 0.1 end)
             set @Old_Price_NDS = @Old_Price_no_NDS * @NDS
			 set @New_Price_NDS = @Old_Price_NDS * 0.07
			 set @New_Price_no_NDS = @Old_Price_no_NDS * 0.07

			 if @Date_Refund is null
			    begin 
				    exec RandomDateNew  '20240101','20250501', @Date_Created_2 output
				end 
			  else
			     begin
				     set @Date_Refund = DATEADD(day, -5, @Date_Refund)
				     exec RandomDateNew @Date_Refund,'20250501', @Date_Created_2 output
				 end 


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

			 if exists (select * from #Exemplar  as a where @Id_Item = Id_Item and @SelectionSequence = ID_Exemplar and flag = 0)
					       begin 
					            set @i_2 =  @i_2 + 1
			                    update a set flag = 1 from #Exemplar  as a where @Id_Item = Id_Item and @SelectionSequence = ID_Exemplar and flag = 0 
						   end

			  select @s_2 = count(0) from #Exemplar where flag = 0
			  set @n_2 = (select  
			            case  t.flag  when 1 then ' 1  Значения изменены' when 0  then ' 0  Значения не изменялись' end  
			            from #Exemplar t  where t.ID_Exemplar = @SelectionSequence)
			  set @mess_2 = @n_2 + ' - > '  + ' Id_Item '  + Cast(@SelectionSequence as varchar)  + ' --> ' + ' - ' + Cast(@i_2 as varchar) + ' / ' + Cast(@s_2 as varchar)
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
	 ,@ID_product_measurement	
	 ,@ID_TypeItem			
	 ,@ID_Species_Item		
	 ,@Id_Item_Status			
	 ,@Article_number			
	 ,@Name_Item				
	 ,@Image_Item				
	 ,@Manufacturer			
	 ,@Country				
	 ,@City					
	 ,@Adress					
	 ,@Mail					
	 ,@Phone					
	 ,@Logo					
	 ,@Date_Created			
	 ,@Quantity				
	 ,@Description		    
	 ,@flag	                
   end
close Mycur
deallocate Mycur

---- Проверяем результаты
--SELECT 
-- soh.id_item
--,soh.ID_TypeItem
--,count(soh.id_item) as OrderCount
--,replicate('|',count(soh.id_item)/4) as orderCount_Bar
--FROM #RandomSelectedRows soh
--group by soh.id_item,ID_TypeItem
--order by soh.ID_TypeItem


--select 
--r.Id_Item
--,r.Name_Item
--,r.ID_product_measurement
--,t.Product_measurement_Name
--,r.ID_TypeItem
--,ti.TypeItemName
--,r.ID_Species_Item
--,s.SpeciesItemName
--from #RandomSelectedRows r 
--inner join item i on i.Id_Item = r.Id_Item 
--left join  Type_of_product_measurement t on t.ID_product_measurement = r.ID_product_measurement
--left join  TypeItem ti on ti.Id_TypeItem = r.ID_TypeItem
--left join  Species_Item s on s.ID_Species_Item = r.ID_Species_Item
-- --where r.ID_product_measurement = 1
-- order by r.Id_Item



--select  
--r.Id_Item
--,r.Name_Item
--,r.ID_product_measurement
--,t.Product_measurement_Name
--,r.ID_TypeItem
--,ti.TypeItemName
--,r.ID_Species_Item
--,s.SpeciesItemName
--from item r
--left join  Type_of_product_measurement t on t.ID_product_measurement = r.ID_product_measurement
--left join  TypeItem ti on ti.Id_TypeItem = r.ID_TypeItem
--left join  Species_Item s on s.ID_Species_Item = r.ID_Species_Item
-- --where r.ID_product_measurement = 1
-- order by r.Id_Item

 --select * from Item
 --select * from Currency where ID_Currency in (6,5,115,36)
 --select * from Storage_location
 --select * from Condition_of_the_item

 --select * from #RandomSelectedRows
--select * from Type_of_product_measurement	
--select * from TypeItem	
--select * from Species_Item

/*
 create table Exemplar                                                                   --Экземпляр
(
ID_Exemplar               bigint          not null   identity (1,1)  check(ID_Exemplar != 0),     -- ID Экземпляра
Id_Item                   bigint          not null,                                               -- ID Карточки товара
ID_Currency               bigint          not null,											      -- ID Валюта, цены на экземпляр
ID_Storage_location       bigint          not null,                                               -- ID Место хранение экземпляра
KeySource                 bigint          null,                                                   -- Источник ключа с другими БД или сервисами
Serial_number             nvarchar(500)   not null,                                               -- Серийный номер экземпляра товара
ID_Condition_of_the_item  bigint          not null,                                               -- ID Текущего состояния экземпляра
Old_Price_no_NDS          decimal(10,2)   not null,                                               -- Цена без НДС экземпляра
Refund                    bit             not null,                                               -- Был ли возврат данного экземпляра или нет. 0/1
Date_Refund               datetime        null,                                                   -- Дата возврата
Return_Note               nvarchar(4000)  null,                                                   -- Записка(Примечание) о возврате
Old_Price_NDS             decimal(10,2)   not null,                                               -- Цена экземпляра с НДС
JSON_Size_Volume          nvarchar(max)   null      check(isjson(JSON_Size_Volume)>0),            -- Данный JSON параметры самого экземпляра
New_Price_NDS             decimal(10,2)   not null,                                               -- Цена экземпляра с НДС после начисления коммисии  за  сервис
New_Price_no_NDS          decimal(10,2)   not null,                                               -- Цена экземпляра без НДС после начисления коммисии  за  сервис
Date_Created              datetime        not null  default GetDate(),                            -- Дата внесения экземпляра в систему
[Description]             nvarchar(4000)  null                                                    -- Комментарий
constraint PK_ID_Exemplar              primary key (ID_Exemplar)
)  on Products_Group
*/