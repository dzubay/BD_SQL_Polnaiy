

begin tran 

CREATE TABLE Buyer_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_buyer               bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)        null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Costomers_Group_2;


go

CREATE TRIGGER trg_Buyer_Audit ON Buyer
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
							SELECT d.Id_buyer,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.Id_buyer,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;

							DECLARE @OldId_buyer                    bigint       ;
							DECLARE @OldID_Connection_Buyer         bigint       ;
							DECLARE @OldId_Status                   bigint       ;
							DECLARE @OldName                        nvarchar(100);
							DECLARE @OldSurName                     nvarchar(100);
							DECLARE @OldLastName                    nvarchar(100);
							DECLARE @OldMail                        nvarchar(250);
							DECLARE @OldPol                         char(1)      ;
							DECLARE @OldPhone                       nvarchar(30) ;
							DECLARE @OldDate_Of_Birth               datetime     ;
							DECLARE @OldDescription                 nvarchar(4000);
							
							DECLARE @NewId_buyer                    bigint       ;
							DECLARE @NewID_Connection_Buyer         bigint       ;
							DECLARE @NewId_Status                   bigint       ;
							DECLARE @NewName                        nvarchar(100);
							DECLARE @NewSurName                     nvarchar(100);
							DECLARE @NewLastName                    nvarchar(100);
							DECLARE @NewMail                        nvarchar(250);
							DECLARE @NewPol                         char(1)      ;
							DECLARE @NewPhone                       nvarchar(30) ;
							DECLARE @NewDate_Of_Birth               datetime     ;
							DECLARE @NewDescription                 nvarchar(4000);


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
							                @OldId_buyer             = D.Id_buyer           , 
							            	@OldID_Connection_Buyer  = D.ID_Connection_Buyer,
							            	@OldId_Status            = D.Id_Status          ,
							            	@OldName                 = D.Name               ,
							            	@OldSurName              = D.SurName            ,
							            	@OldLastName             = D.LastName           ,
							            	@OldMail                 = D.Mail               ,
							            	@OldPol                  = D.Pol                ,
							            	@OldPhone                = D.Phone              ,
							            	@OldDate_Of_Birth        = D.Date_Of_Birth      ,
							            	@OldDescription          = D.[Description]        							
							            FROM Deleted D
										where @ID_entity_D = D.Id_buyer;

							            SELECT 
							                @NewId_buyer             = I.Id_buyer           , 
							            	@NewID_Connection_Buyer  = I.ID_Connection_Buyer,
							            	@NewId_Status            = I.Id_Status          ,
							            	@NewName                 = I.Name               ,
							            	@NewSurName              = I.SurName            ,
							            	@NewLastName             = I.LastName           ,
							            	@NewMail                 = I.Mail               ,
							            	@NewPol                  = I.Pol                ,
							            	@NewPhone                = I.Phone              ,
							            	@NewDate_Of_Birth        = I.Date_Of_Birth      ,
							            	@NewDescription          = I.[Description]        	
							            FROM inserted I									 
							            where @ID_entity_D = I.Id_buyer;


                                       IF @NewID_Connection_Buyer <> @OldID_Connection_Buyer 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Connection_Buyer = Old ->"' +  ISNULL(CAST(@OldID_Connection_Buyer AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Connection_Buyer AS NVARCHAR(50)),'') + '", ';
							              end
                                       
							           IF @NewId_Status <> @OldId_Status
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Id_Status = Old ->"' +  ISNULL(CAST(@OldId_Status AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewId_Status AS NVARCHAR(50)),'') + '", ';
							              end
							           IF @NewName <> @OldName 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name = Old ->"' +  ISNULL(@OldName,'') + ' " NEW -> " ' + isnull(@NewName,'') + '", ';
							              end
                                                                                               
							           IF @NewSurName <> @OldSurName 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SurName = Old ->"' +  ISNULL(@OldSurName,'') + ' " NEW -> " ' + isnull(@NewSurName,'') + '", ';
							              end
							           IF @NewLastName <> @OldLastName 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  LastName = Old ->"' +  ISNULL(@OldLastName,'') + ' " NEW -> " ' + isnull(@NewLastName,'') + '", ';
							              end
							           IF @NewMail <> @OldMail 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Mail = Old ->"' +  ISNULL(@OldMail,'') + ' " NEW -> " ' + isnull(@NewMail,'') + '", ';
							              end
							           
							           IF @NewPol <> @OldPol 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Pol = Old ->"' +  ISNULL(CAST(@OldPol AS NVARCHAR(1)),'') + ' " NEW -> " ' + isnull(CAST(@NewPol AS NVARCHAR(1)),'') + '", ';
							              end
							           IF @NewPhone <> @OldPhone 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Phone = Old ->"' +  ISNULL(@OldPhone,'') + ' " NEW -> " ' + isnull(@NewPhone,'') + '", ';
							              end
                           	           			
							           IF @NewDate_Of_Birth <> @OldDate_Of_Birth
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Of_Birth = Old ->"' +  ISNULL(CAST(Format(@OldDate_Of_Birth,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Of_Birth,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							              end
							           
                                       IF @NewDescription <> @OldDescription
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                          end
                                       SET @ChangeDescription = 'Updated: ' + ' Id_buyer = "' +  isnull(cast(@OldId_buyer as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                        --Удаляем запятую на конце
                                       IF LEN(@ChangeDescription) > 0
                                           SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                       
									   INSERT  INTO dbo.Buyer_Audit
                                        ( 
                                         Id_buyer,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.Id_buyer,@login_name,GETDATE(),'D'  
							FROM  Deleted D

							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

                            DECLARE @OldId_buyer_2                    bigint         ;
							DECLARE @OldID_Connection_Buyer_2         bigint       	 ;
							DECLARE @OldId_Status_2                   bigint       	 ;
							DECLARE @OldName_2                        nvarchar(100)	 ;
							DECLARE @OldSurName_2                     nvarchar(100)	 ;
							DECLARE @OldLastName_2                    nvarchar(100)	 ;
							DECLARE @OldMail_2                        nvarchar(250)	 ;
							DECLARE @OldPol_2                         char(1)      	 ;
							DECLARE @OldPhone_2                       nvarchar(30) 	 ;
							DECLARE @OldDate_Of_Birth_2               datetime     	 ;
							DECLARE @OldDescription_2                 nvarchar(4000) ;



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
							                    @OldId_buyer_2             = D.Id_buyer           , 
							                	@OldID_Connection_Buyer_2  = D.ID_Connection_Buyer,
							                	@OldId_Status_2            = D.Id_Status          ,
							                	@OldName_2                 = D.Name               ,
							                	@OldSurName_2              = D.SurName            ,
							                	@OldLastName_2             = D.LastName           ,
							                	@OldMail_2                 = D.Mail               ,
							                	@OldPol_2                  = D.Pol                ,
							                	@OldPhone_2                = D.Phone              ,
							                	@OldDate_Of_Birth_2        = D.Date_Of_Birth      ,
							                	@OldDescription_2          = D.[Description]        
							                FROM deleted D									 
											where @ID_entity_D_2 = D.Id_buyer;

                                            SET @ChangeDescription = 'Deleted: '
							                + 'Id_buyer'            +' = "'+  ISNULL(CAST(@OldId_buyer_2     AS NVARCHAR(50)),'')     + '", '
							                + 'ID_Connection_Buyer' +' = "'+  ISNULL(CAST(@OldID_Connection_Buyer_2  AS NVARCHAR(50)),'') + '", '
							                + 'Id_Status'           +' = "'+  ISNULL(CAST(@OldId_Status_2 AS NVARCHAR(50)),'') + '", '
							                + 'Name'                +' = "'+  ISNULL(@OldName_2,'')+ '", '				
							                + 'SurName'             +' = "'+  ISNULL(@OldSurName_2,'')+ '", '
							                + 'LastName'            +' = "'+  ISNULL(@OldLastName_2,'') + '", '
							                + 'Mail'                +' = "'+  ISNULL(@OldMail_2,'')+ '", '
							                + 'Pol'                 +' = "'+  ISNULL(CAST(@OldPol_2 AS NVARCHAR(1)),'') 	   + '", '
							                + 'Phone'               +' = "'+  ISNULL(@OldPhone_2,'')+ '", '
							                + 'Date_Of_Birth'       +' = "'+  ISNULL(CAST(Format(@OldDate_Of_Birth_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							                + 'Description'         +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

                                           IF LEN(@ChangeDescription) > 0
						                       SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                           INSERT  INTO dbo.Buyer_Audit
                                           ( 
                                            Id_buyer,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.Id_buyer,@login_name,GETDATE(),'I'  
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
                                         + 'Id_buyer = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                       
									   INSERT  INTO dbo.Buyer_Audit
                                       ( 
                                        Id_buyer,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
