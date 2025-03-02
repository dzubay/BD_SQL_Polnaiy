
begin tran 

CREATE TABLE Storage_location_Audit
(
    AuditID                   bigint IDENTITY(1,1)  not null,
    ID_Storage_location       bigint                null,
 	ModifiedBy                nVARCHAR(128)         null,
    ModifiedDate              DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation                 CHAR(1)               null,
    ChangeDescription         nvarchar(max)         null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Storage_location_Audit ON Storage_location
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
							SELECT d.ID_Storage_location,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Storage_location,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;
                           
                           DECLARE @OldID_Storage_location        bigint         ;
						   DECLARE @OldID_Type_Storage_location   bigint         ;
						   DECLARE @OldKeySource                  bigint         ;
						   DECLARE @OldName                       nvarchar(400)  ;
						   DECLARE @OldCountry                    nvarchar(200)  ;
						   DECLARE @OldCity                       nvarchar(200)  ;
						   DECLARE @OldAdress                     nvarchar(800)  ;
						   DECLARE @OldMail                       nvarchar(250)  ;
						   DECLARE @OldPhone                      nvarchar(30)   ;
						   DECLARE @OldDate_Created               datetime       ;
						   DECLARE @OldDescription                nvarchar(4000) ;

                           DECLARE @NewID_Storage_location        bigint         ;
						   DECLARE @NewID_Type_Storage_location   bigint         ;
						   DECLARE @NewKeySource                  bigint         ;
						   DECLARE @NewName                       nvarchar(400)  ;
						   DECLARE @NewCountry                    nvarchar(200)  ;
						   DECLARE @NewCity                       nvarchar(200)  ;
						   DECLARE @NewAdress                     nvarchar(800)  ;
						   DECLARE @NewMail                       nvarchar(250)  ;
						   DECLARE @NewPhone                      nvarchar(30)   ;
						   DECLARE @NewDate_Created               datetime       ;
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
							                @OldID_Storage_location     	= D.ID_Storage_location     ,
							            	@OldID_Type_Storage_location	= D.ID_Type_Storage_location,
							            	@OldKeySource               	= D.KeySource               ,
							            	@OldName                    	= D.Name                    ,
							            	@OldCountry                 	= D.Country                 ,
							            	@OldCity                    	= D.City                    ,
							            	@OldAdress                  	= D.Adress                  ,
							            	@OldMail                    	= D.Mail                    ,
							            	@OldPhone                   	= D.Phone                   ,
							            	@OldDate_Created                = D.Date_Created            ,
							            	@OldDescription                 = D.[Description]        	  					
							            FROM Deleted D	
										 where @ID_entity_D = D.ID_Storage_location

							            SELECT 
							                @NewID_Storage_location     	= I.ID_Storage_location     ,
							            	@NewID_Type_Storage_location	= I.ID_Type_Storage_location,
							            	@NewKeySource               	= I.KeySource               ,
							            	@NewName                    	= I.Name                    ,
							            	@NewCountry                 	= I.Country                 ,
							            	@NewCity                    	= I.City                    ,
							            	@NewAdress                  	= I.Adress                  ,
							            	@NewMail                    	= I.Mail                    ,
							            	@NewPhone                   	= I.Phone                   ,
							            	@NewDate_Created                = I.Date_Created            ,
							            	@NewDescription                 = I.[Description]        	  
							            FROM inserted I									 
							            where @ID_entity_D = I.ID_Storage_location;
																	 

                                        IF @NewID_Type_Storage_location  <> @OldID_Type_Storage_location  
							               begin
                                            SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Type_Storage_location  = Old ->"' +  ISNULL(CAST(@OldID_Type_Storage_location  AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Type_Storage_location  AS NVARCHAR(20)),'') + '", ';
							               end
                                        
							            IF @NewKeySource <> @OldKeySource
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  KeySource = Old ->"' +  ISNULL(CAST(@OldKeySource AS NVARCHAR(50)),'') + ' " NEW -> "' + isnull(CAST(@NewKeySource AS NVARCHAR(50)),'') + '", ';
							               end
							            
							            IF @NewName <> @OldName
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name = Old ->"' +  ISNULL(@OldName,'') + ' " NEW -> "' + isnull(@NewName,'') + '", ';
							               end                  
							            
							            IF @NewCountry <> @OldCountry
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Country = Old ->"' +  ISNULL(@OldCountry,'') + ' " NEW -> "' + isnull(@NewCountry,'') + '", ';
							               end
							            
							            IF @NewCity <> @OldCity
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  City = Old ->"' +  ISNULL(@OldCity,'') + ' " NEW -> "' + isnull(@NewCity,'') + '", ';
							               end
							            
							            IF @NewAdress <> @OldAdress
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Adress = Old ->"' +  ISNULL(@OldAdress,'') + ' " NEW -> "' + isnull(@NewAdress,'') + '", ';
							               end
							            
							            IF @NewMail <> @OldMail
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Mail = Old ->"' +  ISNULL(@OldMail,'') + ' " NEW -> "' + isnull(@NewMail,'') + '", ';
							               end
							            
                                        IF @NewPhone <> @OldPhone
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Phone = Old ->"' +  ISNULL(@OldPhone,'') + ' " NEW -> "' + isnull(@NewPhone,'') + '", ';
							               end
							            
                                        IF @NewDate_Created <> @OldDate_Created
							               begin
							                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Created = Old ->"' +  ISNULL(CAST(Format(@OldDate_Created,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Created,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							               end
							            
                                        IF @NewDescription <> @OldDescription
							               begin
                                            SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> "' + ISNULL(@NewDescription,'') + '",';
                                           end
                                        SET @ChangeDescription = 'Updated: ' + ' ID_Storage_location = "' +  isnull(cast(@OldID_Storage_location as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                         --Удаляем запятую на конце
                                        IF LEN(@ChangeDescription) > 0
                                            SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                                         INSERT  INTO dbo.Storage_location_Audit
                                         ( 
                                          ID_Storage_location,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Storage_location,@login_name,GETDATE(),'D'  
							FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

							DECLARE @OldID_Storage_location_2        bigint         ;
							DECLARE @OldID_Type_Storage_location_2   bigint         ;
							DECLARE @OldKeySource_2                  bigint         ;
							DECLARE @OldName_2                       nvarchar(400)  ;
							DECLARE @OldCountry_2                    nvarchar(200)  ;
							DECLARE @OldCity_2                       nvarchar(200)  ;
							DECLARE @OldAdress_2                     nvarchar(800)  ;
							DECLARE @OldMail_2                       nvarchar(250)  ;
							DECLARE @OldPhone_2                      nvarchar(30)   ;
							DECLARE @OldDate_Created_2               datetime       ;
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
							                        @OldID_Storage_location_2         = D.ID_Storage_location     ,
							                    	@OldID_Type_Storage_location_2	  = D.ID_Type_Storage_location,
							                    	@OldKeySource_2               	  = D.KeySource               ,
							                    	@OldName_2                    	  = D.Name                    ,
							                    	@OldCountry_2                 	  = D.Country                 ,
							                    	@OldCity_2                    	  = D.City                    ,
							                    	@OldAdress_2                  	  = D.Adress                  ,
							                    	@OldMail_2                    	  = D.Mail                    ,
							                    	@OldPhone_2                   	  = D.Phone                   ,
							                    	@OldDate_Created_2                = D.Date_Created            ,
							                    	@OldDescription_2                 = D.[Description]        
							                    FROM deleted D	
												where @ID_entity_D_2 = D.ID_Storage_location

                                                SET @ChangeDescription = 'Deleted: '
							                    + 'ID_Storage_location'      +' = "'+  ISNULL(CAST(@OldID_Storage_location_2     AS NVARCHAR(20)),'')+ '", '
							                    + 'ID_Type_Storage_location' +' = "'+  ISNULL(CAST(@OldID_Type_Storage_location_2  AS NVARCHAR(20)),'')+ '", '
							                    + 'KeySource'                +' = "'+  ISNULL(CAST(@OldKeySource_2 AS NVARCHAR(50)),'') + '", '
							                    + 'Name'                     +' = "'+  ISNULL(@OldName_2,'')+ '", '				
							                    + 'Country'                  +' = "'+  ISNULL(@OldCountry_2,'')+ '", '
							                    + 'City'                     +' = "'+  ISNULL(@OldCity_2,'') + '", '
							                    + 'Adress'                   +' = "'+  ISNULL(@OldAdress_2,'')+ '", '
							                    + 'Mail'                     +' = "'+  ISNULL(@OldMail_2,'') + '", '
							                    + 'Phone'                    +' = "'+  ISNULL(@OldPhone_2,'')+ '", '
							                    + 'Date_Created'             +' = "'+  ISNULL(CAST(Format(@OldDate_Created_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
            				                    + 'Description'              +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

							                    IF LEN(@ChangeDescription) > 0
                                                        SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                                INSERT  INTO dbo.Storage_location_Audit
                                                ( 
                                                 ID_Storage_location,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.ID_Storage_location,@login_name,GETDATE(),'I'  
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
                                            + 'ID_Storage_location = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                      
                                     INSERT  INTO dbo.Storage_location_Audit
                                     ( 
                                      ID_Storage_location,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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