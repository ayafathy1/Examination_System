# Examination System Project
📌 Project Overview
The Examination System Database is a SQL Server project that manages the full exam lifecycle:

Creating exams
Assigning questions
Submitting student answers
Automatic grading
Calculating and reporting results
This project showcases advanced SQL Server programming with stored procedures, triggers, constraints, and views to ensure data integrity and automation.

⚙️ Exam Process Flow
Question Bank

Instructors create and manage a pool of questions (MCQ, True/False).
Each question is linked to a course and has a degree (mark).
Exam Creation

Exams are created and linked to courses, tracks, branches, and intakes.
Questions are assigned to exams (either manually or randomly).
Student Participation

Answers are recorded in Exam_Student_Questions_Answers.
Automatic Grading

Objective questions (MCQ, True/False) are graded automatically by comparing with the correct answer.
Marks are stored per question.
Result Calculation

Calculate_Result procedure sums correct answers and returns the student’s final score per exam.
SP_ViewStudentGradesByInstructor procedure gives instructors an overview of students grade in their course they taught for specific intake.

📊 Example Stored Procedures
Register_Student – Add new students.
Register_Instructor – Add new instructors.
Register_Course – Add new courses.
Calculate_Result – Calculate final score for a student in a specific exam.
CourseResult – Show student scores for a course taught by an instructor for specific intake.

🛠️ Technologies
Database: Microsoft SQL Server 2022
Language: T-SQL (DDL, DML, Stored Procedures, Triggers, Views)
Diagrams: ERD & Mapping

📂 Repository Structure
├── Data/                   # Inserted Data
├── Queries/                # SQL scripts (DDL, DML, Stored Procedures, Views, Triggers)
├── ERD-Mapping/            # ERD diagrams and mapping documents
├── Documentation/          # Project report (PDF)
└── README.md               # Project description

▶️ How to Use
Restore the database from the provided .bak file in SQL Server.
Run SQL scripts in Queries/ to create and test procedures, views, and triggers.
Use Calculate_Result and CourseResult to analyze exam outcomes.
Refer to Documentation/Examination System Documentation.pdf for full project details.

👥 Team Members
Ahmed Mohamed Reda Salah
Aya Fathy Moahmed Ibrahim
Manar Abdelmnam Elmeslmany
Mohamed Fayez Abdelatif Mabrouk
Mahmoud Mohamed Ahmed Salama 

Supervised By: Eng. Sarah Salah

📅 Date
August 2025
