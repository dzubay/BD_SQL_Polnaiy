

begin tran 

CREATE TABLE Data_Orders_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_Data_Orders         bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Orders_Group_2;


go

CREATE TRIGGER trg_Data_Orders_Audit ON Data_Orders
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
                    INSERT  INTO dbo.Data_Orders_Audit
                            ( 
                               Id_Data_Orders            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.Id_Data_Orders
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
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
                         
							SELECT 
                                    @NewId_Data_Orders    =  Id_Data_Orders     ,
									@NewID_Employee       =  ID_Employee     	,
									@NewID_Orders         =  ID_Orders       	,
									@NewId_buyer          =  Id_buyer        	,
									@NewID_Exemplar       =  ID_Exemplar     	,
									@NewID_Transaction    =  ID_Transaction  	,
									@NewDate_Data_Orders  =  Date_Data_Orders	,
									@NewDescription       =  [Description]         	
							FROM inserted;									 

							SELECT 
                                    @OldId_Data_Orders     =  Id_Data_Orders     ,
									@OldID_Employee        =  ID_Employee     	 ,
									@OldID_Orders          =  ID_Orders       	 ,
									@OldId_buyer           =  Id_buyer        	 ,
									@OldID_Exemplar        =  ID_Exemplar     	 ,
									@OldID_Transaction     =  ID_Transaction  	 ,
									@OldDate_Data_Orders   =  Date_Data_Orders	 ,
									@OldDescription        =  [Description]        							
							FROM Deleted;																		 

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
                            SET @ChangeDescription = 'Updated: ' + ' Id_Data_Orders ="' +  isnull(cast(@OldId_Data_Orders as nvarchar(20)),'')+ '" ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Data_Orders_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Data_Orders_Audit
                            ( 
                               Id_Data_Orders       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.Id_Data_Orders
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                           DECLARE @OldId_Data_Orders_2              bigint           ;
						   DECLARE @OldID_Employee_2                 bigint    		  ;
						   DECLARE @OldID_Orders_2                   bigint    		  ;
						   DECLARE @OldId_buyer_2                    bigint    		  ;
						   DECLARE @OldID_Exemplar_2                 bigint    		  ;
						   DECLARE @OldID_Transaction_2              bigint    		  ;
						   DECLARE @OldDate_Data_Orders_2            datetime  		  ;
	                       DECLARE @OldDescription_2                 nvarchar(4000)	  ;

                            SELECT 
							    @OldId_Data_Orders_2  	   = Id_Data_Orders    ,
								@OldID_Employee_2     	   = ID_Employee       ,
								@OldID_Orders_2       	   = ID_Orders         ,
								@OldId_buyer_2        	   = Id_buyer          ,
								@OldID_Exemplar_2     	   = ID_Exemplar       ,
								@OldID_Transaction_2  	   = ID_Transaction    ,
								@OldDate_Data_Orders_2     = Date_Data_Orders  ,
								@OldDescription_2          = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'Id_Data_Orders'     +'="'+  ISNULL(CAST(@OldId_Data_Orders_2 AS NVARCHAR(20)),'')     + '", '
							+ 'ID_Employee'        +'="'+  ISNULL(CAST(@OldID_Employee_2 AS NVARCHAR(20)),'')     + '", '
							+ 'ID_Orders'          +'="'+  ISNULL(CAST(@OldID_Orders_2 AS NVARCHAR(20)),'')     + '", '
							+ 'Id_buyer'           +'="'+  ISNULL(CAST(@OldId_buyer_2 AS NVARCHAR(20)),'')     + '", '
							+ 'ID_Exemplar'        +'="'+  ISNULL(CAST(@OldID_Exemplar_2 AS NVARCHAR(20)),'')     + '", '
							+ 'ID_Transaction'     +'="'+  ISNULL(CAST(@OldID_Transaction_2 AS NVARCHAR(20)),'')     + '", '
							+ 'Date_Data_Orders'   +'="'+  ISNULL(CAST(Format(@OldDate_Data_Orders_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							+ 'Description'        +'="'+  ISNULL(@OldDescription_2  ,'') + '", '



                          update u
						  set ChangeDescription = @ChangeDescription
						  from Data_Orders_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Data_Orders_Audit
                    ( 
                          Id_Data_Orders  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.Id_Data_Orders
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @Id_Data_Orders_3 BIGINT;
                    SELECT @Id_Data_Orders_3 = Id_Data_Orders FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'Id_Data_Orders="' + CAST(@Id_Data_Orders_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Data_Orders_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit


