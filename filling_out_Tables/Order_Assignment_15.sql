

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
	  	WHERE object_id = OBJECT_ID('dbo.Order_Assignment') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Order_Assignment', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Order_Assignment

--delete from  Order_Assignment where ID_OrderAssignment is not null


begin tran  
insert into  Order_Assignment(OrderAssignmentName,OrderAssignmentNameEng,OrderAssignmentSysName,[Description]) values
('Фрэш', 'FMCG/Food Delivery', 'OrderAssignmentName_FreshFoodDelivery', 'Система заказов свежих продуктов или готовой еды')
,('Бронирование билетов', 'Ticketing System', 'OrderAssignmentName_TicketingBooking', 'Система бронирования билетов на транспорт, мероприятия и т.д.')
,('Бронирование гостиницы', 'Hotel Booking System', 'OrderAssignmentName_HotelBooking', 'Система бронирования отелей или жилья')
,('Доставка', 'DMS (Delivery Management System)', 'OrderAssignmentName_DeliveryManagement', 'Система управления доставкой товаров или услуг')
,('Розничная торговля', 'POS/Retail System', 'OrderAssignmentName_RetailSales', 'Система заказов для розничных магазинов или покупателей')
,('Оптовая торговля', 'Wholesale System', 'OrderAssignmentName_WholesaleSales', 'Система заказов для оптовых покупателей')
,('Подписки', 'SMS (Subscription Management System)', 'OrderAssignmentName_SubscriptionManagement', 'Система управления подписками на услуги или товары')
,('Аренда', 'Rental System', 'OrderAssignmentName_RentalServices', 'Система заказов аренды оборудования, транспорта, недвижимости')
,('Обслуживание', 'SMS (Service Management System)', 'OrderAssignmentName_ServiceManagement', 'Система заказов на техническое обслуживание или ремонт')
,('Логистика', 'LMS (Logistics Management System)', 'OrderAssignmentName_LogisticsManagement', 'Система управления транспортными заказами')
,('Медицина', 'HMS (Healthcare Management System)', 'OrderAssignmentName_HealthcareManagement', 'Система заказов медицинских услуг или препаратов')
,('Образование', 'LMS (Learning Management System)', 'OrderAssignmentName_LearningManagement', 'Система заказов курсов, обучения или учебных материалов')
,('ИТ-услуги', 'ITSM (IT Service Management)', 'OrderAssignmentName_ITServiceManagement', 'Система заказов на разработку, поддержку или консультации')
,('Туризм', 'Tourism Booking System', 'OrderAssignmentName_TourismBooking', 'Система заказов туров или экскурсий')
,('Строительство', 'CMS (Construction Management System)', 'OrderAssignmentName_ConstructionManagement', 'Система заказов строительных материалов или услуг')
,('Производство', 'MES (Manufacturing Execution System)', 'OrderAssignmentName_ManufacturingExecution', 'Система заказов на производство товаров')
,('Фитнес', 'FMS (Fitness Management System)', 'OrderAssignmentName_FitnessManagement', 'Система заказов абонементов или тренировок')
,('Кейтеринг', 'CMS (Catering Management System)', 'OrderAssignmentName_CateringManagement', 'Система заказов на организацию питания для мероприятий')
,('Флористика', 'Florist Ordering System', 'OrderAssignmentName_FloristOrdering', 'Система заказов цветов и композиций')
,('Электронная коммерция', 'E-commerce Platform', 'OrderAssignmentName_EcommercePlatform', 'Система заказов товаров через интернет-магазины')
,('Организация мероприятий', 'EMS (Event Management System)', 'OrderAssignmentName_EventManagement', 'Система заказов для планирования и проведения мероприятий, таких как свадьбы, корпоративы, конференции и т.д.')
--rollback
commit
--rollback