﻿
create  function RandomDate
(
  @StartDate date,
  @EndDate date
)
returns nvarchar(max)
as
begin
declare @DateRange table (DateValue date);

;with DateGenerator as (
    select @StartDate as DateValue
    union all
    select DATEADD(DAY, 1, DateValue)
    from DateGenerator
    where DATEADD(DAY, 1, DateValue) <= @EndDate
)
insert into @DateRange
select DateValue
from DateGenerator
option (maxrecursion  0);

 declare @Date nvarchar(max) = (SELECT  STRING_AGG(Cast(DateValue as nvarchar(max)),',')  AS Result FROM @DateRange)
 RETURN  @Date
end



-- select dbo.RandomDate('19440101','20240110')