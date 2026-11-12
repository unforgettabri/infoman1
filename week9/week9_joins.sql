-- INFOMAN1 Week 9: Multi-Table Join Practical Test
-- Database: infoman1_canteen

CREATE DATABASE IF NOT EXISTS infoman1_canteen;
USE infoman1_canteen;

-- SEED DATA
-- Run this setup section only once.

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    program VARCHAR(20) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE menu_items (
    menu_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL
);

CREATE TABLE order_items (
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, menu_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (menu_id) REFERENCES menu_items(menu_id)
);

INSERT INTO students VALUES
(1, 'Ana Cruz', 'BSIT'),
(2, 'Ben Lim', 'BSCS'),
(3, 'Cara Yu', 'BSIS'),
(4, 'Dan Reyes', 'BSIT');

INSERT INTO orders VALUES
(101, 1, '2026-08-10'),
(102, 1, '2026-08-15'),
(103, 4, '2026-08-16');

INSERT INTO menu_items VALUES
(1, 'Siomai Rice', 65.00),
(2, 'Burger Steak', 89.00),
(3, 'Iced Tea', 30.00);

INSERT INTO order_items VALUES
(101, 1, 2),
(101, 3, 1),
(102, 2, 1),
(103, 1, 1);


-- TASK 1: INNER JOIN BASICS

SELECT
    s.student_name,
    s.program,
    o.order_id,
    o.order_date
FROM students AS s
INNER JOIN orders AS o
    ON s.student_id = o.student_id
ORDER BY o.order_id;


-- TASK 2A: ALL STUDENTS AND THEIR MATCHED ORDERS

SELECT
    s.student_name,
    s.program,
    o.order_id,
    o.order_date
FROM students AS s
LEFT JOIN orders AS o
    ON s.student_id = o.student_id
ORDER BY s.student_id, o.order_id;


-- TASK 2B: STUDENTS WHO NEVER ORDERED

SELECT
    s.student_name,
    s.program,
    o.order_id
FROM students AS s
LEFT JOIN orders AS o
    ON s.student_id = o.student_id
WHERE o.order_id IS NULL
ORDER BY s.student_id;


-- TASK 3: FOUR-TABLE CANTEEN REPORT

SELECT
    s.student_name,
    s.program,
    o.order_id,
    m.item_name,
    oi.quantity,
    m.price,
    oi.quantity * m.price AS line_total
FROM students AS s
INNER JOIN orders AS o
    ON s.student_id = o.student_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN menu_items AS m
    ON oi.menu_id = m.menu_id
ORDER BY o.order_id, m.item_name;


-- TASK 4A: AUGUST REPORT PRESERVING STUDENTS WITHOUT ORDERS
-- The date condition is in the ON clause, preserving unmatched students.

SELECT
    s.student_name,
    m.item_name,
    oi.quantity * m.price AS line_total
FROM students AS s
LEFT JOIN orders AS o
    ON s.student_id = o.student_id
    AND o.order_date >= '2026-08-01'
    AND o.order_date < '2026-09-01'
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN menu_items AS m
    ON oi.menu_id = m.menu_id
ORDER BY o.order_date DESC, s.student_name;


-- TASK 4B: AUGUST REPORT WITH DATE FILTER IN WHERE
-- The WHERE condition removes rows where o.order_date is NULL.

SELECT
    s.student_name,
    m.item_name,
    oi.quantity * m.price AS line_total
FROM students AS s
LEFT JOIN orders AS o
    ON s.student_id = o.student_id
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN menu_items AS m
    ON oi.menu_id = m.menu_id
WHERE o.order_date >= '2026-08-01'
  AND o.order_date < '2026-09-01'
ORDER BY o.order_date DESC, s.student_name;


-- TASK 4C: COMPARE ROW COUNTS

SELECT
    'LEFT JOIN with date condition in ON' AS report_version,
    COUNT(*) AS row_count
FROM students AS s
LEFT JOIN orders AS o
    ON s.student_id = o.student_id
    AND o.order_date >= '2026-08-01'
    AND o.order_date < '2026-09-01'
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN menu_items AS m
    ON oi.menu_id = m.menu_id

UNION ALL

SELECT
    'LEFT JOIN with date condition in WHERE' AS report_version,
    COUNT(*) AS row_count
FROM students AS s
LEFT JOIN orders AS o
    ON s.student_id = o.student_id
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN menu_items AS m
    ON oi.menu_id = m.menu_id
WHERE o.order_date >= '2026-08-01'
  AND o.order_date < '2026-09-01';
