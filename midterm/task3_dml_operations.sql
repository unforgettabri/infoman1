
USE eventhub_midterm;

-- =========================================
-- PART A: MIGRATE DATA FROM FLAT TABLE
-- =========================================

-- 1. Migrate organizers
INSERT INTO Organizers (organizer_id, organizer_name, organizer_email)
SELECT DISTINCT organizer_id, organizer_name, organizer_email
FROM event_booking_flat;

-- 2. Migrate venues
INSERT INTO Venues (venue_code, venue_name, venue_city, venue_capacity)
SELECT DISTINCT venue_code, venue_name, venue_city, venue_capacity
FROM event_booking_flat;

-- 3. Migrate events
INSERT INTO Events (event_title, organizer_id, venue_code)
SELECT DISTINCT event_title, organizer_id, venue_code
FROM event_booking_flat;

-- 4. Migrate bookings
INSERT INTO Bookings (booking_id, booking_date, event_id)
SELECT DISTINCT f.booking_id, f.booking_date, e.event_id
FROM event_booking_flat f
JOIN Events e ON e.event_title = f.event_title;

-- 5. Migrate sessions
INSERT INTO Sessions (event_id, session_code)
SELECT DISTINCT e.event_id, f.session_code
FROM event_booking_flat f
JOIN Events e ON e.event_title = f.event_title;

-- 6. Migrate booking details
INSERT INTO Booking_Details
    (booking_id, event_id, session_id, ticket_category,
     ticket_price, tickets_booked)
SELECT
    f.booking_id,
    e.event_id,
    s.session_id,
    f.ticket_category,
    f.ticket_price,
    f.tickets_booked
FROM event_booking_flat f
JOIN Events e ON e.event_title = f.event_title
JOIN Sessions s
    ON s.event_id = e.event_id
    AND s.session_code = f.session_code;

-- 7. Migrate speakers
INSERT INTO Speakers (speaker_name)
SELECT DISTINCT jt.speaker_name
FROM event_booking_flat f,
JSON_TABLE(
    CONCAT('["', REPLACE(f.speaker_list, ', ', '","'), '"]'),
    '$[*]' COLUMNS (
        speaker_name VARCHAR(100) PATH '$'
    )
) AS jt;

-- 8. Migrate session-speaker relationships
INSERT INTO Session_Speakers (session_id, speaker_id)
SELECT DISTINCT s.session_id, sp.speaker_id
FROM event_booking_flat f
JOIN Events e ON e.event_title = f.event_title
JOIN Sessions s
    ON s.event_id = e.event_id
    AND s.session_code = f.session_code
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(f.speaker_list, ', ', '","'), '"]'),
    '$[*]' COLUMNS (
        speaker_name VARCHAR(100) PATH '$'
    )
) AS jt
JOIN Speakers sp ON sp.speaker_name = jt.speaker_name;

-- =========================================
-- PART B: INSERT NEW VENUE
-- =========================================

INSERT INTO Venues
    (venue_code, venue_name, venue_city, venue_capacity)
VALUES
    ('V-CAMPUS', 'Lorma Campus Hall', 'San Juan', 200);

SELECT * FROM Venues
WHERE venue_code = 'V-CAMPUS';

-- =========================================
-- PART C: SAFE 10% PRICE INCREASE
-- Only prices originally above 400
-- =========================================

-- Step 1: Preview affected records
SELECT booking_id, ticket_category, ticket_price
FROM Booking_Details
WHERE ticket_price > 400;

-- Step 2: Start transaction
START TRANSACTION;

-- Step 3: Apply increase
UPDATE Booking_Details
SET ticket_price = ticket_price * 1.10
WHERE ticket_price > 400;

-- Step 4: Verify and commit
SELECT booking_id, ticket_category, ticket_price
FROM Booking_Details
WHERE ticket_price > 400;

COMMIT;

-- =========================================
-- PART D: SAFE DELETE OF V-TEMP
-- =========================================

-- Create a temporary test venue
INSERT INTO Venues
    (venue_code, venue_name, venue_city, venue_capacity)
VALUES
    ('V-TEMP', 'Temporary Test Venue', 'Test City', 50);

-- Preview before deletion
SELECT * FROM Venues
WHERE venue_code = 'V-TEMP';

-- Delete the temporary venue
DELETE FROM Venues
WHERE venue_code = 'V-TEMP';

-- Verify deletion
SELECT * FROM Venues
WHERE venue_code = 'V-TEMP';

-- =========================================
-- PART E: TEST CHECK CONSTRAINT
-- This INSERT is intentionally invalid.
-- It should fail because ticket_price is negative.
-- The transaction is rolled back afterward.
-- =========================================

START TRANSACTION;

INSERT INTO Bookings (booking_id, booking_date, event_id)
SELECT 9999, '2025-04-30', event_id
FROM Events
LIMIT 1;

INSERT INTO Booking_Details
    (booking_id, event_id, session_id, ticket_category,
     ticket_price, tickets_booked)
SELECT
    9999, s.event_id, s.session_id, 'Invalid Test', -50.00, 1
FROM Sessions s
LIMIT 1;

ROLLBACK;