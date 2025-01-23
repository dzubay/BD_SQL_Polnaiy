
begin tran
create table dbo.Group_Audit
(
AuditID                 INTEGER        NOT NULL IDENTITY(1, 1),
ModifiedBy              nVARCHAR(128)  null,
ModifiedDate            DATETIME       null,
Operation               CHAR(1)        null,
ID_Group                bigint         null,
ID_Head_Group           bigint         null,
ID_Vice_Head_Group      bigint         null,
ID_Department           bigint         null,
Name_Group              nvarchar(300)  null,
ID_Branch               bigint         null,
Department_Ñode         int            null,
[Description]           nvarchar(1000) null, 
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
go
	CREATE TRIGGER TR_Group_Audit ON dbo.[Group]
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
                    INSERT  INTO dbo.Group_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Group           
							   ,ID_Head_Group      
							   ,ID_Vice_Head_Group 
							   ,ID_Department      
							   ,Name_Group         
							   ,ID_Branch          
							   ,Department_Ñode    
							   ,[Description]                 
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
									,D.ID_Group           
									,D.ID_Head_Group      
									,D.ID_Vice_Head_Group 
									,D.ID_Department      
									,D.Name_Group         
									,D.ID_Branch          
									,D.Department_Ñode    
									,D.[Description]      
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Group_Audit
                            ( 
                                ModifiedBy         
							   ,ModifiedDate       
							   ,Operation          
                               ,ID_Group           
							   ,ID_Head_Group      
							   ,ID_Vice_Head_Group 
							   ,ID_Department      
							   ,Name_Group         
							   ,ID_Branch          
							   ,Department_Ñode    
							   ,[Description]      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Group           
									,D.ID_Head_Group      
									,D.ID_Vice_Head_Group 
									,D.ID_Department      
									,D.Name_Group         
									,D.ID_Branch          
									,D.Department_Ñode    
									,D.[Description]                          
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Group_Audit
                    ( 
                         ModifiedBy         
						,ModifiedDate       
						,Operation          
						,ID_Group           
						,ID_Head_Group      
						,ID_Vice_Head_Group 
						,ID_Department      
						,Name_Group         
						,ID_Branch          
						,Department_Ñode    
						,[Description]                         
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Group           
									,I.ID_Head_Group      
									,I.ID_Vice_Head_Group 
									,I.ID_Department      
									,I.Name_Group         
									,I.ID_Branch          
									,I.Department_Ñode    
									,I.[Description]      
                    FROM    Inserted I
        END
GO
--rollback
commit