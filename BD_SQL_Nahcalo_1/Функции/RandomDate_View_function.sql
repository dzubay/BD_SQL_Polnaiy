create function RandomDate_View_function
(
)
Returns date
as 
begin
declare @RandomDate date
set @RandomDate = cast((select *  from RandomDate_View) as date)
return @RandomDate
end;


--select dbo.RandomDate_View_function()