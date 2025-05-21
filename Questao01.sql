CREATE PROCEDURE salaryHistogram (@num INT)
AS
BEGIN
    DECLARE @min DECIMAL(10,2);
    DECLARE @max DECIMAL(10,2);
    DECLARE @intervalo DECIMAL(10,2);
    DECLARE @intervaloMin DECIMAL(10,2);
    DECLARE @intervaloMax DECIMAL(10,2);
    DECLARE @i INT = 0;

    -- Obter o salário mínimo e máximo
    SELECT @min = MIN(salary), @max = MAX(salary) FROM Professors;

    -- Calcular tamanho dos intervalos
    SET @intervalo = (@max - @min) / @num;

    -- Iterar sobre os intervalos e calcular os professores por faixa
    WHILE @i < @num
    BEGIN
        SET @intervaloMin = @min + (@i * @intervalo);
        SET @intervaloMax = @intervaloMin + @intervalo;

        SELECT 
            @intervaloMin AS valorMinimo, 
            @intervaloMax AS valorMaximo, 
            COUNT(*) AS total
        FROM Professors 
        WHERE salary >= @intervaloMin AND salary < @intervaloMax;

        SET @i = @i + 1;
    END;

        SET @intervaloMax = @intervaloMin + @intervalo;
        SELECT 
            @intervaloMax AS valorMinimo, 
            @intervaloMax AS valorMaximo, 
            COUNT(*) AS total
        FROM Professors 
        WHERE salary >= @intervaloMin AND salary < @intervaloMax;
END;
