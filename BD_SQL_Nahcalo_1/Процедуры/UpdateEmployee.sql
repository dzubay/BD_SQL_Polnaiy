
begin tran
USE [Magaz_DB]
GO

create procedure UpdateEmployee
 @ID_Employee                    bigint         
,@ID_Department					 bigint        	     
,@ID_Group						 bigint        	   	 
,@ID_The_Subgroup				 bigint        	   	 
,@ID_Passport					 bigint        	   	 
,@ID_Branch						 bigint        	   	 
,@ID_Post						 bigint        	   	 
,@ID_Status_Employee			 bigint        	   	 
,@ID_Connection_String			 bigint        	   	 
,@ID_Chief						 bigint        	   	 
,@Name							 nvarchar(100) 	   	 
,@SurName						 nvarchar(100) 	   	 
,@LastName						 nvarchar(100) 	   	 
,@Date_Of_Hiring				 datetime      	   	      	   	 
,@Residential_Address			 nvarchar(400) 	   	 
,@Home_Phone					 nvarchar(30)           	   	 
,@Cell_Phone					 nvarchar(30)           	   	 
,@Image_Employees				 varbinary(max)	   	 
,@Work_Phone					 nvarchar(30)           	   	 
,@Mail							 nvarchar(150) 	   	 
,@Pol							 char(1)       	   	 
,@Date_Of_Dismissal				 datetime      	   	 
,@Date_Of_Birth					 datetime      	   	 
,@Description					 nvarchar(1000)	   	 
as
		
Declare
 @2_ID_Employee                      bigint
,@2_ID_Department					 bigint        	  
,@2_ID_Group						 bigint        	  
,@2_ID_The_Subgroup				     bigint        	  
,@2_ID_Passport					     bigint        	  
,@2_ID_Branch						 bigint        	  
,@2_ID_Post						     bigint        	  
,@2_ID_Status_Employee			     bigint        	  
,@2_ID_Connection_String			 bigint        	  
,@2_ID_Chief						 bigint        	  
,@2_Name							 nvarchar(100) 	  
,@2_SurName						     nvarchar(100) 	  
,@2_LastName						 nvarchar(100) 	  
,@2_Date_Of_Hiring				     datetime      	       	  
,@2_Residential_Address			     nvarchar(400) 	  
,@2_Home_Phone					     nvarchar(30)           	  
,@2_Cell_Phone					     nvarchar(30)           	  
,@2_Image_Employees				     varbinary(max)	  
,@2_Work_Phone					     nvarchar(30)           	  
,@2_Mail							 nvarchar(150) 	  
,@2_Pol							     char(1)       	  
,@2_Date_Of_Dismissal				 datetime      	  
,@2_Date_Of_Birth					 datetime      	  
,@2_Description					     nvarchar(1000)	  

declare @Update table
(
ID_Employee                bigint         null      ,
ID_Department              bigint         null      ,
ID_Group                   bigint         null      ,
ID_The_Subgroup            bigint         null      ,
ID_Passport                bigint         not null  ,
ID_Branch                  bigint         null      ,
ID_Post                    bigint         null      ,
ID_Status_Employee         bigint         null      ,
ID_Connection_String       bigint         null      ,
ID_Chief                   bigint         null      ,
Name                       nvarchar(100)  null      ,
SurName                    nvarchar(100)  null      ,
LastName                   nvarchar(100)  null      ,
Date_Of_Hiring             datetime       not null  ,
Residential_Address        nvarchar(400)  null      ,
Home_Phone                 nvarchar(30)   null      ,
Cell_Phone                 nvarchar(30)   null      ,
Image_Employees            varbinary(max) null      ,    
Work_Phone                 nvarchar(30)   null      ,
Mail                       nvarchar(150)  null      ,
Pol                        char(1)        not null  , 
Date_Of_Dismissal          datetime       null      ,
Date_Of_Birth              datetime       not null  ,
[Description]              nvarchar(1000) null       				
)


insert into  @Update (
ID_Employee 
,ID_Department				
,ID_Group					
,ID_The_Subgroup			    
,ID_Passport				    
,ID_Branch					
,ID_Post					    
,ID_Status_Employee			
,ID_Connection_String		
,ID_Chief					
,Name						
,SurName					    
,LastName					
,Date_Of_Hiring				
,Residential_Address		    
,Home_Phone					
,Cell_Phone					
,Image_Employees			    
,Work_Phone					
,Mail						
,Pol						    
,Date_Of_Dismissal			
,Date_Of_Birth				
,Description	
)
values
(
@ID_Employee 
,@ID_Department				         
,@ID_Group					         
,@ID_The_Subgroup				 
,@ID_Passport					 
,@ID_Branch					         
,@ID_Post						 
,@ID_Status_Employee				     
,@ID_Connection_String		         
,@ID_Chief					         
,@Name						         
,@SurName						 
,@LastName					         
,@Date_Of_Hiring					     	     
,@Residential_Address			 
,@Home_Phone						     
,@Cell_Phone						     
,@Image_Employees				 
,@Work_Phone						     
,@Mail						         
,@Pol							 
,@Date_Of_Dismissal			         
,@Date_Of_Birth				         
,@Description	
)				 



declare mycur_Update cursor local fast_forward read_only for

select 
ID_Employee 
,ID_Department				
,ID_Group					
,ID_The_Subgroup			
,ID_Passport				
,ID_Branch					
,ID_Post					
,ID_Status_Employee		
,ID_Connection_String		
,ID_Chief					
,Name						
,SurName					
,LastName					
,Date_Of_Hiring			
,Residential_Address		
,Home_Phone				
,Cell_Phone				
,Image_Employees			
,Work_Phone				
,Mail						
,Pol						
,Date_Of_Dismissal			
,Date_Of_Birth				
,Description				
from @Update

  
open  mycur_Update

fetch next from mycur_Update into 
           @2_ID_Employee 
          ,@2_ID_Department				
		  ,@2_ID_Group					
		  ,@2_ID_The_Subgroup				
		  ,@2_ID_Passport					
		  ,@2_ID_Branch					
		  ,@2_ID_Post						
		  ,@2_ID_Status_Employee			
		  ,@2_ID_Connection_String		
		  ,@2_ID_Chief					
		  ,@2_Name						
		  ,@2_SurName						
		  ,@2_LastName					
		  ,@2_Date_Of_Hiring				
		  ,@2_Residential_Address			
		  ,@2_Home_Phone					
		  ,@2_Cell_Phone					
		  ,@2_Image_Employees				
		  ,@2_Work_Phone					
		  ,@2_Mail						
		  ,@2_Pol							
		  ,@2_Date_Of_Dismissal			
		  ,@2_Date_Of_Birth				
		  ,@2_Description					
       
   while @@FETCH_STATUS = 0 
      begin
        begin try
		    update s
			  set   ID_Department		  =  @2_ID_Department				,
			        ID_Group			  =  @2_ID_Group					,
			        ID_The_Subgroup		  =  @2_ID_The_Subgroup				,
			        ID_Passport			  =  @2_ID_Passport					,
			        ID_Branch			  =  @2_ID_Branch					,
			        ID_Post				  =  @2_ID_Post						,
			        ID_Status_Employee	  =  @2_ID_Status_Employee			,
			        ID_Connection_String  =  @2_ID_Connection_String		,
			        ID_Chief			  =  @2_ID_Chief					,
			        Name				  =  @2_Name						,
			        SurName				  =  @2_SurName						,
			        LastName			  =  @2_LastName					,
			        Date_Of_Hiring		  =  @2_Date_Of_Hiring				,
			        Residential_Address	  =  @2_Residential_Address			,
			        Home_Phone			  =  @2_Home_Phone					,
			        Cell_Phone			  =  @2_Cell_Phone					,
			        Image_Employees		  =  @2_Image_Employees				,
			        Work_Phone			  =  @2_Work_Phone					,
			        Mail				  =  @2_Mail						,
			        Pol					  =  @2_Pol							,
			        Date_Of_Dismissal	  =  @2_Date_Of_Dismissal			,
			        Date_Of_Birth		  =  @2_Date_Of_Birth				,
			        Description	          =  @2_Description					
			  from   Employees as s
              where ID_Employee =  @2_ID_Employee
		end try
		begin catch
		    if xact_state() in (1, -1)
			   ROLLBACK TRAN
			SELECT 
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage;
		end catch
      fetch next from mycur_Update into 
	      @2_ID_Employee
		 ,@2_ID_Department				
		 ,@2_ID_Group					
		 ,@2_ID_The_Subgroup				
		 ,@2_ID_Passport					
		 ,@2_ID_Branch					
		 ,@2_ID_Post						
		 ,@2_ID_Status_Employee			
		 ,@2_ID_Connection_String		
		 ,@2_ID_Chief					
		 ,@2_Name						
		 ,@2_SurName						
		 ,@2_LastName					
		 ,@2_Date_Of_Hiring				
		 ,@2_Residential_Address			
		 ,@2_Home_Phone					
		 ,@2_Cell_Phone					
		 ,@2_Image_Employees				
		 ,@2_Work_Phone					
		 ,@2_Mail						
		 ,@2_Pol							
		 ,@2_Date_Of_Dismissal			
		 ,@2_Date_Of_Birth				
		 ,@2_Description					
	end
close mycur_Update
deallocate mycur_Update

go

--rollback
commit


/*
ID_Employee                bigint         not null identity (1,1) check(ID_Employee !=0),
ID_Department              bigint         null,
ID_Group                   bigint         null,
ID_The_Subgroup            bigint         null,
ID_Passport                bigint         not null,
ID_Branch                  bigint         null,
ID_Post                    bigint         null,
ID_Status_Employee         bigint         null,
ID_Connection_String       bigint         null,
ID_Chief                   bigint         null,
Name                       nvarchar(100)  null,
SurName                    nvarchar(100)  null,
LastName                   nvarchar(100)  null,
Date_Of_Hiring             datetime       not null, 
Date_Ñard_Ñreated_Employee datetime       not null default GetDate(),
Residential_Address        nvarchar(400)  null,
Home_Phone                 nvarchar(30)   null,
Cell_Phone                 nvarchar(30)   null,
Image_Employees            varbinary(max) null,    
Work_Phone                 nvarchar(30)   null,
Mail                       nvarchar(150)  null,
Pol                        char(1)        not null CHECK (Pol IN ('Ì', 'Æ')),
Date_Of_Dismissal          datetime       null,
Date_Of_Birth              datetime       not null,
[Description]              nvarchar(1000) null, 
*/