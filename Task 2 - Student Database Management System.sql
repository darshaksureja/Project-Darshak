-- 1. Database Setup

-- CREATE DATABASE student_database;
-- Connect to the student_database

-- Create the student_table
CREATE TABLE student_table (
    student_id SERIAL PRIMARY KEY,
    stu_name TEXT,
    department TEXT,
    email_id TEXT,
    phone_no NUMERIC,
    address TEXT,
    date_of_birth DATE,
    gender TEXT,
    major TEXT,
    gpa NUMERIC,
    grade TEXT
);

-- 2. Data Entry
-- Insert 10 sample records into student_table
INSERT INTO student_table (stu_name, department, email_id, phone_no, address, date_of_birth, gender, major, gpa, grade)
VALUES
    ('Rahul Verma', 'Computer Science', 'rahul.verma@email.com', '9876543210', '123 Main St, Delhi', '1998-08-15', 'Male', 'Computer Science', 3.8, 'B'),
    ('Priya Patel', 'Mathematics', 'priya.patel@email.com', '9988776655', '456 Elm St, Mumbai', '1999-04-22', 'Female', 'Mathematics', 4.0, 'A'),
    ('Amit Kumar', 'History', 'amit.kumar@email.com', '9876541230', '789 Oak St, Kolkata', '1997-11-05', 'Male', 'History', 3.5, 'B'),
    ('Sneha Gupta', 'Physics', 'sneha.gupta@email.com', '9876549876', '321 Cedar St, Chennai', '1999-03-14', 'Female', 'Physics', 4.2, 'A'),
    ('Vikas Sharma', 'Chemistry', 'vikas.sharma@email.com', '7890123456', '456 Oak St, Bangalore', '1998-05-27', 'Male', 'Chemistry', 3.3, 'B'),
    ('Anjali Singh', 'Economics', 'anjali.singh@email.com', '7890123000', '123 Elm St, Mumbai', '2000-01-08', 'Female', 'Economics', 3.9, 'A'),
    ('Rohit Verma', 'Political Science', 'rohit.verma@email.com', '9876545678', '456 Pine St, Delhi', '1996-09-18', 'Male', 'Political Science', 3.7, 'B'),
    ('Kavita Gupta', 'Engineering', 'kavita.gupta@email.com', '7890012345', '234 Maple St, Bangalore', '1997-06-30', 'Female', 'Mechanical Engineering', 3.5, 'B'),
    ('Sanjay Patel', 'Business Administration', 'sanjay.patel@email.com', '9988776655', '567 Cedar St, Mumbai', '1999-12-10', 'Male', 'Business Administration', 3.8, 'A'),
    ('Sarika Sharma', 'Psychology', 'sarika.sharma@email.com', '9876541230', '345 Oak St, Kolkata', '1998-04-02', 'Female', 'Psychology', 4.1, 'A');

-- 3. Student Information Retrieval
-- Retrieve all students' information and sort by grade in descending order
SELECT * FROM student_table ORDER BY grade DESC;

-- 4. Query for Male Students
-- Retrieve information about all male students
SELECT * FROM student_table WHERE gender = 'Male';

-- 5. Query for Students with GPA less than 5.0
-- Fetch details of students with GPA less than 5.0
SELECT * FROM student_table WHERE gpa < 5.0;

-- 6. Update Student Email and Grade
-- Update email and grade for a specific student (e.g., student with student_id 1)
UPDATE student_table
SET email_id = 'newemail@email.com', grade = 'A'
WHERE student_id = 1;

-- 7. Query for Students with Grade "B"
-- Retrieve names and ages of students with grade "B"
SELECT stu_name, EXTRACT(YEAR FROM age(date_of_birth)) AS age
FROM student_table
WHERE grade = 'B';

-- 8. Grouping and Calculation
-- Group by Department and Gender, calculate average GPA
SELECT department, gender, AVG(gpa) AS average_gpa
FROM student_table
GROUP BY department, gender;

-- 9. Table Renaming
-- Rename the student_table to student_info
ALTER TABLE student_table RENAME TO student_info;

-- 10. Retrieve Student with Highest GPA
-- Retrieve the name of the student with the highest GPA
SELECT stu_name
FROM student_info
WHERE gpa = (SELECT MAX(gpa) FROM student_info);