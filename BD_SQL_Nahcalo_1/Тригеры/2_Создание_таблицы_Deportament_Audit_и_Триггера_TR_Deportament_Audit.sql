
begin tran 
create table dbo.[Department_Audit]
(
AuditID                     INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                  nVARCHAR(128)  null,
ModifiedDate                DATETIME       null,
Operation                   CHAR(1)        null,
ID_Department               bigint         null,
ID_Head_Department          bigint         null,
ID_Vice_Head_Department     bigint         null,
Name_Department             nvarchar(300)  null,
ID_Branch                   bigint         null,
Department_Ñode             int            null,
[Description]               nvarchar(1000) null, 
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Department_Audit ON dbo.Department
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
                    INSERT  INTO dbo.Department_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]            
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
									,D.ID_Department            
									,D.ID_Head_Department       
									,D.ID_Vice_Head_Department  
									,D.Name_Department          
									,D.ID_Branch                
									,D.Department_Ñode          
									,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Department_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]                    
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Department            
									,D.ID_Head_Department       
									,D.ID_Vice_Head_Department  
									,D.Name_Department          
									,D.ID_Branch                
									,D.Department_Ñode          
									,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Department_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Department            
							   ,ID_Head_Department       
							   ,ID_Vice_Head_Department  
							   ,Name_Department          
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]                     
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Department           
									,I.ID_Head_Department      
									,I.ID_Vice_Head_Department 
									,I.Name_Department         
									,I.ID_Branch               
									,I.Department_Ñode         
									,I.[Description]           
                    FROM    Inserted I
        END
GO
commit
--rollback