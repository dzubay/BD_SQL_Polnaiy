﻿

begin tran 

CREATE TABLE Data_Orders_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_Data_Orders         bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)         null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Orders_Group_2;


go

CREATE TRIGGER trg_Data_Orders_Audit ON Data_Orders
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
							SELECT d.Id_Data_Orders,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.Id_Data_Orders,@login_name,GETDATE(),'U'  
							FROM  inserted D
 
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;
                           
                           DECLARE @OldId_Data_Orders              bigint           ;
						   DECLARE @OldID_Employee                 bigint    		;
						   DECLARE @OldID_Orders                   bigint    		;
						   DECLARE @OldId_buyer                    bigint    		;
						   DECLARE @OldID_Exemplar                 bigint    		;
						   DECLARE @OldID_Transaction              bigint    		;
						   DECLARE @OldDate_Data_Orders            datetime  		;
	                       DECLARE @OldDescription                 nvarchar(4000)	;

                           DECLARE @NewId_Data_Orders              bigint           ;
						   DECLARE @NewID_Employee                 bigint    		;
						   DECLARE @NewID_Orders                   bigint    		;
						   DECLARE @NewId_buyer                    bigint    		;
						   DECLARE @NewID_Exemplar                 bigint    		;
						   DECLARE @NewID_Transaction              bigint    		;
						   DECLARE @NewDate_Data_Orders            datetime  		;
	                       DECLARE @NewDescription                 nvarchar(4000)	;
                           

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
                                               @OldId_Data_Orders     =  D.Id_Data_Orders  ,
									           @OldID_Employee        =  D.ID_Employee     ,
									           @OldID_Orders          =  D.ID_Orders       ,
									           @OldId_buyer           =  D.Id_buyer        ,
									           @OldID_Exemplar        =  D.ID_Exemplar     ,
									           @OldID_Transaction     =  D.ID_Transaction  ,
									           @OldDate_Data_Orders   =  D.Date_Data_Orders,
									           @OldDescription        =  D.[Description]        							
							             FROM Deleted D	
										 where @ID_entity_D = D.Id_Data_Orders;

							             SELECT 
                                                @NewId_Data_Orders    =  I.Id_Data_Orders  ,
							             		@NewID_Employee       =  I.ID_Employee     ,
							             		@NewID_Orders         =  I.ID_Orders       ,
							             		@NewId_buyer          =  I.Id_buyer        ,
							             		@NewID_Exemplar       =  I.ID_Exemplar     ,
							             		@NewID_Transaction    =  I.ID_Transaction  ,
							             		@NewDate_Data_Orders  =  I.Date_Data_Orders,
							             		@NewDescription       =  I.[Description]         	
							             FROM inserted I	
										 where @ID_entity_D = I.Id_Data_Orders;
																	 
                                         IF @NewID_Employee <> @OldID_Employee
							                begin
                                             SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Employee = Old ->"' +  ISNULL(CAST(@OldID_Employee AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Employee AS NVARCHAR(20)),'') + '", ';
							                end
                                         
							             IF @NewID_Orders <> @OldID_Orders
							                begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Orders = Old ->"' +  ISNULL(CAST(@OldID_Orders AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Orders AS NVARCHAR(20)),'') + '", ';
							                end
							             IF @NewId_buyer <> @OldId_buyer 
							                begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Id_buyer = Old ->"' +  ISNULL(cast(@OldId_buyer AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(cast(@NewId_buyer AS NVARCHAR(20)),'') + '", ';
							                end
                                                                                                 
							             IF @NewID_Exemplar <> @OldID_Exemplar 
							                begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Exemplar = Old ->"' +  ISNULL(cast(@OldID_Exemplar AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Exemplar AS NVARCHAR(20)),'') + '", ';
							                end
							             IF @NewID_Transaction <> @OldID_Transaction 
							                begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Transaction = Old ->"' +  ISNULL(CAST(@OldID_Transaction AS NVARCHAR(20)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Transaction AS NVARCHAR(20)),'') + '", ';
							                end
							             
							             IF @NewDate_Data_Orders <> @OldDate_Data_Orders
							                begin
							                 SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Data_Orders = Old ->"' +  ISNULL(CAST(Format(@OldDate_Data_Orders,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Data_Orders,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							                end
							             
                                         IF @NewDescription <> @OldDescription
							                begin
                                             SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                            end
                                         SET @ChangeDescription = 'Updated: ' + ' Id_Data_Orders = "' +  isnull(cast(@OldId_Data_Orders as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                          --Удаляем запятую на конце
                                         IF LEN(@ChangeDescription) > 0
                                             SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                                         INSERT  INTO dbo.Data_Orders_Audit
                                         ( 
                                          Id_Data_Orders,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
						   SELECT d.Id_Data_Orders,@login_name,GETDATE(),'D'  
						   FROM  Deleted D


							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

                           DECLARE @OldId_Data_Orders_2              bigint           ;
						   DECLARE @OldID_Employee_2                 bigint    		  ;
						   DECLARE @OldID_Orders_2                   bigint    		  ;
						   DECLARE @OldId_buyer_2                    bigint    		  ;
						   DECLARE @OldID_Exemplar_2                 bigint    		  ;
						   DECLARE @OldID_Transaction_2              bigint    		  ;
						   DECLARE @OldDate_Data_Orders_2            datetime  		  ;
	                       DECLARE @OldDescription_2                 nvarchar(4000)	  ;

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
							                    @OldId_Data_Orders_2  	   = D.Id_Data_Orders    ,
							                	@OldID_Employee_2     	   = D.ID_Employee       ,
							                	@OldID_Orders_2       	   = D.ID_Orders         ,
							                	@OldId_buyer_2        	   = D.Id_buyer          ,
							                	@OldID_Exemplar_2     	   = D.ID_Exemplar       ,
							                	@OldID_Transaction_2  	   = D.ID_Transaction    ,
							                	@OldDate_Data_Orders_2     = D.Date_Data_Orders  ,
							                	@OldDescription_2          = D.[Description]        
							                FROM deleted D									 
							                where @ID_entity_D_2 = D.Id_Data_Orders

                                            SET @ChangeDescription = 'Deleted: '
							                + 'Id_Data_Orders'     +' = "'+  ISNULL(CAST(@OldId_Data_Orders_2 AS NVARCHAR(20)),'')     + '", '
							                + 'ID_Employee'        +' = "'+  ISNULL(CAST(@OldID_Employee_2 AS NVARCHAR(20)),'')     + '", '
							                + 'ID_Orders'          +' = "'+  ISNULL(CAST(@OldID_Orders_2 AS NVARCHAR(20)),'')     + '", '
							                + 'Id_buyer'           +' = "'+  ISNULL(CAST(@OldId_buyer_2 AS NVARCHAR(20)),'')     + '", '
							                + 'ID_Exemplar'        +' = "'+  ISNULL(CAST(@OldID_Exemplar_2 AS NVARCHAR(20)),'')     + '", '
							                + 'ID_Transaction'     +' = "'+  ISNULL(CAST(@OldID_Transaction_2 AS NVARCHAR(20)),'')     + '", '
							                + 'Date_Data_Orders'   +' = "'+  ISNULL(CAST(Format(@OldDate_Data_Orders_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							                + 'Description'        +' = "'+  ISNULL(@OldDescription_2  ,'') + '", '

						                    IF LEN(@ChangeDescription) > 0
                                                    SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                            INSERT  INTO dbo.Data_Orders_Audit
                                            ( 
                                             Id_Data_Orders,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.Id_Data_Orders,@login_name,GETDATE(),'I'  
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
                                         + 'Id_Data_Orders = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                    
                                    INSERT  INTO dbo.Data_Orders_Audit
                                     ( 
                                      Id_Data_Orders,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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


