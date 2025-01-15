
begin tran 

CREATE TABLE Connection_Buyer_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    ID_Connection_Buyer    bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Orders_Group_2;


go

CREATE TRIGGER trg_Connection_Buyer_Audit ON Connection_Buyer
AFTER INSERT, UPDATE, DELETE

AS
    DECLARE @login_name nVARCHAR(128) 
	DECLARE @ChangeDescription nvarchar(4000);


    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID

    IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Connection_Buyer_Audit
                            ( 
                               ID_Connection_Buyer            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Connection_Buyer
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                                          	                      

						   DECLARE @OldID_Connection_Buyer  bigint          ;
						   DECLARE @OldPassword           	nvarchar(50)  	;
						   DECLARE @OldLogin              	nvarchar(100) 	;
						   DECLARE @OldDate_Сreated       	datetime      	;
						   DECLARE @OldDescription      	nvarchar(1000)	;


						   DECLARE @NewID_Connection_Buyer  bigint          ;
						   DECLARE @NewPassword           	nvarchar(50)  	;
						   DECLARE @NewLogin              	nvarchar(100) 	;
						   DECLARE @NewDate_Сreated       	datetime      	;
						   DECLARE @NewDescription      	nvarchar(1000)	;
                       

							SELECT 
                                  @NewID_Connection_Buyer = ID_Connection_Buyer  ,
								  @NewPassword            = Password           	 ,
								  @NewLogin               = Login              	 ,
								  @NewDate_Сreated        = Date_Сreated       	 ,
								  @NewDescription      	  = [Description]      	
							FROM inserted;									 

							SELECT 
                                  @OldID_Connection_Buyer = ID_Connection_Buyer  ,
								  @OldPassword            = Password           	 ,
								  @OldLogin               = Login              	 ,
								  @OldDate_Сreated        = Date_Сreated       	 ,
								  @OldDescription      	  = [Description]      	
							FROM Deleted;																		 

                            IF @NewPassword <> @OldPassword 
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Password = Old ->"' +  ISNULL(CAST(@OldPassword AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewPassword AS NVARCHAR(50)),'') + '", ';
							   end
                            
							IF @NewLogin <> @OldLogin 
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Login = Old ->"' +  ISNULL(CAST(@OldLogin AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(@NewLogin AS NVARCHAR(50)),'') + '", ';
							   end
							IF @NewDate_Сreated <> @OldDate_Сreated
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Date_Сreated = Old ->"' +  ISNULL(CAST(Format(@OldDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + ' " NEW -> " ' + isnull(CAST(Format(@NewDate_Сreated,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", ';
							   end
                                                                                    
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> " ' + ISNULL(@NewDescription,'') + '", ';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_Connection_Buyer = (' +  isnull(cast(@OldID_Connection_Buyer as nvarchar(20)),'')+ ') ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Connection_Buyer_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Connection_Buyer_Audit
                            ( 
                               ID_Connection_Buyer       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Connection_Buyer
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                             DECLARE @OldID_Connection_Buyer_2  bigint          ;
							 DECLARE @OldPassword_2           	nvarchar(50)  	;
							 DECLARE @OldLogin_2              	nvarchar(100) 	;
							 DECLARE @OldDate_Сreated_2       	datetime      	;
							 DECLARE @OldDescription_2         	nvarchar(1000)	;


							SELECT 
                                  @OldID_Connection_Buyer_2	   = ID_Connection_Buyer  ,
								  @OldPassword_2           	   = Password             ,
								  @OldLogin_2              	   = Login                ,
								  @OldDate_Сreated_2       	   = Date_Сreated         ,
								  @OldDescription_2            = [Description]      	  
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Connection_Buyer'  +'="'+  ISNULL(CAST(@OldID_Connection_Buyer_2  AS NVARCHAR(50)),'')+ '", '
							+ 'Password'             +'="'+  ISNULL(CAST(@OldPassword_2  AS NVARCHAR(50)),'')+ '", '
							+ 'Login'                +'="'+  ISNULL(CAST(@OldLogin_2   AS NVARCHAR(50)),'')+ '", '
							+ 'Date_Сreated'         +'="'+  ISNULL(CAST(Format(@OldDate_Сreated_2,'yyyy-MM-dd HH:mm:ss.fff')AS NVARCHAR(50)),'')+ '", '
							+ '[Description]'        +'="'+  ISNULL(@OldDescription_2  ,'')+ '", '


                          update u
						  set ChangeDescription = @ChangeDescription
						  from Connection_Buyer_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Connection_Buyer_Audit
                    ( 
                          ID_Connection_Buyer  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Connection_Buyer
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Connection_Buyer_3 BIGINT;
                    SELECT @ID_Connection_Buyer_3 = ID_Connection_Buyer FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Connection_Buyer="' + CAST(@ID_Connection_Buyer_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Connection_Buyer_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback

commit


 