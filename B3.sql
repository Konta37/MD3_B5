-- Session 05
-- Procedure to get all classes with more than 5 students
DELIMITER //

CREATE PROCEDURE get_classes_with_more_than_5_students()
BEGIN
    SELECT c.classID, c.className, COUNT(s.studentId) AS student_count
    FROM Class c
    JOIN Student s ON c.classID = s.classId
    GROUP BY c.classID, c.className
    HAVING student_count > 5;
END //

DELIMITER ;

-- Procedure to show subjects with a score of 10
DELIMITER //

CREATE PROCEDURE get_subjects_with_score_10()
BEGIN
    SELECT sub.subId, sub.subName
    FROM Subject sub
    JOIN Mark m ON sub.subId = m.subjectId
    WHERE m.mark = 10;
END //

DELIMITER ;

-- Procedure to show class information with students having a score of 10
DELIMITER //

CREATE PROCEDURE get_classes_with_students_with_score_10()
BEGIN
    SELECT DISTINCT c.classID, c.className, c.startDate, c.status
    FROM Class c
    JOIN Student s ON c.classID = s.classId
    JOIN Mark m ON s.studentId = m.studentId
    WHERE m.mark = 10;
END //

DELIMITER ;

-- Procedure to add a new student and return the new student ID
DELIMITER //

CREATE PROCEDURE add_new_student(
    IN p_studentName VARCHAR(255),
    IN p_address VARCHAR(255),
    IN p_phone VARCHAR(255),
    IN p_status BIT,
    IN p_classId INT,
    OUT p_studentId INT
)
BEGIN
    INSERT INTO Student (studentName, address, phone, status, classId)
    VALUES (p_studentName, p_address, p_phone, p_status, p_classId);

    SET p_studentId = LAST_INSERT_ID();
END //

DELIMITER ;

-- Procedure to show subjects not taken by any student
DELIMITER //

CREATE PROCEDURE get_subjects_not_taken_by_any_student()
BEGIN
    SELECT sub.subId, sub.subName
    FROM Subject sub
    LEFT JOIN Mark m ON sub.subId = m.subjectId
    WHERE m.subjectId IS NULL;
END //

DELIMITER ;