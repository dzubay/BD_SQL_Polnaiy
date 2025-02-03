begin tran 

CREATE TABLE Branch_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Branch               bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)        null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Employee_Group_2;


go

CREATE TRIGGER trg_Branch_Audit ON Branch
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
							SELECT d.ID_Branch,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Branch,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;


							DECLARE @OldID_Branch     bigint        ;
							DECLARE @OldId_Country    bigint        ;
							DECLARE @OldCity          nvarchar(100) ;
							DECLARE @OldAddress       nvarchar(300) ;
							DECLARE @OldName_Branch   nvarchar(300) ;
							DECLARE @OldMail          nvarchar(300) ;
							DECLARE @OldPhone         nvarchar(15)  ;
							DECLARE @OldPostal_Code   int           ;
							DECLARE @OldINN           int           ;
							DECLARE @OldDescription   nvarchar(1000);

						   DECLARE @NewID_Branch     bigint        ;
						   DECLARE @NewId_Country    bigint        ;
						   DECLARE @NewCity          nvarchar(100) ;
						   DECLARE @NewAddress       nvarchar(300) ;
						   DECLARE @NewName_Branch   nvarchar(300) ;
						   DECLARE @NewMail          nvarchar(300) ;
						   DECLARE @NewPhone         nvarchar(15)  ;
						   DECLARE @NewPostal_Code   int           ;
						   DECLARE @NewINN           int           ;
						   DECLARE @NewDescription   nvarchar(1000);


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
                                              @OldID_Branch   = D.ID_Branch     ,
											  @OldId_Country  = D.Id_Country  	,
											  @OldCity        = D.City        	,
											  @OldAddress     = D.[Address]     ,
											  @OldName_Branch = D.Name_Branch 	,
											  @OldMail        = D.Mail        	,
											  @OldPhone       = D.Phone       	,
											  @OldPostal_Code = D.Postal_Code 	,
											  @OldINN         = D.INN         	,
											  @OldDescription = D.[Description]   							
							            FROM Deleted D
										where @ID_entity_D = D.ID_Branch;

							            SELECT 
                                              @NewID_Branch   = I.ID_Branch     ,
											  @NewId_Country  = I.Id_Country  	,
											  @NewCity        = I.City        	,
											  @NewAddress     = I.[Address]     ,
											  @NewName_Branch = I.Name_Branch 	,
											  @NewMail        = I.Mail        	,
											  @NewPhone       = I.Phone       	,
											  @NewPostal_Code = I.Postal_Code 	,
											  @NewINN         = I.INN         	,
											  @NewDescription = I.[Description]    	
							            FROM inserted I									 
							            where @ID_entity_D = I.ID_Branch;


                                       IF @NewId_Country <> @OldId_Country 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Id_Country = Old ->"' +  ISNULL(CAST(@OldId_Country AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewId_Country AS NVARCHAR(50)),'') + '", ';
							              end
                                       
							           IF @NewCity <> @OldCity 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  City = Old ->"' +  ISNULL(@OldCity,'') + ' " NEW -> " ' + isnull(@NewCity,'') + '", ';
							              end
                                                                                               
							           IF @NewAddress <> @OldAddress 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Address = Old ->"' +  ISNULL(@OldAddress,'') + ' " NEW -> " ' + isnull(@NewAddress,'') + '", ';
							              end
							           IF @NewName_Branch <> @OldName_Branch 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name_Branch = Old ->"' +  ISNULL(@OldName_Branch,'') + ' " NEW -> " ' + isnull(@NewName_Branch,'') + '", ';
							              end
							           IF @NewMail <> @OldMail 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Mail = Old ->"' +  ISNULL(@OldMail,'') + ' " NEW -> " ' + isnull(@NewMail,'') + '", ';
							              end
							           
							           IF @NewPhone <> @OldPhone 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Phone = Old ->"' +  ISNULL(@OldPhone,'') + ' " NEW -> " ' + isnull(@NewPhone,'') + '", ';
							              end
                           	          IF @NewPostal_Code <> @OldPostal_Code
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Postal_Code = Old ->"' +  ISNULL(CAST(@OldPostal_Code AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewPostal_Code AS NVARCHAR(50)),'') + '", ';
							              end
										  
									  IF @NewINN <> @OldINN 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  INN = Old ->"' +  ISNULL(CAST(@OldINN AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewINN AS NVARCHAR(50)),'') + '", ';
							              end

                                       IF @NewDescription <> @OldDescription
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                          end
                                       SET @ChangeDescription = 'Updated: ' + ' ID_Branch = "' +  isnull(cast(@OldID_Branch as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                        --Удаляем запятую на конце
                                       IF LEN(@ChangeDescription) > 0
                                           SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                       
									   INSERT  INTO dbo.Branch_Audit
                                        ( 
                                         ID_Branch,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Branch,@login_name,GETDATE(),'D'  
							FROM  Deleted D

							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

							DECLARE @OldID_Branch_2     bigint        ;
							DECLARE @OldId_Country_2    bigint        ;
							DECLARE @OldCity_2          nvarchar(100) ;
							DECLARE @OldAddress_2       nvarchar(300) ;
							DECLARE @OldName_Branch_2   nvarchar(300) ;
							DECLARE @OldMail_2          nvarchar(300) ;
							DECLARE @OldPhone_2         nvarchar(15)  ;
							DECLARE @OldPostal_Code_2   int           ;
							DECLARE @OldINN_2           int           ;
							DECLARE @OldDescription_2   nvarchar(1000);



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
											     @OldID_Branch_2   = D.ID_Branch     ,
												 @OldId_Country_2  = D.Id_Country  	,
												 @OldCity_2        = D.City        	,
												 @OldAddress_2     = D.[Address]     ,
												 @OldName_Branch_2 = D.Name_Branch 	,
												 @OldMail_2        = D.Mail        	,
												 @OldPhone_2       = D.Phone       	,
												 @OldPostal_Code_2 = D.Postal_Code 	,
												 @OldINN_2         = D.INN         	,
												 @OldDescription_2 = D.[Description]   
							                FROM deleted D									 
											where @ID_entity_D_2 = D.ID_Branch;

                                            SET @ChangeDescription = 'Deleted: '
							                + 'ID_Branch'           +' = "'+  ISNULL(CAST(@OldID_Branch_2     AS NVARCHAR(50)),'')     + '", '
							                + 'Id_Country'          +' = "'+  ISNULL(CAST(@OldId_Country_2  AS NVARCHAR(50)),'') + '", '
							                + 'City'                +' = "'+  ISNULL(@OldCity_2,'')+ '", '				
							                + 'Address'             +' = "'+  ISNULL(@OldAddress_2,'')+ '", '
							                + 'Name_Branch'         +' = "'+  ISNULL(@OldName_Branch_2,'') + '", '
							                + 'Mail'                +' = "'+  ISNULL(@OldMail_2,'')+ '", '	   + '", '
							                + 'Phone'               +' = "'+  ISNULL(@OldPhone_2,'')+ '", '
								            + 'Postal_Code'         +' = "'+  ISNULL(CAST(@OldPostal_Code_2  AS NVARCHAR(50)),'') + '", '
							                + 'INN'                 +' = "'+  ISNULL(CAST(@OldINN_2  AS NVARCHAR(50)),'') + '", '
							                + 'Description'         +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

                                           IF LEN(@ChangeDescription) > 0
						                       SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                           INSERT  INTO dbo.Branch_Audit
                                           ( 
                                            ID_Branch,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.ID_Branch,@login_name,GETDATE(),'I'  
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
                                         + 'ID_Branch = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                       
									   INSERT  INTO dbo.Branch_Audit
                                       ( 
                                        ID_Branch,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
