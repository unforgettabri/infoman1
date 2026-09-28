CREATE DATABASE infoman1_vetclinic;

USE infoman1_vetclinic;

-- Task 2: Core tables

CREATE TABLE Owner (
    owner_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number INT
);

CREATE TABLE Pet (
    pet_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    age INT,
    owner_id INT NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES Owner(owner_id)
);

CREATE TABLE Veterinarian (
    vet_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50) NOT NULL
);

-- Task 3: Relationship tables

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    appointment_date DATE NOT NULL,
    reason_for_visit TEXT NOT NULL,
    pet_id INT NOT NULL,
    vet_id INT NOT NULL,
    FOREIGN KEY (pet_id) REFERENCES Pet(pet_id),
    FOREIGN KEY (vet_id) REFERENCES Veterinarian(vet_id)
);

CREATE TABLE Vaccination_Record (
    pet_id INT NOT NULL,
    vaccine_name VARCHAR(50) NOT NULL,
    vaccination_date DATE NOT NULL,
    PRIMARY KEY (pet_id, vaccine_name, vaccination_date),
    FOREIGN KEY (pet_id) REFERENCES Pet(pet_id)
);

-- Task 5: Deliberate datatype mistake and correction

-- phone_number was initially created as INT.
-- It is corrected to VARCHAR(20) because phone numbers are identifiers,
-- not values used for arithmetic.

ALTER TABLE Owner
MODIFY COLUMN phone_number VARCHAR(20);