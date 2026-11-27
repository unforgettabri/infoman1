
USE eventhub_midterm;

-- =========================================
-- 1. INNER JOIN: MULTIPLE RELATED TABLES
-- =========================================

SELECT
    b.booking_id,
    e.event_title,
    o.organizer_name,
    v.venue_name,
    bd.ticket_category,
    bd.ticket_price,
    bd.tickets_booked
FROM Bookings b
INNER JOIN Events e
    ON b.event_id = e.event_id
INNER JOIN Organizers o
    ON e.organizer_id = o.organizer_id
INNER JOIN Venues v
    ON e.venue_code = v.venue_code
INNER JOIN Booking_Details bd
    ON b.booking_id = bd.booking_id
   AND b.event_id = bd.event_id;

-- =========================================
-- 2. FIND VENUES WITH NO EVENTS
-- =========================================

SELECT
    v.venue_code,
    v.venue_name,
    v.venue_city
FROM Venues v
LEFT JOIN Events e
    ON v.venue_code = e.venue_code
WHERE e.event_id IS NULL;

-- =========================================
-- 3. FLAWED LEFT JOIN
-- VIP CONDITION IN WHERE
-- =========================================

SELECT
    v.venue_name,
    e.event_title,
    b.booking_id,
    bd.ticket_category
FROM Venues v
LEFT JOIN Events e
    ON v.venue_code = e.venue_code
LEFT JOIN Bookings b
    ON e.event_id = b.event_id
LEFT JOIN Booking_Details bd
    ON b.booking_id = bd.booking_id
   AND b.event_id = bd.event_id
WHERE bd.ticket_category = 'VIP';

-- =========================================
-- 4. CORRECT LEFT JOIN
-- VIP CONDITION IN ON
-- =========================================

SELECT
    v.venue_name,
    e.event_title,
    b.booking_id,
    bd.ticket_category
FROM Venues v
LEFT JOIN Events e
    ON v.venue_code = e.venue_code
LEFT JOIN Bookings b
    ON e.event_id = b.event_id
LEFT JOIN Booking_Details bd
    ON b.booking_id = bd.booking_id
   AND b.event_id = bd.event_id
   AND bd.ticket_category = 'VIP';