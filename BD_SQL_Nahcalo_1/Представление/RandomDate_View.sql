

create view RandomDate_View  
as
select 
(
select 
e.Name 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Name 
from STRING_SPLIT(dbo.RandomDate('19440101','20240110'),',') order by NEWID()) as e) as Name
