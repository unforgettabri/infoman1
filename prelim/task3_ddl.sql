-- INFOMAN1 Prelim Lab Exam - Task 3: MySQL DDL Implementation
-- Database: toolshare_prelim

CREATE DATABASE IF NOT EXISTS toolshare_prelim;
USE toolshare_prelim;

-- 1. Member Table
CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    membership_start_date DATE NOT NULL
);

-- 2. Storage Location Table
CREATE TABLE StorageLocation (
    location_code VARCHAR(20) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

-- 3. Tool Table (Includes total participation FK to StorageLocation)
CREATE TABLE Tool (
    tool_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    purchase_date DATE NOT NULL,
    location_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (location_code) 
        REFERENCES StorageLocation(location_code)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 4. Certification Table
CREATE TABLE Certification (
    certification_id INT AUTO_INCREMENT PRIMARY KEY,
    certification_name VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Borrowing Junction Table (Member <-> Tool)
CREATE TABLE Borrowing (
    member_id INT NOT NULL,
    tool_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NULL,
    PRIMARY KEY (member_id, tool_id, borrow_date),
    FOREIGN KEY (member_id) 
        REFERENCES Member(member_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (tool_id) 
        REFERENCES Tool(tool_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 6. MemberCertification Junction Table (Member <-> Certification)
CREATE TABLE MemberCertification (
    member_id INT NOT NULL,
    certification_id INT NOT NULL,
    completion_date DATE NOT NULL,
    PRIMARY KEY (member_id, certification_id),
    FOREIGN KEY (member_id) 
        REFERENCES Member(member_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (certification_id) 
        REFERENCES Certification(certification_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. ToolCertification Junction Table (Tool <-> Certification)
CREATE TABLE ToolCertification (
    tool_id INT NOT NULL,
    certification_id INT NOT NULL,
    PRIMARY KEY (tool_id, certification_id),
    FOREIGN KEY (tool_id) 
        REFERENCES Tool(tool_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (certification_id) 
        REFERENCES Certification(certification_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- Data Type Justifications (Task 3 Requirement):
-- 1. return_date (DATE NULL): Using a nullable DATE column explicitly models
--    active/ongoing loans where NULL signifies that the tool has not been returned.
-- 2. location_code (VARCHAR(20)): Selected over an auto-increment integer because
--    physical storage codes use alphanumeric identifiers (e.g., 'Shelf A3', 'Pegboard B1').
-- =========================================================