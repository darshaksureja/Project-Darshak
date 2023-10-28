-- 1. Database Creation
-- Create the tables
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(50),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(50),
    ADDRESS VARCHAR(100)
);

CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(50),
    COURSE_INSTRUCTOR_NAME VARCHAR(50)
);

CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

-- 2. Data Creation
-- Insert sample data
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
    (1, 'Rahul Verma', '1998-08-15', '9876543215', 'rahul.verma@email.com', 'Delhi, India'),
    (2, 'Priya Patel', '1999-04-22', '7890123450', 'priya.patel@email.com', 'Mumbai, India'),
    (3, 'Amit Kumar', '1997-11-05', '9988776658', 'amit.kumar@email.com', 'Kolkata, India');

SELECT * FROM StudentInfo;

INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
    (101, 'Mathematics 101', 'Dr. Rajesh Seth'),
    (102, 'History 101', 'Dr. Sneha Gupta'),
    (103, 'Computer Science 101', 'Prof. Priyanka Sharma');

SELECT * FROM CoursesInfo;

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
    (1, 1, 101, 'Enrolled'),
    (2, 2, 101, 'Enrolled'),
    (3, 3, 103, 'Enrolled');
	
SELECT * FROM EnrollmentInfo;

-- 3. Retrieve Student Information
-- a. Retrieve student details
SELECT STU_NAME, PHONE_NO, EMAIL_ID, ENROLL_STATUS
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID;

-- b. List of courses for a specific student
SELECT CoursesInfo.COURSE_NAME
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
WHERE EnrollmentInfo.STU_ID = 1;

-- c. Retrieve course information
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

-- d. Course information for a specific course
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_NAME = 'Mathematics 101';

-- e. Course information for multiple courses
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_NAME IN ('Mathematics 101', 'History 101');

-- f. Test the queries by executing them

-- 4. Reporting and Analytics (using joining queries)
-- a. Number of students enrolled in each course
SELECT CoursesInfo.COURSE_NAME, COUNT(EnrollmentInfo.STU_ID) AS Num_Students
FROM CoursesInfo
LEFT JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
GROUP BY CoursesInfo.COURSE_NAME;

-- b. List of students enrolled in a specific course
SELECT StudentInfo.STU_NAME
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID
WHERE EnrollmentInfo.COURSE_ID = 101;

-- c. Count of enrolled students for each instructor
SELECT CoursesInfo.COURSE_INSTRUCTOR_NAME, COUNT(EnrollmentInfo.STU_ID) AS Num_Students
FROM CoursesInfo
LEFT JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
GROUP BY CoursesInfo.COURSE_INSTRUCTOR_NAME;

-- d. List of students enrolled in multiple courses
SELECT StudentInfo.STU_NAME, COUNT(EnrollmentInfo.STU_ID) AS Num_Courses
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID
GROUP BY StudentInfo.STU_NAME
HAVING COUNT(EnrollmentInfo.STU_ID) > 1;

-- e. Courses with the highest number of enrolled students
SELECT CoursesInfo.COURSE_NAME, COUNT(EnrollmentInfo.STU_ID) AS Num_Students
FROM CoursesInfo
LEFT JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
GROUP BY CoursesInfo.COURSE_NAME
ORDER BY Num_Students DESC;



