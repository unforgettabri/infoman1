USE infoman1_normalization;

SELECT 'TASK 1A: UPDATE ANOMALY' AS section;
SELECT dept_id, department_name, COUNT(*) AS affected_rows
FROM student_enrollment
WHERE dept_id = 'D01'
GROUP BY dept_id, department_name;

SELECT student_id, course_id, department_name FROM student_enrollment WHERE dept_id = 'D01';
SELECT 'TASK 1B: INSERT ANOMALY' AS section;
SELECT 'IT103' AS proposed_course_id,
       'Intro to Networks' AS proposed_course_title,
       'D01' AS proposed_dept_id,
       'No student enrollment exists' AS problem;

SELECT 'TASK 1C: DELETE ANOMALY' AS section;
SELECT student_id, student_name, course_id, course_title,
       dept_id, department_name
FROM student_enrollment
WHERE student_id = 101 AND course_id = 'IT102';

SELECT 'TASK 2: FIRST NORMAL FORM' AS section;
SELECT * FROM enrollment_1nf
ORDER BY student_id, course_id;

SELECT 'TASK 3: SECOND NORMAL FORM' AS section;
SELECT s.student_id, s.student_name, c.course_id,
       c.course_title, c.department_name, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses_2nf c ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_id;

SELECT 'TASK 4: THIRD NORMAL FORM' AS section;
SELECT s.student_id, s.student_name, c.course_id,
       c.course_title, d.department_name, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN departments d ON c.dept_id = d.dept_id
ORDER BY s.student_id, c.course_id;
