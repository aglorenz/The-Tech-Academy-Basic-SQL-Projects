--PRINT 'Hello world'

--DECLARE @myVar INT
--SET @myVar = 6
--PRINT @myVar


--PRINT 'Having fun with' + ' TSQL and MS SQL Server!'
-- CHAR(9) = tab 
-- CHAR(13) = <CR>
-- CHAR(10) = <LF>
--PRINT 'I have ' + CONVERT(VARCHAR(50), @var1) + char(10)  + 'dollars..'

DECLARE @var1 INT = 7, @var2 INT= 5
PRINT 'Variable 1 = ' + CONVERT(VARCHAR(5), @var1) + CHAR(13)  + 'Variable 2 = ' + CONVERT(VARCHAR(5), @var2) + CHAR(13) +  'Total: '
PRINT @var1 + @var2

IF @var1 != 3
	BEGIN
		PRINT 'Variable 1 is NOT =  3'
	END
ELSE
	BEGIN
		PRINT 'Variable 1 is = 3'
	END

IF @var1 < 2
	BEGIN
		PRINT '@Var1 < 2'
	END
ELSE IF @var1 > 1 AND @var1 < 3
	BEGIN
		PRINT '@Var1 > 1 AND @VAR1 < 3'
	END
ELSE IF @var1 = 4 OR @var1 < 6
	BEGIN
		PRINT '@var1 = 4 OR @var1 < 6'
	END
ELSE
	PRINT '@var1 does not qualify'





