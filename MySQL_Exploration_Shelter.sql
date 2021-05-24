/*
Austin Animal Shelter Data Exploration

The data origin is https://www.kaggle.com/aaronschlegel/austin-animal-center-shelter-outcomes-and and the data itself contains information about the animals that spent
time in the shelter through the years 2013 to 2017.

The data inserted into the database comes from a modified version of a dataset used to train a ML model to predict animal outcomes.
The code for that particular experiment can be seen here:
A visualisation of some basic insights from this data can be viewed on Tableau at https://public.tableau.com/profile/conor.loughran#!/vizhome/Austin_Animal_Shelter/Dashboard1.

This particular script contains some SQL operations that help us to learn more about the shelter and what are common outcomes for animals that went through the centre.


*/

CREATE DATABASE shelter;

USE shelter;

DROP TABLE IF EXISTS shelter.Animals; 
CREATE TABLE shelter.Animals (
age_upon_outcome INT,
animal_id VARCHAR(10),
animal_type VARCHAR(10),
breed VARCHAR(60),
color VARCHAR(30),
date_of_birth DATE,
datetime DATETIME,
name VARCHAR(30),
outcome_subtype VARCHAR(20),
outcome_type VARCHAR(20),
sex_upon_outcome VARCHAR(20),
PRIMARY KEY (animal_id)
);

LOAD DATA INFILE '/var/lib/mysql-files/2_austin/aac_shelter_outcomes_sql_forimport2.csv' 
INTO TABLE shelter.Animals
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
;

-- Overview
-- Select and view a small number of columns from the table

SELECT animal_type, breed, color, outcome_type, name
FROM shelter.Animals
LIMIT 20;


-- Identify the total number of animals

SELECT count(*)
FROM shelter.Animals;


-- Identify the animal_types and the number of animals belonging to each type

SELECT animal_type, COUNT(*) as count
FROM shelter.Animals
GROUP BY 1;


-- Using information from the previous query
-- Show the percentage of animals in each outcome_type

SELECT outcome_type, COUNT(*) AS count, COUNT(*) / 70847 * 100 AS percentage_in_outcome_type
FROM shelter.Animals
GROUP BY 1
ORDER BY COUNT(*) DESC;


-- Dogs
-- Find total number of dogs that were in care

SELECT COUNT(*) as total_number_dogs
FROM shelter.Animals
WHERE animal_type = "Dog";


-- Show the number of Dogs in care that were adopted

SELECT COUNT(*) as total_dogs_adopted
FROM shelter.Animals
WHERE animal_type = "Dog" AND outcome_type = "Adoption";


-- Using results from above queries
-- Find the percentage of all dogs that have been adopted

SELECT COUNT(*) / 38065 * 100 as percentage_of_dogs_adopted
FROM shelter.Animals
WHERE animal_type = "Dog" AND outcome_type = "Adoption";


-- Show the average age of dogs that were adopted ( in years)

SELECT AVG(age_upon_outcome)/365 AS avg_age_in_years
FROM shelter.Animals
WHERE animal_type = "Dog" AND outcome_type = "Adoption";


-- Euthanasia
-- Find the total number of euthanised animals

SELECT COUNT(*)
FROM shelter.Animals
WHERE outcome_type = "Euthanasia";


-- Get count of each type of animal euthanised

SELECT animal_type, COUNT(*)
FROM shelter.Animals
GROUP BY 1;


-- Get percentage of each type of animal euthanised

SELECT animal_type, COUNT(*), COUNT(*) / 5916 * 100 AS percent_of_animals_euthanised
FROM shelter.Animals
WHERE outcome_type = "Euthanasia"
GROUP BY 1;


-- Lots of animals in the subtype "Other" need to be euthanised
-- Outcome_subtype gives us hints as to why a certain outcome_type occurs in a given animal
-- Look at outcome_subtype of animal_type "Other" to find out more information about this subtype

SELECT DISTINCT outcome_subtype
FROM shelter.Animals
WHERE animal_type = "Other";


-- Look at which outcome subtypes most commonly occur in this animal type

SELECT outcome_subtype, COUNT(outcome_subtype) as count
FROM shelter.Animals
WHERE animal_type = "Other"
GROUP BY 1
ORDER BY count DESC;


-- Miscellaneous Information
-- Show the features and outcome of the ten oldest cats that have been in care

SELECT animal_type, name, breed, MAX(age_upon_outcome)/365 AS age_years, outcome_type
FROM shelter.Animals
WHERE animal_Type = "Cat"
GROUP BY 1,2,3,5
ORDER BY age_years DESC
LIMIT 10;


-- Find the outcome_types for animals classified as livestock

SELECT DISTINCT outcome_type
FROM shelter.Animals
WHERE animal_type = "Livestock";

