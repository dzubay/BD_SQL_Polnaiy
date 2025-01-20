
begin tran 

CREATE TABLE Condition_of_the_item_Audit
(
    AuditID                   bigint IDENTITY(1,1)  not null,
    ID_Condition_of_the_item  bigint                null,
 	ModifiedBy                nVARCHAR(128)         null,
    ModifiedDate              DATETIME              NOT NULL DEFAULT GETDATE(),
	Operation                 CHAR(1)               null,
    ChangeDescription         nvarchar(4000)        null
    PRIMARY KEY CLUSTERED ( AuditID ) 
) on Products_Group_2;


go

CREATE TRIGGER trg_Condition_of_the_item_Audit ON Condition_of_the_item
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
                    INSERT  INTO dbo.Condition_of_the_item_Audit
                            ( 
                               ID_Condition_of_the_item            
							   ,ModifiedBy             
                               ,ModifiedDate     
                               ,Operation                
                            )
                            SELECT  
							        d.ID_Condition_of_the_item
                                    ,@login_name            
									,GETDATE()             
									,'U'               
                            FROM    Deleted D

				            declare @AuditID bigint
				            set @AuditID = (SELECT  SCOPE_IDENTITY())
                           
						   DECLARE @OldID_Condition_of_the_item       bigint         ;
						   DECLARE @OldName_Condition_of_the_item     nvarchar(300)	 ;
						   DECLARE @OldSysNameConditionTypeOfTheItem  nvarchar(300)	 ;
						   DECLARE @OldDescription                    nvarchar(4000) ;

                           DECLARE @NewID_Condition_of_the_item       bigint         ;
						   DECLARE @NewName_Condition_of_the_item     nvarchar(300)	 ;
						   DECLARE @NewSysNameConditionTypeOfTheItem  nvarchar(300)	 ;
						   DECLARE @NewDescription                    nvarchar(4000) ;

							SELECT 
							    @NewID_Condition_of_the_item       = ID_Condition_of_the_item     ,
								@NewName_Condition_of_the_item     = Name_Condition_of_the_item   ,
								@NewSysNameConditionTypeOfTheItem  = SysNameConditionTypeOfTheItem,
								@NewDescription                    = [Description]        	  
							FROM inserted;									 

                            SELECT 
							    @OldID_Condition_of_the_item       = ID_Condition_of_the_item     ,
								@OldName_Condition_of_the_item     = Name_Condition_of_the_item   ,
								@OldSysNameConditionTypeOfTheItem  = SysNameConditionTypeOfTheItem,
								@OldDescription                    = [Description]  					
							FROM Deleted;																		 

                            IF @NewID_Condition_of_the_item  <> @OldID_Condition_of_the_item  
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  ID_Condition_of_the_item  = Old ->"' +  ISNULL(CAST(@OldID_Condition_of_the_item  AS NVARCHAR(20)),'') + ' " NEW -> "' + isnull(CAST(@NewID_Condition_of_the_item  AS NVARCHAR(20)),'') + '", ';
							   end
                            
							IF @NewName_Condition_of_the_item <> @OldName_Condition_of_the_item
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Name_Condition_of_the_item = Old ->"' +  ISNULL(@OldName_Condition_of_the_item,'') + ' " NEW -> "' + isnull(@NewName_Condition_of_the_item,'') + '", ';
							   end

							IF @NewSysNameConditionTypeOfTheItem <> @OldSysNameConditionTypeOfTheItem
							   begin
							    SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  SysNameConditionTypeOfTheItem = Old ->"' +  ISNULL(@OldSysNameConditionTypeOfTheItem,'') + ' " NEW -> "' + isnull(@NewSysNameConditionTypeOfTheItem,'') + '", ';
							   end                  
							
                            IF @NewDescription <> @OldDescription
							   begin
                                SET @ChangeDescription = '' + isnull(@ChangeDescription,'') + '  Description = Old ->"' + ISNULL(@OldDescription,'') + ' " NEW -> "' + ISNULL(@NewDescription,'') + '",';
                               end
                            SET @ChangeDescription = 'Updated: ' + ' ID_Condition_of_the_item = "' +  isnull(cast(@OldID_Condition_of_the_item as nvarchar(20)),'')+ '" ' + @ChangeDescription
                             --Удаляем запятую на конце
                            IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);
                            
                            
                            update y
							set ChangeDescription = @ChangeDescription
							from Condition_of_the_item_Audit y
							where @AuditID  = AuditID    					
                END
            ELSE
                BEGIN
                    INSERT  INTO dbo.Condition_of_the_item_Audit
                            ( 
                               ID_Condition_of_the_item       
							   ,ModifiedBy       
							   ,ModifiedDate     
                               ,Operation                                                   
                            )
                            SELECT  
                                    d.ID_Condition_of_the_item
									,@login_name 
									,GETDATE()   
                                    ,'D'                                                                     
                            FROM    Deleted D

							declare @AuditID_2 bigint
							set @AuditID_2 = (SELECT  SCOPE_IDENTITY())

                           DECLARE @OldID_Condition_of_the_item_2       bigint         ;
						   DECLARE @OldName_Condition_of_the_item_2     nvarchar(300)  ;
						   DECLARE @OldSysNameConditionTypeOfTheItem_2  nvarchar(300)  ;
						   DECLARE @OldDescription_2                    nvarchar(4000) ;    	  	

                            SELECT 
							    @OldID_Condition_of_the_item_2      = ID_Condition_of_the_item     ,
								@OldName_Condition_of_the_item_2    = Name_Condition_of_the_item   ,
								@OldSysNameConditionTypeOfTheItem_2 = SysNameConditionTypeOfTheItem,
								@OldDescription_2                   = [Description]        
							FROM deleted;									 

                            SET @ChangeDescription = 'Deleted: '
							+ 'ID_Condition_of_the_item'      +' = "'+  ISNULL(CAST(@OldID_Condition_of_the_item_2 AS NVARCHAR(20)),'')+ '", '
							+ 'Name_Condition_of_the_item'    +' = "'+  ISNULL(@OldName_Condition_of_the_item_2,'')+ '", '
							+ 'SysNameConditionTypeOfTheItem' +' = "'+  ISNULL(@OldSysNameConditionTypeOfTheItem_2,'') + '", '
            				+ 'Description'                   +' = "'+  ISNULL(@OldDescription_2,'') + '", '

							IF LEN(@ChangeDescription) > 0
                                SET @ChangeDescription = LEFT(@ChangeDescription, LEN(@ChangeDescription) - 1);

                          update u
						  set ChangeDescription = @ChangeDescription
						  from Condition_of_the_item_Audit u
						  where @AuditID_2  = AuditID                          
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Condition_of_the_item_Audit
                    ( 
                          ID_Condition_of_the_item  
						  ,ModifiedBy  
						  ,ModifiedDate
						  ,Operation				  
                            )
                            SELECT   
									I.ID_Condition_of_the_item
									,@login_name 
									,GETDATE()   
                                    ,'I'                                                                                         
                    FROM    Inserted I

					declare @AuditID_3 bigint
					set @AuditID_3 = (SELECT  SCOPE_IDENTITY())

					DECLARE @ID_Condition_of_the_item_3 BIGINT;
                    SELECT @ID_Condition_of_the_item_3 = ID_Condition_of_the_item FROM inserted;
		            
                    SET @ChangeDescription = 'Inserted: '
                                         + 'ID_Condition_of_the_item = "' + CAST(@ID_Condition_of_the_item_3 AS NVARCHAR(20)) + '" ';
                    
                    update i
					set ChangeDescription = @ChangeDescription
					from Condition_of_the_item_Audit i
					where @AuditID_3  = AuditID                

                    END

GO
--rollback
commit
