# INFOMAN1 — Week 8: Employee Payroll Query Lab

**Name:** Brianna T. Bustamante  
**Student ID:** [ADD YOUR STUDENT ID]  
**Repository:** https://github.com/unforgettabri/infoman1  
**Date:** November 12, 2026

---

## Task 1 — Pattern Matching with LIKE

### Approach / Explanation

I used the SQL `LIKE` operator to retrieve employee records based on specific text patterns. The `%` wildcard represents zero or more characters, while `_` represents exactly one character.

### 1.1 Employees with last names ending in "ez"

**Code / Query Used**
```sql
SELECT *
FROM employee
WHERE last_name LIKE '%ez';
```

**Evidence / Output**

- Total matching records: **161 rows**
- The query successfully retrieved employees whose last names end in `ez`.

### 1.2 Employees whose first names start with "Ma"

**Code / Query Used**
```sql
SELECT *
FROM employee
WHERE first_name LIKE 'Ma%';
```

**Evidence / Output**

- Total matching records: **112 rows**
- The query returned employees whose first names begin with `Ma`.

### 1.3 Employee codes containing exactly five characters and starting with E

**Code / Query Used**
```sql
SELECT *
FROM employee
WHERE emp_code LIKE 'E____';
```

**Evidence / Output**

- Total matching records: **500 rows**
- The query matched all employee codes beginning with `E` followed by exactly four characters.

### 1.4 Employee codes matching the pattern E, any character, 0, and two more characters

**Code / Query Used**
```sql
SELECT emp_code, first_name, last_name
FROM employee
WHERE emp_code LIKE 'E_0__';
```

**Evidence / Output**

- Total matching records: **48 rows**

| Employee Code | First Name | Last Name |
|---|---|---|
| E9042 | Isabel | Cruz |
| E1041 | John | Navarro |
| E9032 | Leo | Tolentino |
| E6062 | Jacob | Morales |
| E7043 | Matthew | Jimenez |
| E9045 | Vanessa | Gutierrez |
| E8035 | Matthew | Soriano |
| E6040 | Liam | Mendoza |
| E8095 | Maricel | Dela Cruz |
| E9020 | Olivia | Pascual |
| E2053 | Emma | Perez |
| E7064 | Oscar | Perez |
| E1003 | Lucia | Velasquez |
| E5060 | Oscar | Castillo |
| E1084 | Liam | Salazar |
| E9060 | Rico | Rivera |
| E6013 | Bianca | Tan |
| E4088 | Isabel | Morales |
| E4047 | Helen | Pascual |
| E4067 | Mario | Lim |
| E1080 | Yna | Salazar |
| E4039 | Hannah | Navarro |
| E2047 | Walter | Ramos |
| E2030 | Gabriel | Morales |
| E6077 | Maricel | Villanueva |
| E3015 | Sara | Aquino |
| E3004 | Noel | Gutierrez |
| E3010 | Jacob | Martinez |
| E3059 | John | Cruz |
| E3069 | Hannah | Ramirez |
| E3051 | John | Gomez |
| E4005 | Carmen | Tolentino |
| E4078 | Dennis | Martinez |
| E1087 | Olivia | Bautista |
| E6025 | Carmen | Mendoza |
| E6085 | Lara | Villanueva |
| E4091 | Maria | Ortiz |
| E1032 | Victor | Domingo |
| E2042 | Liam | Navarro |
| E7029 | Liam | Mendoza |
| E5065 | Mavis | Santos |
| E3072 | Marisol | Mendoza |
| E5047 | Matthew | Reyes |
| E8087 | Karen | Chua |
| E9080 | Victor | Morales |
| E3090 | Maria | Rodriguez |
| E8066 | Olivia | Chua |
| E3019 | Jose | Martinez |

### Reflection

The `LIKE` operator makes it easier to search for records using partial text patterns. The `%` and `_` wildcards are useful because they allow searches without knowing the complete value.

---

## Task 2 — Aggregate Functions

### Approach / Explanation

I used aggregate functions to summarize employee information, including the total number of employees, salary totals, average salary, and hire date range.

### Code / Query Used

**1. Count all employees and employees with a commission**
```sql
SELECT
    COUNT(*) AS total_employees,
    COUNT(commission) AS employees_with_commission
FROM employee;
```

**Output**

| Total Employees | Employees with Commission |
|---:|---:|
| 500 | 352 |

**2. Calculate total salary**
```sql
SELECT SUM(salary) AS total_salary
FROM employee;
```

**Output**

| Total Salary |
|---:|
| 33282250.00 |

**3. Calculate average salary**
```sql
SELECT AVG(salary) AS average_salary
FROM employee;
```

**Output**

| Average Salary |
|---:|
| 66564.500000 |

**4. Find the earliest and latest hire dates**
```sql
SELECT
    MIN(hire_date) AS earliest_hire_date,
    MAX(hire_date) AS latest_hire_date
FROM employee;
```

**Output**

| Earliest Hire Date | Latest Hire Date |
|---|---|
| 2015-01-03 | 2026-09-14 |

**5. Calculate total salary including commission**
```sql
SELECT
    SUM(salary + COALESCE(commission, 0)) AS total_compensation
FROM employee;
```

**Output**

| Total Compensation |
|---:|
| 35387750.00 |

### Reflection

Aggregate functions help summarize large amounts of data. `COUNT(*)` counts all records, while `COUNT(commission)` only counts records with a non-NULL commission. `COALESCE()` replaces NULL commission values with zero so that employee salaries are still included in the total compensation calculation.

---

## Task 3 — GROUP BY

### Approach / Explanation

I used `GROUP BY` to organize employee records by department and job title. This allowed me to calculate department statistics and count employees in each job position.

### 3.1 Employee count, average salary, and distinct job titles per department

**Code / Query Used**
```sql
SELECT
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    COUNT(DISTINCT job_title) AS distinct_job_titles
FROM employee
GROUP BY department
ORDER BY department;
```

**Output**

| Department | Employee Count | Average Salary | Distinct Job Titles |
|---|---:|---:|---:|
| Engineering | 125 | 75160.000000 | 3 |
| Finance | 69 | 79513.043478 | 3 |
| HR | 50 | 62610.000000 | 3 |
| Sales | 144 | 71799.652778 | 3 |
| Support | 112 | 44028.571429 | 3 |

### 3.2 Employee count per department and job title

**Code / Query Used**
```sql
SELECT
    department,
    job_title,
    COUNT(*) AS employee_count
FROM employee
GROUP BY department, job_title
ORDER BY department, job_title;
```

**Output**

| Department | Job Title | Employee Count |
|---|---|---:|
| Engineering | DevOps Engineer | 42 |
| Engineering | QA Analyst | 39 |
| Engineering | Software Engineer | 44 |
| Finance | Accountant | 21 |
| Finance | Finance Manager | 24 |
| Finance | Financial Analyst | 24 |
| HR | HR Manager | 18 |
| HR | HR Specialist | 20 |
| HR | Recruiter | 12 |
| Sales | Account Manager | 50 |
| Sales | Sales Manager | 49 |
| Sales | Sales Representative | 45 |
| Support | Support Agent | 40 |
| Support | Support Lead | 29 |
| Support | Support Specialist | 43 |

### Reflection

`GROUP BY` organizes records into groups based on shared values. It is useful when calculating totals, averages, and counts for categories such as departments and job titles.

---

## Task 4 — HAVING

### Approach / Explanation

I used `HAVING` to filter grouped results based on aggregate values. Unlike `WHERE`, which filters individual records before grouping, `HAVING` filters groups after aggregation.

### 4.1 Departments with an average salary greater than 70,000

**Code / Query Used**
```sql
SELECT
    department,
    AVG(salary) AS average_salary
FROM employee
GROUP BY department
HAVING AVG(salary) > 70000
ORDER BY average_salary DESC;
```

**Output**

| Department | Average Salary |
|---|---:|
| Finance | 79513.043478 |
| Engineering | 75160.000000 |
| Sales | 71799.652778 |

### 4.2 Departments with more than 50 active employees

**Code / Query Used**
```sql
SELECT
    department,
    COUNT(*) AS active_headcount
FROM employee
WHERE status = 'Active'
GROUP BY department
HAVING COUNT(*) > 50
ORDER BY active_headcount DESC;
```

**Output**

| Department | Active Headcount |
|---|---:|
| Sales | 116 |
| Engineering | 104 |
| Support | 99 |
| Finance | 52 |

### Reflection

`HAVING` is useful when filtering results based on aggregate functions such as `COUNT()` and `AVG()`. In the second query, `WHERE` first selects active employees, while `HAVING` keeps only departments with more than 50 active employees.

---