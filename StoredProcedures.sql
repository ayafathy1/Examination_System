------------Stored Procedures---------
--========= 1 =========--
--SP to assign a course to an instructor in a specific intake

-- Creation of the stored procedure and required variables
go
Create or alter procedure Assign_Instructor_To_Course 
    @CourseID int,
    @InstructorID int,
	@Intake_id int
as
begin

-- Check for the cource id to avoide replication
     if not exists (select 1 from Course where Crs_ID = @CourseID)
    begin
        select ('Course does not exist.');
        return;
    end
-- Check for the instructor id to avoide replication
    if not exists (select 1 from Instructor where Ins_ID = @InstructorID)
    begin
        select ('Instructor does not exist.');
        return;
    end
-- Check for the intake id to avoide replication
	if not exists (select 1 from Intake where ID = @Intake_id)
    begin
        select ('Intake is not valid.');
        return;
    end
-- check that course id, instructor id, and intake are not inserted before
    if exists (select 1 from Crs_Inst_Intake
               where Ins_ID = @InstructorID and Crs_ID = @CourseID and Intake_ID= @Intake_id)
    begin
        select ('Instructor already assigned to this course in the same intake.')
        
    end
-- insertion in Crs_Inst_Intake table
    insert into Crs_Inst_Intake (Crs_ID, Ins_ID, Intake_ID)
    values (@CourseID,@InstructorID ,@Intake_id)
end


--============ 2 ==================
--SP to view exam details based on student ID
go
create or alter procedure view_student_exams
    @studentid int
as
begin
    
    -- check if the student exists
    if not exists (select 1 from student where st_id = @studentid)
    begin
        select 'there is no student with this id.' as message;
        return;
    end

    -- check if student has exams
    if not exists (
        select 1
        from stu_exam_qup seq
        inner join exam e on seq.ex_id = e.ex_id
        where seq.st_id = @studentid
    )
    begin
        select 'this student has no exams yet.' as message;
        return;
    end

    -- Return exams if found
    if exists (
        select 1
        from stu_exam_qup seq
        inner join exam e on seq.ex_id = e.ex_id
        where seq.st_id = @studentid
    )
    begin
        select distinct
            e.ex_id,
            c.crs_name,
            e.date,
            e.start_time,
            e.end_time,
            e.exam_status
        from stu_exam_qup seq
        inner join exam e on seq.ex_id = e.ex_id
        inner join course c on e.crs_id = c.crs_id
        where seq.st_id = @studentid
        order by e.date desc, e.start_time desc;
    end
end;
go


execute View_Student_Exams 1000
--============ 3 ==================
------Training Manager can assign instructor to a branch in an intake---------
use Examination_System_Data
go
CREATE or ALTER PROCEDURE SP_AssignInstructorToBranchIntake
    @InstructorID INT,
    @BranchID INT,
    @IntakeID INT
AS
BEGIN
    -- Prevent duplicates here we check that this instructor in not assigned before 
    IF NOT EXISTS (
        SELECT 1 
        FROM Intake_Ins_Branch
        WHERE Ins_ID = @InstructorID
          AND Bran_ID = @BranchID
          AND Intake_ID = @IntakeID
    )
    BEGIN
        INSERT INTO Intake_Ins_Branch (Ins_ID, Bran_ID, Intake_ID)
        VALUES (@InstructorID, @BranchID, @IntakeID);
    END
    ELSE
    BEGIN
        PRINT 'Instructor is already assigned to this Branch and Intake.';
    END
END;
GO

--============ 4 ==================
----Instructor can view the grades of all the students in the courses he/she taught----
Go
CREATE OR ALTER PROCEDURE SP_ViewStudentGradesByInstructor
    @InstructorID INT,
    @ExamID INT
AS
BEGIN
   
   -- Check if the instructor created this exam
    IF NOT EXISTS (
        SELECT 1 
        FROM Exam 
        WHERE Ex_ID = @ExamID 
        AND Ins_ID = @InstructorID
    )
    BEGIN
        -- Use PRINT statement instead of RAISERROR
        PRINT 'Instructor with ID ' + CAST(@InstructorID AS NVARCHAR(10)) + 
              ' is not the creator of Exam ID ' + CAST(@ExamID AS NVARCHAR(10)) + 
              '.Can not access the grade report to that exam.';
        RETURN; -- Exit the procedure
    END



    -- Simple direct query to verify data exists
    SELECT 
        st.ST_ID,
        st.ST_Name,
        c.Crs_ID,
        c.Crs_Name,
        SUM(ISNULL(seq.Score, 0)) AS TotalGrade,
        c.Max_Deg AS CourseMaxDegree,
        CASE 
            WHEN SUM(ISNULL(seq.Score, 0)) < 0.6 * c.Max_Deg 
            THEN 'Needs Corrective Exam' 
            ELSE 'Passed' 
        END AS Status
    FROM Stu_Exam_QUP seq
    INNER JOIN Student st ON st.ST_ID = seq.ST_ID
    INNER JOIN Exam e ON e.Ex_ID = seq.Ex_ID
    INNER JOIN Course c ON c.Crs_ID = e.Crs_ID
    WHERE seq.Ex_ID = @ExamID 
      AND e.Ins_ID = @InstructorID
    GROUP BY st.ST_ID, st.ST_Name, c.Crs_ID, c.Crs_Name, c.Max_Deg
    ORDER BY st.ST_Name;
END;
GO



--============ 5 ==================
-------Instructor creates Exam , the questions are chosen randmoly by the system-------
Go
CREATE OR ALTER PROCEDURE SP_CreateExamByInstructor
    @Ins_ID INT,
    @Crs_ID INT,
    @ExamDate DATE,  
    @StartTime TIME,
    @EndTime TIME,
    @Branch_ID INT,
    @Intake_ID INT,
    @Track_ID INT,
    @NumQuestions INT,
    @IsCorrective BIT
AS
BEGIN
  
    DECLARE @ExamID INT;
    DECLARE @StartDateTime DATETIME = CAST(@ExamDate AS DATETIME) + CAST(@StartTime AS DATETIME);
    DECLARE @EndDateTime DATETIME = CAST(@ExamDate AS DATETIME) + CAST(@EndTime AS DATETIME);

    -- Validate instructor can create exam for this course and intake
    IF NOT EXISTS (
        SELECT 1 FROM Crs_Inst_Intake 
        WHERE Crs_ID = @Crs_ID AND Ins_ID = @Ins_ID AND Intake_ID = @Intake_ID
    )
    BEGIN
        PRINT 'Instructor is not assigned to teach this course for the specified intake.';
        RETURN;
    END

    -- Validate track belongs to the correct course
    IF NOT EXISTS (
        SELECT 1 FROM Track_Crs 
        WHERE Track_ID = @Track_ID AND Crs_ID = @Crs_ID
    )
    BEGIN
        PRINT 'The specified track does not include this course.';
        RETURN;
    END

    -- Validate exam duration (must be exactly 1 or 2 hours)
IF DATEDIFF(MINUTE, @StartDateTime, @EndDateTime) NOT IN (60, 120)
BEGIN
    PRINT 'Exam duration must be exactly 1 hour (60 minutes) or 2 hours (120 minutes).';
    RETURN;
END
    -- Check if a normal exam already exists for this course (to prevent unique index violation)
    IF @IsCorrective = 0 AND EXISTS (
        SELECT 1 FROM Exam 
        WHERE Crs_ID = @Crs_ID AND Corrective = 0 AND Intake_ID = @Intake_ID
    )
    BEGIN
        PRINT 'A normal exam already exists for this course and intake. Cannot create another normal exam. Consider creating a corrective exam instead.';
        RETURN;
    END

    BEGIN TRY
        -- Insert the new exam with all required foreign keys
        INSERT INTO Exam (
            [Date], 
            Start_time, 
            End_time, 
            Corrective, 
            Bran_ID, 
            Crs_ID, 
            Intake_ID, 
            Ins_ID, 
            Track_ID,
            Exam_Status
        )
        VALUES (
            @ExamDate, 
            @StartDateTime, 
            @EndDateTime, 
            @IsCorrective, 
            @Branch_ID, 
            @Crs_ID, 
            @Intake_ID, 
            @Ins_ID, 
            @Track_ID,
            'Scheduled'
        );

        -- Get the newly created exam ID
        SET @ExamID = SCOPE_IDENTITY();

        -- Select random questions from the question pool for this course
        INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order)
        SELECT 
            @ExamID, 
            Qu_ID, 
            ROW_NUMBER() OVER (ORDER BY NEWID())
        FROM (
            SELECT TOP (@NumQuestions) Qu_ID
            FROM Qu_Pool
            WHERE Crs_ID = @Crs_ID
            ORDER BY NEWID()
        ) AS RandomQuestions;

        -- Also link the questions to the instructor in Inst_Exam_QuP
        INSERT INTO Inst_Exam_QuP (Ins_ID, Ex_ID, Qu_ID)
        SELECT @Ins_ID, @ExamID, Question_ID
        FROM Exam_Questions
        WHERE Exam_ID = @ExamID;

        -- Return exam details with questions
        SELECT 
            @ExamID AS ExamID, 
            eq.Question_ID,
            q.Body,
            q.Type,
            q.Degree,
            eq.Question_Order
        FROM Exam_Questions eq
        INNER JOIN Qu_Pool q ON eq.Question_ID = q.Qu_ID
        WHERE eq.Exam_ID = @ExamID
        ORDER BY eq.Question_Order;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error occurred: ' + @ErrorMessage;
    END CATCH
END;
GO


--============ 6 ==================
---------------------SP_AutoAssignCorrectiveExams----------------------
CREATE OR ALTER PROCEDURE AutoAssignCorrectiveExams
    @DaysAfterOriginal INT = 7 
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF OBJECT_ID('tempdb..#FailedStudents') IS NOT NULL
            DROP TABLE #FailedStudents;

        CREATE TABLE #FailedStudents (
            StudentID INT,
            OriginalExamID INT,
            CourseID INT,
            TrackID INT,
            BranchID INT,
            IntakeID INT,
            InstructorID INT,
            OriginalExamDate DATE,
            PlannedCorrectiveDate DATE
        );

        INSERT INTO #FailedStudents (
            StudentID, OriginalExamID, CourseID, TrackID, BranchID, IntakeID, InstructorID, OriginalExamDate
        )
        SELECT 
            seq.ST_ID,
            e.Ex_ID,
            e.Crs_ID,
            e.Track_ID,
            e.Bran_ID,
            e.Intake_ID,
            e.Ins_ID,
            e.Date
        FROM 
            Stu_Exam_QUP seq
        INNER JOIN 
            Exam e ON seq.Ex_ID = e.Ex_ID
        WHERE 
            e.Corrective = 0 
            AND e.Exam_Status = 'Completed' 
            AND NOT EXISTS (
                SELECT 1 
                FROM Exam_Corrective ec 
                WHERE ec.Original_Exam_ID = e.Ex_ID 
                AND ec.Student_ID = seq.ST_ID
                AND (ec.Is_Completed = 1 OR ec.Corrective_Date >= GETDATE())
            )
        GROUP BY 
            seq.ST_ID, e.Ex_ID, e.Crs_ID, e.Track_ID, e.Bran_ID, e.Intake_ID, e.Ins_ID, e.Date
        HAVING 
            SUM(ISNULL(seq.Score, 0)) < (SELECT Min_Deg FROM Course WHERE Crs_ID = e.Crs_ID); -- ??????? ??? ?? ???? ??????

        UPDATE #FailedStudents
        SET PlannedCorrectiveDate = DATEADD(DAY, @DaysAfterOriginal, OriginalExamDate);

        INSERT INTO Exam_Corrective (
            Original_Exam_ID, 
            Student_ID, 
            Corrective_Date, 
            Start_time, 
            End_time, 
            Is_Completed, 
            Score
        )
        SELECT 
            OriginalExamID,
            StudentID,
            PlannedCorrectiveDate,
            CAST(PlannedCorrectiveDate AS DATETIME) + CAST('10:00:00' AS DATETIME),
            CAST(PlannedCorrectiveDate AS DATETIME) + CAST('12:00:00' AS DATETIME),
            0, 
            NULL 
        FROM 
            #FailedStudents;

        SELECT 
            fs.StudentID,
            s.ST_Name AS StudentName,
            fs.OriginalExamID,
            c.Crs_Name AS CourseName,
            fs.PlannedCorrectiveDate AS CorrectiveExamDate,
            CONCAT(FORMAT(CAST('10:00:00' AS DATETIME), N'hh:mm tt'), ' - ', 
                   FORMAT(CAST('12:00:00' AS DATETIME), N'hh:mm tt')) AS ExamTime
        FROM 
            #FailedStudents fs
        INNER JOIN 
            Student s ON fs.StudentID = s.ST_ID
        INNER JOIN 
            Course c ON fs.CourseID = c.Crs_ID
        ORDER BY 
            fs.PlannedCorrectiveDate, s.ST_Name;

        PRINT 'has been scheduled ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' Successful remedial examination.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO




EXEC AutoAssignCorrectiveExams;

EXEC AutoAssignCorrectiveExams @DaysAfterOriginal = 10;
go
--============ 7 ==================
-- Create a procedure to manually assign students to specific courses
CREATE or alter PROCEDURE SP_Assign_Student_To_Course
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    BEGIN TRY
        -- Check if student exists
        IF NOT EXISTS (SELECT 1 FROM Student WHERE ST_ID = @StudentID)
        BEGIN
            RAISERROR('Student does not exist.', 16, 1);
            RETURN;
        END
        
        -- Check if course exists
        IF NOT EXISTS (SELECT 1 FROM Course WHERE Crs_ID = @CourseID)
        BEGIN
            RAISERROR('Course does not exist.', 16, 1);
            RETURN;
        END
        
        -- Get student's track
        DECLARE @TrackID INT;
        SELECT @TrackID = Track_ID FROM Student WHERE ST_ID = @StudentID;
        
        -- Check if course is already in student's track
        IF NOT EXISTS (
            SELECT 1 FROM Track_Crs 
            WHERE Track_ID = @TrackID AND Crs_ID = @CourseID
        )
        BEGIN
            -- Add course to student's track
            INSERT INTO Track_Crs (Track_ID, Crs_ID)
            VALUES (@TrackID, @CourseID);
            
            PRINT 'Course successfully added to student''s track.';
        END
        ELSE
        BEGIN
            PRINT 'Course is already in student''s track.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

--============ 8 ==================
--Assign student to track
CREATE Or ALTER PROCEDURE SP_Assign_Students_To_Track
    @StudentIDs NVARCHAR(MAX), -- Comma-separated list of student IDs
    @TrackID INT
AS
BEGIN
    BEGIN TRY
        -- Check if track exists
        IF NOT EXISTS (SELECT 1 FROM Track WHERE Track_ID = @TrackID)
        BEGIN
            RAISERROR('Track does not exist.', 16, 1);
            RETURN;
        END
        
        -- Create temporary table to hold student IDs
        CREATE TABLE #TempStudents (ST_ID INT);
        
        -- Parse comma-separated string and insert into temp table
        INSERT INTO #TempStudents (ST_ID)
        SELECT value FROM STRING_SPLIT(@StudentIDs, ',');
        
        -- Check if all students exist
        IF EXISTS (
            SELECT 1 FROM #TempStudents ts
            WHERE NOT EXISTS (SELECT 1 FROM Student s WHERE s.ST_ID = ts.ST_ID)
        )
        BEGIN
            RAISERROR('One or more students do not exist.', 16, 1);
            RETURN;
        END
        
        -- Update students' track
        UPDATE s
        SET s.Track_ID = @TrackID
        FROM Student s
        INNER JOIN #TempStudents ts ON s.ST_ID = ts.ST_ID;
        
        PRINT 'Students successfully assigned to track.';
        
        -- Display assigned students
        SELECT 
            s.ST_ID,
            s.ST_Name,
            s.Email,
            t.Track_Name AS New_Track
        FROM Student s
        INNER JOIN Track t ON s.Track_ID = t.Track_ID
        INNER JOIN #TempStudents ts ON s.ST_ID = ts.ST_ID;
        
        -- Clean up
        DROP TABLE #TempStudents;
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
        -- Clean up in case of error
        IF OBJECT_ID('tempdb..#TempStudents') IS NOT NULL
            DROP TABLE #TempStudents;
    END CATCH
END;
GO


--============ 9 ==================
-------------creating exam with Manual question assignment ---------------------------
-- Creates an exam and attaches the first 20 questions of the course (by Qu_ID)
CREATE OR ALTER PROC SP_CreateExamWithManualQuestions
  @Date       date,
  @Start_time datetime2(0),
  @End_time   datetime2(0),
  @Corrective bit,
  @Bran_ID    int,
  @Crs_ID     int,
  @Intake_ID  int,
  @Ins_ID     int,
  @Track_ID   int
AS
BEGIN
  SET NOCOUNT ON;

  IF DATEDIFF(MINUTE, @Start_time, @End_time) <= 0
  BEGIN
    RAISERROR('End_time must be greater than Start_time.', 16, 1);
    RETURN;
  END;

  IF (SELECT COUNT(*) FROM Qu_Pool WHERE Crs_ID = @Crs_ID) < 20
  BEGIN
    RAISERROR('Need at least 20 questions in Qu_Pool for this course.', 16, 1);
    RETURN;
  END;

  -- 1) create exam
  INSERT INTO Exam ([Date], Start_time, End_time, Corrective, Bran_ID, Crs_ID, Intake_ID, Ins_ID, Track_ID)
  VALUES (@Date, @Start_time, @End_time, @Corrective, @Bran_ID, @Crs_ID, @Intake_ID, @Ins_ID, @Track_ID);

  DECLARE @Ex_ID int = SCOPE_IDENTITY();

  -- 2) pick 20 questions (deterministic by Qu_ID) and attach in order 1..20
  DECLARE @Picked TABLE(Qu_ID int NOT NULL, Question_Order int NOT NULL);

  INSERT INTO @Picked(Qu_ID, Question_Order)
  SELECT Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID)
  FROM (
    SELECT TOP (20) Qu_ID
    FROM Qu_Pool
    WHERE Crs_ID = @Crs_ID
    ORDER BY Qu_ID
  ) x;

  INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order)
  SELECT @Ex_ID, Qu_ID, Question_Order
  FROM @Picked
  ORDER BY Question_Order;

  -- 3) outputs:  exam header & the 20 attached questions
  SELECT e.Ex_ID   AS NewExamID,
         e.Crs_ID, e.Bran_ID, e.Track_ID,
         e.[Date], e.Start_time, e.End_time
  FROM Exam e
  WHERE e.Ex_ID = @Ex_ID;

  SELECT p.Question_Order, q.Qu_ID, q.Type, q.Body
  FROM @Picked p
  JOIN Qu_Pool q ON q.Qu_ID = p.Qu_ID
  ORDER BY p.Question_Order;
END
GO

-- Test 
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

--=========================================================================================================
---------------- Assign Exam to Student --------------------
go
CREATE OR ALTER PROC SP_AssignExamToStudents  --show students who should take a specific exam (show by exam)
    @Ex_ID INT
AS
BEGIN
    -- preview of the exam’s targeting 
    SELECT Ex_ID, Track_ID, Intake_ID, Bran_ID
    FROM Exam
    WHERE Ex_ID = @Ex_ID;

    -- Students who match the exam’s Branch + Track + Intake
    SELECT
        s.ST_ID,
        s.ST_Name,
        s.User_Name,
        s.Email,
        s.Intake_ID,
        s.Track_ID,
        s.Bran_ID
    FROM Student s
    JOIN Exam e ON e.Ex_ID = @Ex_ID
    WHERE s.Track_ID = e.Track_ID
      AND s.Intake_ID = e.Intake_ID
      AND s.Bran_ID = e.Bran_ID
    ORDER BY s.ST_Name;
END
GO

EXEC SP_AssignExamToStudents @Ex_ID = 3  
EXEC SP_AssignExamToStudents @Ex_ID = 2

--============= 11 ================
----Get student exam results
go
Create Or ALTER PROCEDURE SP_GetStudentExamResult
    @StudentID INT,
    @ExamID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- First, validate existence of Student and Exam
    IF NOT EXISTS (SELECT 1 FROM Student WHERE ST_ID = @StudentID)
    BEGIN
        RAISERROR('Error: Invalid Student ID.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Ex_ID = @ExamID)
    BEGIN
        RAISERROR('Error: Invalid Exam ID.', 16, 1);
        RETURN;
    END

    -- Check if the student has any answers for this specific exam
    IF NOT EXISTS (SELECT 1 FROM Stu_Exam_QUP WHERE ST_ID = @StudentID AND Ex_ID = @ExamID)
    BEGIN
        RAISERROR('Error: This student did not take this exam.', 16, 1);
        RETURN;
    END

    -- If the student took the exam, proceed to calculate and display the grade
    SELECT
        S.ST_Name AS StudentName,
        E.Ex_ID AS ExamID,
        C.Crs_Name AS CourseName,
        SUM(SEQP.Score) AS TotalGrade
    FROM
        Student AS S
    JOIN
        Exam AS E ON E.Ex_ID = @ExamID
    JOIN
        Course AS C ON E.Crs_ID = C.Crs_ID
    JOIN
        Stu_Exam_QUP AS SEQP ON S.ST_ID = SEQP.ST_ID AND E.Ex_ID = SEQP.Ex_ID
    WHERE
        S.ST_ID = @StudentID
    GROUP BY
        S.ST_Name, E.Ex_ID, C.Crs_Name;

END;
GO