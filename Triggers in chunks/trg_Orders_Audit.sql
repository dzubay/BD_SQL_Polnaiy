

begin tran 

CREATE TABLE Orders_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Orders              bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Orders_Group_2;


go

CREATE TRIGGER trg_Orders_Audit ON Orders
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
                    INSERT  INTO dbo.Orders_Audit
                            ( 
                               ID_Orders            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Orders
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                                          
	                       
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
						
                           
                           
                           

							SELECT 
                                   @NewID_Orders      =  ID_Orders      ,
								   @NewID_status      =  ID_status    	,
								   @NewID_TypeOrders  =  ID_TypeOrders	,
								   @NewID_Currency    =  ID_Currency  	,
								   @NewDate           =  Date           ,         --convert(datetime,Date,109),     
								   @NewPayment_Date   =  Payment_Date   ,         --convert(datetime,Payment_Date,109),
								   @NewAmount         =  Amount       	,
								   @NewAmountCurr     =  AmountCurr   	,
								   @NewAmountNDS      =  AmountNDS    	,
								   @NewAmountCurrNDS  =  AmountCurrNDS	,
								   @NewNum            =  Num          	,
								   @NewDescription    =  [Description]  
							FROM inserted;									 

							SELECT 
							       @OldID_Orders      =  ID_Orders      ,
								   @OldID_status      =  ID_status    	,
								   @OldID_TypeOrders  =  ID_TypeOrders	,
								   @OldID_Currency    =  ID_Currency  	,
								   @OldDate           =  Date           ,       --convert(datetime,Date,109),
								   @OldPayment_Date   =  Payment_Date   ,       --convert(datetime,Payment_Date,109),
								   @OldAmount         =  Amount       	,
								   @OldAmountCurr     =  AmountCurr   	,
								   @OldAmountNDS      =  AmountNDS    	,
								   @OldAmountCurrNDS  =  AmountCurrNDS	,
								   @OldNum            =  Num          	,
								   @OldDescription    =  [Description]  
							FROM Deleted;																		 

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
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Orders_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Orders_Audit
                            ( 
                               ID_Orders       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Orders
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                            DECLARE @OldID_Orders_2        bigint               ;
							DECLARE @OldID_status_2        bigint        		;
							DECLARE @OldID_TypeOrders_2    bigint        		;
							DECLARE @OldID_Currency_2      bigint        		;
							DECLARE @OldDate_2             datetime      		;
							DECLARE @OldPayment_Date_2     datetime      		;
							DECLARE @OldAmount_2           float         		;
							DECLARE @OldAmountCurr_2       float         		;
							DECLARE @OldAmountNDS_2        float         		;
							DECLARE @OldAmountCurrNDS_2    float         		;
							DECLARE @OldNum_2              nvarchar(50)  		;
							DECLARE @OldDescription_2      nvarchar(4000)		;


							SELECT 
							   @OldID_Orders_2       =  ID_Orders        ,
							   @OldID_status_2     	 =  ID_status    	 ,
							   @OldID_TypeOrders_2 	 =  ID_TypeOrders	 ,
							   @OldID_Currency_2   	 =  ID_Currency  	 ,
							   @OldDate_2          	 =  Date             ,    --convert(datetime,Date,109),         	 
							   @OldPayment_Date_2  	 =  Payment_Date     ,    --convert(datetime,Payment_Date,109), 	 
							   @OldAmount_2        	 =  Amount       	 ,
							   @OldAmountCurr_2    	 =  AmountCurr   	 ,
							   @OldAmountNDS_2     	 =  AmountNDS    	 ,
							   @OldAmountCurrNDS_2 	 =  AmountCurrNDS	 ,
							   @OldNum_2           	 =  Num          	 ,
							   @OldDescription_2   	 =  [Description]  	 
							FROM deleted;									 

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

                          update u
						  set ChangeDescription = @ChangeDescription
						  from Orders_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Orders_Audit
                    ( 
                          ID_Orders  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Orders
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Orders_3 BIGINT;
                    SELECT @ID_Orders_3 = ID_Orders FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Orders = "' + CAST(@ID_Orders_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Orders_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback

commit




 