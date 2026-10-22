# INFOMAN1 Prelim Lab Exam - Answer Document

## Task 5: Debug a Cross-Week Mismatch

### 1. Explanation of Mismatch
The target query:
```sql
SELECT borrow_date, return_date
FROM Borrowing
WHERE member_name = 'Maria Santos';