-- Drill 1
SELECT * FROM tbl_habitat

-- Drill 2
SELECT species_name 
FROM tbl_species
WHERE species_order = 3

-- Drill 3
SELECT nutrition_type
FROM tbl_nutrition
WHERE nutrition_cost <= 600

-- Drill 4
SELECT species_name, nutrition_id
FROM tbl_nutrition 
JOIN tbl_species	ON nutrition_id = species_nutrition
WHERE nutrition_id between 2202 and 2206

-- Drill 5
SELECT	
	sp.species_name  'Species Name',
	nut.nutrition_type 'Nutrition Type'
FROM tbl_species sp 
JOIN tbl_nutrition nut ON nut.nutrition_id = sp.species_nutrition

--Drill 6 
SELECT sp.specialist_fname, sp.specialist_lname, sp.specialist_contact
FROM tbl_specialist sp
JOIN tbl_care ca ON sp.specialist_id = ca.care_specialist
JOIN tbl_species spe ON ca.care_id = spe.species_care
WHERE spe.species_name = 'penguin'




--Drill 7
CREATE DATABASE publisher
GO

USE publisher
GO

CREATE TABLE author (
		author_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		first_nm VARCHAR(50) NOT NULL,
		last_nm VARCHAR(50) NOT NULL
	);

CREATE TABLE book (
		book_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		author_id INT NOT NULL CONSTRAINT fk_author_id FOREIGN KEY REFERENCES author(author_id) ON UPDATE CASCADE ON DELETE CASCADE,
		title VARCHAR(50) NOT NULL,
		price INT
	);

INSERT author
VALUES
('John','Davidson'),
('Mary', 'Jones'),
('Lisa','Murray'),
('Mark','Twain')
;

INSERT book
VALUES
('4', 'Life on the Mississippi',8),
('4', 'The Advendures of Tom Sawyer',10),
('1', 'The Ants Ate My Homework',7),
('2', 'Life of Vinnny',6),
('3', 'The Subtle One',11);


SELECT auth.first_nm, auth.last_nm, bk.title, bk.price
FROM author auth
JOIN book bk ON auth.author_id = bk.author_id

