begin tran
create table Country_Audit 
(
AuditID            INTEGER          NOT NULL IDENTITY(1, 1) ,
ModifiedBy         nVARCHAR(128)    null,
ModifiedDate       DATETIME         null,
Operation          CHAR(1)          null,
Id_Country         bigint           null,
Name_Country       nvarchar(150)    null,
Name_English       nvarchar(150)    null,
Cod_Country_Phone  nvarchar(10)     null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Country_Audit  ON dbo.Country
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
                    INSERT  INTO dbo.Country_Audit 
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone           
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.Id_Country        
                                    ,D.Name_Country      
                                    ,D.Name_English      
                                    ,D.Cod_Country_Phone           
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Country_Audit 
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone                   
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.Id_Country        
                                    ,D.Name_Country      
                                    ,D.Name_English      
                                    ,D.Cod_Country_Phone                   
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Country_Audit 
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,Id_Country        
                               ,Name_Country      
                               ,Name_English      
                               ,Cod_Country_Phone                   
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.Id_Country        
                                    ,I.Name_Country      
                                    ,I.Name_English      
                                    ,I.Cod_Country_Phone           
                    FROM    Inserted I
        END
GO
commit
--rollback