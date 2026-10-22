# ToolShare Relational Schema Notation

## Schema Notation Legend
- `<u>column_name</u>`: Primary Key (PK)
- `column_name [FK]`: Foreign Key (FK) referencing parent table
- `<u>column_name [FK]</u>`: Part of Composite Primary Key & Foreign Key

---

## Relational Schema Definitions

### 1. `Member`
Member(<u>member_id</u>, name, phone_number, membership_start_date)

### 2. `StorageLocation`
StorageLocation(<u>location_code</u>, description)

### 3. `Tool`
Tool(<u>tool_id</u>, name, category, purchase_date, location_code [FK])
- Foreign Key (`location_code`) references `StorageLocation(location_code)`

### 4. `Certification`
Certification(<u>certification_id</u>, certification_name)

### 5. `Borrowing` *(Junction Table: Member <-> Tool)*
Borrowing(<u>member_id [FK]</u>, <u>tool_id [FK]</u>, <u>borrow_date</u>, return_date)
- Foreign Key (`member_id`) references `Member(member_id)`
- Foreign Key (`tool_id`) references `Tool(tool_id)`

### 6. `MemberCertification` *(Junction Table: Member <-> Certification)*
MemberCertification(<u>member_id [FK]</u>, <u>certification_id [FK]</u>, completion_date)
- Foreign Key (`member_id`) references `Member(member_id)`
- Foreign Key (`certification_id`) references `Certification(certification_id)`

### 7. `ToolCertification` *(Junction Table: Tool <-> Certification)*
ToolCertification(<u>tool_id [FK]</u>, <u>certification_id [FK]</u>)
- Foreign Key (`tool_id`) references `Tool(tool_id)`
- Foreign Key (`certification_id`) references `Certification(certification_id)`