# Lab 11 — Database Normalization

## Task 1: Diagnosing Anomalies

- **Update anomaly:** The department name appears in three enrollment rows. Renaming it requires updating every matching row because department information is stored repeatedly.
- **Insert anomaly:** The original table combines course and student enrollment information. A course cannot be stored independently without inventing a placeholder student.
- **Delete anomaly:** Deleting Ana's IT102 enrollment also removes the only stored record containing the Web Development course details.

The structural cause is that student, course, department, and enrollment facts are stored together in one table.

## Task 2: First Normal Form (1NF)

The `enrollment_1nf` table stores one student-course combination per row. The multi-valued `enrolled_courses` field is removed, and each value is atomic. The `enrollment_row_id` column provides a unique primary key.

However, student names, course titles, and department details are still repeated across rows.

## Task 3: Second Normal Form (2NF)

The logical composite key is `(student_id, course_id)`.

Functional dependencies:
- `student_id → student_name`
- `course_id → course_title, dept_id, department_name`
- `(student_id, course_id) → grade`

The `students` table stores student details, `courses_2nf` stores course details, and `enrollments` stores the student-course relationship and grade. Grade remains in `enrollments` because it depends on the complete combination of student and course.

The department name still depends on `dept_id`, so a transitive dependency remains at this stage.

## Task 4: Third Normal Form (3NF)

The department information is separated into `departments`. The final structure contains four tables:

| Table | Normalization decision |
|---|---|
| `students` | Student name depends only on the primary key, `student_id`. |
| `courses` | Course title and department ID depend only on `course_id`; department name is stored separately. |
| `departments` | Department name depends only on `dept_id`. |
| `enrollments` | Grade depends on the complete composite key, `(student_id, course_id)`. |

The final JOIN combines all four tables to reconstruct the enrollment report without storing department names repeatedly in course records.

## Task 5: Reflection

Normalization helps keep data accurate by separating facts that belong to different entities. In a campus enrollment system, students, courses, departments, and grades should be stored in their proper tables. This prevents repeated information and makes updates safer. For example, changing a department name should require updating only one department record, not every enrollment containing that department.

However, normalization is not always the fastest option for reading data. A campus dashboard that frequently displays complete enrollment reports may benefit from a deliberately denormalized reporting table or view. This can reduce the number of JOINs needed for repeated reports, although the stored data must be kept consistent.

One issue I encountered during this lab was rerunning the entire SQL script after creating the 1NF table. MySQL returned an error because the table already existed. I initially treated the script as something that could be executed repeatedly. I fixed this by running only the unfinished task section instead. This reminded me to track which database changes have already been applied and to understand that table creation statements are not automatically repeatable.
