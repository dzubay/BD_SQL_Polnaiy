CREATE PROCEDURE GetRandomDateTimeBetween
    @DateStart DATETIME,
    @DateEnd DATETIME,
    @RandomDateTime DATETIME OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Проверка, что DateEnd больше DateStart
    IF @DateEnd <= @DateStart
    BEGIN
        RAISERROR('DateEnd must be greater than DateStart', 16, 1);
        RETURN;
    END
    
    -- Вычисляем разницу в секундах между датами
    DECLARE @TotalSeconds INT;
    SET @TotalSeconds = DATEDIFF(SECOND, @DateStart, @DateEnd);
    
    -- Проверка, что есть хотя бы 2 секунды разницы (чтобы можно было выбрать значение строго между)
    IF @TotalSeconds <= 2
    BEGIN
        RAISERROR('The difference between dates must be at least 2 seconds', 16, 1);
        RETURN;
    END
    
    -- Генерируем случайное количество секунд (от 1 до TotalSeconds-1)
    DECLARE @RandomSeconds INT;
    SET @RandomSeconds = 1 + ABS(CAST(CAST(CRYPT_GEN_RANDOM(4) AS INT) AS BIGINT) % (@TotalSeconds - 1));
    
    -- Вычисляем случайную дату (DateStart + случайное количество секунд)
    SET @RandomDateTime = DATEADD(SECOND, @RandomSeconds, @DateStart);
    
    -- Убираем миллисекунды
    SET @RandomDateTime = DATEADD(MILLISECOND, -DATEPART(MILLISECOND, @RandomDateTime), @RandomDateTime);
END;


--DECLARE @StartDate DATETIME = '20200130';
--DECLARE @EndDate DATETIME = '20230131';
--DECLARE @Result DATETIME;

--EXEC GetRandomDateTimeBetween 
--    @DateStart = @StartDate,
--    @DateEnd = @EndDate,
--    @RandomDateTime = @Result OUTPUT;
    
--SELECT @Result AS RandomDateTime;