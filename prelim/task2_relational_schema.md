# ToolShare Relational Schema Notation

## Schema Notation Legend
- `<u>column_name</u>`: Primary Key (PK)
- `column_name [FK]`: Foreign Key (FK) referencing parent table
- `<u>column_name [FK]</u>`: Part of Composite Primary Key & Foreign Key

---

## Relational Schema Definitions

### 1. `member`
Member(<u>member_id</u>, first_name, last_name, phone_number, membership_start_date)

### 2. `storage_location`
Storage_Location(<u>location_code</u>, description)

### 3. `tool`
Tool(<u>tool_id</u>, name, category, purchase_date, location_code [FK])
- Foreign Key (`location_code`) references `storage_location(location_code)`

### 4. `certification`
Certification(<u>certification_id</u>, certification_name)

### 5. `borrowing` *(Junction Table: Member <-> Tool)*
Borrowing(<u>borrowing_id</u>, member_id [FK], tool_id [FK], borrow_date, return_date)
- Foreign Key (`member_id`) references `member(member_id)`
- Foreign Key (`tool_id`) references `tool(tool_id)`

### 6. `member_certification` *(Junction Table: Member <-> Certification)*
Member_Certification(<u>member_id [FK]</u>, <u>certification_id [FK]</u>, completion_date)
- Foreign Key (`member_id`) references `member(member_id)`
- Foreign Key (`certification_id`) references `certification(certification_id)`

### 7. `tool_certification` *(Junction Table: Tool <-> Certification)*
Tool_Certification(<u>tool_id [FK]</u>, <u>certification_id [FK]</u>)
- Foreign Key (`tool_id`) references `tool(tool_id)`
- Foreign Key (`certification_id`) references `certification(certification_id)`