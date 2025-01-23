

create procedure RandomFIO
@gender int   
as
select 
(
select 
e.Name 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Name 
from STRING_SPLIT(dbo.RandomName(@gender),',') order by NEWID()) as e) as Name
,
(select 
e_2.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomLastname(@gender),',') order by NEWID()) as e_2) as Lastname 
,
(select 
e_3.Lastname 
from
(select top 1
ROW_NUMBER() over (order by value) as Num
,value as Lastname 
from STRING_SPLIT(dbo.RandomMiddlename(@gender),',') order by NEWID()) as e_3) as Middlename
go


--exec RandomFIO @gender = 2

