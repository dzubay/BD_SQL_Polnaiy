

begin tran

CREATE TABLE Currency_Audit
(
    AuditID              bigint IDENTITY(1,1)  not null,
    ID_Currency          bigint                null,
 	ModifiedBy           nVARCHAR(128)         null,
    ModifiedDate         DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation            CHAR(1)               null,
    ChangeDescription    nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
)on Orders_Group_2 ;

go

CREATE TRIGGER trg_Currency_Audit ON Currency
AFTER INSERT, UPDATE, DELETE

AS
    DECLARE @login_name nVARCHAR(128) 
	DECLARE @ChangeDescription nvarchar(4000);


    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID

    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Currency_Audit
                            ( 
                               ID_Currency            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Currency
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                                              
	                       
						   DECLARE @OldID_Currency         BIGINT
						   DECLARE @OldFull_name_rus       NVARCHAR(300);
						   DECLARE @OldFull_name_eng       NVARCHAR(300);
						   DECLARE @OldAbbreviation_rus    NVARCHAR(15);
						   DECLARE @OldAbbreviation_eng    NVARCHAR(15);
						   DECLARE @OldDescription         NVARCHAR(4000);

						   DECLARE @NewID_Currency         BIGINT
						   DECLARE @NewFull_name_rus       NVARCHAR(300);
						   DECLARE @NewFull_name_eng       NVARCHAR(300);
						   DECLARE @NewAbbreviation_rus    NVARCHAR(15);
						   DECLARE @NewAbbreviation_eng    NVARCHAR(15);
						   DECLARE @NewDescription         NVARCHAR(4000);


							SELECT 
							@NewID_Currency        = ID_Currency,     
							@NewFull_name_rus      = Full_name_rus,   
							@NewFull_name_eng      = Full_name_eng,   
							@NewAbbreviation_rus   = Abbreviation_rus,
							@NewAbbreviation_eng   = Abbreviation_eng,
							@NewDescription        = [Description]     
							FROM inserted;

							SELECT 
							@OldID_Currency        = ID_Currency,     
							@OldFull_name_rus      = Full_name_rus,   
							@OldFull_name_eng      = Full_name_eng,   
							@OldAbbreviation_rus   = Abbreviation_rus,
							@OldAbbreviation_eng   = Abbreviation_eng,
							@OldDescription        = [Description]    
                            FROM deleted;

                         
                            IF @NewFull_name_rus <> @OldFull_name_rus 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Full_name_rus = Old ->"' +  ISNULL(@OldFull_name_rus,'') + ' " NEW -> " ' + isnull(@NewFull_name_rus,'') + '", ';
							   end
                            IF @NewFull_name_eng <> @OldFull_name_eng
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Full_name_eng = Old ->"' + ISNULL(@OldFull_name_eng,'') + ' " NEW -> "' + ISNULL(@NewFull_name_eng,'') + '", ';
							   end

                            IF @NewAbbreviation_rus <> @OldAbbreviation_rus 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Abbreviation_rus = Old ->"' +  ISNULL(@OldAbbreviation_rus,'') + ' " NEW -> " ' + isnull(@NewAbbreviation_rus,'') + '", ';
							   end
                            IF @NewAbbreviation_eng <> @OldAbbreviation_eng
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Abbreviation_eng = Old ->"' + ISNULL(@OldAbbreviation_eng,'') + ' " NEW -> "' + ISNULL(@NewAbbreviation_eng,'') + '", ';
							   end

                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' TypeItem = (' +  isnull(cast(@OldID_Currency as nvarchar(20)),'')+ ') ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Currency_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Currency_Audit
                            ( 
                               ID_Currency       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Currency
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

							DECLARE @OldID_Currency_2         BIGINT
							DECLARE @OldFull_name_rus_2       NVARCHAR(300);
							DECLARE @OldFull_name_eng_2       NVARCHAR(300);
							DECLARE @OldAbbreviation_rus_2    NVARCHAR(15);
							DECLARE @OldAbbreviation_eng_2    NVARCHAR(15);
							DECLARE @OldDescription_2         NVARCHAR(4000);
                            
                            
                
                            
                            SELECT 
							@OldID_Currency_2        = ID_Currency,     
							@OldFull_name_rus_2      = Full_name_rus,   
                            @OldFull_name_eng_2      = Full_name_eng,   
                            @OldAbbreviation_rus_2   = Abbreviation_rus,
                            @OldAbbreviation_eng_2   = Abbreviation_eng,
                            @OldDescription_2        = [Description]   
							FROM deleted;

                            SET @ChangeDescription = 'Deleted: '
                                                 + 'Id_TypeItem="' + CAST(@OldID_Currency_2 AS NVARCHAR(20)) + '", '
                                                 + 'TypeItemName="' + ISNULL(@OldFull_name_rus_2, '') + '", '
                                                 + 'SysTypeItemName="' + ISNULL(@OldAbbreviation_rus_2, '') + '", '
												 + 'SysTypeItemName="' + ISNULL(@OldAbbreviation_eng_2, '') + '", '
                                                 + 'Description="' + ISNULL(@OldDescription_2, '') + '" ';
                            
                          update u
						  set ChangeDescription = @ChangeDescription
						  from Currency_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Currency_Audit
                    ( 
                          ID_Currency  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Currency
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Currency_3 BIGINT;
                    SELECT @ID_Currency_3 = ID_Currency FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'Id_TypeItem="' + CAST(@ID_Currency_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Currency_Audit i
					where @AuditID_3  = AuditID                

                    END

GO


--rollback
commit


