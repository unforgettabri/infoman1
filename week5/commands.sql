-- INFOMAN1 — Week 5 Lab: Performance Task Using SQL 2

-- Task 1: Basic SELECT Statements

SELECT * FROM Pet;

SELECT name, species
FROM Pet;


-- Task 2: Filtering with Equality

SELECT name, species
FROM Pet
WHERE species = 'Dog';


-- Task 3: Filtering with Relational Operators

SELECT name, species, age
FROM Pet
WHERE age > 3;

SELECT appointment_date
FROM Appointment
WHERE appointment_date >= '2026-09-20';


-- Task 4: Combine and Debug

-- Working query
SELECT name
FROM Pet
WHERE species = 'Cat';

-- Deliberately broken query: missing closing quote
SELECT name
FROM Pet
WHERE species = 'Cat;