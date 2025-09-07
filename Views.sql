
CREATE VIEW v_QuestionPool 
AS
SELECT 
    q.Qu_ID,
    q.Body AS Question_Text,
    q.Type AS Question_Type,
    q.Degree AS Question_Degree,
    c.Crs_Name AS Course_Name,
    c.Crs_ID,
    COUNT(ch.Ch_ID) AS Choices_Count,
    SUM(CASE WHEN ch.Is_Correct = 1 THEN 1 ELSE 0 END) AS Correct_Choices_Count
FROM Qu_Pool q
INNER JOIN Course c ON q.Crs_ID = c.Crs_ID
LEFT JOIN Choices ch ON q.Qu_ID = ch.Qu_ID
GROUP BY q.Qu_ID, q.Body, q.Type, q.Degree, c.Crs_Name, c.Crs_ID;
GO

select * from v_QuestionPool
--------------------------------------------------------
GO
CREATE VIEW v_ExamSchedule 
AS
SELECT 
    e.Ex_ID AS Exam_ID,
    c.Crs_Name AS Course_Name,
    e.[Date] AS Exam_Date,
    e.Start_time,
    e.End_time,
    e.Exam_Status,
    b.Bran_Name AS Branch_Name,
    t.Track_Name,
    i.Ins_Name AS Instructor_Name,
    e.Corrective,
    DATEDIFF(MINUTE, e.Start_time, e.End_time) AS Duration_Minutes
FROM Exam e
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
INNER JOIN Branch b ON e.Bran_ID = b.Bran_ID
INNER JOIN Track t ON e.Track_ID = t.Track_ID
INNER JOIN Instructor i ON e.Ins_ID = i.Ins_ID;
GO

select * from v_ExamSchedule
------------------------------------------------------------------------------------
GO
CREATE VIEW v_ExamQuestions 
AS
SELECT 
    eq.Exam_ID,
    e.Crs_ID,
    c.Crs_Name,
    eq.Question_ID,
    q.Body AS Question_Text,
    q.Type AS Question_Type,
    q.Degree AS Question_Degree,
    eq.Question_Order,
    i.Ins_Name AS Question_Creator
FROM Exam_Questions eq
INNER JOIN Exam e ON eq.Exam_ID = e.Ex_ID
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
INNER JOIN Qu_Pool q ON eq.Question_ID = q.Qu_ID
LEFT JOIN Inst_Exam_QuP ieq ON eq.Exam_ID = ieq.Ex_ID AND eq.Question_ID = ieq.Qu_ID
LEFT JOIN Instructor i ON ieq.Ins_ID = i.Ins_ID;
GO

select * from v_ExamQuestions
------------------------------------------------------------------------------------
GO
CREATE VIEW v_ExamChoices 
AS
SELECT 
    eq.Exam_ID,
    eq.Question_ID,
    q.Body AS Question_Text,
    ch.Ch_ID AS Choice_ID,
    ch.Body AS Choice_Text,
    ch.Is_Correct,
    c.Crs_Name AS Course_Name
FROM Exam_Questions eq
INNER JOIN Qu_Pool q ON eq.Question_ID = q.Qu_ID
INNER JOIN Choices ch ON q.Qu_ID = ch.Qu_ID
INNER JOIN Exam e ON eq.Exam_ID = e.Ex_ID
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID;
GO

select * from v_ExamChoices
---------------------------------------------------------------------------------

GO
CREATE VIEW v_EligibleStudentsForExam 
AS
SELECT 
    e.Ex_ID AS Exam_ID,
    c.Crs_Name AS Course_Name,
    t.Track_Name,
    b.Bran_Name AS Branch_Name,
    s.ST_ID AS Student_ID,
    s.ST_Name AS Student_Name,
    s.User_Name AS Student_Username,
    s.Email AS Student_Email,
    i.Year AS Intake_Year
FROM Exam e
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
INNER JOIN Track t ON e.Track_ID = t.Track_ID
INNER JOIN Branch b ON e.Bran_ID = b.Bran_ID
INNER JOIN Student s ON e.Track_ID = s.Track_ID 
    AND e.Bran_ID = s.Bran_ID 
    AND e.Intake_ID = s.Intake_ID
INNER JOIN Intake i ON s.Intake_ID = i.ID
WHERE e.Exam_Status IN ('Scheduled', 'In Progress');
GO

select * from v_EligibleStudentsForExam
---------------------------------------------------------------------------------
GO
CREATE VIEW v_StudentAnswers 
AS
SELECT 
    seq.ST_ID AS Student_ID,
    s.ST_Name AS Student_Name,
    seq.Ex_ID AS Exam_ID,
    c.Crs_Name AS Course_Name,
    seq.Qu_ID AS Question_ID,
    q.Body AS Question_Text,
    q.Type AS Question_Type,
    seq.Answer_Ch_ID,
    ch.Body AS Choice_Answer,
    seq.Answer_TF AS TrueFalse_Answer,
    seq.Score,
    CASE 
        WHEN q.Type = 'MCQ' AND ch.Is_Correct = 1 THEN 'Correct'
        WHEN q.Type = 'MCQ' AND ch.Is_Correct = 0 THEN 'Incorrect'
        WHEN q.Type = 'True/False' THEN 
            CASE 
                WHEN (q.Qu_ID BETWEEN 101 AND 110 AND seq.Answer_TF = 1) OR 
                     (q.Qu_ID BETWEEN 111 AND 120 AND seq.Answer_TF = 1) OR
                     (q.Qu_ID BETWEEN 121 AND 130 AND seq.Answer_TF = 0) OR
                     (q.Qu_ID BETWEEN 131 AND 140 AND seq.Answer_TF = 1) OR
                     (q.Qu_ID BETWEEN 141 AND 150 AND seq.Answer_TF = 1) OR
                     (q.Qu_ID BETWEEN 151 AND 160 AND seq.Answer_TF = 0) OR
                     (q.Qu_ID BETWEEN 161 AND 170 AND seq.Answer_TF = 1) OR
                     (q.Qu_ID BETWEEN 171 AND 180 AND seq.Answer_TF = 1) OR
                     (q.Qu_ID BETWEEN 181 AND 190 AND seq.Answer_TF = 1) OR
                     (q.Qu_ID BETWEEN 191 AND 200 AND seq.Answer_TF = 0) THEN 'Correct'
                ELSE 'Incorrect'
            END
        ELSE 'Not Answered'
    END AS Answer_Status
FROM Stu_Exam_QUP seq
INNER JOIN Student s ON seq.ST_ID = s.ST_ID
INNER JOIN Exam e ON seq.Ex_ID = e.Ex_ID
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
INNER JOIN Qu_Pool q ON seq.Qu_ID = q.Qu_ID
LEFT JOIN Choices ch ON seq.Answer_Ch_ID = ch.Ch_ID;
GO

select * from v_StudentAnswers
---------------------------------------------------------------------------------

GO
CREATE VIEW v_ExamResultsByStudent 
AS
SELECT 
    s.ST_ID AS Student_ID,
    s.ST_Name AS Student_Name,
    s.User_Name AS Student_Username,
    e.Ex_ID AS Exam_ID,
    c.Crs_Name AS Course_Name,
    e.[Date] AS Exam_Date,
    SUM(seq.Score) AS Total_Score,
    c.Max_Deg AS Max_Degree,
    c.Min_Deg AS Min_Degree,
    CASE 
        WHEN SUM(seq.Score) >= c.Min_Deg THEN 'Pass'
        ELSE 'Fail'
    END AS Result,
    COUNT(seq.Qu_ID) AS Questions_Count,
    AVG(seq.Score) AS Average_Score_Per_Question
FROM Student s
INNER JOIN Stu_Exam_QUP seq ON s.ST_ID = seq.ST_ID
INNER JOIN Exam e ON seq.Ex_ID = e.Ex_ID
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
GROUP BY s.ST_ID, s.ST_Name, s.User_Name, e.Ex_ID, c.Crs_Name, e.[Date], c.Max_Deg, c.Min_Deg;
GO

select * from v_ExamResultsByStudent
---------------------------------------------------------------------------------

GO
CREATE VIEW v_TeachingAssignments 
AS
SELECT 
    i.Ins_ID AS Instructor_ID,
    i.Ins_Name AS Instructor_Name,
    i.User_Name AS Instructor_Username,
    c.Crs_ID AS Course_ID,
    c.Crs_Name AS Course_Name,
    d.Dep_Name AS Department_Name,
    t.Track_Name,
    b.Bran_Name AS Branch_Name,
    iny.Year AS Intake_Year,
    COUNT(ci.Crs_ID) OVER (PARTITION BY i.Ins_ID) AS Total_Courses_Assigned
FROM Crs_Inst_Intake ci
INNER JOIN Instructor i ON ci.Ins_ID = i.Ins_ID
INNER JOIN Course c ON ci.Crs_ID = c.Crs_ID
INNER JOIN Department d ON i.Dep_ID = d.Dep_ID
INNER JOIN Intake iny ON ci.Intake_ID = iny.ID
LEFT JOIN Track_Crs tc ON c.Crs_ID = tc.Crs_ID
LEFT JOIN Track t ON tc.Track_ID = t.Track_ID
LEFT JOIN Intake_Ins_Branch iib ON ci.Intake_ID = iib.Intake_ID AND ci.Ins_ID = iib.Ins_ID
LEFT JOIN Branch b ON iib.Bran_ID = b.Bran_ID;
GO

select * from v_TeachingAssignments
-------------------------------------------------------------------------------------

GO
CREATE VIEW v_CorrectiveExams 
AS
SELECT 
    ec.Corrective_ID,
    ec.Original_Exam_ID,
    e.Crs_ID,
    c.Crs_Name AS Course_Name,
    ec.Student_ID,
    s.ST_Name AS Student_Name,
    ec.Corrective_Date,
    ec.Start_time,
    ec.End_time,
    ec.Is_Completed,
    ec.Score AS Corrective_Score,
    oes.Total_Score AS Original_Score,
    c.Min_Deg AS Minimum_Degree,
    CASE 
        WHEN ec.Is_Completed = 1 AND ec.Score >= c.Min_Deg THEN 'Passed'
        WHEN ec.Is_Completed = 1 AND ec.Score < c.Min_Deg THEN 'Failed'
        ELSE 'Not Completed'
    END AS Corrective_Result,
    DATEDIFF(DAY, e.[Date], ec.Corrective_Date) AS Days_After_Original
FROM Exam_Corrective ec
INNER JOIN Exam e ON ec.Original_Exam_ID = e.Ex_ID
INNER JOIN Course c ON e.Crs_ID = c.Crs_ID
INNER JOIN Student s ON ec.Student_ID = s.ST_ID
LEFT JOIN (
    SELECT ST_ID, Ex_ID, SUM(Score) AS Total_Score
    FROM Stu_Exam_QUP
    GROUP BY ST_ID, Ex_ID
) oes ON ec.Student_ID = oes.ST_ID AND ec.Original_Exam_ID = oes.Ex_ID;
GO

select * from v_CorrectiveExams
----------------------------------------------------------------------------------------
-- ??? ??????? ????????
GRANT SELECT ON v_QuestionPool TO Instructors_Role;
GRANT SELECT ON v_ExamQuestions TO Instructors_Role;
GRANT SELECT ON v_ExamChoices TO Instructors_Role;
GRANT SELECT ON v_EligibleStudentsForExam TO Instructors_Role;
GRANT SELECT ON v_StudentAnswers TO Instructors_Role;
GRANT SELECT ON v_ExamResultsByStudent TO Instructors_Role;
GRANT SELECT ON v_CorrectiveExams TO Instructors_Role;

-- ??? ??????? ??????
GRANT SELECT ON v_ExamSchedule TO Students_Role;
GRANT SELECT ON v_ExamResultsByStudent TO Students_Role;

-- ??? ??????? ?????????
GRANT SELECT ON v_QuestionPool TO Exam_Admin;
GRANT SELECT ON v_ExamSchedule TO Exam_Admin;
GRANT SELECT ON v_ExamQuestions TO Exam_Admin;
GRANT SELECT ON v_ExamChoices TO Exam_Admin;
GRANT SELECT ON v_EligibleStudentsForExam TO Exam_Admin;
GRANT SELECT ON v_StudentAnswers TO Exam_Admin;
GRANT SELECT ON v_ExamResultsByStudent TO Exam_Admin;
GRANT SELECT ON v_TeachingAssignments TO Exam_Admin;
GRANT SELECT ON v_CorrectiveExams TO Exam_Admin;
GO



