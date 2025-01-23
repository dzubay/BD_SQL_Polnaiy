
begin tran
create table Post_Audit  
(
AuditID               INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy            nVARCHAR(128)  null,
ModifiedDate          DATETIME       null,
Operation             CHAR(1)        null,
ID_Post               bigint         null,
Name_Post             nvarchar(200)  null,
ID_Department         bigint         null,
ID_Group              bigint         null,
ID_The_Subgroup       bigint         null,
[Description]         nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Post_Audit ON dbo.Post
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
                    INSERT  INTO dbo.Post_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]             
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Post         
                                    ,D.Name_Post       
                                    ,D.ID_Department   
                                    ,D.ID_Group        
                                    ,D.ID_The_Subgroup 
                                    ,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Post_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]                      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Post         
                                    ,D.Name_Post       
                                    ,D.ID_Department   
                                    ,D.ID_Group        
                                    ,D.ID_The_Subgroup 
                                    ,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Post_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Post         
                               ,Name_Post       
                               ,ID_Department   
                               ,ID_Group        
                               ,ID_The_Subgroup 
                               ,[Description]                       
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Post         
                                    ,I.Name_Post       
                                    ,I.ID_Department   
                                    ,I.ID_Group        
                                    ,I.ID_The_Subgroup 
                                    ,I.[Description]             
                    FROM    Inserted I
        END
GO
--rollback
commit