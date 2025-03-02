begin tran
create table Branch_Audit 
(
AuditID       INTEGER         NOT NULL IDENTITY(1, 1) ,
ModifiedBy    nVARCHAR(128)   null,
ModifiedDate  DATETIME        null,
Operation     CHAR(1)         null,
ID_Branch     bigint          null,
Id_Country    bigint          null,
City          nvarchar(100)   null,
[Address]     nvarchar(300)   null,
Name_Branch   nvarchar(300)   null,
Mail          nvarchar(300)   null,
Phone         nvarchar(15)    null,
Postal_Code   int             null,
INN           int             null,
[Description] nvarchar(1000)  null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Branch_Audit ON dbo.Branch
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
                    INSERT  INTO dbo.Branch_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]        
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Branch    
                                    ,D.Id_Country   
                                    ,D.City         
                                    ,D.[Address]    
                                    ,D.Name_Branch  
                                    ,D.Mail         
                                    ,D.Phone        
                                    ,D.Postal_Code  
                                    ,D.INN          
                                    ,D.[Description]            
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Branch_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]                  
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Branch    
                                    ,D.Id_Country   
                                    ,D.City         
                                    ,D.[Address]    
                                    ,D.Name_Branch  
                                    ,D.Mail         
                                    ,D.Phone        
                                    ,D.Postal_Code  
                                    ,D.INN          
                                    ,D.[Description]                     
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Branch_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Branch    
                               ,Id_Country   
                               ,City         
                               ,[Address]    
                               ,Name_Branch  
                               ,Mail         
                               ,Phone        
                               ,Postal_Code  
                               ,INN          
                               ,[Description]                   
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Branch    
                                    ,I.Id_Country   
                                    ,I.City         
                                    ,I.[Address]    
                                    ,I.Name_Branch  
                                    ,I.Mail         
                                    ,I.Phone        
                                    ,I.Postal_Code  
                                    ,I.INN          
                                    ,I.[Description]          
                    FROM    Inserted I
        END
GO
commit
--rollback