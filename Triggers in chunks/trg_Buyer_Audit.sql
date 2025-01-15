

begin tran 

CREATE TABLE Buyer_Audit
(
    AuditID                bigint IDENTITY(1,1)  not null,
    Id_buyer               bigint                null,
 	ModifiedBy             nVARCHAR(128)         null,
    ModifiedDate           DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation              CHAR(1)               null,
    ChangeDescription      nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
)  on Costomers_Group_2;


go

CREATE TRIGGER trg_Buyer_Audit ON Buyer
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
                    INSERT  INTO dbo.Buyer_Audit
                            ( 
                               ID_Buyer            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Buyer
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
						   DECLARE @OldId_buyer                    bigint           ;
						   DECLARE @OldID_Connection_Buyer         bigint       	;
						   DECLARE @OldId_Status                   bigint       	;
						   DECLARE @OldName                        nvarchar(100)	;
						   DECLARE @OldSurName                     nvarchar(100)	;
						   DECLARE @OldLastName                    nvarchar(100)	;
						   DECLARE @OldMail                        nvarchar(250)	;
						   DECLARE @OldPol                         char(1)      	;
						   DECLARE @OldPhone                       nvarchar(30) 	;
						   DECLARE @OldDate_Of_Birth               datetime     	;
	                       DECLARE @OldDescription                 nvarchar(4000)	;

						   DECLARE @NewId_buyer                    bigint           ;
						   DECLARE @NewID_Connection_Buyer         bigint       	;
						   DECLARE @NewId_Status                   bigint       	;
						   DECLARE @NewName                        nvarchar(100)	;
						   DECLARE @NewSurName                     nvarchar(100)	;
						   DECLARE @NewLastName                    nvarchar(100)	;
						   DECLARE @NewMail                        nvarchar(250)	;
						   DECLARE @NewPol                         char(1)      	;
						   DECLARE @NewPhone                       nvarchar(30) 	;
						   DECLARE @NewDate_Of_Birth               datetime     	;
						   DECLARE @NewDescription                 nvarchar(4000)	;
                     
                         
							SELECT 
							    @NewId_buyer             = Id_buyer           , 
								@NewID_Connection_Buyer  = ID_Connection_Buyer,
								@NewId_Status            = Id_Status          ,
								@NewName                 = Name               ,
								@NewSurName              = SurName            ,
								@NewLastName             = LastName           ,
								@NewMail                 = Mail               ,
								@NewPol                  = Pol                ,
								@NewPhone                = Phone              ,
								@NewDate_Of_Birth        = Date_Of_Birth      ,
								@NewDescription          = [Description]        	
							FROM inserted;									 

							SELECT 
							    @OldId_buyer             = Id_buyer           , 
								@OldID_Connection_Buyer  = ID_Connection_Buyer,
								@OldId_Status            = Id_Status          ,
								@OldName                 = Name               ,
								@OldSurName              = SurName            ,
								@OldLastName             = LastName           ,
								@OldMail                 = Mail               ,
								@OldPol                  = Pol                ,
								@OldPhone                = Phone              ,
								@OldDate_Of_Birth        = Date_Of_Birth      ,
								@OldDescription          = [Description]        							
							FROM Deleted;																		 

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
                            SET @ChangeDescription = 'Updated: ' + ' Id_buyer = (' +  isnull(cast(@OldId_buyer as nvarchar(20)),'')+ ') ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 2);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Buyer_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Buyer_Audit
                            ( 
                               Id_buyer       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.Id_buyer
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                            DECLARE @OldId_buyer_2                    bigint           ;
							DECLARE @OldID_Connection_Buyer_2         bigint       	;
							DECLARE @OldId_Status_2                   bigint       	;
							DECLARE @OldName_2                        nvarchar(100)	;
							DECLARE @OldSurName_2                     nvarchar(100)	;
							DECLARE @OldLastName_2                    nvarchar(100)	;
							DECLARE @OldMail_2                        nvarchar(250)	;
							DECLARE @OldPol_2                         char(1)      	;
							DECLARE @OldPhone_2                       nvarchar(30) 	;
							DECLARE @OldDate_Of_Birth_2               datetime     	;
							DECLARE @OldDescription_2                 nvarchar(4000)	;

                            SELECT 
							    @OldId_buyer_2             = Id_buyer           , 
								@OldID_Connection_Buyer_2  = ID_Connection_Buyer,
								@OldId_Status_2            = Id_Status          ,
								@OldName_2                 = Name               ,
								@OldSurName_2              = SurName            ,
								@OldLastName_2             = LastName           ,
								@OldMail_2                 = Mail               ,
								@OldPol_2                  = Pol                ,
								@OldPhone_2                = Phone              ,
								@OldDate_Of_Birth_2        = Date_Of_Birth      ,
								@OldDescription_2          = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'Id_buyer'            +'="'+  ISNULL(CAST(@OldId_buyer_2     AS NVARCHAR(50)),'')     + '", '
							+ 'ID_Connection_Buyer' +'="'+  ISNULL(CAST(@OldID_Connection_Buyer_2  AS NVARCHAR(50)),'') + '", '
							+ 'Id_Status'           +'="'+  ISNULL(CAST(@OldId_Status_2 AS NVARCHAR(50)),'') + '", '
							+ 'Name'                +'="'+  ISNULL(@OldName_2,'')+ '", '				
							+ 'SurName'             +'="'+  ISNULL(@OldSurName_2,'')+ '", '
							+ 'LastName'            +'="'+  ISNULL(@OldLastName_2,'') + '", '
							+ 'Mail'                +'="'+  ISNULL(@OldMail_2,'')+ '", '
							+ 'Pol'                 +'="'+  ISNULL(CAST(@OldPol_2 AS NVARCHAR(1)),'') 	   + '", '
							+ 'Phone'               +'="'+  ISNULL(@OldPhone_2,'')+ '", '
							+ 'Date_Of_Birth'       +'="'+  ISNULL(CAST(Format(@OldDate_Of_Birth_2,'yyyy-MM-dd HH:mm:ss.fff') AS NVARCHAR(50)),'') + '", '
							+ 'Description'         +'="'+  ISNULL(@OldDescription_2  ,'') + '", '



                          update u
						  set ChangeDescription = @ChangeDescription
						  from Buyer_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Buyer_Audit
                    ( 
                          Id_buyer  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.Id_buyer
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @Id_buyer_3 BIGINT;
                    SELECT @Id_buyer_3 = Id_buyer FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'Id_buyer="' + CAST(@Id_buyer_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Buyer_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit
