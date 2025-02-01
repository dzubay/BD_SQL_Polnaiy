begin tran 

CREATE TABLE Currency_Rate_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Currency_Rate       bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)         null
 --   PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Currency_Rate_Audit ON Currency_Rate
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
							SELECT d.ID_Currency_Rate,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Currency_Rate,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;
                          
							DECLARE @OldID_Currency_Rate        bigint          ;
							DECLARE @OldID_Currency             bigint       	;
							DECLARE @OldAmount_Rate             float        	;
							DECLARE @OldValid_from              datetime     	;
							DECLARE @OldValid_to                datetime     	;
							DECLARE @OldJSON_Currency_Rate_Data nvarchar(max)	;
							DECLARE @OldDescription             nvarchar(4000)	;

							DECLARE @NewID_Currency_Rate        bigint          ;
							DECLARE @NewID_Currency             bigint       	;
							DECLARE @NewAmount_Rate             float        	;
							DECLARE @NewValid_from              datetime     	;
							DECLARE @NewValid_to                datetime     	;
							DECLARE @NewJSON_Currency_Rate_Data nvarchar(max)	;
							DECLARE @NewDescription             nvarchar(4000)	;
                            
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
                                                  @NewID_Currency_Rate         =  I.ID_Currency_Rate         ,
							                	  @NewID_Currency              =  I.ID_Currency              ,
							                	  @NewAmount_Rate              =  I.Amount_Rate              ,
							                	  @NewValid_from               =  I.Valid_from               ,
							                	  @NewValid_to                 =  I.Valid_to                 ,
							                	  @NewJSON_Currency_Rate_Data  =  I.JSON_Currency_Rate_Data  ,
							                	  @NewDescription              =  I.[Description]              
							                FROM inserted I	
											where @ID_entity_D = I.ID_Currency_Rate;	
							                
							                SELECT  
							                      @OldID_Currency_Rate         =  D.ID_Currency_Rate         ,
							                	  @OldID_Currency              =  D.ID_Currency              ,
							                	  @OldAmount_Rate              =  D.Amount_Rate              ,
							                	  @OldValid_from               =  D.Valid_from               ,
							                	  @OldValid_to                 =  D.Valid_to                 ,
							                	  @OldJSON_Currency_Rate_Data  =  D.JSON_Currency_Rate_Data  ,
							                	  @OldDescription              =  D.[Description]              
							                FROM Deleted D																		 
											where @ID_entity_D = D.ID_Currency_Rate;


                                            IF @NewID_Currency <> @OldID_Currency 
							                   begin
                                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Currency = Old ->"' +  ISNULL(cast(@OldID_Currency as nvarchar(20)),'') + ' " NEW -> " ' + isnull(cast(@NewID_Currency as nvarchar(20)),'') + '", ';
							                   end
                                            
							                IF @NewAmount_Rate <> @OldAmount_Rate
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Amount_Rate = Old ->"' +  ISNULL(cast(@OldAmount_Rate as nvarchar(20)),'') + ' " NEW -> " ' + isnull(cast(@NewAmount_Rate as nvarchar(20)),'') + '", ';
							                   end
							                
							                   				
							                IF @NewValid_from <> @OldValid_from
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Valid_from = Old ->"' +  ISNULL(CAST(Format(@OldValid_from,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewValid_from,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							                   end
							                
							                						   				
							                IF @NewValid_to <> @OldValid_to
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Valid_to = Old ->"' +  ISNULL(CAST(Format(@OldValid_to,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewValid_to,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							                   end
							                
							                IF @NewJSON_Currency_Rate_Data <> @OldJSON_Currency_Rate_Data
							                   begin
							                    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  JSON_Currency_Rate_Data = Old ->"' +  ISNULL(CAST(@OldAmount_Rate AS NVARCHAR(max)),'') + ' " NEW -> " ' + isnull(CAST(@NewAmount_Rate AS NVARCHAR(max)),'') + '", ';
							                   end
							                
                                            IF @NewDescription <> @OldDescription
							                   begin
                                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                               end
                                            SET @ChangeDescription = 'Updated: ' + ' ID_Currency_Rate = "' +  isnull(cast(@OldID_Currency_Rate as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                             --Удаляем запятую на конце
                                            IF LEN(@ChangeDescription) > 0
                                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                                             INSERT  INTO dbo.Currency_Rate_Audit
                                             ( 
                                              ID_Currency_Rate,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Currency_Rate,@login_name,GETDATE(),'D'  
							FROM  Deleted D

							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;


							DECLARE @OldID_Currency_Rate_2        bigint          ;
							DECLARE @OldID_Currency_2             bigint       	  ;
							DECLARE @OldAmount_Rate_2             float        	  ;
							DECLARE @OldValid_from_2              datetime     	  ;
							DECLARE @OldValid_to_2                datetime     	  ;
							DECLARE @OldJSON_Currency_Rate_Data_2 nvarchar(max)	  ;
							DECLARE @OldDescription_2             nvarchar(4000)  ;

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
							                    @OldID_Currency_Rate_2        = D.ID_Currency_Rate       	 ,
							                	@OldID_Currency_2             = D.ID_Currency            	 ,
							                	@OldAmount_Rate_2             = D.Amount_Rate           	 ,
							                	@OldValid_from_2              = D.Valid_from             	 ,
							                	@OldValid_to_2                = D.Valid_to               	 ,
							                	@OldJSON_Currency_Rate_Data_2 = D.JSON_Currency_Rate_Data  ,
							                	@OldDescription_2             = D.[Description]            
							                FROM deleted D	
											where @ID_entity_D_2 = D.ID_Currency_Rate 

                                            SET @ChangeDescription = 'Deleted: '
							                + 'ID_Currency_Rate'         +'="'+  ISNULL(CAST(@OldID_Currency_Rate_2 AS NVARCHAR(50)),'')     + '", '
							                + 'ID_Currency'              +'="'+  ISNULL(CAST(@OldID_Currency_2 AS NVARCHAR(50)),'')     + '", '
							                + 'Amount_Rate'              +'="'+  ISNULL(cast(@OldAmount_Rate_2 as nvarchar(20)),'')+ '", '	
							                + 'Valid_from'               +'="'+  ISNULL(CAST(Format(@OldValid_from_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							                + 'Valid_to'                 +'="'+  ISNULL(CAST(Format(@OldValid_to_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							                + 'JSON_Currency_Rate_Data'  +'="'+  ISNULL(cast(@OldJSON_Currency_Rate_Data_2 as nvarchar(max)),'')+ '", '
							                + 'Description'              +'="'+  ISNULL(@OldDescription_2  ,'') + '", '

                                           IF LEN(@ChangeDescription) > 0
                                                  SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                           
										   INSERT  INTO dbo.Currency_Rate_Audit
                                           ( 
                                            ID_Currency_Rate,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.ID_Currency_Rate,@login_name,GETDATE(),'I'  
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
                                              + 'ID_Currency_Rate = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';

									   INSERT  INTO dbo.Currency_Rate_Audit
                                        ( 
                                         ID_Currency_Rate,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
