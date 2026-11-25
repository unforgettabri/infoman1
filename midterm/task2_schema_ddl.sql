
CREATE DATABASE IF NOT EXISTS eventhub_midterm;
USE eventhub_midterm;

-- Drop tables in dependency order
DROP TABLE IF EXISTS Session_Speakers;
DROP TABLE IF EXISTS Booking_Details;
DROP TABLE IF EXISTS Speakers;
DROP TABLE IF EXISTS Sessions;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Venues;
DROP TABLE IF EXISTS Organizers;

-- 1. Organizers
CREATE TABLE Organizers (
    organizer_id INT PRIMARY KEY,
    organizer_name VARCHAR(100) NOT NULL,
    organizer_email VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Venues
CREATE TABLE Venues (
    venue_code VARCHAR(20) PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    venue_city VARCHAR(50) NOT NULL,
    venue_capacity INT NOT NULL,
    CHECK (venue_capacity > 0)
);

-- 3. Events
CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_title VARCHAR(150) NOT NULL,
    organizer_id INT NOT NULL,
    venue_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (organizer_id)
        REFERENCES Organizers(organizer_id),
    FOREIGN KEY (venue_code)
        REFERENCES Venues(venue_code)
);

-- 4. Bookings
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    booking_date DATE NOT NULL,
    event_id INT NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',
    UNIQUE (booking_id, event_id),
    FOREIGN KEY (event_id)
        REFERENCES Events(event_id)
);

-- 5. Sessions
CREATE TABLE Sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    session_code VARCHAR(20) NOT NULL,
    UNIQUE (event_id, session_code),
    UNIQUE (session_id, event_id),
    FOREIGN KEY (event_id)
        REFERENCES Events(event_id)
);

-- 6. Booking details
CREATE TABLE Booking_Details (
    booking_id INT NOT NULL,
    event_id INT NOT NULL,
    session_id INT NOT NULL,
    ticket_category VARCHAR(50) NOT NULL,
    ticket_price DECIMAL(8,2) NOT NULL,
    tickets_booked INT NOT NULL,
    PRIMARY KEY (booking_id, session_id),
    FOREIGN KEY (booking_id, event_id)
        REFERENCES Bookings(booking_id, event_id),
    FOREIGN KEY (session_id, event_id)
        REFERENCES Sessions(session_id, event_id),
    CHECK (ticket_price >= 0),
    CHECK (tickets_booked >= 0)
);

-- 7. Speakers
CREATE TABLE Speakers (
    speaker_id INT AUTO_INCREMENT PRIMARY KEY,
    speaker_name VARCHAR(100) NOT NULL UNIQUE
);

-- 8. Session speakers (junction table)
CREATE TABLE Session_Speakers (
    session_id INT NOT NULL,
    speaker_id INT NOT NULL,
    PRIMARY KEY (session_id, speaker_id),
    FOREIGN KEY (session_id)
        REFERENCES Sessions(session_id),
    FOREIGN KEY (speaker_id)
        REFERENCES Speakers(speaker_id)
);

-- Verify tables
SHOW TABLES;

-- Verify table structures
DESCRIBE Organizers;
DESCRIBE Venues;
DESCRIBE Events;
DESCRIBE Bookings;
DESCRIBE Sessions;
DESCRIBE Booking_Details;
DESCRIBE Speakers;
DESCRIBE Session_Speakers;