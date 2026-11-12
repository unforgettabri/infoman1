# INFOMAN1 — Lab 9: Multi-Table Join Practical Test

**Name:** Brianna T. Bustamante  
**Student ID:** [ADD YOUR STUDENT ID]  
**Repository:** https://github.com/unforgettabri/infoman1  
**Date:** November 12, 2026

## Task 1 — INNER JOIN Basics

### Approach / Explanation

I used `INNER JOIN` to connect the students table with the orders table through their shared `student_id`. This retrieves only students who have matching orders.

### Code / Query Used

See `week9_joins.sql`, Task 1.

### Actual Output

| Student Name | Program | Order ID | Order Date |
|---|---|---:|---|
| Ana Cruz | BSIT | 101 | 2026-08-10 |
| Ana Cruz | BSIT | 102 | 2026-08-15 |
| Dan Reyes | BSIT | 103 | 2026-08-16 |

**Total: 3 rows**

### Reflection

The INNER JOIN only returns records with matching values in both tables. Ben and Cara do not appear because they have no orders.

---

## Task 2 — Finding Missing Relationships

### Approach / Explanation

I used `LEFT JOIN` to retrieve every student, including those without orders. I then used `WHERE o.order_id IS NULL` to identify students who have never placed an order.

### Task 2A — All Students and Their Orders

**Code / Query Used**

See `week9_joins.sql`, Task 2A.

**Actual Output**

| Student Name | Program | Order ID | Order Date |
|---|---|---:|---|
| Ana Cruz | BSIT | 101 | 2026-08-10 |
| Ana Cruz | BSIT | 102 | 2026-08-15 |
| Ben Lim | BSCS | NULL | NULL |
| Cara Yu | BSIS | NULL | NULL |
| Dan Reyes | BSIT | 103 | 2026-08-16 |

**Total: 5 rows**

### Task 2B — Students Who Never Ordered

**Code / Query Used**

See `week9_joins.sql`, Task 2B.

**Actual Output**

| Student Name | Program | Order ID |
|---|---|---|
| Ben Lim | BSCS | NULL |
| Cara Yu | BSIS | NULL |

**Total: 2 rows**

**Explanation:** Ben Lim and Cara Yu appear because they have no matching records in the orders table. Their order IDs are NULL.

### Reflection

LEFT JOIN is useful when a report must include all records from the main table, even when related information does not exist.

---

## Task 3 — Four-Table Canteen Report

### Approach / Explanation

I joined four tables using their primary-key and foreign-key relationships. I used table aliases to make the query easier to read and qualified shared columns to avoid ambiguity. I also calculated each item's total by multiplying its quantity by its price.

### Code / Query Used

See `week9_joins.sql`, Task 3.

### Actual Output

| Student Name | Program | Order ID | Item Name | Quantity | Price | Line Total |
|---|---|---:|---|---:|---:|---:|
| Ana Cruz | BSIT | 101 | Iced Tea | 1 | 30.00 | 30.00 |
| Ana Cruz | BSIT | 101 | Siomai Rice | 2 | 65.00 | 130.00 |
| Ana Cruz | BSIT | 102 | Burger Steak | 1 | 89.00 | 89.00 |
| Dan Reyes | BSIT | 103 | Siomai Rice | 1 | 65.00 | 65.00 |

**Total: 4 rows**

### Reflection

Joining multiple tables allows information from different parts of a database to appear in one report. Each JOIN needs a correct ON condition to connect related records.

---

## Task 4 — Aliases, Filters, and the Silent INNER JOIN

### Approach / Explanation

I used a date condition to filter orders from August 2026. I compared two LEFT JOIN versions: one places the date condition inside the ON clause, while the other places it inside WHERE.

### Task 4A — Date Condition in ON

**Code / Query Used**

See `week9_joins.sql`, Task 4A.

**Actual Output**

| Student Name | Item Name | Line Total |
|---|---|---:|
| Dan Reyes | Siomai Rice | 65.00 |
| Ana Cruz | Burger Steak | 89.00 |
| Ana Cruz | Siomai Rice | 130.00 |
| Ana Cruz | Iced Tea | 30.00 |
| Ben Lim | NULL | NULL |
| Cara Yu | NULL | NULL |

**Total: 6 rows**

### Task 4B — Date Condition in WHERE

**Code / Query Used**

See `week9_joins.sql`, Task 4B.

**Actual Output**

| Student Name | Item Name | Line Total |
|---|---|---:|
| Dan Reyes | Siomai Rice | 65.00 |
| Ana Cruz | Burger Steak | 89.00 |
| Ana Cruz | Siomai Rice | 130.00 |
| Ana Cruz | Iced Tea | 30.00 |

**Total: 4 rows**

### Comparison and Explanation

The first query returns 6 rows because the date condition is included in the ON clause. This preserves students without matching orders, showing NULL values for their order details.

The second query returns only 4 rows because the WHERE condition filters out records where `o.order_date` is NULL. Although it begins with a LEFT JOIN, the condition makes its result behave like an INNER JOIN for this date filter.

**Fix:** Move the date condition into the ON clause to preserve students without orders. Another option is to handle NULL values explicitly if the report requires them.

### Reflection

The placement of a filter matters when using outer joins. A condition in WHERE can remove unmatched records that a LEFT JOIN would normally preserve.

---

## Task 5 — Final Reflection

I would choose INNER JOIN when I only need records that have matching information in two or more tables. For example, in Task 1, INNER JOIN was appropriate because the report only needed students who had placed orders. Ben and Cara were excluded because they had no matching orders.

I would choose LEFT JOIN when I need to include every record from the main table, even when related information is missing. Task 2 is an example because it showed all four students, including those who had never ordered.

One mistake I observed in Task 4 was placing the date condition in the WHERE clause while using LEFT JOIN. The query returned only four rows instead of six because students without orders had NULL dates, which did not satisfy the filter. I fixed this by moving the date condition into the ON clause. This allowed the query to keep students without matching orders while still filtering the order dates. This exercise helped me understand that the position of a condition can change the behavior of a JOIN.

---

## Final Self-Check

- [x] Task 1 — INNER JOIN with explicit ON condition
- [x] Task 2 — LEFT JOIN and IS NULL filter
- [x] Task 3 — Four-table JOIN with three ON conditions
- [x] Task 4 — Comparison of ON and WHERE filtering
- [x] Task 5 — Reflection within the required word range
- [x] All queries executed successfully in MySQL
- [ ] Save actual query output as evidence
- [ ] Commit and push Week 9 files to GitHub
