use Magaz_DB_Poln
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
	  	WHERE object_id = OBJECT_ID('dbo.Buyer') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Buyer', RESEED, 0)
	  end
--rollback
commit
go
*/

/*
select * from  Buyer

select distinct ID_Connection_Buyer from  Buyer order by ID_Connection_Buyer

select * from  Buyer_audit

delete from  Buyer where Id_buyer < 999999
*/


begin tran
declare @Buyer_i                   int = 0;
declare @Buyer_ID_Connection_Buyer bigint;
declare @Buyer_Id_Status           bigint;
declare @Buyer_Id_Buyer_Type       bigint;
declare @Buyer_Name                nvarchar(50);
declare @Buyer_SurName             nvarchar(50);
declare @Buyer_LastName            nvarchar(50);
declare @Buyer_RandomLogin         nvarchar(100);
declare @Buyer_gender              int;
declare @Buyer_TypePhoneRandom     nvarchar(20);
declare @Buyer_RandomDate          date;
declare @Buyer_Premium             bit;
declare @Buyer_The_resident        bit;

 while @Buyer_i < 10000
  begin 
      set @Buyer_gender = round(1+rand()*1,0);
      set @Buyer_ID_Connection_Buyer = (select top 1 cb.ID_Connection_Buyer from Connection_Buyer as cb where not exists (select ID_Connection_Buyer from Buyer where cb.ID_Connection_Buyer = ID_Connection_Buyer)order by newID())
      set @Buyer_Id_Status = (select top 1 Id_Status from Buyer_status order by newID())
	  set @Buyer_Id_Buyer_Type =  (select top 1 Id_Buyer_Type from Buyer_Type order by newID())
      exec Proc_Random_F                         @Buyer_gender,@Buyer_Name        output;
      exec Proc_Random_I                         @Buyer_gender,@Buyer_SurName     output;
      exec Proc_Random_O                         @Buyer_gender,@Buyer_LastName    output;
	  exec RandomLogin 10,20,                    @Buyer_RandomLogin               output;
	  exec RandomPhone 1,                        @Buyer_TypePhoneRandom           output;
	  exec RandomDateNew  '19680101','20170101', @Buyer_RandomDate                output;
	  set  @Buyer_Premium = round(rand()*1,0);
	  set  @Buyer_The_resident = round(rand()*1,0);

      insert into  Buyer (ID_Connection_Buyer,Id_Status,Id_Buyer_Type,Name,SurName,LastName,Mail,Pol,Phone,Date_Of_Birth,Premium,The_resident,[Description])
	  values 
	  (
       @Buyer_ID_Connection_Buyer,
	   @Buyer_Id_Status,
	   @Buyer_Id_Buyer_Type,
	   @Buyer_Name,
	   @Buyer_SurName,
	   @Buyer_LastName,
	   case  when round(rand()*100,0) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yandex.ru'
             when round(rand()*1,0)    = 1 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.ru'
	         when round(rand()*2,0)    = 2 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.com'
	         when round(rand()*3,0)    = 3 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@gmail.com'
	         when round(rand()*4,0)    = 4 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yahoo.com'
	         when round(rand()*5,0)    = 5 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@hotmail.com'
	         when round(rand()*6,0)    = 6 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.com'
	         when round(rand()*7,0)    = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@icloud.com'
	         when round(rand()*8,0)    = 8 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@moore@mail.com'
	         when round(rand()*9,0)    = 9 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@tutanota.com'
	         when round(rand()*10,0)  = 10 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mydomain.com'
	         when round(rand()*11,0)  = 11 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@dr.com'
	         when round(rand()*12,0)  = 12 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.co.uk'
	         when round(rand()*13,0)  = 13 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@sharklasers.com'
	         when round(rand()*14,0)  = 14 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Buyer_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@uol.com.br'
       ELSE N'Email не указан' END,
	   case  when @Buyer_gender = 2 then 'Ж'
             when @Buyer_gender = 1 then 'М'
	   end,
	   @Buyer_TypePhoneRandom,
	   @Buyer_RandomDate,
	   @Buyer_Premium,
	   @Buyer_The_resident,
       CASE   
               WHEN ROUND(RAND() * 60, 0) = 1  THEN  'Клиент всегда выбирает товары высокого качества.'  
               WHEN ROUND(RAND() * 59, 0) = 2  THEN  'Покупатель делает заказы регулярно, что приятно.'  
               WHEN ROUND(RAND() * 58, 0) = 3  THEN  'Отлично разбирается в новых продуктах.'  
               WHEN ROUND(RAND() * 57, 0) = 4  THEN  'Показал интерес к скидкам и акциям.'  
               WHEN ROUND(RAND() * 56, 0) = 5  THEN  'Всегда оставляет положительные отзывы о нашем сервисе.'  
               WHEN ROUND(RAND() * 55, 0) = 6  THEN  'Клиент интересовался оптовыми закупками.'  
               WHEN ROUND(RAND() * 54, 0) = 7  THEN  'Покупатель лоялен к нашим продуктам.'  
               WHEN ROUND(RAND() * 53, 0) = 8  THEN  'Рекомендовал нас своим друзьям.'  
               WHEN ROUND(RAND() * 52, 0) = 9  THEN  'Всегда обращается с вежливостью.'  
               WHEN ROUND(RAND() * 51, 0) = 10 THEN  'Заботится о деталях и продукции.'  
               WHEN ROUND(RAND() * 50, 0) = 11 THEN  'Иногда задаёт сложные вопросы.'  
               WHEN ROUND(RAND() * 49, 0) = 12 THEN  'Замечает изменения в ассортименте.'  
               WHEN ROUND(RAND() * 48, 0) = 13 THEN  'Покупатель часто интересуется новинками.'  
               WHEN ROUND(RAND() * 47, 0) = 14 THEN  'Сравнивает цены с конкурентами, делает информированный выбор.'  
               WHEN ROUND(RAND() * 46, 0) = 15 THEN  'Обратился с просьбой по улучшению сервиса.'  
               WHEN ROUND(RAND() * 45, 0) = 16 THEN  'Позитивный клиент, которого приятно обслуживать.'  
               WHEN ROUND(RAND() * 44, 0) = 17 THEN  'Выражает благодарность за качественное обслуживание.'  
               WHEN ROUND(RAND() * 43, 0) = 18 THEN  'Часто участвует в обсуждениях на нашем сайте.'  
               WHEN ROUND(RAND() * 42, 0) = 19 THEN  'Уже стал постоянным клиентом за последние полгода.'  
               WHEN ROUND(RAND() * 41, 0) = 20 THEN  'Имеет интерес к программе лояльности.'  
               WHEN ROUND(RAND() * 40, 0) = 21 THEN  'Обратил внимание на нашу экологическую упаковку.'  
               WHEN ROUND(RAND() * 39, 0) = 22 THEN  'Спрашивал об истории продукции.'  
               WHEN ROUND(RAND() * 38, 0) = 23 THEN  'Покупатель не стесняется высказывать свои пожелания.'  
               WHEN ROUND(RAND() * 37, 0) = 24 THEN  'Участвует в опросах и находит их полезными.'  
               WHEN ROUND(RAND() * 36, 0) = 25 THEN  'Пробовал несколько товаров, прежде чем выбрать основной.'  
               WHEN ROUND(RAND() * 35, 0) = 26 THEN  'Часто запрашивает дополнительные фотографии товаров.'  
               WHEN ROUND(RAND() * 34, 0) = 27 THEN  'Задаёт вопросы о доступности товаров.'  
               WHEN ROUND(RAND() * 33, 0) = 28 THEN  'Выразил интерес к предстоящим распродажам.'  
               WHEN ROUND(RAND() * 32, 0) = 29 THEN  'Ставит высокие оценки пост-продажному сервису.'  
               WHEN ROUND(RAND() * 31, 0) = 30 THEN  'Сторонник отечественного производителя.'  
               WHEN ROUND(RAND() * 30, 0) = 31 THEN  'Поделился опытом использования продукта.'  
               WHEN ROUND(RAND() * 29, 0) = 32 THEN  'Интересуется другими брендами в нашей линейке.'  
               WHEN ROUND(RAND() * 28, 0) = 33 THEN  'Покупатель хорошо ориентируется в нашей продукции.'  
               WHEN ROUND(RAND() * 27, 0) = 34 THEN  'Часто заказывает доставку на дом.'  
               WHEN ROUND(RAND() * 26, 0) = 35 THEN  'Покупает товары для бизнеса.'  
               WHEN ROUND(RAND() * 25, 0) = 36 THEN  'Оставил положительный отзыв в социальных сетях.'  
               WHEN ROUND(RAND() * 24, 0) = 37 THEN  'Поддерживает экологические инициативы компании.'  
               WHEN ROUND(RAND() * 23, 0) = 38 THEN  'Пользуется нашим приложением для покупок.'  
               WHEN ROUND(RAND() * 22, 0) = 39 THEN  'Иногда обращается с рекламациями, но адекватно.'  
               WHEN ROUND(RAND() * 21, 0) = 40 THEN  'Следит за нашими новостями через рассылку.'  
               WHEN ROUND(RAND() * 20, 0) = 41 THEN  'Покупатель высказывает мнения по улучшению сайта.'  
               WHEN ROUND(RAND() * 19, 0) = 42 THEN  'Часто участвует в акциях и конкурсах.'  
               WHEN ROUND(RAND() * 18, 0) = 43 THEN  'Обратил внимание на качество упаковки.'  
               WHEN ROUND(RAND() * 17, 0) = 44 THEN  'Иногда сравнивает товары с международными аналогами.'  
               WHEN ROUND(RAND() * 16, 0) = 45 THEN  'Замечает детали, которые другие игнорируют.'  
               WHEN ROUND(RAND() * 15, 0) = 46 THEN  'Спрашивает о возможности покупки в кредит.'  
               WHEN ROUND(RAND() * 14, 0) = 47 THEN  'Сотрудничает с нами по крупным контрактам.'  
               WHEN ROUND(RAND() * 13, 0) = 48 THEN  'Знак качества на упаковке его особенно заинтересовал.'  
               WHEN ROUND(RAND() * 12, 0) = 49 THEN  'Интересуется деталями доставки.'  
               WHEN ROUND(RAND() * 11, 0) = 50 THEN  'Регулярно оставляет положительные комментарии на нашем форуме.'  
			   WHEN ROUND(RAND() * 10, 0) = 51 THEN  'Обращал внимание на наш социальный след.'  
			   WHEN ROUND(RAND() * 9 , 0) = 52 THEN  'Покупатель делится опытом с другими пользователями.'  
			   WHEN ROUND(RAND() * 8 , 0) = 53 THEN  'Задавал вопросы о возможности кастомизации продуктов.'  
			   WHEN ROUND(RAND() * 7 , 0) = 54 THEN  'Часто запрашивает каталоги новых товаров.'  
			   WHEN ROUND(RAND() * 6 , 0) = 55 THEN  'Указывает предпочтения при подборе товаров.'  
			   WHEN ROUND(RAND() * 5 , 0) = 56 THEN  'Отмечает важность быстроты обработки заказа.'  
			   WHEN ROUND(RAND() * 4 , 0) = 57 THEN  'Имеет собственные рекомендации для новых клиентов.'  
			   WHEN ROUND(RAND() * 3 , 0) = 58 THEN  'Повторно заказывает те же товары, что говорит о доверии.'  
			   WHEN ROUND(RAND() * 2 , 0) = 59 THEN  'Покупатель активно использует бонусную систему.'  
			   WHEN ROUND(RAND() * 1 , 0) = 60 THEN  'Обратил внимание на улучшение сервиса после последнего заказа.'
          ELSE null END
	  );
  set @Buyer_i = @Buyer_i +1
  print ' Добавлено число ' +  ' -  строк --> ' + convert(nvarchar(10),@Buyer_i) + '  В таблицу dbo.Buyer';
  end;
  --rollback
  commit
go



select * from Buyer