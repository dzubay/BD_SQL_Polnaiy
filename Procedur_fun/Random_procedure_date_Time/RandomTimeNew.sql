set nocount,xact_abort on
go

CREATE PROCEDURE RandomTimeNew  --процедура для формирования случайного времени
(
  @StartDate DATEtime,
  @EndDate DATEtime,
  @RandomDateTime datetime output
)
AS
BEGIN

    DECLARE @RandomTime DATETIME;
	Declare @TimeResult Datetime;


    /*Проверяем, чтобы начальная дата была равна конечной даты*/
    IF (@StartDate > @EndDate or @StartDate < @EndDate) 
    BEGIN
        PRINT N'@StartDate должна быть равна @EndDate. --> RandomTimeNew';                                           
        RETURN;
    END
	else if (@StartDate is null)
	   begin
	        if (@StartDate is  null) and (@EndDate is  null)
	             begin
	               PRINT N'Обе даты содержат Null. --> RandomTimeNew'; 
	               RETURN;
	             end
	     PRINT N'@StartDate содержит Null. --> RandomTimeNew';                                           
         RETURN;
	   end
	else if (@EndDate is null)
	   begin
	     PRINT N'@EndDate содержит Null. --> RandomTimeNew';                                           
         RETURN;
	   end



    /*Генерируем случайное время от 00:00:00.000 до 23:59:59.999*/
    SET @RandomTime = DATEADD(MILLISECOND, 
        ROUND(RAND() * 86400000, 0),    /*86400000 миллисекунд в дне*/
        CAST('00:00:00.000' AS DATETIME)
    );


	set @TimeResult  = @StartDate + @RandomTime
    /*Объединяем дату и время*/

	/* Пример
    SET @DataResult = DATEADD(SECOND, DATEPART(SECOND, @RandomTime), 
	                                  DATEADD(MINUTE, DATEPART(MINUTE, @RandomTime), 
							          DATEADD(HOUR, DATEPART(HOUR, @RandomTime), 
									  DATEADD (MILLISECOND, DATEPART(MILLISECOND,@RandomTime), @DataResult))));
	SELECT @DataResult;
    */
    set @RandomDateTime = @TimeResult

END;

/*
declare @RandomDateTime datetime
exec RandomTimeNew '20000101','20000101', @RandomDateTime output
select @RandomDateTime
*/