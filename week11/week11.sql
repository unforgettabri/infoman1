USE infoman1_normalization;

-- TASK 1A: UPDATE ANOMALY
-- How many rows contain the department name?
SELECT dept_id, department_name, COUNT(*) AS affected_rows
FROM student_enrollment
WHERE dept_id = 'D01'
GROUP BY dept_id, department_name;

-- Show every row that would need updating if the department is renamed
SELECT student_id, course_id, department_name
FROM student_enrollment
WHERE dept_id = 'D01';


-- TASK 1B: INSERT ANOMALY
-- Show why IT103 cannot be stored independently in this table
SELECT
    'IT103' AS proposed_course_id,
    'Intro to Networks' AS proposed_course_title,
    'D01' AS proposed_dept_id,
    'No student enrollment exists' AS problem;

-- The table requires student-related fields, so a placeholder student
-- would have to be invented to store this course.


-- TASK 1C: DELETE ANOMALY
-- Identify Ana's IT102 enrollment and its associated course facts
SELECT
    student_id,
    student_name,
    course_id,
    course_title,
    dept_id,
    department_name
FROM student_enrollment
WHERE student_id = 101 AND course_id = 'IT102';
-- TASK 2: FIRST NORMAL FORM (1NF)

CREATE TABLE enrollment_1nf (
    enrollment_row_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    course_title VARCHAR(100) NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    grade DECIMAL(3,2) NOT NULL
);

INSERT INTO enrollment_1nf
(student_id, student_name, course_id, course_title,
 dept_id, department_name, grade)
VALUES
(101, 'Ana Cruz', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.50),
(102, 'Ben Lim', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.75),
(101, 'Ana Cruz', 'IT102', 'Web Development', 'D01', 'Computing Studies', 1.25);

SELECT * FROM enrollment_1nf
ORDER BY student_id, course_id;

-- TASK 3: SECOND NORMAL FORM (2NF)

-- Functional dependencies:
-- student_id -> student_name
-- course_id -> course_title, dept_id, department_name
-- (student_id, course_id) -> grade

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses_2nf (
    course_id VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
    student_id INT NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    grade DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses_2nf(course_id)
);

INSERT INTO students
SELECT DISTINCT student_id, student_name
FROM enrollment_1nf;

INSERT INTO courses_2nf
SELECT DISTINCT course_id, course_title, dept_id, department_name
FROM enrollment_1nf;

INSERT INTO enrollments
SELECT student_id, course_id, grade
FROM enrollment_1nf;

-- Reconstruct the enrollment report using JOINs
SELECT
    s.student_id,
    s.student_name,
    c.course_id,
    c.course_title,
    c.department_name,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses_2nf c ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_id;


-- TASK 4: THIRD NORMAL FORM (3NF)

CREATE TABLE departments (
    dept_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments
SELECT DISTINCT dept_id, department_name
FROM courses_2nf;

INSERT INTO courses
SELECT DISTINCT course_id, course_title, dept_id
FROM courses_2nf;

-- Final normalized enrollment report
SELECT
    s.student_id,
    s.student_name,
    c.course_id,
    c.course_title,
    d.department_name,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN departments d ON c.dept_id = d.dept_id
ORDER BY s.student_id, c.course_id;

