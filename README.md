# Student Registration System

## Project Overview
This project is a Student Registration System developed using PostgreSQL.
It stores student information, course details, and student enrollments.

## Database Management System
PostgreSQL

## Database Tables

### 1. Students
Stores student information:
- student_id (Primary Key)
- student_name
- email
- phone_number
- city
- scholarship_eligible

### 2. Courses
Stores course information:
- course_id (Primary Key)
- course_name
- fee

### 3. Enrollments
Stores student enrollment information:
- enrollment_id (Primary Key)
- student_id (Foreign Key)
- course_id (Foreign Key)
- enrollment_date
- grade

## Relationships
- One student can have multiple enrollments.
- One course can have multiple enrollments.
- The enrollments table connects students and courses.

## SQL Tasks
The assignment includes:
- SELECT queries
- JOIN queries
- UPDATE statements
- ALTER TABLE statements
- INSERT statements

## Entity Relationship Diagram (ERD)
The database structure is shown below.

![Student Registration System ERD](erd.png)

## Files
- assignment_iii.sql: SQL statements for the assignment.
- erd.png: Entity Relationship Diagram.

## Conclusion
This project demonstrates the use of PostgreSQL to create related tables, insert data, retrieve records, update information, and modify table structures