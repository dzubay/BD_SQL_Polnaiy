

begin tran 

CREATE TABLE Orders_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Orders              bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(max)        null
--    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Orders_Group_2;


go

CREATE TRIGGER trg_Orders_Audit ON Orders
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
							SELECT d.ID_Orders,@login_name,GETDATE(),'U'  
							FROM  Deleted D

							insert into @t_U_I (ID_entity,login_name,ModifiedDate,Name_action)
							SELECT d.ID_Orders,@login_name,GETDATE(),'U'  
							FROM  inserted D
                            
							DECLARE @ID_entity_D    bigint       ;
							DECLARE @login_name_2_D nvarchar(128);
							DECLARE @ModifiedDate_D DATETIME     ;
							DECLARE @Name_action_D  char(1)      ;
 
							DECLARE @ID_entity_I    bigint       ;
							DECLARE @login_name_2_I nvarchar(128);
							DECLARE @ModifiedDate_I DATETIME     ;
							DECLARE @Name_action_I  char(1)      ;
	                       
						   DECLARE @OldID_Orders        bigint              ;
						   DECLARE @OldID_status        bigint        		;
						   DECLARE @OldID_TypeOrders    bigint        		;
						   DECLARE @OldID_Currency      bigint        		;
						   DECLARE @OldDate             datetime      		;
						   DECLARE @OldPayment_Date     datetime      		;
						   DECLARE @OldAmount           float         		;
						   DECLARE @OldAmountCurr       float         		;
						   DECLARE @OldAmountNDS        float         		;
						   DECLARE @OldAmountCurrNDS    float         		;
						   DECLARE @OldNum              nvarchar(50)  		;
						   DECLARE @OldDescription      nvarchar(4000)		;


						   DECLARE @NewID_Orders        bigint              ;
						   DECLARE @NewID_status        bigint        		;
						   DECLARE @NewID_TypeOrders    bigint        		;
						   DECLARE @NewID_Currency      bigint        		;
						   DECLARE @NewDate             datetime      		;
						   DECLARE @NewPayment_Date     datetime      		;
						   DECLARE @NewAmount           float         		;
						   DECLARE @NewAmountCurr       float         		;
						   DECLARE @NewAmountNDS        float         		;
						   DECLARE @NewAmountCurrNDS    float         		;
						   DECLARE @NewNum              nvarchar(50)  		;
						   DECLARE @NewDescription      nvarchar(4000)		;
						
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
							                   @OldID_Orders      =  D.ID_Orders        ,
							            	   @OldID_status      =  D.ID_status    	,
							            	   @OldID_TypeOrders  =  D.ID_TypeOrders	,
							            	   @OldID_Currency    =  D.ID_Currency  	,
							            	   @OldDate           =  D.Date             ,       --convert(datetime,Date,109),
							            	   @OldPayment_Date   =  D.Payment_Date     ,       --convert(datetime,Payment_Date,109),
							            	   @OldAmount         =  D.Amount       	,
							            	   @OldAmountCurr     =  D.AmountCurr   	,
							            	   @OldAmountNDS      =  D.AmountNDS    	,
							            	   @OldAmountCurrNDS  =  D.AmountCurrNDS	,
							            	   @OldNum            =  D.Num          	,
							            	   @OldDescription    =  D.[Description]  
							            FROM Deleted D																		 
										where @ID_entity_D = D.ID_Orders

										SELECT 
                                               @NewID_Orders      =  I.ID_Orders        ,
							            	   @NewID_status      =  I.ID_status    	,
							            	   @NewID_TypeOrders  =  I.ID_TypeOrders	,
							            	   @NewID_Currency    =  I.ID_Currency  	,
							            	   @NewDate           =  I.Date             ,         --convert(datetime,Date,109),     
							            	   @NewPayment_Date   =  I.Payment_Date     ,         --convert(datetime,Payment_Date,109),
							            	   @NewAmount         =  I.Amount       	,
							            	   @NewAmountCurr     =  I.AmountCurr   	,
							            	   @NewAmountNDS      =  I.AmountNDS    	,
							            	   @NewAmountCurrNDS  =  I.AmountCurrNDS	,
							            	   @NewNum            =  I.Num          	,
							            	   @NewDescription    =  I.[Description]  
							            FROM inserted I									 
										where @ID_entity_D = I.ID_Orders


                                        IF @NewID_status <> @OldID_status 
							               begin
                                              SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_status = Old ->"' +  ISNULL(CAST(@OldID_status AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_status AS NVARCHAR(50)),'') + '", ';
							               end
                                        
							            IF @NewID_TypeOrders <> @OldID_TypeOrders 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_TypeOrders = Old ->"' +  ISNULL(CAST(@OldID_TypeOrders AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_TypeOrders AS NVARCHAR(50)),'') + '", ';
							               end
							            IF @NewID_Currency <> @OldID_Currency 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Currency = Old ->"' +  ISNULL(CAST(@OldID_Currency AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewID_Currency AS NVARCHAR(50)),'') + '", ';
							               end
                                                                                                
							            IF @NewDate <> @OldDate 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date = Old ->"' +  ISNULL(CAST(Format(@OldDate,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							               end
							            IF @NewPayment_Date <> @OldPayment_Date 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Payment_Date = Old ->"' +  ISNULL(CAST(Format(@OldPayment_Date,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewPayment_Date,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							               end
							            IF @NewAmount <> @OldAmount 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Amount = Old ->"' +  ISNULL(CAST(@OldAmount AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewAmount AS NVARCHAR(50)),'') + '", ';
							               end
							            
							            IF @NewAmountCurr <> @OldAmountCurr 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  AmountCurr = Old ->"' +  ISNULL(CAST(@OldAmountCurr AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewAmountCurr AS NVARCHAR(50)),'') + '", ';
							               end
							            IF @NewAmountNDS <> @OldAmountNDS 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  AmountNDS = Old ->"' +  ISNULL(CAST(@OldAmountNDS AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewAmountNDS AS NVARCHAR(50)),'') + '", ';
							               end
                                        
							            IF @NewAmountCurrNDS <> @OldAmountCurrNDS 
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  AmountCurrNDS = Old ->"' +  ISNULL(CAST(@OldAmountCurrNDS AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewAmountCurrNDS AS NVARCHAR(50)),'') + '", ';
							               end
							            IF @NewNum <> @OldNum
							               begin
							                  SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Num = Old ->"' +  ISNULL(@OldNum,'') + ' " NEW -> " ' + isnull(@NewNum,'') + '", ';
							               end
							            
                                        IF @NewDescription <> @OldDescription
							               begin
                                              SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                                           end
                                        SET @ChangeDescription = 'Updated: ' + ' ID_Orders = "' +  isnull(cast(@OldID_Orders as nvarchar(20)),'')+ '" ' + @ChangeDescription
                                         --Удаляем запятую на конце
                                        IF LEN(@ChangeDescription) > 0
                                            SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                                        
										INSERT  INTO dbo.Orders_Audit
                                        ( 
                                         ID_Orders,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
							SELECT d.ID_Orders,@login_name,GETDATE(),'D'  
							FROM  Deleted D

							DECLARE @ID_entity_D_2    bigint       ;
							DECLARE @login_name_2_D_2 nvarchar(128);
							DECLARE @ModifiedDate_D_2 DATETIME     ;
							DECLARE @Name_action_D_2  char(1)      ;

                            DECLARE @OldID_Orders_2        bigint        ;
							DECLARE @OldID_status_2        bigint        ;
							DECLARE @OldID_TypeOrders_2    bigint        ;
							DECLARE @OldID_Currency_2      bigint        ;
							DECLARE @OldDate_2             datetime      ;
							DECLARE @OldPayment_Date_2     datetime      ;
							DECLARE @OldAmount_2           float         ;
							DECLARE @OldAmountCurr_2       float         ;
							DECLARE @OldAmountNDS_2        float         ;
							DECLARE @OldAmountCurrNDS_2    float         ;
							DECLARE @OldNum_2              nvarchar(50)  ;
							DECLARE @OldDescription_2      nvarchar(4000);

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
							               @OldID_Orders_2       =  D.ID_Orders        ,
							               @OldID_status_2     	 =  D.ID_status    	   ,
							               @OldID_TypeOrders_2 	 =  D.ID_TypeOrders	   ,
							               @OldID_Currency_2   	 =  D.ID_Currency  	   ,
							               @OldDate_2          	 =  D.Date             ,    --convert(datetime,Date,109),         	 
							               @OldPayment_Date_2  	 =  D.Payment_Date     ,    --convert(datetime,Payment_Date,109), 	 
							               @OldAmount_2        	 =  D.Amount       	   ,
							               @OldAmountCurr_2    	 =  D.AmountCurr   	   ,
							               @OldAmountNDS_2     	 =  D.AmountNDS    	   ,
							               @OldAmountCurrNDS_2 	 =  D.AmountCurrNDS	   ,
							               @OldNum_2           	 =  D.Num          	   ,
							               @OldDescription_2   	 =  D.[Description]  	 
							            FROM deleted D									 
										where @ID_entity_D_2 = D.ID_Orders

                                        SET @ChangeDescription = 'Deleted: '
							            + 'ID_Orders'      +' = "'+  ISNULL(CAST(@OldID_Orders_2     AS NVARCHAR(50)),'')     + '", '
							            + 'ID_status'      +' = "'+  ISNULL(CAST(@OldID_status_2     AS NVARCHAR(50)),'') 	   + '", '
							            + 'ID_TypeOrders'  +' = "'+  ISNULL(CAST(@OldID_TypeOrders_2 AS NVARCHAR(50)),'') 	   + '", '
							            + 'ID_Currency'    +' = "'+  ISNULL(CAST(@OldID_Currency_2   AS NVARCHAR(50)),'') 	   + '", '
							            + 'Date'           +' = "'+  ISNULL(CAST(Format(@OldDate_2,'yyyy-MM-dd HH:mm:ss.fff')          AS NVARCHAR(50)),'') 	   + '", '
							            + 'Payment_Date'   +' = "'+  ISNULL(CAST(Format(@OldPayment_Date_2,'yyyy-MM-dd HH:mm:ss.fff')  AS NVARCHAR(50)),'') 	   + '", '
							            + 'Amount'         +' = "'+  ISNULL(CAST(@OldAmount_2        AS NVARCHAR(50)),'') 	   + '", '
							            + 'AmountCurr'     +' = "'+  ISNULL(CAST(@OldAmountCurr_2    AS NVARCHAR(50)),'') 	   + '", '
							            + 'AmountNDS'      +' = "'+  ISNULL(CAST(@OldAmountNDS_2     AS NVARCHAR(50)),'') 	   + '", '
							            + 'AmountCurrNDS'  +' = "'+  ISNULL(CAST(@OldAmountCurrNDS_2 AS NVARCHAR(50)),'') 	   + '", '
							            + 'Num'            +' = "'+  ISNULL(@OldNum_2          ,'') 	   + '", '
							            + '[Description]'  +' = "'+  ISNULL(@OldDescription_2  ,'') 	   + '", '

                                        IF LEN(@ChangeDescription) > 0
                                              SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                                         INSERT  INTO dbo.Orders_Audit
                                         ( 
                                          ID_Orders,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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
					SELECT I.ID_Orders,@login_name,GETDATE(),'I'  
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
                                         + 'ID_Orders = "' + CAST(@ID_entity_I_2 AS NVARCHAR(20)) + '" ';
                                     
                                     INSERT  INTO dbo.Orders_Audit
                                     ( 
                                      ID_Orders,ModifiedBy,ModifiedDate,Operation,ChangeDescription                
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




 