-- INFOMAN1 Prelim Lab Exam - Task 4: Sample Data & DQL Queries
-- Database: toolshare_prelim

USE toolshare_prelim;

-- =========================================================
-- 1. SAMPLE DATA POPULATION
-- =========================================================

INSERT INTO StorageLocation (location_code, description) VALUES
('Shelf A1', 'Main metal shelving unit - top row'),
('Shelf A3', 'Main metal shelving unit - bottom row'),
('Pegboard B1', 'Wall-mounted pegboard for hand and power tools');

INSERT INTO Member (name, phone_number, membership_start_date) VALUES
('Maria Santos', '09171234567', '2024-03-15'),
('Juan Dela Cruz', '09189876543', '2025-02-10'),
('Aris Thorne', '09201112222', '2025-01-20'),
('Elena Rostova', '09153334444', '2023-11-05'),
('Kenji Sato', '09995556666', '2025-03-01');

INSERT INTO Certification (certification_name) VALUES
('Chainsaw Safety'),
('Welding Basics'),
('Heavy Power Equipment Handling'),
('Ladder & Scaffolding Safety');

INSERT INTO Tool (name, category, purchase_date, location_code) VALUES
('Angle Grinder 700W', 'Power Tools', '2023-05-10', 'Pegboard B1'),
('Circular Saw 1400W', 'Power Tools', '2023-08-22', 'Shelf A1'),
('Chainsaw 40cc', 'Power Tools', '2024-01-15', 'Shelf A3'),
('Garden Hedge Trimmer', 'Garden', '2022-04-12', 'Shelf A1'),
('Lawn Mower Gas', 'Garden', '2023-09-01', 'Shelf A3'),
('Arc Welder 160A', 'Power Tools', '2024-06-30', 'Shelf A3'),
('Extension Ladder 12ft', 'General', '2022-12-01', 'Pegboard B1'),
('Hammer Drill 18V', 'Power Tools', '2024-02-14', 'Pegboard B1');

INSERT INTO Borrowing (member_id, tool_id, borrow_date, return_date) VALUES
(1, 1, '2025-01-10', '2025-01-15'), -- Maria Santos (Returned)
(1, 2, '2025-02-01', NULL),         -- Maria Santos (Currently on loan)
(2, 4, '2025-02-15', '2025-02-20'), -- Juan Dela Cruz (Returned)
(3, 3, '2025-02-18', NULL),         -- Aris Thorne (Currently on loan)
(4, 5, '2025-01-05', '2025-01-12'), -- Elena Rostova (Returned)
(5, 8, '2025-03-02', NULL);         -- Kenji Sato (Currently on loan)

INSERT INTO MemberCertification (member_id, certification_id, completion_date) VALUES
(1, 1, '2024-04-01'),
(1, 2, '2024-05-10'),
(3, 1, '2025-01-25');

INSERT INTO ToolCertification (tool_id, certification_id) VALUES
(3, 1),
(6, 2);

-- =========================================================
-- 2. TASK 4 REQUIRED DQL QUERIES
-- =========================================================

-- Query 1: List the names and categories of all tools in the "Power Tools" category.
SELECT name, category
FROM Tool
WHERE category = 'Power Tools';

-- Query 2: Find all members who joined after January 1, 2025.
SELECT member_id, name, membership_start_date
FROM Member
WHERE membership_start_date > '2025-01-01';

-- Query 3: Show all borrowing records currently on loan (return_date IS NULL).
SELECT member_id, tool_id, borrow_date, return_date
FROM Borrowing
WHERE return_date IS NULL;

-- Query 4: List all borrowing records for one specific member ID (Maria Santos: member_id = 1).
SELECT member_id, tool_id, borrow_date, return_date
FROM Borrowing
WHERE member_id = 1;

-- Query 5: List all tools purchased before January 1, 2024.
SELECT tool_id, name, category, purchase_date
FROM Tool
WHERE purchase_date < '2024-01-01';