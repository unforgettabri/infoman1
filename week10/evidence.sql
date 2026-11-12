USE infoman1_bookstore;

-- Task 1: Inserted products
SELECT * FROM products
WHERE sku IN ('CALC-SCI-001', 'CMP-001');

-- Task 2: Updated Calculator and deleted Eraser
SELECT * FROM products WHERE product_id = 6;
SELECT * FROM products WHERE product_id = 5;

-- Task 3: SELF JOIN
SELECT e.employee_name AS employee,
       m.employee_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

-- Task 3: CROSS JOIN and count
SELECT c.color_name, s.size_name
FROM colors c CROSS JOIN sizes s
ORDER BY c.color_name, s.size_name;

SELECT COUNT(*) AS total_combinations
FROM colors CROSS JOIN sizes;

-- Task 4: Constraints and successful test records
SHOW CREATE TABLE products;

SELECT product_name, sku, price, status
FROM products
WHERE sku LIKE 'TEST-%'
ORDER BY product_id;
