USE AdventureWorks2014
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_get_person_info'))
   EXEC('CREATE PROCEDURE [dbo].[usp_get_person_info] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/19/2018
	Purpose:	Given at least a partial e-mail address and optional last name, this procedure returns address,
				full e-mail, phone number, and address information
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_get_person_info] 
	@InputEmail VARCHAR(50) = '',	-- Try 'andy' or 'andy21@adventure-works.com';
	@LastName VARCHAR(50) = NULL	-- Try 'Blanco'
AS

BEGIN

	SET NOCOUNT ON

	IF NOT EXISTS(	SELECT 
			pea.EmailAddress, pp.FirstName, pp.LastName, ppp.PhoneNumber, 
			pa.AddressLine1, pa.AddressLine2, pa.City, psp.Name, psp.CountryRegionCode, 
			pa.PostalCode
		FROM Person.EmailAddress pea
			JOIN Person.Person pp ON pp.BusinessEntityID = pea.BusinessEntityID
			JOIN Person.PersonPhone ppp ON ppp.BusinessEntityID = pp.BusinessEntityID
			JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = pp.BusinessEntityID
			JOIN Person.Address pa ON pa.AddressID = pbea.AddressID
			JOIN Person.StateProvince psp ON psp.StateProvinceID = pa.StateProvinceID
		WHERE EmailAddress like '%' + @InputEmail + '%'
			AND LastName = ISNULL(@LastName, LastName))

		PRINT CHAR(13) + 'No data was found matching the criteria'

	ELSE
		SELECT 
		pea.EmailAddress, pp.FirstName, pp.LastName, ppp.PhoneNumber, 
		pa.AddressLine1, pa.AddressLine2, pa.City, psp.Name, psp.CountryRegionCode, 
		pa.PostalCode
	FROM Person.EmailAddress pea
		JOIN Person.Person pp ON pp.BusinessEntityID = pea.BusinessEntityID
		JOIN Person.PersonPhone ppp ON ppp.BusinessEntityID = pp.BusinessEntityID
		JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = pp.BusinessEntityID
		JOIN Person.Address pa ON pa.AddressID = pbea.AddressID
		JOIN Person.StateProvince psp ON psp.StateProvinceID = pa.StateProvinceID
	WHERE EmailAddress like '%' + @InputEmail + '%'
		AND LastName = ISNULL(@LastName, LastName)
END
GO

-- Testing
--EXEC usp_get_person_info 'andy', 'blanco'		-- 1 row found; e-mail contains 'andy' and last name ='Blanco'
--EXEC usp_get_person_info 'andDy', 'BlaDnco'	-- no data found
--EXEC usp_get_person_info 'andDy', 'Blanco'	-- no data found
--EXEC usp_get_person_info '', 'Blanco'			-- 88 rows with 'Blanco' last name
--EXEC usp_get_person_info 'andDy'				-- no data found; Optional Last name not supplied
--EXEC usp_get_person_info 'andy'				-- 93 e-mails found containing 'andy' ; Optional Last name not supplied
--EXEC usp_get_person_info 						-- returns all rows; no parameters supplied
