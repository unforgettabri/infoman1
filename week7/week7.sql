-- INFOMAN1 Week 7 — Functions, Aliases & Filtering
-- Run after importing university_db.sql and selecting university_db.

USE university_db;

-- Task 1: Complex Student Roster
SELECT first_name, last_name, major
FROM students
WHERE major IN ('Computer Science', 'Information Technology')
  AND last_name LIKE 'S%'
  AND NOT (section = 'Online');

-- Task 2: Formatting Instructor Data
SELECT CONCAT(
    LEFT(first_name, 1),
    '. ',
    last_name,
    ' ($',
    ROUND(salary, 0),
    ')'
) AS `Instructor Details`
FROM instructors
LIMIT 5;

-- Task 3: Project Deadline Analysis
SELECT
    assignment_name,
    assigned_date,
    due_date,
    DATEDIFF(due_date, assigned_date) AS Days_To_Complete
FROM assignments
WHERE DATEDIFF(due_date, assigned_date) > 14
ORDER BY Days_To_Complete DESC;

-- Task 4: Comprehensive Data Audit
SELECT course_code, course_name, credits
FROM courses
WHERE (course_description IS NULL OR credits BETWEEN 4 AND 6)
  AND course_code LIKE '%ADV%'
ORDER BY course_name ASC;
