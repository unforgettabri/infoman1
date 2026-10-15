CREATE DATABASE IF NOT EXISTS toolshare_prelim;
USE toolshare_prelim;

CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    membership_start_date DATE NOT NULL
);

CREATE TABLE StorageLocation (
    location_code VARCHAR(20) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE Tool (
    tool_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    purchase_date DATE NOT NULL,
    location_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (location_code)
        REFERENCES StorageLocation(location_code)
);

CREATE TABLE Certification (
    certification_id INT AUTO_INCREMENT PRIMARY KEY,
    certification_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Borrowing (
    member_id INT NOT NULL,
    tool_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NULL,
    PRIMARY KEY (member_id, tool_id, borrow_date),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (tool_id) REFERENCES Tool(tool_id)
);

CREATE TABLE MemberCertification (
    member_id INT NOT NULL,
    certification_id INT NOT NULL,
    completion_date DATE NOT NULL,
    PRIMARY KEY (member_id, certification_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (certification_id)
        REFERENCES Certification(certification_id)
);

CREATE TABLE ToolCertification (
    tool_id INT NOT NULL,
    certification_id INT NOT NULL,
    PRIMARY KEY (tool_id, certification_id),
    FOREIGN KEY (tool_id) REFERENCES Tool(tool_id),
    FOREIGN KEY (certification_id)
        REFERENCES Certification(certification_id)
);

-- Data type justifications:
-- VARCHAR accommodates variable-length names and descriptions.
-- DATE stores calendar dates and supports date comparisons.
-- INT provides numeric identifiers for members, tools, and certifications.