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
,(15,'Товары для животных',(0.5)									 )
,(16,'Услуги связи (интернет, телефон)',(1.0)						 )
,(17,'Услуги транспортировки (такси, грузоперевозки)',(1.0)		     )
,(18,'Образовательные услуги (курсы, тренинги)',(0.5)				 )
,(19,'Медицинские услуги (консультации, лечение)',(0.5)			     )
,(20,'Услуги по ремонту и обслуживанию',(0.5)						 )
,(21,'Туристические услуги (экскурсии, туры)',(0.5)				     )
,(22,'Услуги красоты (парикмахерские, спа)',(0.5)					 )
,(23,'Финансовые услуги (банкинг, консалтинг)',(0.3)				 )
,(24,'Юридические услуги (консультации, документооборот)',(0.3)	     )
,(25,'Услуги проживания (гостиницы, аренда квартир)',(0.5)		     )
,(26,'Бронирование билетов (самолеты, поезда, мероприятия)',(1.0)	 )
,(27,'Услуги по организации мероприятий (свадьбы, корпоративы)',(0.3))
,(28,'Услуги по дизайну (графический, интерьерный)',(0.3)            )
,(29,'Услуги рекламы и маркетинга',(2.0)                             )
 
-- Взвешенный случайный выбор

--SELECT TOP 10000 
--    t.*,
--    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS SelectionSequence
--INTO #RandomSelectedRows
--FROM Item t
--JOIN @TypeWeights w ON t.ID_TypeItem = w.Id_RowType
--ORDER BY -LOG(RAND()) / w.Weight; -- Алгоритм взвешенного случайного выбора



DECLARE @i INT = 1;
DECLARE @MaxSequence float = 0;

WHILE @i <= 100000 
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
    JOIN @TypeWeights w ON t.ID_TypeItem = w.Id_RowType
    ORDER BY -LOG(RAND(CHECKSUM(NEWID()))) / w.Weight;
    
    SET @i = @i + 1;
    
    -- Оптимизация: периодически выводим прогресс
    IF @i % 1000 = 0
        PRINT 'Processed ' + CAST(@i AS VARCHAR) + ' rows';
END

-- Проверяем результаты
SELECT 
 soh.id_item
,soh.ID_TypeItem
,count(soh.id_item) as OrderCount
,replicate('|',count(soh.id_item)/4) as orderCount_Bar
FROM #RandomSelectedRows soh
group by soh.id_item,ID_TypeItem
order by soh.ID_TypeItem


