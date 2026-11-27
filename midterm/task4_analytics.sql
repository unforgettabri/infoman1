
USE eventhub_midterm;

-- =========================================
-- 1. DATE RANGE + VIP OR PRICE ABOVE 500
-- =========================================

SELECT
    b.booking_id,
    b.booking_date,
    bd.ticket_category,
    bd.ticket_price,
    bd.tickets_booked
FROM Bookings b
JOIN Booking_Details bd
    ON b.booking_id = bd.booking_id
WHERE b.booking_date BETWEEN '2025-04-10' AND '2025-04-20'
  AND (bd.ticket_category = 'VIP' OR bd.ticket_price > 500);

-- =========================================
-- 2. CONCAT ORGANIZER CONTACT + DATEDIFF
-- =========================================

SELECT
    e.event_title,
    CONCAT(o.organizer_name, ' - ', o.organizer_email)
        AS organizer_contact,
    b.booking_date,
    DATEDIFF(CURDATE(), b.booking_date) AS days_since_booking
FROM Events e
JOIN Organizers o
    ON e.organizer_id = o.organizer_id
JOIN Bookings b
    ON e.event_id = b.event_id;

-- =========================================
-- 3. VENUE NAME PATTERN MATCHING
-- =========================================

SELECT
    venue_code,
    venue_name,
    venue_city
FROM Venues
WHERE venue_name LIKE '%City'
   OR venue_name LIKE 'M%';

-- =========================================
-- 4. GROUP BY TICKET CATEGORY + HAVING
-- =========================================

SELECT
    ticket_category,
    SUM(tickets_booked) AS total_tickets_booked,
    COUNT(*) AS booking_lines
FROM Booking_Details
GROUP BY ticket_category
HAVING SUM(tickets_booked) >= 5;