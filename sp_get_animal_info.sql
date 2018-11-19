USE db_zoo1
GO

CREATE PROC sp_get_animal_info

@animal_name varchar(25)
AS
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
