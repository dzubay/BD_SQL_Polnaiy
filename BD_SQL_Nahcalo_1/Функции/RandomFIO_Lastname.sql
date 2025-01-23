
create  function  RandomFIO_Lastname
(
   @gender     int
 -- ,@Name       nvarchar(50)
  --,@Lastname   nvarchar(50)
  --,@Middlename nvarchar(50)
)
returns nvarchar(50)
as 
begin
declare @Lastname   nvarchar(50)
set @Lastname = (select 
case when @gender = 1  then (select Lastname from RandomFIO_W)
     when @gender = 2  then (select Lastname from RandomFIO_G)
	 else ' Нужно ввести 1 или 2' end as Name)
return @Lastname
end;


--select dbo.RandomFIO_Lastname(1)

