set nocount,xact_abort on
go

create procedure RandomPhone
   (
   @TypePhone bit 
   )
as
begin;
   declare @PhoneMobil  nvarchar(15);
   declare @PhoneHome   nvarchar(10);
   if @TypePhone = 1
         begin
             set @PhoneMobil = '('+ cast((FLOOR(124*RAND()+875)) as nvarchar(3)) +')'+
             + REPLACE(STR(cast(round(rand()*999,0) as nvarchar(3)),3,0),' ','0') + '-' 
             + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' 
             + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0');
			 select @PhoneMobil  as PhoneMobil;
			 return;
         end
	  else 
	     begin; 
		     set @PhoneHome =  REPLACE(cast(round(FLOOR(899*rand()+100),0) as nvarchar(3)),' ','0') + '-' 
             + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0') + '-' 
             + REPLACE(STR(cast(round(rand()*99,0) as nvarchar(2)),2,0),' ','0');
			 select @PhoneHome  as PhoneHome;
			 return;
		 end;  
end;


--exec RandomPhone 0