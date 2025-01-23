begin tran
create table dbo.[Employees_Audit]
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_Employee                bigint         null,
ID_Department              bigint         null,
ID_Group                   bigint         null,
ID_The_Subgroup            bigint         null,
ID_Passport                bigint         null,
ID_Branch                  bigint         null,
ID_Post                    bigint         null,
ID_Status_Employee         bigint         null,
ID_Connection_String       bigint         null,
ID_Chief                   bigint         null,
Name                       nvarchar(100)  null,
SurName                    nvarchar(100)  null,
LastName                   nvarchar(100)  null,
Date_Of_Hiring             datetime       null, 
Date_Ñard_Ñreated_Employee datetime       null,
Residential_Address        nvarchar(400)  null,
Home_Phone                 nvarchar(30)   null,
Cell_Phone                 nvarchar(30)   null, 
Work_Phone                 nvarchar(30)   null,
Mail                       nvarchar(150)  null,
Pol                        char(1)        null,
Date_Of_Dismissal          datetime       null,
Date_Of_Birth              datetime       null,
[Description]              nvarchar(1000) null, 
Image_Employees            varbinary(max) null,   
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go


	CREATE TRIGGER TR_Employees_Audit ON dbo.Employees
    FOR INSERT, UPDATE, DELETE
AS
    DECLARE @login_name VARCHAR(128) 
    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID
    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Employees_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
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
							   ,Date_Ñard_Ñreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U'            
									,D.ID_Employee               
									,D.ID_Department             
									,D.ID_Group                  
									,D.ID_The_Subgroup           
									,D.ID_Passport               
									,D.ID_Branch                 
									,D.ID_Post                   
									,D.ID_Status_Employee        
									,D.ID_Connection_String      
									,D.ID_Chief                  
									,D.Name                      
									,D.SurName                   
									,D.LastName                  
									,D.Date_Of_Hiring            
									,D.Date_Ñard_Ñreated_Employee
									,D.Residential_Address       
									,D.Home_Phone                
									,D.Cell_Phone                
									,D.Work_Phone                
									,D.Mail                      
									,D.Pol                       
									,D.Date_Of_Dismissal         
									,D.Date_Of_Birth             
									,D.[Description]             
									,D.Image_Employees                                                                                                                 
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Employees_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
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
							   ,Date_Ñard_Ñreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
									,D.ID_Employee               
									,D.ID_Department             
									,D.ID_Group                  
									,D.ID_The_Subgroup           
									,D.ID_Passport               
									,D.ID_Branch                 
									,D.ID_Post                   
									,D.ID_Status_Employee        
									,D.ID_Connection_String      
									,D.ID_Chief                  
									,D.Name                      
									,D.SurName                   
									,D.LastName                  
									,D.Date_Of_Hiring            
									,D.Date_Ñard_Ñreated_Employee
									,D.Residential_Address       
									,D.Home_Phone                
									,D.Cell_Phone                
									,D.Work_Phone                
									,D.Mail                      
									,D.Pol                       
									,D.Date_Of_Dismissal         
									,D.Date_Of_Birth             
									,D.[Description]             
									,D.Image_Employees           
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Employees_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
							   ,ID_Employee               
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
							   ,Date_Ñard_Ñreated_Employee
							   ,Residential_Address       
							   ,Home_Phone                
							   ,Cell_Phone                
							   ,Work_Phone                
							   ,Mail                      
							   ,Pol                       
							   ,Date_Of_Dismissal         
							   ,Date_Of_Birth             
							   ,[Description]             
							   ,Image_Employees           
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
									,I.ID_Employee               
									,I.ID_Department             
									,I.ID_Group                  
									,I.ID_The_Subgroup           
									,I.ID_Passport               
									,I.ID_Branch                 
									,I.ID_Post                   
									,I.ID_Status_Employee        
									,I.ID_Connection_String      
									,I.ID_Chief                  
									,I.Name                      
									,I.SurName                   
									,I.LastName                  
									,I.Date_Of_Hiring            
									,I.Date_Ñard_Ñreated_Employee
									,I.Residential_Address       
									,I.Home_Phone                
									,I.Cell_Phone                
									,I.Work_Phone                
									,I.Mail                      
									,I.Pol                       
									,I.Date_Of_Dismissal         
									,I.Date_Of_Birth             
									,I.[Description]             
									,I.Image_Employees           
                    FROM    Inserted I
        END
GO

commit
--rollback