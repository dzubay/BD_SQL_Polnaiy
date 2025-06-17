
create  procedure RandomDateNew
(
  @StartDate date,
  @EndDate date,
  @RandomDate datetime output
)
as
begin

declare @DateDayRaz int;
declare @DataRezult datetime;
 
  /*Проверяем, чтобы начальная дата была меньше конечной даты*/
if @StartDate >= @EndDate
  begin
      print  N'@StartDate не должна ровняться с @EndDate. --> RandomDateNew '; 	   
	  RETURN;
  end
else if (@StartDate is null)
	   begin
	        if (@StartDate is  null) and (@EndDate is  null)
	             begin
	               PRINT N'Обе даты содержат Null. --> RandomDateNew'; 
	               RETURN;
	             end
	     PRINT N'@StartDate содержит Null. --> RandomDateNew';                                           
         RETURN;
	   end
else if (@EndDate is null)
   begin
	   PRINT N'@EndDate содержит Null. --> RandomDateNew';                                           
       RETURN;
   end
else 
  begin 
       /*Рассчитываем разницу в днях между датами*/
       set @DateDayRaz = (SELECT DATEDIFF(DAY, @StartDate,@EndDate));
	   /*Генерируем случайную дату в пределах заданного диапазона*/
       set @DataRezult = (select dateadd(day,round(rand()* @DateDayRaz,0),@StartDate));
	   set @RandomDate = @DataRezult
  end;
end;

--exec RandomDateNew  '19440101','19440102', @RandomDate output


