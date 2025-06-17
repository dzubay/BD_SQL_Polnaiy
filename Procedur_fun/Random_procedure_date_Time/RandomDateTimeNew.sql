set nocount,xact_abort on
go

CREATE PROCEDURE RandomDateTimeNew  --процедура для формирования случайной даты и времени 
(
  @StartDate DATE,
  @EndDate DATE,
  @RandomDate datetime output
)
AS
BEGIN

    DECLARE @DateDayRaz INT;
    DECLARE @DataResult DATETIME;
    DECLARE @RandomTime DATETIME;
	Declare @DataTimeResult Datetime;


    /*Проверяем, чтобы начальная дата была меньше конечной даты*/
    IF @StartDate >= @EndDate
    BEGIN
        PRINT N'@StartDate должна быть меньше @EndDate. --> RandomDateTimeNew';                                           
        RETURN;
    END
	else if (@StartDate is null)
	   begin
	        if (@StartDate is  null) and (@EndDate is  null)
	             begin
	               PRINT N'Обе даты содержат Null. --> RandomDateTimeNew'; 
	               RETURN;
	             end
	     PRINT N'@StartDate содержит Null. --> RandomDateTimeNew';                                           
         RETURN;
	   end
	else if (@EndDate is null)
	   begin
	     PRINT N'@EndDate содержит Null. --> RandomDateTimeNew';                                           
         RETURN;
	   end

    
    /*Рассчитываем разницу в днях между датами*/
    SET @DateDayRaz = DATEDIFF(DAY, @StartDate, @EndDate);
    
    /*Генерируем случайную дату в пределах заданного диапазона*/
    SET @DataResult = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % (@DateDayRaz + 1), @StartDate);

    /*Генерируем случайное время от 00:00:00.000 до 23:59:59.999*/
    SET @RandomTime = DATEADD(MILLISECOND, 
        ABS(CHECKSUM(NEWID())) % 86400000,    /*86400000 миллисекунд в дне*/
        CAST('00:00:00.000' AS DATETIME)
    );


	set @DataTimeResult  = @DataResult + @RandomTime
    /*Объединяем дату и время*/

	/* Пример
    SET @DataResult = DATEADD(SECOND, DATEPART(SECOND, @RandomTime), 
	                                  DATEADD(MINUTE, DATEPART(MINUTE, @RandomTime), 
							          DATEADD(HOUR, DATEPART(HOUR, @RandomTime), 
									  DATEADD (MILLISECOND, DATEPART(MILLISECOND,@RandomTime), @DataResult))));
	SELECT @DataResult;
    */
    set @RandomDate = @DataTimeResult

END;




--exec RandomDateTimeNew '19410101','20200202', @RandomDate output