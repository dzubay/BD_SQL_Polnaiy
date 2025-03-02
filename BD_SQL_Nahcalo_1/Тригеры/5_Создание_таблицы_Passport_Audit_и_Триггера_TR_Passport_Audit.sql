begin tran
create table dbo.Passport_Audit
(
AuditID                    INTEGER        NOT NULL IDENTITY(1, 1) ,
ModifiedBy                 nVARCHAR(128)  null,
ModifiedDate               DATETIME       null,
Operation                  CHAR(1)        null,
ID_Passport                bigint         null,
Number_Series              nvarchar(100)  null,
Date_Of_Issue              Datetime       null,
Department_Code            nvarchar(20)   null,
Issued_By_Whom             nvarchar(400)  null,
Registration               nvarchar(200)  null,
Military_Duty              nvarchar(200)  null,
[Description]              nvarchar(1000) null,
PRIMARY KEY CLUSTERED ( AuditID )
) on Employee_Group
go
	CREATE TRIGGER TR_Passport_Audit ON dbo.Passport
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
                    INSERT  INTO dbo.Passport_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport      
                               ,Number_Series    
                               ,Date_Of_Issue    
                               ,Department_Code  
                               ,Issued_By_Whom   
                               ,Registration     
                               ,Military_Duty    
                               ,[Description]             
                            )
                            SELECT  
                                     @login_name            
									,GETDATE()             
									,'U' 
                                    ,D.ID_Passport      
                                    ,D.Number_Series    
                                    ,D.Date_Of_Issue    
                                    ,D.Department_Code  
                                    ,D.Issued_By_Whom   
                                    ,D.Registration     
                                    ,D.Military_Duty    
                                    ,D.[Description]              
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Passport_Audit
                            ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport     
                               ,Number_Series   
                               ,Date_Of_Issue   
                               ,Department_Code 
                               ,Issued_By_Whom  
                               ,Registration    
                               ,Military_Duty   
                               ,[Description]                      
                            )
                            SELECT  
                                     @login_name
									,GETDATE() 
									,'D'
                                    ,D.ID_Passport     
                                    ,D.Number_Series   
                                    ,D.Date_Of_Issue   
                                    ,D.Department_Code 
                                    ,D.Issued_By_Whom  
                                    ,D.Registration    
                                    ,D.Military_Duty   
                                    ,D.[Description]                      
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Passport_Audit
                    ( 
                                ModifiedBy                
							   ,ModifiedDate              
							   ,Operation                 
                               ,ID_Passport     
                               ,Number_Series   
                               ,Date_Of_Issue   
                               ,Department_Code 
                               ,Issued_By_Whom  
                               ,Registration    
                               ,Military_Duty   
                               ,[Description]                      
                            )
                            SELECT   
									 @login_name
									,GETDATE() 
									,'I'
                                    ,I.ID_Passport     
                                    ,I.Number_Series   
                                    ,I.Date_Of_Issue   
                                    ,I.Department_Code 
                                    ,I.Issued_By_Whom  
                                    ,I.Registration    
                                    ,I.Military_Duty   
                                    ,I.[Description]              
                    FROM    Inserted I
        END
GO
--rollback
commit