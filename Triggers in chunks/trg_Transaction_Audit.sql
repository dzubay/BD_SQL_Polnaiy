begin tran 

CREATE TABLE TRANSACTION_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Transaction         bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Transaction_Audit ON [dbo].[Transaction]
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
                    INSERT  INTO dbo.TRANSACTION_Audit
                            ( 
                               ID_Transaction            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Transaction
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
                            DECLARE @OldID_Transaction                  bigint          ;
							DECLARE @OldID_Currency                     bigint       	;
							DECLARE @OldID_Transaction_status           bigint       	;
							DECLARE @OldID_Currency_Rate                bigint       	;
							DECLARE @OldTransaction_Date                datetime     	;
							DECLARE @OldKeySource                       bigint       	;
							DECLARE @OldTransaction_name_sender         nvarchar(500)	;
							DECLARE @OldJSON_Transaction_sender         nvarchar(max)	;
							DECLARE @OldTransaction_Amount              float        	;
							DECLARE @OldDescription                     nvarchar(4000)	;

							DECLARE @NewID_Transaction                  bigint          ;
							DECLARE @NewID_Currency                     bigint       	;
							DECLARE @NewID_Transaction_status           bigint       	;
							DECLARE @NewID_Currency_Rate                bigint       	;
							DECLARE @NewTransaction_Date                datetime     	;
							DECLARE @NewKeySource                       bigint       	;
							DECLARE @NewTransaction_name_sender         nvarchar(500)	;
							DECLARE @NewJSON_Transaction_sender         nvarchar(max)	;
							DECLARE @NewTransaction_Amount              float        	;
							DECLARE @NewDescription                     nvarchar(4000)	;
                         
							SELECT  
                                  @NewID_Transaction          = ID_Transaction          ,
								  @NewID_Currency             = ID_Currency            	,
								  @NewID_Transaction_status   = ID_Transaction_status  	,
								  @NewID_Currency_Rate        = ID_Currency_Rate       	,
								  @NewTransaction_Date        = Transaction_Date       	,
								  @NewKeySource               = KeySource              	,
								  @NewTransaction_name_sender = Transaction_name_sender	,
								  @NewJSON_Transaction_sender = JSON_Transaction_sender	,
								  @NewTransaction_Amount      = Transaction_Amount     	,
								  @NewDescription             = [Description]                      
							FROM inserted;									 

							SELECT  
                                  @OldID_Transaction          = ID_Transaction          ,
								  @OldID_Currency             = ID_Currency            	,
								  @OldID_Transaction_status   = ID_Transaction_status  	,
								  @OldID_Currency_Rate        = ID_Currency_Rate       	,
								  @OldTransaction_Date        = Transaction_Date       	,
								  @OldKeySource               = KeySource              	,
								  @OldTransaction_name_sender = Transaction_name_sender	,
								  @OldJSON_Transaction_sender = JSON_Transaction_sender	,
								  @OldTransaction_Amount      = Transaction_Amount     	,
								  @OldDescription             = [Description]                           
							FROM Deleted;																		 

                            IF @NewID_Currency <> @OldID_Currency 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Currency = Old ->"' +  ISNULL(cast(@OldID_Currency as nvarchar(20)),'') + ' " NEW -> " ' + isnull(cast(@NewID_Currency as nvarchar(20)),'') + '", ';
							   end
                            
							IF @NewID_Transaction_status <> @OldID_Transaction_status 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Transaction_status = Old ->"' +  ISNULL(cast(@OldID_Transaction_status as nvarchar(20)),'') + ' " NEW -> " ' + isnull(cast(@NewID_Transaction_status as nvarchar(20)),'') + '", ';
							   end
                            
							IF @NewID_Currency_Rate <> @OldID_Currency_Rate 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Currency_Rate = Old ->"' +  ISNULL(cast(@OldID_Currency_Rate as nvarchar(20)),'') + ' " NEW -> " ' + isnull(cast(@NewID_Currency_Rate as nvarchar(20)),'') + '", ';
							   end
                            
							IF @NewTransaction_Date <> @OldTransaction_Date
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Transaction_Date = Old ->"' +  ISNULL(CAST(Format(@OldTransaction_Date,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewTransaction_Date,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							   end
							

							IF @NewKeySource <> @OldKeySource
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  KeySource = Old ->"' +  ISNULL(cast(@OldKeySource as nvarchar(100)),'') + ' " NEW -> " ' + isnull(cast(@NewKeySource as nvarchar(100)),'') + '", ';
							   end
							
							IF @NewTransaction_name_sender <> @OldTransaction_name_sender
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Transaction_name_sender = Old ->"' +  ISNULL(@OldTransaction_name_sender,'') + ' " NEW -> " ' + isnull(@NewTransaction_name_sender,'') + '", ';
							   end  																	   			

							IF @NewJSON_Transaction_sender <> @OldJSON_Transaction_sender
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  JSON_Transaction_sender = Old ->"' +  ISNULL(@OldJSON_Transaction_sender,'') + ' " NEW -> " ' + isnull(@NewJSON_Transaction_sender,'') + '", ';
							   end

                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_Transaction = (' +  isnull(cast(@OldID_Transaction as nvarchar(20)),'')+ ') ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from TRANSACTION_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.TRANSACTION_Audit
                            ( 
                               ID_Transaction       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Transaction
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                            DECLARE @OldID_Transaction_2                  bigint          ;
							DECLARE @OldID_Currency_2                     bigint       	  ;
							DECLARE @OldID_Transaction_status_2           bigint       	  ;
							DECLARE @OldID_Currency_Rate_2                bigint       	  ;
							DECLARE @OldTransaction_Date_2                datetime     	  ;
							DECLARE @OldKeySource_2                       bigint       	  ;
							DECLARE @OldTransaction_name_sender_2         nvarchar(500)	  ;
							DECLARE @OldJSON_Transaction_sender_2         nvarchar(max)	  ;
							DECLARE @OldTransaction_Amount_2              float        	  ;
							DECLARE @OldDescription_2                     nvarchar(4000)  ;

                            SELECT
                                  @OldID_Transaction_2          = ID_Transaction          ,
								  @OldID_Currency_2             = ID_Currency             ,
								  @OldID_Transaction_status_2   = ID_Transaction_status   ,
								  @OldID_Currency_Rate_2        = ID_Currency_Rate        ,
								  @OldTransaction_Date_2        = Transaction_Date        ,
								  @OldKeySource_2               = KeySource               ,
								  @OldTransaction_name_sender_2 = Transaction_name_sender ,
								  @OldJSON_Transaction_sender_2 = JSON_Transaction_sender ,
								  @OldTransaction_Amount_2      = Transaction_Amount      ,
								  @OldDescription_2             = [Description]           
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Transaction'           +'="'+  ISNULL(CAST(@OldID_Transaction_2 AS NVARCHAR(50)),'')     + '", '
							+ 'ID_Currency'              +'="'+  ISNULL(CAST(@OldID_Currency_2 AS NVARCHAR(50)),'')     + '", '
							+ 'ID_Transaction_status'    +'="'+  ISNULL(CAST(@OldID_Transaction_status_2 AS NVARCHAR(50)),'')     + '", '
							+ 'ID_Currency_Rate'         +'="'+  ISNULL(CAST(@OldID_Currency_Rate_2 AS NVARCHAR(50)),'')     + '", '
							+ 'Transaction_Date'         +'="'+  ISNULL(CAST(Format(@OldTransaction_Date_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							+ 'KeySource'                +'="'+  ISNULL(cast(@OldKeySource_2 as nvarchar(100)),'') + '", ' 
							+ 'Transaction_name_sender'  +'="'+  ISNULL(@OldTransaction_name_sender_2,'')+ '", ' 
							+ 'JSON_Currency_Rate_Data'  +'="'+  ISNULL(@OldJSON_Transaction_sender_2,'')+ '", '
							+ 'Transaction_Amount      ' +'="'+  ISNULL(cast(@OldTransaction_Amount_2 as nvarchar(20)),'')+ '", '		
							+ 'Description'              +'="'+  ISNULL(@OldDescription_2  ,'') + '", '



                          update u
						  set ChangeDescription = @ChangeDescription
						  from TRANSACTION_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.TRANSACTION_Audit
                    ( 
                          ID_Transaction  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Transaction
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Transaction_3 BIGINT;
                    SELECT @ID_Transaction_3 = ID_Transaction FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Transaction="' + CAST(@ID_Transaction_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from TRANSACTION_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit

