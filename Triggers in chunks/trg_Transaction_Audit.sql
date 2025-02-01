begin tran 

CREATE TABLE TRANSACTION_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Transaction         bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)         null
 --   PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Transaction_Audit ON [dbo].[Transaction]
AFTER INSERT, UPDATE, DELETE

AS
    set nocount,xact_abort on;

    DECLARE @login_name nVARCHAR(128) 
	DECLARE @ChangeDescription nvarchar(max);


    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID

    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
				            declare @t_U_D table 
							(
							Id_Num         bigint        identity(1,1) not null,
							ID_entity      bigint        null,
							login_name     nvarchar(128) null,
							ModifiedDate   DATETIME      null,
							Name_action    char(1)       null
							);

							declare @t_U_I table 
							(
							Id_Num         bigint        identity(1,1) not null,
							ID_entity      bigint        null,
							login_name     nvarchar(128) null,
							ModifiedDate   DATETIME      null,
							Name_action    char(1)       null
							);

							insert into @t_U_D (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Transaction,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Transaction,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;


                           
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
                            

							declare cr cursor local fast_forward for
						   
						    select 
						    ID_entity    
						    ,login_name   
						    ,ModifiedDate 
						    ,Name_action  
						    from @t_U_D 
                            open cr       
						    
						    fetch next from cr into 
						    @ID_entity_D,@login_name_2_D,@ModifiedDate_D,@Name_action_D 
						    while @@FETCH_STATUS  = 0
						          begin
							          begin try								 
							                
							                SELECT  
                                                  @OldID_Transaction          = D.ID_Transaction          ,
							                	  @OldID_Currency             = D.ID_Currency            	,
							                	  @OldID_Transaction_status   = D.ID_Transaction_status  	,
							                	  @OldID_Currency_Rate        = D.ID_Currency_Rate       	,
							                	  @OldTransaction_Date        = D.Transaction_Date       	,
							                	  @OldKeySource               = D.KeySource              	,
							                	  @OldTransaction_name_sender = D.Transaction_name_sender	,
							                	  @OldJSON_Transaction_sender = D.JSON_Transaction_sender	,
							                	  @OldTransaction_Amount      = D.Transaction_Amount     	,
							                	  @OldDescription             = D.[Description]                           
							                FROM Deleted D
											where @ID_entity_D = D.ID_Transaction; 

											SELECT  
                                                  @NewID_Transaction          = I.ID_Transaction          ,
							                	  @NewID_Currency             = I.ID_Currency            	,
							                	  @NewID_Transaction_status   = I.ID_Transaction_status  	,
							                	  @NewID_Currency_Rate        = I.ID_Currency_Rate       	,
							                	  @NewTransaction_Date        = I.Transaction_Date       	,
							                	  @NewKeySource               = I.KeySource              	,
							                	  @NewTransaction_name_sender = I.Transaction_name_sender	,
							                	  @NewJSON_Transaction_sender = I.JSON_Transaction_sender	,
							                	  @NewTransaction_Amount      = I.Transaction_Amount     	,
							                	  @NewDescription             = I.[Description]                      
							                FROM inserted I
											where @ID_entity_D = I.ID_Transaction;	


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
							                      SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  JSON_Transaction_sender = Old ->"' +  ISNULL(cast(@OldJSON_Transaction_sender as nvarchar(max)),'') + ' " NEW -> " ' + isnull(cast(@NewJSON_Transaction_sender as nvarchar(max)),'') + '", ';
							                   end
							                
                                            IF @NewDescription <> @OldDescription
							                   begin
                                                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                               end
                                            SET @ChangeDescription = 'Updated: ' + ' ID_Transaction = "' +  isnull(cast(@OldID_Transaction as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                             --Удаляем запятую на конце
                                            IF LEN(@ChangeDescription) > 0
                                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                                            INSERT  INTO dbo.TRANSACTION_Audit
                                            ( 
                                             ID_Transaction,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
                                            )
                                              SELECT  @ID_entity_D,@login_name_2_D,@ModifiedDate_D,@Name_action_D,@ChangeDescription;              
                                     
									        set @ChangeDescription = null 

								  end try
								  begin catch
								     if xact_state() in (1, -1)
									    begin
									       ROLLBACK TRAN
									    end
								     SELECT 
									   ERROR_NUMBER() AS ErrorNumber_U_D,
									   ERROR_SEVERITY() AS ErrorSeverity_U_D,
									   ERROR_STATE() as ErrorState_U_D,
									   ERROR_PROCEDURE() as ErrorProcedure_U_D,
									   ERROR_LINE() as ErrorLine_U_D,
									   ERROR_MESSAGE() as ErrorMessage_U_D;
								  end catch;
							     fetch next from cr into 
								 @ID_entity_D,@login_name_2_D,@ModifiedDate_D,@Name_action_D
						         end
						   close cr
                           deallocate cr
  					
                END
            ELSE
                BEGIN
				           declare @t_D_D table 
						   (
						   Id_Num         bigint        identity(1,1) not null,
						   ID_entity      bigint        null,
						   login_name     nvarchar(128) null,
						   ModifiedDate   DATETIME      null,
						   Name_action    char(1)       null
						   );


							insert into @t_D_D (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Transaction,@login_name,GETDATE(),'D'  
							FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;


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
                            
							declare cr_2 cursor local fast_forward for
						   
						    select 
						    ID_entity   
						    ,login_name  
						    ,ModifiedDate
						    ,Name_action 
						    from @t_D_D 
                            open cr_2       
						    
						    fetch next from cr_2 into 
						    @ID_entity_D_2,@login_name_2_D_2,@ModifiedDate_D_2,@Name_action_D_2 
						    while @@FETCH_STATUS  = 0
						         begin
							         begin try

                                            SELECT
                                                  @OldID_Transaction_2          = D.ID_Transaction          ,
							                	  @OldID_Currency_2             = D.ID_Currency             ,
							                	  @OldID_Transaction_status_2   = D.ID_Transaction_status   ,
							                	  @OldID_Currency_Rate_2        = D.ID_Currency_Rate        ,
							                	  @OldTransaction_Date_2        = D.Transaction_Date        ,
							                	  @OldKeySource_2               = D.KeySource               ,
							                	  @OldTransaction_name_sender_2 = D.Transaction_name_sender ,
							                	  @OldJSON_Transaction_sender_2 = D.JSON_Transaction_sender ,
							                	  @OldTransaction_Amount_2      = D.Transaction_Amount      ,
							                	  @OldDescription_2             = D.[Description]           
							                FROM deleted D	
											where @ID_entity_D_2 = D.ID_Transaction;

                                            SET @ChangeDescription = 'Deleted: '
							                + 'ID_Transaction'           +' = "'+  ISNULL(CAST(@OldID_Transaction_2 AS NVARCHAR(50)),'')     + '", '
							                + 'ID_Currency'              +' = "'+  ISNULL(CAST(@OldID_Currency_2 AS NVARCHAR(50)),'')     + '", '
							                + 'ID_Transaction_status'    +' = "'+  ISNULL(CAST(@OldID_Transaction_status_2 AS NVARCHAR(50)),'')     + '", '
							                + 'ID_Currency_Rate'         +' = "'+  ISNULL(CAST(@OldID_Currency_Rate_2 AS NVARCHAR(50)),'')     + '", '
							                + 'Transaction_Date'         +' = "'+  ISNULL(CAST(Format(@OldTransaction_Date_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							                + 'KeySource'                +' = "'+  ISNULL(cast(@OldKeySource_2 as nvarchar(100)),'') + '", ' 
							                + 'Transaction_name_sender'  +' = "'+  ISNULL(@OldTransaction_name_sender_2,'')+ '", ' 
							                + 'JSON_Currency_Rate_Data'  +' = "'+  ISNULL(@OldJSON_Transaction_sender_2,'')+ '", '
							                + 'Transaction_Amount      ' +' = "'+  ISNULL(cast(@OldTransaction_Amount_2 as nvarchar(20)),'')+ '", '		
							                + 'Description'              +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

                                           IF LEN(@ChangeDescription) > 0
                                                   SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                            
										   INSERT  INTO dbo.TRANSACTION_Audit
                                           ( 
                                            ID_Transaction,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
                                           )
                                            SELECT  @ID_entity_D_2,@login_name_2_D_2,@ModifiedDate_D_2,@Name_action_D_2,@ChangeDescription;              
                                     
									        set @ChangeDescription = null

								  end try
								  begin catch
								     if xact_state() in (1, -1)
									    begin
									       ROLLBACK TRAN
									    end
								     SELECT 
									   ERROR_NUMBER() AS ErrorNumber_D_D,
									   ERROR_SEVERITY() AS ErrorSeverity_D_D,
									   ERROR_STATE() as ErrorState_D_D,
									   ERROR_PROCEDURE() as ErrorProcedure_D_D,
									   ERROR_LINE() as ErrorLine_D_D,
									   ERROR_MESSAGE() as ErrorMessage_D_D;
								  end catch;
							     fetch next from cr_2 into 
								 @ID_entity_D_2,@login_name_2_D_2,@ModifiedDate_D_2,@Name_action_D_2
						         end
						   close cr_2
                           deallocate cr_2
                END   
        END
    ELSE
        BEGIN
		            declare @t_I_I table 
					(
					Id_Num         bigint        identity(1,1) not null,
					ID_entity      bigint        null,
					login_name     nvarchar(128) null,
					ModifiedDate   DATETIME      null,
					Name_action    char(1)       null
					);

                    insert into @t_I_I (ID_entity,login_name,ModifiedDate,Name_action)
					SELECT I.ID_Transaction,@login_name,GETDATE(),'I'  
					FROM  inserted I

					DECLARE @ID_entity_I_2    bigint       ;
					DECLARE @login_name_2_I_2 nvarchar(128);
					DECLARE @ModifiedDate_I_2 DATETIME     ;
					DECLARE @Name_action_I_2  char(1)      ;

					declare cr_3 cursor local fast_forward for
						   
					select 
					ID_entity   
					,login_name  
					,ModifiedDate
					,Name_action 
					from @t_I_I 
                    open cr_3       
					
					fetch next from cr_3 into 
					@ID_entity_I_2,@login_name_2_I_2,@ModifiedDate_I_2,@Name_action_I_2 
					while @@FETCH_STATUS  = 0
						    begin
							      begin try
                                       SET @ChangeDescription = 'Inserted: '
                                            + 'ID_Transaction = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                        
									   INSERT  INTO dbo.TRANSACTION_Audit
                                       ( 
                                        ID_Transaction,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
                                       )
                                        SELECT  @ID_entity_I_2,@login_name_2_I_2,@ModifiedDate_I_2,@Name_action_I_2,@ChangeDescription;              
                                     
									    set @ChangeDescription = null
                                 end try
								 begin catch
								     if xact_state() in (1, -1)
									    begin
									       ROLLBACK TRAN
									    end
								     SELECT 
									   ERROR_NUMBER() AS ErrorNumber_I_I,
									   ERROR_SEVERITY() AS ErrorSeverity_I_I,
									   ERROR_STATE() as ErrorState_I_I,
									   ERROR_PROCEDURE() as ErrorProcedure_I_I,
									   ERROR_LINE() as ErrorLine_I_I,
									   ERROR_MESSAGE() as ErrorMessage_I_I;
								  end catch;
							     fetch next from cr_3 into 
								 @ID_entity_I_2,@login_name_2_I_2,@ModifiedDate_I_2,@Name_action_I_2
						         end
						   close cr_3
                           deallocate cr_3          

                    END

GO
--rollback
commit

