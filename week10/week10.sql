USE infoman1_bookstore;

-- TASK 1: INSERT products

INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES
('Scientific Calculator', 'CALC-SCI-001', 850.00, 20, 'Active');

SELECT * FROM products
WHERE sku = 'CALC-SCI-001';

INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES
('Compass', 'CMP-001', 120.00, 50, 'Active');

SELECT * FROM products
WHERE sku = 'CMP-001';

-- TASK 2A: UPDATE Calculator price
-- Preview
SELECT * FROM products WHERE product_id = 6;

-- Execute
UPDATE products
SET price = 875.00
WHERE product_id = 6;

-- Verify
SELECT * FROM products WHERE product_id = 6;


-- TASK 2B: DELETE Eraser
-- Preview
SELECT * FROM products WHERE product_id = 5;

-- Execute
DELETE FROM products
WHERE product_id = 5;

-- Verify
SELECT * FROM products WHERE product_id = 5;

-- Without a WHERE clause, UPDATE or DELETE can affect every row.

-- TASK 3A: SELF JOIN employees and their managers
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

-- TASK 3B: CROSS JOIN colors and sizes
SELECT
    c.color_name,
    s.size_name
FROM colors c
CROSS JOIN sizes s
ORDER BY c.color_name, s.size_name;

-- Count all combinations
SELECT COUNT(*) AS total_combinations
FROM colors
CROSS JOIN sizes;

-- TASK 4A: Add contact number column
ALTER TABLE products
ADD COLUMN contact_number VARCHAR(20) NULL;

-- TASK 4B: Enforce NOT NULL on product_name
ALTER TABLE products
MODIFY product_name VARCHAR(100) NOT NULL;

-- TASK 4C: Enforce UNIQUE on SKU
ALTER TABLE products
ADD CONSTRAINT uq_products_sku UNIQUE (sku);

-- TASK 4D: Enforce positive prices
ALTER TABLE products
ADD CONSTRAINT chk_products_price CHECK (price > 0);

-- Verify table structure and constraints
SHOW CREATE TABLE products;

-- TASK 4E: DEFAULT status value
ALTER TABLE products
ALTER COLUMN status SET DEFAULT 'Active';

-- Valid NOT NULL write
INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES ('NOT NULL Test', 'TEST-NN-001', 1.00, 1, 'Active');

-- Rejected: product_name cannot be NULL
INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES (NULL, 'TEST-NN-002', 1.00, 1, 'Active');

-- Valid UNIQUE write
INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES ('UNIQUE Test', 'TEST-UNQ-001', 1.00, 1, 'Active');

-- Rejected: duplicate SKU
INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES ('Duplicate SKU Test', 'NB-001', 1.00, 1, 'Active');

-- Valid CHECK write
INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES ('CHECK Test', 'TEST-CHK-001', 10.00, 1, 'Active');

-- Rejected: price must be greater than zero
INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES ('Invalid Price Test', 'TEST-CHK-002', 0.00, 1, 'Active');

-- Valid DEFAULT write: status is omitted
INSERT INTO products
(product_name, sku, price, stock_quantity)
VALUES ('DEFAULT Test', 'TEST-DEF-001', 5.00, 1);

-- Verify successful test records
SELECT product_name, sku, price, status
FROM products
WHERE sku LIKE 'TEST-%'
ORDER BY product_id;

-- Task 1 rejected insert: duplicate existing Calculator SKU
INSERT INTO products
(product_name, sku, price, stock_quantity, status)
VALUES ('Rejected Insert Test', 'CALC-SCI-001', 100.00, 1, 'Active');
