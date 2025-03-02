
create  function  RandomFIO_Middlename
(
   @gender     int
 -- ,@Name       nvarchar(50)
  --,@Lastname   nvarchar(50)
  --,@Middlename nvarchar(50)
)
returns nvarchar(50)
as 
begin
declare @Middlename  nvarchar(50)
set @Middlename = (select 
case when @gender = 1  then (select Middlename from RandomFIO_W)
     when @gender = 2  then (select Middlename from RandomFIO_G)
	 else ' Нужно ввести 1 или 2' end as Name)
return @Middlename
end;


--select dbo.RandomFIO_@Middlename(2)

