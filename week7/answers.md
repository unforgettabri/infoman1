# INFOMAN1 — Week 7 Lab Answers

**Lab 7: Performance Task Using SQL 3 (Functions, Aliases & Filtering)**

## Task 1 — Complex Student Roster

**Approach / explanation:**

The query selects students whose major is either Computer Science or Information Technology, whose last name begins with `S`, and whose section is not Online. `IN` checks the allowed majors, `LIKE 'S%'` matches last names beginning with S, and `NOT` excludes Online students.

**Code / query used:**

```sql
SELECT first_name, last_name, major
FROM students
WHERE major IN ('Computer Science', 'Information Technology')
  AND last_name LIKE 'S%'
  AND NOT (section = 'Online');
```

**Expected result:**

| first_name | last_name | major |
|---|---|---|
| Sofia | Santos | Computer Science |
| Samuel | Santiago | Information Technology |
| Sarah | Sy | Computer Science |
| Daniel | Serrano | Information Technology |
| Liza | Soberano | Computer Science |

**Evidence:** `screenshots/task1.png`

**Reflection question:**

Why is it often better to use the `IN` operator rather than chaining multiple `OR` conditions when filtering by a specific list of values?

**Answer:**

`IN` makes a query shorter and easier to read when checking a column against several possible values. It is also easier to maintain because values can be added to or removed from one list instead of editing multiple `OR` conditions.

---

## Task 2 — Formatting Employee Data

**Approach / explanation:**

`LEFT(first_name, 1)` extracts the instructor's first initial. `CONCAT` combines the initial, last name, and formatted salary into one string. `ROUND(salary, 0)` rounds the salary to the nearest whole number. `LIMIT 5` returns only the first five rows.

**Code / query used:**

```sql
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
```

**Textual output (first 5 rows):**

```text
+--------------------------+
| Instructor Details       |
+--------------------------+
| J. Smith ($55001)        |
| M. Santos ($62500)       |
| R. Johnson ($49000)      |
| A. Reyes ($71250)        |
| P. Cruz ($47001)         |
+--------------------------+
5 rows in set
```

**Evidence:** Textual output is included above, as required by the task.

**Reflection question:**

How do string functions like `CONCAT` affect the performance of a query compared to retrieving raw columns and formatting them in the application layer (e.g., in Java or Python)?

**Answer:**

`CONCAT` requires the database to do extra work to build each formatted string, especially when many rows are returned. Formatting in the application can keep presentation logic outside the database and leave the original values unchanged. However, formatting in SQL is convenient for reports and quick query results.

---

## Task 3 — Project Deadline Analysis

**Approach / explanation:**

`DATEDIFF(due_date, assigned_date)` calculates the number of days between the assigned date and due date. The result is named `Days_To_Complete`. The `WHERE` clause keeps only assignments with more than 14 days, and `ORDER BY Days_To_Complete DESC` sorts the longest duration first.

**Code / query used:**

```sql
SELECT
    assignment_name,
    assigned_date,
    due_date,
    DATEDIFF(due_date, assigned_date) AS Days_To_Complete
FROM assignments
WHERE DATEDIFF(due_date, assigned_date) > 14
ORDER BY Days_To_Complete DESC;
```

**Evidence:** `screenshots/task3.png`

---

## Task 4 — Comprehensive Data Audit

**Approach / explanation:**

The query selects courses whose description is missing or whose credits are between 4 and 6, while also requiring the course code to contain `ADV`. Parentheses group the `OR` conditions so the `AND` condition applies to both alternatives.

**Code / query used:**

```sql
SELECT course_code, course_name, credits
FROM courses
WHERE (course_description IS NULL OR credits BETWEEN 4 AND 6)
  AND course_code LIKE '%ADV%'
ORDER BY course_name ASC;
```

**Explanation of AND / OR precedence:**

In SQL, `AND` has higher precedence than `OR`. Without parentheses, an expression such as `A OR B AND C` is evaluated as `A OR (B AND C)`. The parentheses in this query make MySQL evaluate `(course_description IS NULL OR credits BETWEEN 4 AND 6)` first. It then applies `AND course_code LIKE '%ADV%'` to the result, ensuring that every returned course code contains `ADV`.

**Expected result (based on the supplied sample data):**

| course_code | course_name | credits |
|---|---|---:|
| CS-ADV305 | Advanced Algorithms | 4 |
| CS-ADV400 | Advanced Capstone Project | 6 |
| CS-ADV101 | Advanced Database Systems | 5 |
| IT-ADV210 | Advanced Networking | 3 |
| ENG-ADV110 | Advanced Technical Writing | 2 |
| IT-ADV150 | Advanced Web Development | 6 |

---

## Self-Check

- [x] Task 1 uses `IN`, `LIKE`, and `NOT`.
- [x] Task 2 uses `CONCAT`, `LEFT`, `ROUND`, an alias, and `LIMIT 5`.
- [x] Task 3 uses `DATEDIFF`, an alias, filtering greater than 14 days, and descending sorting.
- [x] Task 4 uses `IS NULL`, `BETWEEN`, `LIKE`, parentheses, and alphabetical sorting.
- [x] `answers.md` is included in the `week7/` folder.
- [x] Supplied screenshots are included under their correct task filenames.
- [ ] Run all queries in your own MySQL environment and confirm the results.
- [ ] Commit and push the `week7/` folder to the `infoman1` repository.
- [ ] Submit only the repository URL in Moodle.
