
create  function  RandomFIO_Name
(
   @gender     int
 -- ,@Name       nvarchar(50)
  --,@Lastname   nvarchar(50)
  --,@Middlename nvarchar(50)
)
returns nvarchar(50)
as 
begin
declare @Name  nvarchar(50)
set @Name = (select 
case when @gender = 1  then (select [Name] from RandomFIO_W)
     when @gender = 2  then (select [Name] from RandomFIO_G)
	 else ' Нужно ввести 1 или 2' end as Name)
return @Name
end;


--select dbo.RandomFIO_Name(2)

