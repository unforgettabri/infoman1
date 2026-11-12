# Lab 10 — Safe DML & Data Integrity Practical Test

## Task 1 — INSERT

Inserted:
- Scientific Calculator — SKU: CALC-SCI-001 — Product ID: 6
- Compass — SKU: CMP-001 — Product ID: 7

Used explicit column lists and SELECT statements to verify both inserts. A duplicate Calculator SKU was rejected by the UNIQUE constraint with MySQL error 1062.

## Task 2 — UPDATE and DELETE

Updated product ID 6 from 850.00 to 875.00. Previewed the row before updating and verified the new price afterward.

Deleted Eraser using product ID 5. Previewed it before deletion; the verification query returned no row afterward.

Without a WHERE clause, UPDATE can change every row, while DELETE can remove every row in the table.

## Task 3 — SELF JOIN and CROSS JOIN

The SELF JOIN uses aliases `e` and `m` to match employees with their managers. LEFT JOIN keeps Lea Ramos in the results even though she has no manager.

The CROSS JOIN produced 9 combinations from 3 colors and 3 sizes. A bookstore could use this to generate product variants, such as notebooks in different colors and sizes. An accidental CROSS JOIN can multiply rows and produce incorrect results when a join condition is missing.

## Task 4 — ALTER TABLE and constraints

Added `contact_number` using ALTER TABLE.

Enforced:
- NOT NULL on product_name
- UNIQUE on sku
- CHECK (price > 0) on price
- DEFAULT 'Active' on status

Valid inserts succeeded. Invalid writes were rejected: NULL product name (1048), duplicate SKU (1062), and zero price (3819). An insert that omitted status received the default value Active.

MySQL 8.4 supports and enforces CHECK constraints. This was verified through SHOW CREATE TABLE and the rejected zero-price insert.

## Task 5 — Reflection

During this lab, I made an execution mistake while testing Task 2. I extracted the Task 2 section from week10.sql and piped it directly to MySQL, but that section did not include `USE infoman1_bookstore;`. MySQL returned ERROR 1046: No database selected, so the statements did not run. I checked the file with `tail` and confirmed the SQL itself was intact. I fixed the command by adding `USE infoman1_bookstore;` before the extracted section, then reran the statements. The Calculator changed from 850.00 to 875.00, and the Eraser verification returned no row. This showed me that a correct query can still fail when the session context is missing. Previewing target rows and using stable product IDs also made UPDATE and DELETE safer. For a campus bookstore, application validation can guide users with immediate messages, but database constraints protect records even when data comes from another screen or process. Both layers are useful, with database rules serving as the final safeguard.
