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
	  	WHERE object_id = OBJECT_ID('dbo.Connection_Buyer') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Connection_Buyer', RESEED, 0)
	  end
--rollback
commit
go
*/

/*
select * from  Connection_Buyer

select * from  Connection_Buyer_audit

delete from  Connection_Buyer where ID_Connection_Buyer < 999999
*/


begin tran
declare @i int =0;
declare @RandomLogin nvarchar(max);
declare @RandomDate  datetime;
declare @GetDate datetime = GetDate();

 while @i < 10000
  begin 
      exec RandomLogin 10,10,  @RandomLogin output;
	  exec RandomDateTimeNew '20200101',@GetDate, @RandomDate output;
      insert into  Connection_Buyer (Password,Login,Date_Created,[Description])
	  values 
	  (
	   (REPLACE(SUBSTRING(CONVERT(varchar(72), NEWID()), 1,CONVERT(int,(ROUND(5+rand()*25,0)))), '-', '')),
	   @RandomLogin,
	   @RandomDate,
       CASE   
               WHEN ROUND(RAND() * 51, 0) = 1  THEN 'Необходимо обновить фотографию в паспорте.'
               WHEN ROUND(RAND() * 51, 0) = 2  THEN 'Дефект страницы с личными данными.'
               WHEN ROUND(RAND() * 51, 0) = 3  THEN 'Несоответствие данных в паспорте и базе.'
               WHEN ROUND(RAND() * 51, 0) = 4  THEN 'Проблема с доступом к учетной записи.'
               WHEN ROUND(RAND() * 51, 0) = 5  THEN 'Требуется подтверждение личности.'
               WHEN ROUND(RAND() * 51, 0) = 6  THEN 'Срок действия документа истек.'
               WHEN ROUND(RAND() * 51, 0) = 7  THEN 'Отсутствие необходимых документов.'
               WHEN ROUND(RAND() * 51, 0) = 8  THEN 'Неверный формат загрузки документа.'
               WHEN ROUND(RAND() * 51, 0) = 9  THEN 'Проверка подлинности документа.'
               WHEN ROUND(RAND() * 51, 0) = 10 THEN 'Требуется поездка в офис для уточнения.'
               WHEN ROUND(RAND() * 51, 0) = 11 THEN 'Информация не соответствует стандартам.'
               WHEN ROUND(RAND() * 51, 0) = 12 THEN 'Документ поврежден.'
               WHEN ROUND(RAND() * 51, 0) = 13 THEN 'Недостаточно прав для выполнения действия.'
               WHEN ROUND(RAND() * 51, 0) = 14 THEN 'Страничка с отметкой о запрете выезда.'
               WHEN ROUND(RAND() * 51, 0) = 15 THEN 'Необходимо указать дополнительную информацию.'
               WHEN ROUND(RAND() * 51, 0) = 16 THEN 'Копия документа нечеткая.'
               WHEN ROUND(RAND() * 51, 0) = 17 THEN 'Требуется дубликат документа.'
               WHEN ROUND(RAND() * 51, 0) = 18 THEN 'Необходимо провести проверку данных.'
               WHEN ROUND(RAND() * 51, 0) = 19 THEN 'Исправление данных в паспорте.'
               WHEN ROUND(RAND() * 51, 0) = 20 THEN 'Недостаточно времени для обработки.'
               WHEN ROUND(RAND() * 51, 0) = 21 THEN 'Требуется другое удостоверение личности.'
               WHEN ROUND(RAND() * 51, 0) = 22 THEN 'Не удалось проверить подлинность документа.'
               WHEN ROUND(RAND() * 51, 0) = 23 THEN 'Проблема с сканированием документа.'
               WHEN ROUND(RAND() * 51, 0) = 24 THEN 'Ошибка в системе обработки.'
               WHEN ROUND(RAND() * 51, 0) = 25 THEN 'Требуется ксерокопия документа.'
               WHEN ROUND(RAND() * 51, 0) = 26 THEN 'Запрос документов не выполнен.'
               WHEN ROUND(RAND() * 51, 0) = 27 THEN 'Необходимо удостоверение от работодателя.'
               WHEN ROUND(RAND() * 51, 0) = 28 THEN 'Требуется предоставление справок.'
               WHEN ROUND(RAND() * 51, 0) = 29 THEN 'Перепроверка ранее предоставленной информации.'
               WHEN ROUND(RAND() * 51, 0) = 30 THEN 'Отсутствует подпись заявителя.'
               WHEN ROUND(RAND() * 51, 0) = 31 THEN 'Некорректные данные в анкете.'
               WHEN ROUND(RAND() * 51, 0) = 32 THEN 'Требуется подтверждение гражданства.'
               WHEN ROUND(RAND() * 51, 0) = 33 THEN 'Неверный ИНН или ОГРН.'
               WHEN ROUND(RAND() * 51, 0) = 34 THEN 'Фотография не соответствует требованиям.'
               WHEN ROUND(RAND() * 51, 0) = 35 THEN 'Отказ в обработке заявления.'
               WHEN ROUND(RAND() * 51, 0) = 36 THEN 'Заявление необходимо повторить.'
               WHEN ROUND(RAND() * 51, 0) = 37 THEN 'Не хватает информации для завершения.'
               WHEN ROUND(RAND() * 51, 0) = 38 THEN 'Активация учетной записи приостановлена.'
               WHEN ROUND(RAND() * 51, 0) = 39 THEN 'Документы не прошли проверку.'
               WHEN ROUND(RAND() * 51, 0) = 40 THEN 'Заявка передана на дополнительную проверку.'
               WHEN ROUND(RAND() * 51, 0) = 41 THEN 'Необходимо исправить ошибки в анкете.'
               WHEN ROUND(RAND() * 51, 0) = 42 THEN 'Ошибка в адресе проживания.'
               WHEN ROUND(RAND() * 51, 0) = 43 THEN 'Требуется указать актуальный номер телефона.'
               WHEN ROUND(RAND() * 51, 0) = 44 THEN 'Копия документа неразборчива.'
               WHEN ROUND(RAND() * 51, 0) = 45 THEN 'Необходима дополнительная справка от врача.'
               WHEN ROUND(RAND() * 51, 0) = 46 THEN 'Необходимо заполнение дополнительного поля.'
               WHEN ROUND(RAND() * 51, 0) = 47 THEN 'Запрос отклонен по техническим причинам.'
               WHEN ROUND(RAND() * 51, 0) = 48 THEN 'Необходимо предоставить документы на ребенка.'
               WHEN ROUND(RAND() * 51, 0) = 49 THEN 'Неправильный тип документа.'
               WHEN ROUND(RAND() * 51, 0) = 50 THEN 'Системная ошибка, попробуйте позже.'
			   WHEN ROUND(RAND() * 51, 0) = 51 THEN null
          ELSE N'' END
	  );
  set @i = @i +1
  print ' Добавлено число ' +  ' -  строк --> ' + convert(nvarchar(10),@i) + '  В таблицу dbo.Connection_Buyer';
  end;
  --rollback
  commit
go