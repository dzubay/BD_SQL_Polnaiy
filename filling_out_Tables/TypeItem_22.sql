
-- Cформированный через  https://chat.deepseek.com/
/*  
Первый столбец должен быть с наименованием на русском. 
Добавь к данному слову - SysSpeciesItemName,  продолжение на логическом умозаключении, на английском во втором столбце. 
к каждой строчке ниже , исходя из названия строки.
Продукты питания
,Одежда и обувь
,Электроника
,Бытовая техника
,Декор и товары для дома
,Косметика и парфюмерия
,Спортивные товары
,Игрушки и игры
,Автомобили и запчасти
,Мебель
,Книги и канцтовары
,Ювелирные изделия
,Товары для дачи и сада
,Художественные материалы
,Товары для животных 
,Услуги связи (интернет, телефон)
,Услуги транспортировки (такси, грузоперевозки)
,Образовательные услуги (курсы, тренинги)
,Медицинские услуги (консультации, лечение)
,Услуги по ремонту и обслуживанию
,Туристические услуги (экскурсии, туры)
,Услуги красоты (парикмахерские, спа)
,Финансовые услуги (банкинг, консалтинг)
,Юридические услуги (консультации, документооборот)
,Услуги проживания (гостиницы, аренда квартир)
,Бронирование билетов (самолеты, поезда, мероприятия)
,Услуги по организации мероприятий (свадьбы, корпоративы)
,Услуги по дизайну (графический, интерьерный)
,Услуги рекламы и маркетинга
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
	  	WHERE object_id = OBJECT_ID('dbo.TypeItem') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.TypeItem', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.TypeItem

--delete from  TypeItem where Id_TypeItem is not null


begin tran
insert into  TypeItem(TypeItemName,SysTypeItemName,Description) values 
('Продукты питания', 'SysSpeciesItemName_FoodProducts', null),
('Одежда и обувь', 'SysSpeciesItemName_ClothingAndFootwear', null),
('Электроника', 'SysSpeciesItemName_Electronics', null),
('Бытовая техника', 'SysSpeciesItemName_HouseholdAppliances', null),
('Декор и товары для дома', 'SysSpeciesItemName_HomeDecorAndGoods', null),
('Косметика и парфюмерия', 'SysSpeciesItemName_CosmeticsAndPerfumery', null),
('Спортивные товары', 'SysSpeciesItemName_SportingGoods', null),
('Игрушки и игры', 'SysSpeciesItemName_ToysAndGames', null),
('Автомобили и запчасти', 'SysSpeciesItemName_CarsAndSpareParts', null),
('Мебель', 'SysSpeciesItemName_Furniture', null),
('Книги и канцтовары', 'SysSpeciesItemName_BooksAndStationery', null),
('Ювелирные изделия', 'SysSpeciesItemName_Jewelry', null),
('Товары для дачи и сада', 'SysSpeciesItemName_GardenAndOutdoorGoods', null),
('Художественные материалы', 'SysSpeciesItemName_ArtSupplies', null),
('Товары для животных', 'SysSpeciesItemName_PetSupplies', null),
('Услуги связи (интернет, телефон)', 'SysSpeciesItemName_CommunicationServices', null),
('Услуги транспортировки (такси, грузоперевозки)', 'SysSpeciesItemName_TransportationServices', null),
('Образовательные услуги (курсы, тренинги)', 'SysSpeciesItemName_EducationalServices', null),
('Медицинские услуги (консультации, лечение)', 'SysSpeciesItemName_MedicalServices', null),
('Услуги по ремонту и обслуживанию', 'SysSpeciesItemName_RepairAndMaintenanceServices', null),
('Туристические услуги (экскурсии, туры)', 'SysSpeciesItemName_TourismServices', null),
('Услуги красоты (парикмахерские, спа)', 'SysSpeciesItemName_BeautyServices', null),
('Финансовые услуги (банкинг, консалтинг)', 'SysSpeciesItemName_FinancialServices', null),
('Юридические услуги (консультации, документооборот)', 'SysSpeciesItemName_LegalServices', null),
('Услуги проживания (гостиницы, аренда квартир)', 'SysSpeciesItemName_AccommodationServices', null),
('Бронирование билетов (самолеты, поезда, мероприятия)', 'SysSpeciesItemName_TicketBookingServices', null),
('Услуги по организации мероприятий (свадьбы, корпоративы)', 'SysSpeciesItemName_EventOrganizationServices', null),
('Услуги по дизайну (графический, интерьерный)', 'SysSpeciesItemName_DesignServices', null),
('Услуги рекламы и маркетинга', 'SysSpeciesItemName_AdvertisingAndMarketingServices', null)
--rollback
commit


