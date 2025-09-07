---------------Stores procedures Execution---------------------
--========= 1 =========
--SP to assign a course to an instructor in a specific intake
execute Assign_Instructor_To_Course 10,5,3

select * from Crs_Inst_Intake

--========= 2 =========
--SP to view exam details based on student ID
execute View_Student_Exams 1000


select * from Exam
select * from Stu_Exam_QUP

--========= 3 =========
------Training Manager can assign instructor to a branch in an intake---------
EXEC SP_AssignInstructorToBranchIntake @InstructorID = 5, @BranchID = 2, @IntakeID = 3;


--============ 4 ==================
----Instructor can view the grades of all the students in the courses he/she taught----
-- Here we put Instructor ID(2) , Exam ID(3), so instructor can see the grades of each student assigned to the course he taught
EXEC SP_ViewStudentGradesByInstructor @InstructorID = 2, @ExamID = 3;

-- Here we put Instructor ID(3) , Exam ID(1), so instructor can see the grades of each student assigned to the course he taught
EXEC SP_ViewStudentGradesByInstructor @InstructorID = 3, @ExamID = 1;

EXEC SP_ViewStudentGradesByInstructor @InstructorID = 3, @ExamID = 2;


--============ 5 ==================
-------Instructor creates Exam , the questions are chosen randmoly by the system-------
-- instructor puts the data that he wants to create the the normal exam 
-- Create a normal exam for Instructor 2 (CS) for Python Basics course
EXEC SP_CreateExamByInstructor 
    @Ins_ID = 2,
    @Crs_ID = 3,          -- Python Basics
    @ExamDate = '2024-12-25',
    @StartTime = '10:00:00',
    @EndTime = '11:00:00', -- 1 hour duration
    @Branch_ID = 1,
    @Intake_ID = 2,       -- 2024 intake
    @Track_ID = 2,        -- Python Backend Development Track
    @NumQuestions = 20,
    @IsCorrective = 1;


--============ 6 ==================
---------------------SP_AutoAssignCorrectiveExams----------------------



EXEC AutoAssignCorrectiveExams;

EXEC AutoAssignCorrectiveExams @DaysAfterOriginal = 10;

--============ 7 ==================
-- Create a procedure to manually assign students to specific courses
select * from student
select * from Course
select * from Track
select * from Track_Crs

EXEC SP_Assign_Student_To_Course @StudentID = 1, @CourseID = 4;


--============ 8 ==================
--Assign student to track
select * from Track
select * from Student

EXEC SP_Assign_Students_To_Track @StudentIDs = '1', @TrackID = 2;

EXEC SP_Assign_Students_To_Track @StudentIDs = '1,2,3,4,5', @TrackID = 3;


--============ 9 ==================
-------------creating exam with Manual question assignment ---------------------------
EXEC SP_CreateExamWithManualQuestions
  @Date       = '2025-09-15',
  @Start_time = '2025-09-15T10:00:00',  
  @End_time   = '2025-09-15T12:00:00',
  @Corrective = 0,
  @Bran_ID    = 1,
  @Crs_ID     = 7,
  @Intake_ID  = 3,
  @Ins_ID     = 9,
  @Track_ID   = 2;


--============= 10 ================
---------------- Assign Exam to Student --------------------
EXEC SP_AssignExamToStudents @Ex_ID = 3
EXEC SP_AssignExamToStudents @Ex_ID = 4



--============= 11 ================
----Get student exam results
EXEC SP_GetStudentExamResult 1,1


