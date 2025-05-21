CREATE PROCEDURE salaryHistogram (@num INT)
AS
BEGIN
    DECLARE @min DECIMAL(10,2);
    DECLARE @max DECIMAL(10,2);
    declare @intervalo DECIMAL(10,2);
    DECLARE @intervaloMin DECIMAL(10,2);
    DECLARE @intervaloMax DECIMAL(10,2);
    DECLARE @i INT = 0;

    CREATE TABLE #Histograma (
        valorMinimo DECIMAL(10,2),
        valorMaximo DECIMAL(10,2),
        total INT
    );

SELECT @min = MIN(salary), @max = MAX(salary) FROM instructor;

 SET @intervalo = (@max - @min) / @num;
    WHILE @i < @num
        BEGIN
            SET @intervaloMin = @min + (@i * @intervalo);
            SET @intervaloMax = @intervaloMin + @intervalo;
    
            INSERT INTO #Histograma
            SELECT 
               @intervaloMin as valorMinimo, 
                @intervaloMax as valorMaximo, 
                COUNT(*) as Total
            FROM instructor 
            WHERE salary >= @intervaloMin AND salary < @intervaloMax;
        SET @i = @i + 1;
        END;
         INSERT INTO #Histograma
        SELECT 
            @intervaloMax as valorMinimo, 
            @max as valorMaximo, 
            COUNT(*) as Total
    FROM instructor 
    WHERE salary >= @intervaloMax;

    SELECT * FROM #Histograma;
END; 
