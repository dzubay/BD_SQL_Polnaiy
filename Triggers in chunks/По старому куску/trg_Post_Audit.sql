begin tran 

CREATE TABLE Post_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Post                bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)        null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Employee_Group_2;


go

CREATE TRIGGER trg_Post_Audit ON Post
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
							SELECT d.ID_Post,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Post,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;


							DECLARE @OldID_Post               bigint        ;
							DECLARE @OldName_Post             nvarchar(200) ;
							DECLARE @OldID_Department         bigint        ;
							DECLARE @OldID_Group              bigint        ;
							DECLARE @OldID_The_Subgroup       bigint        ;
							DECLARE @OldDescription           nvarchar(1000);

                            DECLARE @NewID_Post               bigint        ;
							DECLARE @NewName_Post             nvarchar(200) ;
							DECLARE @NewID_Department         bigint        ;
							DECLARE @NewID_Group              bigint        ;
							DECLARE @NewID_The_Subgroup       bigint        ;
							DECLARE @NewDescription           nvarchar(1000);


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
                                              @OldID_Post         = D.ID_Post        , 
											  @OldName_Post       = D.Name_Post      , 
											  @OldID_Department   = D.ID_Department  , 
											  @OldID_Group        = D.ID_Group       , 
											  @OldID_The_Subgroup = D.ID_The_Subgroup, 
											  @OldDescription     = D.[Description]         							
							            FROM Deleted D
										where @ID_entity_D = D.ID_Post;

							            SELECT 
                                              @NewID_Post         = I.ID_Post        , 
											  @NewName_Post       = I.Name_Post      , 
											  @NewID_Department   = I.ID_Department  , 
											  @NewID_Group        = I.ID_Group       , 
											  @NewID_The_Subgroup = I.ID_The_Subgroup, 
											  @NewDescription     = I.[Description]    
							            FROM inserted I									 
							            where @ID_entity_D = I.ID_Post;


                                       
									   IF @NewName_Post <> @OldName_Post 
							              begin
							               SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name_Post = Old ->"' +  ISNULL(@OldName_Post,'') + ' " NEW -> " ' + isnull(@NewName_Post,'') + '", ';
							              end

                                       IF @NewID_Department <> @OldID_Department 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Department = Old ->"' +  ISNULL(CAST(@OldID_Department AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Department AS NVARCHAR(50)),'') + '", ';
							              end

                                       IF @NewID_Group <> @OldID_Group 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Group = Old ->"' +  ISNULL(CAST(@OldID_Group AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Group AS NVARCHAR(50)),'') + '", ';
							              end

                                       IF @NewID_The_Subgroup <> @OldID_The_Subgroup 
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_The_Subgroup = Old ->"' +  ISNULL(CAST(@OldID_The_Subgroup AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_The_Subgroup AS NVARCHAR(50)),'') + '", ';
							              end
			           
                                       IF @NewDescription <> @OldDescription
							              begin
                                           SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                          end
                                       SET @ChangeDescription = 'Updated: ' + ' ID_Post = "' +  isnull(cast(@OldID_Post as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                        --Удаляем запятую на конце
                                       IF LEN(@ChangeDescription) > 0
                                           SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                       
									   INSERT  INTO dbo.Post_Audit
                                        ( 
                                         ID_Post,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Post,@login_name,GETDATE(),'D'  
							FROM  Deleted D

							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

							DECLARE @OldID_Post_2               bigint        ;
							DECLARE @OldName_Post_2             nvarchar(200) ;
							DECLARE @OldID_Department_2         bigint        ;
							DECLARE @OldID_Group_2              bigint        ;
							DECLARE @OldID_The_Subgroup_2       bigint        ;
							DECLARE @OldDescription_2           nvarchar(1000);



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
                                                 @OldID_Post_2         = D.ID_Post        ,
												 @OldName_Post_2       = D.Name_Post      ,
												 @OldID_Department_2   = D.ID_Department  ,
												 @OldID_Group_2        = D.ID_Group       ,
												 @OldID_The_Subgroup_2 = D.ID_The_Subgroup,
												 @OldDescription_2     = D.[Description]   
							                FROM deleted D									 
											where @ID_entity_D_2 = D.ID_Post;

                                            SET @ChangeDescription = 'Deleted: '
							                + 'ID_Post'         +' = "'+  ISNULL(CAST(@OldID_Post_2     AS NVARCHAR(50)),'')     + '", '
							                + 'Name_Post'       +' = "'+  ISNULL(@OldName_Post_2,'')+ '", '	
							                + 'ID_Department'   +' = "'+  ISNULL(CAST(@OldID_Department_2  AS NVARCHAR(50)),'') + '", '
							                + 'ID_Group'        +' = "'+  ISNULL(CAST(@OldID_Group_2 AS NVARCHAR(50)),'') + '", '
                                            + 'ID_The_Subgroup' +' = "'+  ISNULL(CAST(@OldID_The_Subgroup_2 AS NVARCHAR(50)),'') + '", '
							                + 'Description'     +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

                                           IF LEN(@ChangeDescription) > 0
						                       SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                           INSERT  INTO dbo.Post_Audit
                                           ( 
                                            ID_Post,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.ID_Post,@login_name,GETDATE(),'I'  
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
                                         + 'ID_Post = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                       
									   INSERT  INTO dbo.Post_Audit
                                       ( 
                                        ID_Post,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
