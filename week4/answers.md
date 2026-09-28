# INFOMAN1 — Week 4 Lab: Performance Task Using SQL 1

**Name:** Brianna T. Bustamante  
**Course:** Information Management 1 (INFOMAN1)  
**Lab:** Week 4 — Performance Task Using SQL 1 (DDL & Table Creation)

## Task 1 — Create the Database

Created the database named `infoman1_vetclinic` using MySQL.

The database was verified using `SHOW DATABASES;`, and `infoman1_vetclinic` appeared in the list of databases.

**Evidence:** `screenshots/task1.png`

---

## Task 2 — Create the Core Tables

Created the three core tables based on the Week 3 veterinary clinic relational schema:

- `Owner`
- `Pet`
- `Veterinarian`

Each table has a defined primary key. The `Pet` table also contains `owner_id` as a foreign key referencing `Owner(owner_id)`.

The `phone_number` column in `Owner` was initially created as `INT` as the deliberate datatype mistake required in Task 5.

**Evidence:**
- `screenshots/task2.0.png`
- `screenshots/task2.1.png`
- `screenshots/task2.2.png`

---

## Task 3 — Create the Relationship Tables

Created the two relationship tables:

### Appointment

The `Appointment` table resolves the Pet–Veterinarian many-to-many relationship. It contains foreign keys referencing both `Pet` and `Veterinarian`.

- `pet_id` → `Pet(pet_id)`
- `vet_id` → `Veterinarian(vet_id)`

### Vaccination_Record

The `Vaccination_Record` table represents the weak entity from the Week 3 design.

Its composite primary key consists of:

- `pet_id`
- `vaccine_name`
- `vaccination_date`

The `pet_id` column is also a foreign key referencing `Pet(pet_id)`.

**Evidence:** `screenshots/task3.png`

---

## Task 4 — Verify the Schema

Used `SHOW TABLES;` to verify that all five tables were created:

- `Owner`
- `Pet`
- `Veterinarian`
- `Appointment`
- `Vaccination_Record`

The `DESCRIBE` command was also used to inspect the columns, data types, keys, and nullability of the tables.

The resulting structures were compared with the Week 3 relational schema and physical ERD. The primary keys and foreign key relationships match the intended veterinary clinic design.

**Evidence:**
- `screenshots/task4.0.png`
- `screenshots/task4.1.png`

---

## Task 5 — Fix a Deliberate Mistake

A deliberate datatype mistake was made by initially defining the `Owner.phone_number` column as:

`phone_number INT`

The `DESCRIBE Owner;` output showed that the phone number was stored as an integer.

The column was corrected using:

`ALTER TABLE Owner MODIFY COLUMN phone_number VARCHAR(20);`

After running `DESCRIBE Owner;` again, the column was shown as `VARCHAR(20)`.

`VARCHAR` is more appropriate for phone numbers because phone numbers are identifiers rather than values used for arithmetic, and they may contain leading zeros or formatting characters.

**Evidence:** `screenshots/task5.png`

---

## Schema Summary

| Table | Primary Key | Foreign Keys |
|---|---|---|
| Owner | `owner_id` | None |
| Pet | `pet_id` | `owner_id` → `Owner(owner_id)` |
| Veterinarian | `vet_id` | None |
| Appointment | `appointment_id` | `pet_id` → `Pet(pet_id)`, `vet_id` → `Veterinarian(vet_id)` |
| Vaccination_Record | `pet_id`, `vaccine_name`, `vaccination_date` | `pet_id` → `Pet(pet_id)` |

## Conclusion

The veterinary clinic database was implemented in MySQL using DDL. All five required tables were created with the appropriate primary keys and foreign key relationships. The schema was verified using `SHOW TABLES` and `DESCRIBE`, and the deliberate phone-number datatype mistake was identified and corrected using `ALTER TABLE`.