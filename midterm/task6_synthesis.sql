
USE eventhub_midterm;

-- =========================================
-- PART A: ALTER VENUES TABLE
-- =========================================

ALTER TABLE Venues
ADD COLUMN venue_status VARCHAR(20)
NOT NULL DEFAULT 'ACTIVE';

ALTER TABLE Venues
ADD CONSTRAINT chk_venue_status
CHECK (venue_status IN ('ACTIVE', 'RENOVATION', 'INACTIVE'));

-- Verify new column and default values
DESCRIBE Venues;

SELECT venue_code, venue_name, venue_status
FROM Venues;

-- =========================================
-- PART B: UPDATE V-PARK
-- =========================================

UPDATE Venues
SET venue_status = 'RENOVATION'
WHERE venue_code = 'V-PARK';

SELECT venue_code, venue_name, venue_status
FROM Venues
WHERE venue_code = 'V-PARK';

-- =========================================
-- PART C: INVALID STATUS TEST
-- This should fail because CLOSED is not allowed.
-- =========================================

UPDATE Venues
SET venue_status = 'CLOSED'
WHERE venue_code = 'V-PARK';

-- =========================================
-- PART D: INTEGRATED VENUE REPORT
-- =========================================

SELECT
    v.venue_name,
    v.venue_city,
    COUNT(DISTINCT b.booking_id) AS total_bookings,
    SUM(bd.tickets_booked) AS total_attendees,
    AVG(bd.ticket_price) AS average_ticket_price,
    SUM(bd.ticket_price * bd.tickets_booked) AS total_revenue
FROM Venues v
INNER JOIN Events e
    ON v.venue_code = e.venue_code
INNER JOIN Bookings b
    ON e.event_id = b.event_id
INNER JOIN Booking_Details bd
    ON b.booking_id = bd.booking_id
   AND b.event_id = bd.event_id
WHERE v.venue_status = 'ACTIVE'
GROUP BY v.venue_name, v.venue_city
HAVING AVG(bd.ticket_price) > 300
ORDER BY total_revenue DESC;