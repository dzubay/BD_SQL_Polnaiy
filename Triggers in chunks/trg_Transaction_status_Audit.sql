begin tran 

CREATE TABLE Transaction_status_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Transaction_status  bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Transaction_status_Audit ON Transaction_status
AFTER INSERT, UPDATE, DELETE

AS
    DECLARE @login_name nVARCHAR(128) 
	DECLARE @ChangeDescription nvarchar(max);


    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID

    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Transaction_status_Audit
                            ( 
                               ID_Transaction_status            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Transaction_status
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
	                        DECLARE @OldID_Transaction_status      bigint           ;
						    DECLARE @OldTypeTransactionName        nvarchar(300)	;
						    DECLARE @OldSysTypeTransactionName     nvarchar(300)	;
	                        DECLARE @OldDescription                nvarchar(4000)	;

		                    DECLARE @NewID_Transaction_status      bigint           ;
							DECLARE @NewTypeTransactionName        nvarchar(300)	;
							DECLARE @NewSysTypeTransactionName     nvarchar(300)	;
							DECLARE @NewDescription                nvarchar(4000)	;
                         
							SELECT  
							     @NewID_Transaction_status    = ID_Transaction_status   , 
								 @NewTypeTransactionName      = TypeTransactionName    	,
								 @NewSysTypeTransactionName   = SysTypeTransactionName 	,
								 @NewDescription              = [Description]           
							FROM inserted;									 

							SELECT  
							     @OldID_Transaction_status    = ID_Transaction_status  ,
								 @OldTypeTransactionName      = TypeTransactionName    ,
								 @OldSysTypeTransactionName   = SysTypeTransactionName ,
								 @OldDescription              = [Description]          
							FROM Deleted;																		 

                            IF @NewTypeTransactionName <> @OldTypeTransactionName 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  TypeTransactionName = Old ->"' +  ISNULL(@OldTypeTransactionName,'') + ' " NEW -> " ' + isnull(@NewTypeTransactionName,'') + '", ';
							   end
                            
							IF @NewSysTypeTransactionName <> @OldSysTypeTransactionName
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SysTypeTransactionName = Old ->"' +  ISNULL(@OldTypeTransactionName,'') + ' " NEW -> " ' + isnull(@NewTypeTransactionName,'') + '", ';
							   end
							
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_Transaction_status = "' +  isnull(cast(@OldID_Transaction_status as nvarchar(20)),'')+ '" ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Transaction_status_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Transaction_status_Audit
                            ( 
                               ID_Transaction_status       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Transaction_status
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

							DECLARE @OldID_Transaction_status_2      bigint         ;
							DECLARE @OldTypeTransactionName_2        nvarchar(300)	;
							DECLARE @OldSysTypeTransactionName_2     nvarchar(300)	;
							DECLARE @OldDescription_2                nvarchar(4000)	;

                            SELECT 
							    @OldID_Transaction_status_2   = ID_Transaction_status  ,
								@OldTypeTransactionName_2     = TypeTransactionName    ,
								@OldSysTypeTransactionName_2  = SysTypeTransactionName ,
								@OldDescription_2             = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Transaction_status'    +' = "'+  ISNULL(CAST(@OldID_Transaction_status_2 AS NVARCHAR(50)),'')     + '", '
							+ 'TypeTransactionName'      +' = "'+  ISNULL(@OldTypeTransactionName_2,'')+ '", '				
							+ 'SysTypeTransactionName'   +' = "'+  ISNULL(@OldSysTypeTransactionName_2,'')+ '", '
							+ 'Description'              +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '
						  

						  IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                          update u
						  set ChangeDescription = @ChangeDescription
						  from Transaction_status_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Transaction_status_Audit
                    ( 
                          ID_Transaction_status  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Transaction_status
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Transaction_status_3 BIGINT;
                    SELECT @ID_Transaction_status_3 = ID_Transaction_status FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Transaction_status = "' + CAST(@ID_Transaction_status_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Transaction_status_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit

