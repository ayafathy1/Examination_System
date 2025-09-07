--------------------- Triggers ---------------------
--------------------- TR_Student_PreventDelete ---------------------
go
CREATE TRIGGER TR_Student_PreventDelete
ON Student
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM deleted d INNER JOIN Stu_Exam_QUP seq ON d.ST_ID = seq.ST_ID)
    BEGIN
        RAISERROR('Cannot delete student. Student has exam records.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Student WHERE ST_ID IN (SELECT ST_ID FROM deleted);
    END
END;
GO
--------------------- TR_Student_PreventDelete ---------------------
DELETE FROM Student WHERE ST_ID = 1; 

--------------------- TR_Student_PreventDelete ---------------------
DELETE FROM Student WHERE ST_ID = 20;

------------------------------------------------------------------------------
--------------------- TR_Stu_Exam_QUP_ValidateDegree ---------------------
go
CREATE TRIGGER TR_Stu_Exam_QUP_ValidateDegree
ON Stu_Exam_QUP
INSTEAD OF INSERT, UPDATE  
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted WHERE Score <> 5)
    BEGIN
        RAISERROR('Student score must be exactly 5 for each question.', 16, 1);
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM inserted WHERE Score = 5)
    BEGIN
        IF EXISTS (SELECT 1 FROM deleted)
        BEGIN
            UPDATE seq
            SET seq.Score = i.Score
            FROM Stu_Exam_QUP seq
            INNER JOIN inserted i ON seq.ST_ID = i.ST_ID 
                AND seq.Ex_ID = i.Ex_ID 
                AND seq.Qu_ID = i.Qu_ID;
        END
        ELSE
        BEGIN
            INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score)
            SELECT ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score
            FROM inserted;
        END
    END
END;
GO

SELECT Qu_ID, Degree FROM Qu_Pool WHERE Qu_ID = 6;

INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score)
VALUES (1, 1, 40, 2, NULL, 7); 

--------------------- TR_Stu_Exam_QUP_ValidateDegree ---------------------
INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score)
VALUES (1, 1, 40, 2, NULL, 5); 


UPDATE Stu_Exam_QUP SET Score = 3 WHERE ST_ID = 1 AND Ex_ID = 1 AND Qu_ID = 1;

UPDATE Stu_Exam_QUP SET Score = 8 WHERE ST_ID = 1 AND Ex_ID = 1 AND Qu_ID = 1;

--------------------------------------------------------------------------------------------

--------------------- TR_Qu_Pool_PreventDelete ---------------------
go
CREATE TRIGGER TR_Qu_Pool_PreventDelete
ON Qu_Pool
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM deleted d 
               INNER JOIN Exam_Questions eq ON d.Qu_ID = eq.Question_ID)
    BEGIN
        RAISERROR('Cannot delete question. Question is used in exams.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Choices WHERE Qu_ID IN (SELECT Qu_ID FROM deleted);
        DELETE FROM Qu_Pool WHERE Qu_ID IN (SELECT Qu_ID FROM deleted);
    END
END;
GO
-------------------------------
SELECT TOP 2 q.Qu_ID, q.Body, eq.Exam_ID
FROM Qu_Pool q
INNER JOIN Exam_Questions eq ON q.Qu_ID = eq.Question_ID;


--------------------- TR_Qu_Pool_PreventDelete ---------------------
DELETE FROM Qu_Pool WHERE Qu_ID = 2; 


INSERT INTO Qu_Pool (Body, Type, Degree, Crs_ID)
VALUES ('Test Question for Trigger', 'MCQ', 5, 1);

DECLARE @NewQuestionID INT = SCOPE_IDENTITY();
PRINT 'New Question ID: ' + CAST(@NewQuestionID AS VARCHAR);

INSERT INTO Choices (Body, Is_Correct, Qu_ID)
VALUES 
('Correct Answer', 1, @NewQuestionID),
('Wrong Answer 1', 0, @NewQuestionID),
('Wrong Answer 2', 0, @NewQuestionID),
('Wrong Answer 3', 0, @NewQuestionID);

DELETE FROM Qu_Pool WHERE Qu_ID = @NewQuestionID;

-------------------------------------------------------------------------

--------------------- TR_Exam_Corrective_ValidateDate ---------------------
go
CREATE TRIGGER TR_Exam_Corrective_ValidateDate
ON Exam_Corrective
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted i 
               INNER JOIN Exam e ON i.Original_Exam_ID = e.Ex_ID
               WHERE i.Corrective_Date <= e.Date)
    BEGIN
        RAISERROR('Corrective exam date must be after the original exam date.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

------ TR_Exam_Corrective_ValidateDate ---------
SELECT Ex_ID, [Date], Crs_Name 
FROM Exam e
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID;
----------------------
------ TR_Exam_Corrective_ValidateDate ---------
INSERT INTO Exam_Corrective (Original_Exam_ID, Student_ID, Corrective_Date, Start_time, End_time, Is_Completed, Score)
VALUES (1, 5, '2025-01-15', '2025-01-15 10:00:00', '2025-01-15 12:00:00', 1, 85);

PRINT 'The corrective exam was entered successfully.!';

-------------
BEGIN TRY
    INSERT INTO Exam_Corrective (Original_Exam_ID, Student_ID, Corrective_Date, Start_time, End_time, Is_Completed, Score)
    VALUES (1, 5, '2024-12-10', '2024-12-10 10:00:00', '2024-12-10 12:00:00', 1, 85);
    
    PRINT 'The corrective exam was entered successfully.!';
END TRY
BEGIN CATCH
    PRINT ' Error : ' + ERROR_MESSAGE();
END CATCH

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-------------Count Degrees of the exam (must be 100)-----------------------
go
create or alter trigger trg_check_exam_total_degrees
on Inst_Exam_QuP
after insert, update, delete
as
begin
    
    if exists (
        select ins.Ex_ID
        from Qu_Pool qp
        join Inst_Exam_QuP ins on qp.Qu_ID = ins.Qu_ID
        group by ins.Ex_ID
        having sum(qp.Degree) <> 100
    )
    begin
        rollback;
        select ( 'count of the questions degrees must be = 100');
    end
end;

--------------------------------------------------------------------------------------------------------------------
-------------------------  Enforce exam time window ----------------------

USE Examination_System_Data

----Trigger that prevents the student to answer outside the allowed time frame---
GO
drop trigger TRG_EnforceExamTimeWindow

go
CREATE OR ALTER TRIGGER TRG_EnforceExamTimeWindow
ON Stu_Exam_QUP
After INSERT
AS
BEGIN
    

    DECLARE @CurrentDateTime DATETIME = GETDATE();

    
    -- Check if exam is completed or cancelled
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Exam e ON i.Ex_ID = e.Ex_ID
        WHERE e.Exam_Status IN ('Completed', 'Cancelled')
    )
    BEGIN
        print('Cannot submit answers to a completed or cancelled exam.');
        RETURN;
    END


	-- Check if any inserted answer is outside the exam time frame
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Exam e ON i.Ex_ID = e.Ex_ID
        WHERE @CurrentDateTime < e.Start_time OR @CurrentDateTime > e.End_time
    )
    BEGIN
        print('Cannot submit answers outside the exam time frame.');
        RETURN;
    END

END;
GO



