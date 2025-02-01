
begin tran 

CREATE TABLE Exemplar_Audit
(
    AuditID                   bigint IDENTITY(1,1)  not null,
    ID_Exemplar               bigint                null,
 	ModifiedBy                nVARCHAR(128)         null,
    ModifiedDate              DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation                 CHAR(1)               null,
    ChangeDescription         nvarchar(max)         null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Exemplar_Audit ON Exemplar
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
							SELECT d.ID_Exemplar,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Exemplar,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;
                           
                           DECLARE @OldID_Exemplar                bigint         ;
						   DECLARE @OldId_Item                    bigint         ;
						   DECLARE @OldID_Currency                bigint         ;
						   DECLARE @OldID_Storage_location        bigint         ;
						   DECLARE @OldKeySource                  bigint         ;
						   DECLARE @OldSerial_number              nvarchar(500)  ;
						   DECLARE @OldID_Condition_of_the_item   bigint         ;
						   DECLARE @OldOld_Price_no_NDS           float          ;
						   DECLARE @OldRefund                     bit            ;
						   DECLARE @OldDate_Refund                datetime       ;
						   DECLARE @OldReturn_Note                nvarchar(4000) ;
						   DECLARE @OldOld_Price_NDS              float          ;
						   DECLARE @OldJSON_Size_Volume           nvarchar(max)  ;
						   DECLARE @OldNew_Price_NDS              float          ;
						   DECLARE @OldNew_Price_no_NDS           float          ;
						   DECLARE @OldDate_Сreated               datetime       ;
						   DECLARE @OldDescription                nvarchar(4000) ;

						   DECLARE @NewID_Exemplar                bigint         ;
						   DECLARE @NewId_Item                    bigint         ;
						   DECLARE @NewID_Currency                bigint         ;
						   DECLARE @NewID_Storage_location        bigint         ;
						   DECLARE @NewKeySource                  bigint         ;
						   DECLARE @NewSerial_number              nvarchar(500)  ;
						   DECLARE @NewID_Condition_of_the_item   bigint         ;
						   DECLARE @NewOld_Price_no_NDS           float          ;
						   DECLARE @NewRefund                     bit            ;
						   DECLARE @NewDate_Refund                datetime       ;
						   DECLARE @NewReturn_Note                nvarchar(4000) ;
						   DECLARE @NewOld_Price_NDS              float          ;
						   DECLARE @NewJSON_Size_Volume           nvarchar(max)  ;
						   DECLARE @NewNew_Price_NDS              float          ;
						   DECLARE @NewNew_Price_no_NDS           float          ;
						   DECLARE @NewDate_Сreated               datetime       ;
						   DECLARE @NewDescription                nvarchar(4000) ;

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
							                @OldID_Exemplar             	= D.ID_Exemplar             ,
							            	@OldId_Item                 	= D.Id_Item                 ,
							            	@OldID_Currency             	= D.ID_Currency             ,
							            	@OldID_Storage_location     	= D.ID_Storage_location     ,
							            	@OldKeySource               	= D.KeySource               ,
							            	@OldSerial_number           	= D.Serial_number           ,
							            	@OldID_Condition_of_the_item	= D.ID_Condition_of_the_item,
							            	@OldOld_Price_no_NDS        	= D.Old_Price_no_NDS        ,
							            	@OldRefund                  	= D.Refund                  ,
							            	@OldDate_Refund             	= D.Date_Refund             ,
							            	@OldReturn_Note             	= D.Return_Note             ,
							            	@OldOld_Price_NDS           	= D.Old_Price_NDS           ,
							            	@OldJSON_Size_Volume        	= D.JSON_Size_Volume        ,
							            	@OldNew_Price_NDS           	= D.New_Price_NDS           ,
							            	@OldNew_Price_no_NDS        	= D.New_Price_no_NDS        ,
							            	@OldDate_Сreated                = D.Date_Сreated            , 
							            	@OldDescription                 = D.[Description]        	  					
							            FROM Deleted D																		 
										where @ID_entity_D = D.ID_Exemplar;
								       
							            SELECT 
							                @NewID_Exemplar             	= I.ID_Exemplar             , 
							            	@NewId_Item                 	= I.Id_Item                 ,
							            	@NewID_Currency             	= I.ID_Currency             ,
							            	@NewID_Storage_location     	= I.ID_Storage_location     ,
							            	@NewKeySource               	= I.KeySource               ,
							            	@NewSerial_number           	= I.Serial_number           ,
							            	@NewID_Condition_of_the_item	= I.ID_Condition_of_the_item,
							            	@NewOld_Price_no_NDS        	= I.Old_Price_no_NDS        ,
							            	@NewRefund                  	= I.Refund                  ,
							            	@NewDate_Refund             	= I.Date_Refund             ,
							            	@NewReturn_Note             	= I.Return_Note             ,
							            	@NewOld_Price_NDS           	= I.Old_Price_NDS           ,
							            	@NewJSON_Size_Volume        	= I.JSON_Size_Volume        ,
							            	@NewNew_Price_NDS           	= I.New_Price_NDS           ,
							            	@NewNew_Price_no_NDS        	= I.New_Price_no_NDS        ,
							            	@NewDate_Сreated                = I.Date_Сreated            ,
							            	@NewDescription                 = I.[Description]        	  
							            FROM inserted I
										where @ID_entity_D = I.ID_Exemplar;	


                                          IF @NewId_Item  <> @OldId_Item  
							                 begin
                                              SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Id_Item  = Old ->"' +  ISNULL(CAST(@OldId_Item  AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewId_Item  AS NVARCHAR(20)),'') + '", ';
							                 end
                                          
							              IF @NewID_Currency <> @OldID_Currency
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Currency = Old ->"' +  ISNULL(CAST(@OldID_Currency AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Currency AS NVARCHAR(20)),'') + '", ';
							                 end
							              
							              IF @NewID_Storage_location <> @OldID_Storage_location
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Storage_location = Old ->"' +  ISNULL(CAST(@OldID_Storage_location AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Storage_location AS NVARCHAR(20)),'') + '", ';
							                 end                  
							              
							              IF @NewKeySource <> @OldKeySource
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  KeySource = Old ->"' +  ISNULL(CAST(@OldKeySource AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewKeySource AS NVARCHAR(20)),'') + '", ';
							                 end
							              
							              IF @NewSerial_number <> @OldSerial_number
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Serial_number = Old ->"' +  ISNULL(@OldSerial_number,'') + ' " NEW -> "' + isnull(@NewSerial_number,'') + '", ';
							                 end
							              
							              IF @NewID_Condition_of_the_item <> @OldID_Condition_of_the_item
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Condition_of_the_item = Old ->"' +  ISNULL(CAST(@OldID_Condition_of_the_item AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Condition_of_the_item AS NVARCHAR(20)),'') + '", ';
							                 end
							              
							              IF @NewOld_Price_no_NDS <> @OldOld_Price_no_NDS
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Old_Price_no_NDS = Old ->"' +  ISNULL(CAST(@OldOld_Price_no_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewOld_Price_no_NDS AS NVARCHAR(50)),'') + '", ';
							                 end
							              
                                          IF @NewRefund <> @OldRefund
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Refund = Old ->"' +  ISNULL(CAST(@OldRefund AS NVARCHAR(1)),'') + ' " NEW -> "' + isnull(CAST(@NewRefund AS NVARCHAR(1)),'') + '", ';
							                 end
							              
                                          IF @NewDate_Refund <> @OldDate_Refund
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Refund = Old ->"' +  ISNULL(CAST(Format(@OldDate_Refund,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Refund,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							                 end
                                          -----
							              IF @NewReturn_Note <> @OldReturn_Note
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Return_Note = Old ->"' +  ISNULL(@OldReturn_Note,'') + ' " NEW -> "' + isnull(@NewReturn_Note,'') + '", ';
							                 end
                                          
							              IF @NewOld_Price_NDS <> @OldOld_Price_NDS
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Old_Price_NDS = Old ->"' +  ISNULL(CAST(@OldOld_Price_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewOld_Price_NDS AS NVARCHAR(50)),'') + '", ';
							                 end
							              
							              IF @NewJSON_Size_Volume <> @OldJSON_Size_Volume
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  JSON_Size_Volume = Old ->"' +  ISNULL(CAST(@OldJSON_Size_Volume AS NVARCHAR(max)),'') + ' " NEW -> "' + isnull(CAST(@NewJSON_Size_Volume AS NVARCHAR(max)),'') + '", ';
							                 end
                                          
							              IF @NewNew_Price_NDS <> @OldNew_Price_NDS
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  New_Price_NDS = Old ->"' +  ISNULL(CAST(@OldNew_Price_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewNew_Price_NDS AS NVARCHAR(50)),'') + '", ';
							                 end
							              
							              IF @NewNew_Price_no_NDS <> @OldNew_Price_no_NDS
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  New_Price_no_NDS = Old ->"' +  ISNULL(CAST(@OldNew_Price_no_NDS AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewNew_Price_no_NDS AS NVARCHAR(50)),'') + '", ';
							                 end
                                          
							              IF @NewDate_Сreated <> @OldDate_Сreated
							                 begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Сreated = Old ->"' +  ISNULL(CAST(Format(@OldDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							                 end
							              
                                          IF @NewDescription <> @OldDescription
							                 begin
                                              SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> "' + ISNULL(@NewDescription,'') + '",';
                                             end
                                          SET @ChangeDescription = 'Updated: ' + ' ID_Exemplar = "' +  isnull(cast(@OldID_Exemplar as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                           --Удаляем запятую на конце
                                          IF LEN(@ChangeDescription) > 0
                                              SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                                          INSERT  INTO dbo.Exemplar_Audit
                                          ( 
                                           ID_Exemplar,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Exemplar,@login_name,GETDATE(),'D'  
							FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

		                   DECLARE @OldID_Exemplar_2                bigint         ;
						   DECLARE @OldId_Item_2                    bigint         ;
						   DECLARE @OldID_Currency_2                bigint         ;
						   DECLARE @OldID_Storage_location_2        bigint         ;
						   DECLARE @OldKeySource_2                  bigint         ;
						   DECLARE @OldSerial_number_2              nvarchar(500)  ;
						   DECLARE @OldID_Condition_of_the_item_2   bigint         ;
						   DECLARE @OldOld_Price_no_NDS_2           float          ;
						   DECLARE @OldRefund_2                     bit            ;
						   DECLARE @OldDate_Refund_2                datetime       ;
						   DECLARE @OldReturn_Note_2                nvarchar(4000) ;
						   DECLARE @OldOld_Price_NDS_2              float          ;
						   DECLARE @OldJSON_Size_Volume_2           nvarchar(max)  ;
						   DECLARE @OldNew_Price_NDS_2              float          ;
						   DECLARE @OldNew_Price_no_NDS_2           float          ;
						   DECLARE @OldDate_Сreated_2               datetime       ;
						   DECLARE @OldDescription_2                nvarchar(4000) ;    	  	

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
							                    @OldID_Exemplar_2             	  = D.ID_Exemplar              ,
							                	@OldId_Item_2                 	  = D.Id_Item                  ,
							                	@OldID_Currency_2             	  = D.ID_Currency              ,
							                	@OldID_Storage_location_2     	  = D.ID_Storage_location      ,
							                	@OldKeySource_2               	  = D.KeySource                ,
							                	@OldSerial_number_2           	  = D.Serial_number            ,
							                	@OldID_Condition_of_the_item_2	  = D.ID_Condition_of_the_item ,
							                	@OldOld_Price_no_NDS_2        	  = D.Old_Price_no_NDS         ,
							                	@OldRefund_2                  	  = D.Refund                   ,
							                	@OldDate_Refund_2             	  = D.Date_Refund              ,
							                	@OldReturn_Note_2             	  = D.Return_Note              ,
							                	@OldOld_Price_NDS_2           	  = D.Old_Price_NDS            ,
							                	@OldJSON_Size_Volume_2        	  = D.JSON_Size_Volume         ,
							                	@OldNew_Price_NDS_2           	  = D.New_Price_NDS            ,
							                	@OldNew_Price_no_NDS_2        	  = D.New_Price_no_NDS         ,
							                	@OldDate_Сreated_2                = D.Date_Сreated             ,
							                	@OldDescription_2                 = D.[Description]        
							                FROM deleted D	
											where @ID_entity_D_2 = D.ID_Exemplar

                                            SET @ChangeDescription = 'Deleted: '
							                + 'ID_Exemplar'             +' = "'+  ISNULL(CAST(@OldID_Exemplar_2     AS NVARCHAR(20)),'')+ '", '
							                + 'Id_Item'                 +' = "'+  ISNULL(CAST(@OldId_Item_2  AS NVARCHAR(20)),'')+ '", '
							                + 'ID_Currency'             +' = "'+  ISNULL(CAST(@OldID_Currency_2 AS NVARCHAR(20)),'') + '", '
							                + 'ID_Storage_location'     +' = "'+  ISNULL(CAST(@OldID_Storage_location_2 AS NVARCHAR(20)),'') + '", '
							                + 'KeySource'               +' = "'+  ISNULL(CAST(@OldKeySource_2 AS NVARCHAR(50)),'')+ '", '				
							                + 'Serial_number'           +' = "'+  ISNULL(@OldSerial_number_2,'')+ '", '
							                + 'ID_Condition_of_the_item'+' = "'+  ISNULL(CAST(@OldID_Condition_of_the_item_2 AS NVARCHAR(20)),'') + '", '
							                + 'Old_Price_no_NDS'        +' = "'+  ISNULL(CAST(@OldOld_Price_no_NDS_2 AS NVARCHAR(50)),'')+ '", '
							                + 'Refund'                  +' = "'+  ISNULL(CAST(@OldRefund_2 AS NVARCHAR(1)),'') + '", '
							                + 'Date_Refund'             +' = "'+  ISNULL(CAST(Format(@OldDate_Refund_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							                + 'Return_Note'             +' = "'+  ISNULL(@OldReturn_Note_2,'')+ '", '
							                + 'Old_Price_NDS'           +' = "'+  ISNULL(CAST(@OldOld_Price_NDS_2 AS NVARCHAR(50)),'') + '", '
							                + 'JSON_Size_Volume'        +' = "'+  ISNULL(CAST(@OldJSON_Size_Volume_2 AS NVARCHAR(MAX)),'') + '", '
							                + 'New_Price_NDS'           +' = "'+  ISNULL(CAST(@OldNew_Price_NDS_2 AS NVARCHAR(50)),'') + '", '
							                + 'New_Price_no_NDS'        +' = "'+  ISNULL(CAST(@OldNew_Price_no_NDS_2 AS NVARCHAR(50)),'') + '", '
							                + 'Date_Сreated'            +' = "'+  ISNULL(CAST(Format(@OldDate_Сreated_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
            				                + 'Description'             +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

							               IF LEN(@ChangeDescription) > 0
                                                 SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                           INSERT  INTO dbo.Exemplar_Audit
                                           ( 
                                            ID_Exemplar,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
                   DECLARE @ID_entity_I_2    bigint       ;
				   DECLARE @login_name_2_I_2 nvarchar(128);
				   DECLARE @ModifiedDate_I_2 DATETIME     ;
				   DECLARE @Name_action_I_2  char(1)      ;

				   declare @t_I_I table 
				   (
				   Id_Num         bigint        identity(1,1) not null,
				   ID_entity      bigint        null,
				   login_name     nvarchar(128) null,
				   ModifiedDate   DATETIME      null,
				   Name_action    char(1)       null
				   );


					insert into @t_I_I (ID_entity,login_name,ModifiedDate,Name_action)
					SELECT I.ID_Exemplar,@login_name,GETDATE(),'I'  
					FROM  inserted I  

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
                                               + 'ID_Exemplar = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                        
										 INSERT  INTO dbo.Exemplar_Audit
                                         ( 
                                          ID_Exemplar,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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


