-- A Query against the allergies table that returns all the records
SELECT * FROM hospital.allergies;
-- Return all records from condition where description diabetes or prediabtes
SELECT * FROM hospital.conditions
WHERE DESCRIPTION="diabetes"OR DESCRIPTION="prediabetes";
-- return unique description from procedures where reasondescription is normal pregnancy and description not standard pregnancy test.
SELECT DISTINCT DESCRIPTION FROM procedures
WHERE REASONDESCRIPTION="normal preganacy" and DESCRIPTION!="standard preganancy";
#write a query to display patient,description,value and multiple thevalue by 2.2 and rename it to [weight in Ibs] from observations table
#where description equals to Body weight.
SELECT PATIENT,observations.DESCRIPTION,observations.VALUE,observations.VALUE* 2.2 AS "weight in Ibs" 
FROM observations
WHERE DESCRIPTION="Body weight";
#QUESTION 5
#A query againt the observations table. return patient,description,value. divide the value by 2.5 and rename as Height in Inches 
#--where description is Body Height.
SELECT PATIENT,DESCRIPTION,VALUE/2.5 AS Height_Inches
from observations
WHERE DESCRIPTION="Body Weight";
#QUESTION 6
#write a query to select patient,description,reasondescriptionfrom medications table
#where reasondescription is not null.
SELECT PATIENT,DESCRIPTION, REASONDESCRIPTION FROM medications
WHERE REASONDESCRIPTION IS NOT NULL;
#QUESTION 7
#Write a query joining the patients table to the medications table using the patient column. 
#Use WHERE in your join condition.. 
#Your results should contain the columns patient, marital, race, ethnicity, 
#and gender from the patients table and description (renamed as medications),
#and reasondescription (renamed as diagnosis) from the medications table.
SELECT patients.patient, patients.marital, patients.race, patients.ethnicity, patients.gender, medications.description AS medications, medications.reasondescription AS diagnosis  
FROM patients
JOIN medications 
ON patients.patient = medications.patient
WHERE patients.patient = medications.patient;
#QUESTION 8 
#Using the description column in the conditions table, 
#write a query that returns all the data for patients who are diabetic (Diabetes) or predibetic (Prediabetes).
SELECT* FROM conditions
WHERE PATIENT="Diabetes"or PATIENT="Prediabetes";
#QUESTION 8
#Using the description and reasondescription columns in the table procedures,
#write a query that returns a list of all the descriptions for 
#a normal pregnancy (Normal pregnancy) except a pregnancy test (Standard pregnancy test
SELECT Description 
FROM Procedures 
WHERE ReasonDescription = 'Normal pregnancy' 
AND Description <> 'Standard pregnancy test';
#QUESTION 10
 #Using the patient, description and value columns in the observations table,
 #write a query that returns all the patients expected to have between one and five quality years of life left. 
#(Use the description column and “Quality adjusted life years”).
SELECT patient, description, value
FROM observations
WHERE description = 'Quality adjusted life years'
AND value BETWEEN 1 AND 5;
#QUESTION 11
#Write a query to show a list of all the asian female patients and the procedures they had.
#(Use LEFT OUTER JOIN and join on the patient column from the patient and procedure tables.) 
#Include the columns patients.patient, patients.race, patients.ethnicity, patients.gender,
 #procedures.description (relabeled procedure), and procedures.reasondescription (relabeled diagnosis) in your results.
SELECT patients.patient, patients.race, patients.ethnicity, patients.gender, procedures.description AS "procedure", procedures.reasondescription AS "diagnosis"
FROM patients
LEFT OUTER JOIN procedures ON patients.patient = procedures.patient
WHERE patients.race = 'Asian' AND patients.gender = 'Female';
#QUESTION12
#Write a query that returns the patient column, the average of the value column relabeled as Avg BMI,
#the count of the value column relabeled as Number of readings ,
#and the maximum value of the value column filtered for values over 30 and label it as Max Obese BMI.
#The query should be written against the observations_cleaned table and the results should all be for
#records where the description is “Body Mass Index”. Group your results by the patient column.
SELECT patient, AVG(value) AS 'Avg BMI', COUNT(value) AS 'Number of readings', MAX(value) AS 'Max Obese BMI'
FROM cleaned_observation
WHERE description = 'Body Mass Index' AND value > 30
GROUP BY patient;
