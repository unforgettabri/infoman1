# Task 2: Relational Schema

- **Member**(<u>member_id</u>, name, phone_number, membership_start_date)
- **StorageLocation**(<u>location_code</u>, description)
- **Tool**(<u>tool_id</u>, name, category, purchase_date, location_code [FK])
- **Certification**(<u>certification_id</u>, certification_name)
- **Borrowing**(<u>member_id [PK, FK]</u>, <u>tool_id [PK, FK]</u>, <u>borrow_date [PK]</u>, return_date)
- **MemberCertification**(<u>member_id [PK, FK]</u>, <u>certification_id [PK, FK]</u>, completion_date)
- **ToolCertification**(<u>tool_id [PK, FK]</u>, <u>certification_id [PK, FK]</u>)

## Design Notes

- **Borrowing:** Resolves the many-to-many relationship between Member and Tool. The composite primary key allows the same member to borrow the same tool on different dates.
- **MemberCertification:** Records which certifications each member has completed and the completion date.
- **ToolCertification:** Resolves the many-to-many relationship between Tool and Certification.
- **Tool:** The `location_code` foreign key ensures each tool belongs to a storage location.