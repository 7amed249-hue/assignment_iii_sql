-- ASSIGNMENT III: SQL TABLE MANIPULATION
-- Project: Student Registration System
-- DBMS: PostgreSQL
-- Database: mohamed_202513467_student_system

-- ==================================================
-- SECTION 1: DATABASE CREATION
-- ==================================================

-- The database was created using pgAdmin 4.
-- CREATE DATABASE mohamed_202513467_student_system;


-- ==================================================
-- SECTION 2: TABLE CREATION
-- ==================================================

-- Table 1: Students
CREATE TABLE students (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(50)
);

-- Table 2: Courses
CREATE TABLE courses (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    fee NUMERIC(8,2) NOT NULL CHECK (fee >= 0)
);

-- Table 3: Enrollments
CREATE TABLE enrollments (
    enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(student_id),
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    enrollment_date DATE NOT NULL,
    grade NUMERIC(5,2)
);


-- ==================================================
-- SECTION 3: INITIAL DATA INSERTION
-- ==================================================

-- Insert 5 students
INSERT INTO students (student_name, email, phone, city)
VALUES
('John Peter', 'john@gmail.com', '0781000001', 'Kigali'),
('Mary James', 'mary@gmail.com', '0781000002', 'Kigali'),
('David Paul', 'david@gmail.com', '0781000003', 'Huye'),
('Sarah John', 'sarah@gmail.com', '0781000004', 'Musanze'),
('Peter Mark', 'peter@gmail.com', '0781000005', 'Kigali');

-- Insert 5 courses
INSERT INTO courses (course_name, fee)
VALUES
('Database Systems', 400),
('Programming', 500),
('Networking', 350),
('Web Development', 450),
('Computer Security', 600);

-- Insert 5 enrollments
INSERT INTO enrollments
(student_id, course_id, enrollment_date, grade)
VALUES
(1, 1, '2026-01-15', 80),
(2, 2, '2026-01-16', 75),
(3, 3, '2026-01-17', 90),
(4, 4, '2026-01-18', 85),
(5, 5, '2026-01-19', 70);

-- Verify initial records
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;


-- ==================================================
-- SECTION 4: SELECT TASKS
-- ==================================================

-- Q1.1: Basic Data Retrieval
SELECT student_name, email
FROM students;

-- Q1.2: Conditional Data Retrieval
SELECT *
FROM students
WHERE city = 'Kigali';

-- Q1.3: Sorted Data Retrieval
SELECT student_name, city
FROM students
ORDER BY student_name ASC;


-- ==================================================
-- SECTION 5: JOIN TASKS
-- ==================================================

-- Q2.1: INNER JOIN
SELECT students.student_name, courses.course_name
FROM enrollments
INNER JOIN students
ON enrollments.student_id = students.student_id
INNER JOIN courses
ON enrollments.course_id = courses.course_id;

-- Q2.2: LEFT JOIN
SELECT students.student_name, enrollments.course_id
FROM students
LEFT JOIN enrollments
ON students.student_id = enrollments.student_id;

-- Q2.3: Multi-Table JOIN
SELECT
    students.student_name,
    courses.course_name,
    enrollments.enrollment_date,
    enrollments.grade
FROM enrollments
INNER JOIN students
ON enrollments.student_id = students.student_id
INNER JOIN courses
ON enrollments.course_id = courses.course_id;


-- ==================================================
-- SECTION 6: UPDATE TASKS AND VERIFICATION
-- ==================================================

-- Q3.1: Update One Record
UPDATE students
SET city = 'Huye'
WHERE student_id = 1;

SELECT * FROM students
WHERE student_id = 1;

-- Q3.2: Update Multiple Records
UPDATE courses
SET fee = fee + 50
WHERE fee < 500;

SELECT * FROM courses
ORDER BY course_id;

-- Q3.3: Conditional Update
UPDATE enrollments
SET grade = grade + 5
WHERE grade < 75;

SELECT * FROM enrollments
ORDER BY enrollment_id;


-- ==================================================
-- SECTION 7: ALTER TABLE TASKS AND VERIFICATION
-- ==================================================

-- Q4.1: Rename phone to phone_number
ALTER TABLE students
RENAME COLUMN phone TO phone_number;

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'students'
ORDER BY ordinal_position;

SELECT * FROM students;

-- Q4.2: Change the fee data type
ALTER TABLE courses
ALTER COLUMN fee TYPE NUMERIC(10,2)
USING fee::NUMERIC(10,2);

SELECT course_name, fee
FROM courses;

-- Q4.3: Add a scholarship column
ALTER TABLE students
ADD COLUMN scholarship_eligible BOOLEAN DEFAULT FALSE;

SELECT * FROM students;


-- ==================================================
-- SECTION 8: ADDITIONAL INSERT TASKS
-- ==================================================

-- Q5.1: Insert a Single Student
INSERT INTO students
(student_name, email, phone_number, city)
VALUES
('Alice Brown', 'alice@gmail.com', '0781000006', 'Kigali');

SELECT * FROM students
WHERE email = 'alice@gmail.com';

-- Q5.2: Insert Multiple Courses
INSERT INTO courses (course_name, fee)
VALUES
('Artificial Intelligence', 700),
('Data Science', 650),
('Mobile Development', 550);

SELECT * FROM courses
ORDER BY course_id;

-- Q5.3: Insert a Related Enrollment
INSERT INTO enrollments
(student_id, course_id, enrollment_date, grade)
SELECT s.student_id, c.course_id, DATE '2026-10-26', NULL
FROM students s
CROSS JOIN courses c
WHERE s.email = 'alice@gmail.com'
AND c.course_name = 'Database Systems';

-- Verify the related enrollment
SELECT
    s.student_name,
    c.course_name,
    e.enrollment_date,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.email = 'alice@gmail.com'
AND c.course_name = 'Database Systems';


-- ==================================================
-- END OF ASSIGNMENT III
-- ==================================================