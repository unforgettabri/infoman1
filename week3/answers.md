# INFOMAN1 — Week 3 Lab Answers

## Task 1 — Classify Attributes and Identify Weak Entities

### Attribute Classification

| Attribute | Classification | Justification |
|---|---|---|
| `full_name` (Owner) | Composite | The owner's full name is made up of `first_name` and `last_name`, so it can be divided into smaller atomic attributes. |
| `full_name` (Veterinarian) | Composite | The veterinarian's full name is also composed of `first_name` and `last_name`. |
| Vaccination history | Multivalued | A pet may have zero, one, or several vaccination records, so vaccination history can contain multiple values associated with one pet. |
| `owner_id` | Simple / Atomic | It represents one identifying value for an owner. |
| `phone_number` | Simple / Atomic | The scenario specifies one phone number for an owner. |
| `pet_id` | Simple / Atomic | It is a single identifier for a pet. |
| `name` | Simple / Atomic | It stores the pet's name as one attribute. |
| `species` | Simple / Atomic | It stores one species value for the pet. |
| `age` | Simple / Atomic | The scenario directly provides the pet's age; there is no birth date from which it needs to be calculated. |
| `appointment_id` | Simple / Atomic | It is a single identifier for an appointment. |
| `appointment_date` | Simple / Atomic | It stores the date of an appointment. |
| `reason_for_visit` | Simple / Atomic | It stores the stated reason for the appointment. |
| `vet_id` | Simple / Atomic | It is a single identifier for a veterinarian. |
| `specialization` | Simple / Atomic | It stores the veterinarian's specialization. |
| `vaccine_name` | Simple / Atomic | It identifies the vaccine used in a vaccination record. |
| `vaccination_date` | Simple / Atomic | It stores the date of a vaccination. |

### Weak Entity

`Vaccination Record` should be modeled as a **weak entity** because it cannot be uniquely identified independently of its parent `Pet`. A vaccination record only makes sense in relation to the specific pet that received it.

The record uses the pet's `pet_id` together with its own identifying attributes, `vaccine_name` and `vaccination_date`, to form a composite key. The `pet_id` is therefore the identifying foreign key inherited from the owner entity of the weak entity.

---

## Task 2 — Specify Cardinality & Participation

| Relationship | First Entity | Second Entity | Cardinality & Participation |
|---|---|---|---|
| Owner–Pet | Owner | Pet | Owner: **0..many**; Pet: **exactly 1** |
| Pet–Appointment | Pet | Appointment | Pet: **0..many**; Appointment: **exactly 1** |
| Veterinarian–Appointment | Veterinarian | Appointment | Veterinarian: **0..many**; Appointment: **exactly 1** |
| Pet–Vaccination Record | Pet | Vaccination Record | Pet: **0..many**; Vaccination Record: **exactly 1** |

### Justification from the Scenario

- An **Owner** is not required to have any pets, while every **Pet** must belong to exactly one Owner.
- A **Pet** can have multiple appointments over time, while every **Appointment** must specify exactly one Pet.
- A **Veterinarian** can conduct multiple appointments or none, while every **Appointment** must specify exactly one Veterinarian.
- A **Pet** may have zero, one, or several vaccination records, while each vaccination record belongs to one specific Pet.

---

## Task 3 — Build the Logical ERD

The logical ERD contains the following entities:

- `Owner`
- `Pet`
- `Veterinarian`
- `Appointment`
- `Vaccination Record`

The `Vaccination Record` weak entity is identified using the parent `pet_id` together with `vaccine_name` and `vaccination_date`.

The relationships are:

- Owner **1** to **0..many** Pets
- Pet **1** to **0..many** Appointments
- Veterinarian **1** to **0..many** Appointments
- Pet **1** to **0..many** Vaccination Records

The ERD uses primary keys and foreign keys to represent the resulting relational structure.

---

## Task 4 — Translate to Relational Schema Notation

### Owner

`Owner(`**`owner_id`**`, first_name, last_name, phone_number)`

### Pet

`Pet(`**`pet_id`**`, name, species, age, owner_id*)`

*`owner_id` references `Owner(owner_id)`.*

### Veterinarian

`Veterinarian(`**`vet_id`**`, first_name, last_name, specialization)`

### Appointment

`Appointment(`**`appointment_id`**`, appointment_date, reason_for_visit, pet_id*, vet_id*)`

*`pet_id` references `Pet(pet_id)`.*

*`vet_id` references `Veterinarian(vet_id)`.*

### Vaccination Record

`Vaccination_Record(`**`pet_id`**`, `vaccine_name`, `vaccination_date)`

The composite primary key is **(`pet_id`, `vaccine_name`, `vaccination_date`)**.

*`pet_id` references `Pet(pet_id)`.*

---

## Task 5 — Key Justification & Schema Validation

### Key Justification

**Owner — Surrogate Key**

`owner_id` is used as the primary key because it provides a stable unique identifier for each owner. A person's name or phone number should not be relied upon as a primary key because names may be shared and phone numbers can change.

**Appointment — Surrogate Key**

`appointment_id` is used as the primary key because each appointment needs its own unique identifier. The appointment date and reason for visit do not guarantee uniqueness.

**Vaccination Record — Composite Key**

`Vaccination_Record` uses the composite key (`pet_id`, `vaccine_name`, `vaccination_date`). Since it is a weak entity, the parent `pet_id` is required to identify the record. Combining it with the vaccine name and vaccination date identifies the vaccination record for that pet.

### Schema Validation

- The `Owner` table contains `owner_id`, `first_name`, `last_name`, and `phone_number`, representing the owner's required information.
- An owner may have no pets because an `Owner` record can exist without a related `Pet` record.
- Every pet belongs to exactly one owner through the required `owner_id` foreign key in `Pet`.
- The `Pet` table contains `pet_id`, `name`, `species`, and `age`.
- The `Appointment` table contains `appointment_id`, `appointment_date`, and `reason_for_visit`.
- Every appointment is connected to exactly one pet through `pet_id`.
- Every appointment is connected to exactly one veterinarian through `vet_id`.
- A veterinarian may have no appointments or multiple appointments.
- The `Veterinarian` table contains `vet_id`, `first_name`, `last_name`, and `specialization`.
- The `Vaccination_Record` table stores `vaccine_name` and `vaccination_date` for each pet's vaccination history.
- A pet may have zero, one, or several vaccination records.
- The vaccination record is dependent on its pet and uses a composite key containing `pet_id`.

## Final Self-Check

- [x] Task 1 completed
- [x] Task 2 completed
- [x] Task 3 logical ERD created
- [x] Task 4 relational schemas written using `snake_case`
- [x] Task 5 key choices justified
- [x] Scenario requirements checked against the schema
