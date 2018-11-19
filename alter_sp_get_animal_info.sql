USE [db_zoo1]
GO

/****** Object:  StoredProcedure [dbo].[sp_get_animal_info]    Script Date: 11/18/2018 2:42:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[sp_get_animal_info]

@animal_name varchar(25)
AS
BEGIN
	DECLARE
		@error_string VARCHAR(50),
		@results VARCHAR(5)


SET @error_string = 'There are no ' + @animal_name + ' found at this zoo.'

BEGIN TRY
	SET @results = (SELECT COUNT(tbl_species.species_name) FROM tbl_species WHERE species_name = @animal_name)
	IF @results = 0
		BEGIN
			RAISERROR (@error_string, 16,1)
			RETURN
		END
	ELSE IF @results = 1
		BEGIN
			SELECT
				spe.species_name, ani.animalia_type,
				cla.class_type, ord.order_type, hab.habitat_type,
				nut.nutrition_type, car.care_type
			FROM	
				tbl_species spe
				INNER JOIN tbl_animalia ani ON ani.animalia_id = spe.species_animalia
				INNER JOIN tbl_class cla ON cla.class_id = spe.species_class
				INNER JOIN tbl_order ord ON ord.order_id = spe.species_order
				INNER JOIN tbl_habitat hab ON hab.habitat_id = spe.species_habitat
				INNER JOIN tbl_nutrition nut ON nut.nutrition_id = spe.species_nutrition
				INNER JOIN tbl_care car on car.care_id = spe.species_care
			WHERE 
				species_name = @animal_name
		END
	END TRY

	BEGIN CATCH
		SELECT @error_string = ERROR_MESSAGE()
		RAISERROR (@error_string, 10,1)
	END CATCH
END
GO


