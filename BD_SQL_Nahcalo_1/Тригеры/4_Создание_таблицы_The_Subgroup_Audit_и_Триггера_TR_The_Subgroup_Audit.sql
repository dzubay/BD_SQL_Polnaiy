
begin tran
create table dbo.[The_Subgroup_Audit] 
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_The_Subgroup            bigint         null,
ID_Head_The_Subgroup       bigint         null,
ID_Vice_Head_The_Subgroup  bigint         null,
ID_Group                   bigint         null,
Name_The_Subgroup          nvarchar(300)  null,
ID_Branch                  bigint         null,
Department_Ñode            int            null,
[Description]              nvarchar(1000) null,
ID_Parent_The_Subgroup     bigint         null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go

	CREATE TRIGGER TR_The_Subgroupt_Audit ON dbo.The_Subgroup
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
                    INSERT  INTO dbo.The_Subgroup_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_The_Subgroup          
							   ,ID_Head_The_Subgroup     
							   ,ID_Vice_Head_The_Subgroup
							   ,ID_Group                 
							   ,Name_The_Subgroup        
							   ,ID_Branch                
							   ,Department_Ñode          
							   ,[Description]            
							   ,ID_Parent_The_Subgroup            
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_The_Subgroup          
                                    ,D.ID_Head_The_Subgroup     
                                    ,D.ID_Vice_Head_The_Subgroup
                                    ,D.ID_Group                 
                                    ,D.Name_The_Subgroup        
                                    ,D.ID_Branch                
                                    ,D.Department_Ñode          
                                    ,D.[Description]            
                                    ,D.ID_Parent_The_Subgroup                   
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.The_Subgroup_Audit
                            ( 
                                ModifiedBy                
                               ,ModifiedDate              
                               ,Operation                 
                               ,ID_The_Subgroup          
                               ,ID_Head_The_Subgroup     
                               ,ID_Vice_Head_The_Subgroup
                               ,ID_Group                 
                               ,Name_The_Subgroup        
                               ,ID_Branch                
                               ,Department_Ñode          
                               ,[Description]            
                               ,ID_Parent_The_Subgroup                          
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_The_Subgroup          
                                    ,D.ID_Head_The_Subgroup     
                                    ,D.ID_Vice_Head_The_Subgroup
                                    ,D.ID_Group                 
                                    ,D.Name_The_Subgroup        
                                    ,D.ID_Branch                
                                    ,D.Department_Ñode          
                                    ,D.[Description]            
                                    ,D.ID_Parent_The_Subgroup                       
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.The_Subgroup_Audit
                    ( 
                                 ModifiedBy                
                                ,ModifiedDate              
                                ,Operation                 
                                ,ID_The_Subgroup          
                                ,ID_Head_The_Subgroup     
                                ,ID_Vice_Head_The_Subgroup
                                ,ID_Group                 
                                ,Name_The_Subgroup        
                                ,ID_Branch                
                                ,Department_Ñode          
                                ,[Description]            
                                ,ID_Parent_The_Subgroup                         
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_The_Subgroup          
                                    ,I.ID_Head_The_Subgroup     
                                    ,I.ID_Vice_Head_The_Subgroup
                                    ,I.ID_Group                 
                                    ,I.Name_The_Subgroup        
                                    ,I.ID_Branch                
                                    ,I.Department_Ñode          
                                    ,I.[Description]            
                                    ,I.ID_Parent_The_Subgroup               
                    FROM    Inserted I
        END
GO

--rollback
commit