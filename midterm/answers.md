# INFOMAN1 Midterm Practical Assessment
## EventHub Database Normalization and SQL Implementation

### Task 1 — Database Audit and Normalization

**1. Problems found in the original table**

The original `event_booking_flat` table stores organizer, venue, event, booking, session, ticket, and speaker information in one table. This causes:

- **Update anomaly:** Venue and organizer information is repeated across multiple records. Updating one venue requires changing several rows.
- **Insertion anomaly:** A new venue cannot be stored independently without providing booking and session information.
- **Deletion anomaly:** Deleting the only booking associated with an event can also remove the only stored record of that event's information.

**2. Functional dependencies**

- `booking_id → booking_date, organizer_id, event_title, venue_code`
- `organizer_id → organizer_name, organizer_email`
- `venue_code → venue_name, venue_city, venue_capacity`
- `(booking_id, session_code) → ticket_category, ticket_price, tickets_booked`
- `(event_id, session_code) → session information`

Speaker names are multivalued and therefore require a separate relationship.

**3. Normalization**

- **1NF:** Separate speaker names into individual records and remove repeating groups.
- **2NF:** Separate booking-level information from ticket and session details to eliminate partial dependencies.
- **3NF:** Separate organizers and venues from events to eliminate transitive dependencies.

**4. Final normalized schema**

- `Organizers(organizer_id PK, organizer_name, organizer_email)`
- `Venues(venue_code PK, venue_name, venue_city, venue_capacity)`
- `Events(event_id PK, event_title, organizer_id FK, venue_code FK)`
- `Bookings(booking_id PK, booking_date, event_id FK, booking_status)`
- `Sessions(session_id PK, event_id FK, session_code)`
- `Booking_Details(booking_id PK/FK, event_id FK, session_id PK/FK, ticket_category, ticket_price, tickets_booked)`
- `Speakers(speaker_id PK, speaker_name)`
- `Session_Speakers(session_id PK/FK, speaker_id PK/FK)`

**5. Why is a junction table necessary?**

A session can have multiple speakers, and a speaker can participate in multiple sessions. The `Session_Speakers` junction table resolves this many-to-many relationship without storing multiple speaker names in one field.

---

### Task 2 — Schema Implementation

Created eight normalized tables:

1. Organizers
2. Venues
3. Events
4. Bookings
5. Sessions
6. Booking_Details
7. Speakers
8. Session_Speakers

Implemented primary keys, foreign keys, NOT NULL constraints, unique organizer email, default booking status, and CHECK constraints for venue capacity, ticket price, and tickets booked.

**Verification:** All eight normalized tables were created successfully, and their structures were checked using `DESCRIBE`.

---

### Task 3 — Data Migration and DML

Successfully migrated the original records into the normalized tables.

| Table | Migrated records |
|---|---:|
| Organizers | 4 |
| Venues | 4 |
| Events | 6 |
| Bookings | 6 |
| Sessions | 7 |
| Booking_Details | 7 |
| Speakers | 7 |
| Session_Speakers | 11 |

**Additional operations:**

- Inserted the new venue `V-CAMPUS`.
- Increased ticket prices originally above 400 by 10%.
- Successfully inserted and deleted `V-TEMP`.
- Attempted to insert a negative ticket price. MySQL rejected it with CHECK constraint error 3819, as expected.

---

### Task 4 — Analytical Queries

Successfully executed four analytical queries:

1. Filtered bookings within the specified date range and selected VIP tickets or tickets priced above 500.
2. Used `CONCAT()` to combine organizer names and emails and `DATEDIFF()` to calculate days since booking.
3. Used `LIKE` patterns to search for venue names ending in City or beginning with M.
4. Grouped bookings by ticket category and used `HAVING` to display categories with at least five tickets booked.

**Grouped results:**

| Ticket category | Total tickets booked |
|---|---:|
| Standard | 18 |
| Student | 10 |

VIP was excluded because its total of 3 tickets did not meet the HAVING condition.

---

### Task 5 — Multi-Table Joins

Successfully implemented:

- INNER JOIN across bookings, events, organizers, venues, and booking details.
- LEFT JOIN to identify venues without events. The result was `V-CAMPUS`.
- A flawed LEFT JOIN with the VIP condition in the WHERE clause.
- A corrected LEFT JOIN with the VIP condition in the ON clause.

**Explanation of the LEFT JOIN trap:**

Placing `bd.ticket_category = 'VIP'` in the WHERE clause removes rows containing NULL values, effectively turning the LEFT JOIN into an INNER JOIN for that condition.

Placing the condition in the ON clause preserves unmatched rows, allowing the LEFT JOIN to retain venues and related records even when they have no VIP bookings.

---

### Task 6 — Schema Evolution and Integrated Reporting

Successfully added the `venue_status` column with a default value of ACTIVE and a CHECK constraint allowing only:

- ACTIVE
- RENOVATION
- INACTIVE

Updated `V-PARK` to RENOVATION. An attempt to update its status to CLOSED was rejected with CHECK constraint error 3819.

**Integrated report:**

| Venue | Bookings | Attendees | Average ticket price | Revenue |
|---|---:|---:|---:|---:|
| Metro Tech Auditorium | 2 | 16 | 706.67 | 7,340.00 |
| Bayview Convention Hall | 2 | 8 | 350.00 | 2,800.00 |

The report included only ACTIVE venues with an average ticket price above 300 and was ordered by total revenue in descending order.

---

### Task 7 — Final Checklist and Reflection

**Submission checklist**

- [x] Original seed database imported successfully.
- [x] Eight normalized tables created and verified.
- [x] Data migrated and record counts checked.
- [x] DML operations executed and verified.
- [x] Analytical queries executed.
- [x] Multi-table joins tested.
- [x] Schema evolution and CHECK constraints tested.
- [x] Integrated report generated.
- [ ] All SQL files saved in the `midterm` folder.
- [ ] Evidence screenshots captured.
- [ ] Changes committed and pushed to GitHub.
- [ ] Repository URL submitted to Moodle.

**Reflection 1: What was the most challenging part of the assessment?**

The most challenging part was normalizing the original table while maintaining the correct relationships between bookings, events, and sessions. I had to understand how primary and foreign keys work together to preserve data consistency.

**Reflection 2: What did you learn from this assessment?**

I learned that database normalization is important for reducing data redundancy and preventing anomalies. I also gained practical experience using SQL constraints, transactions, joins, aggregate functions, and schema alterations to maintain data integrity and generate meaningful reports.