use Testingsystem1;

-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

Drop procedure if exists Account_name;
Delimiter $$
create procedure Account_name (in in_DepartmentName VARCHAR(30))
begin
	select a.AccountID
    from `Account` a
    join Department d
    on d.DepartmentID = a.DepartmentID
	where d.DepartmentName = in_DepartmentName;
end $$
Delimiter ;

call Account_name('Bao Ve');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
Drop procedure if exists SLAccount;

Delimiter $$
create procedure SLAccount ()
begin
	select GroupID, Count(AccountID)
    From GroupAccount
	Group by GroupID;
end $$
Delimiter ;

call SLAccount ();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS QuestionMon;
DELIMITER $$
CREATE PROCEDURE QuestionMon(IN in_month INT)
BEGIN
SELECT tq.TypeName, COUNT(q.QuestionID)
FROM question q
JOIN typequestion tq 
ON q.TypeID = tq.TypeID
WHERE month(q.CreateDate) = in_month
GROUP BY tq.TypeName;

end $$
DELIMITER ;

CALL QuestionMon(7);

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
Drop procedure if exists ID_type_Question;
Delimiter $$
Create procedure ID_type_Question()
Begin
	Select q.TypeID, Count(q.QuestionID) as maxquestions
    from Question q
    join TypeQuestion tq
    on q.TypeID = tq.TypeID
    group by q.TypeID
    having maxquestions = (
		select max(maxquestions)
        from (Select Count(q.QuestionID) as maxquestions
			  from Question q
			  join TypeQuestion tq
			  on q.TypeID = tq.TypeID
			  group by q.TypeID) as maxq
    );
End $$
Delimiter ;

call ID_type_Question();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
Drop procedure if exists abc;
Delimiter $$
Create procedure abc ()
Begin
	Select tq.TypeName, Count(q.QuestionID) as maxquestions
    from TypeQuestion tq
    join Question q
    on q.TypeID = tq.TypeID
    group by q.TypeID
    having maxquestions = (
		select max(maxquestions)
        from (Select Count(q.QuestionID) as maxquestions
			   from TypeQuestion tq
			   join Question q
			  on q.TypeID = tq.TypeID
			  group by q.TypeID) as maxq
    );
End $$
Delimiter ;

call abc();

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
Drop procedure if exists GroupAccountName;
Delimiter $$
Create procedure GroupAccountName(in in_GroupAccountName varchar(30), in in_ten varchar(30))
Begin
	if in_ten = 'Group'
    then
		select g.GroupName from `Group` g
		where g.GroupName like '%in_GroupAccountName%';
	else
			select a.Username from `Account` a
            where a.Username like '%in_GroupAccountName%';
    end if;
End $$
Delimiter ;
call GroupAccountName ('Bao', 'Group');

-- Cách 2:
DROP PROCEDURE IF EXISTS p_id_group;
DELIMITER $$
CREATE PROCEDURE  p_id_group(IN in_GroupName VARCHAR(50), OUT out_id_group	TINYINT UNSIGNED)
BEGIN
	SELECT GroupID   INTO out_id_group
	FROM `Group`
    WHERE GroupName=in_GroupName;
END$$
DELIMITER ;
SET @search_group='';
CALL p_id_group('ADN LAND',@search_group);
SELECT @search_group;

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
--                username sẽ giống email nhưng bỏ phần @..mail đi
--                positionID: sẽ có default là developer
--                departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

DROP PROCEDURE IF EXISTS p_update;
DELIMITER $$
CREATE PROCEDURE  p_update(IN in_FullName VARCHAR(50),IN in_email VARCHAR(50))
BEGIN

		DECLARE p_PositionID TINYINT UNSIGNED;
		DECLARE p_DepartmentID TINYINT UNSIGNED;
		SELECT PositionID INTO p_positionID
		FROM Position
		WHERE PositionName='Dev'; -- positionID: sẽ có default là developer
        SELECT DepartmentID INTO p_departmentID 
        FROM Department
        WHERE DepartmentName='Ban Hang'; -- departmentID: sẽ được cho vào bán hàng
	INSERT INTO `Account`(Email,Username,FullName,DepartmentID,PositionID) 
	VALUES (in_email,substring_index(in_email,'@',1 ),in_FullName,p_departmentID,p_positionID); 
    IF ROW_COUNT() > 0 THEN
		SELECT 'thanh cong';
    ELSE 
		SELECT 'that bai';
	END IF;
END$$
DELIMITER ;

CALL p_update('Nguyen Hang','hangng@gmail.com');

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
Drop procedure if exists type_question;
Delimiter $$
Create procedure type_question( in  in_TypeName enum('Essay', 'Multiple-Choice'))
	begin
		select q.QuestionID, q.TypeID, q.Content, length(q.Content) as lengthcontent 
        from typequestion t 
        join question q 
        on t.TypeID=q.TypeID
        having length(q.Content)=(
			select MAX(lengthcontent) 
			from (select q.QuestionID, q.TypeID, q.Content,length(q.Content) as lengthcontent
				  from typequestion t 
				  join question q 
				  on t.TypeID=q.TypeID
				  where TypeName=in_TypeName)
                  as maxlength);
    end$$
Delimiter ;
call type_question('Essay');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
Drop procedure if exists deleExam;
Delimiter $$
Create procedure deleExam (in in_idexam int unsigned)
Begin
	delete from Exam where ExamID=in_idexam;
End $$
Delimiter ;

call deletExam(100);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa) Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS year_3;
DELIMITER $$
CREATE PROCEDURE year_3()
	BEGIN
		DECLARE dele_ex TINYINT UNSIGNED ;
		SELECT ExamID INTO dele_ex  
        FROM Exam 
        WHERE year(now())-year(CreateDate)>=3;
        CALL deleExam(dele_ex );
    END$$
DELIMITER ;
CALL year_3();


-- Cách 2
`DROP PROCEDURE IF EXISTS exam_3year_cach2;
DELIMITER $$
CREATE PROCEDURE exam_3year_cach2(IN in_ExamID TINYINT UNSIGNED)
	BEGIN
        WITH exam_3_yearold AS(
		SELECT ExamID
        FROM Exam WHERE year(now())-year( CreateDate	)>=3)
		DELETE	
		FROM	Exam
		WHERE	ExamID = (SELECT* 
					FROM 	exam_3_yearold
					WHERE	ExamID = in_ExamID);
    END$$
DELIMITER ;
CALL exam_3year_cach2(9);`

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban 
-- và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS delete_name_department;
DELIMITER $$
CREATE PROCEDURE delete_name_department(IN  in_DepartmentName VARCHAR(50))
	BEGIN
		DELETE  FROM department WHERE DepartmentName='Bao ve';
        -- default là về phòng bán hàng 
        UPDATE Department
        SET  DepartmentName='Ban Hang'
        WHERE DepartmentName=in_DepartmentName;
        -- (SELECT*FROM uni_accountupdate)
--         UNION
-- 		(SELECT *FROM `Account` WHERE DepartmentID=(SELECT DepartmentID FROM department WHERE DepartmentName='Ban Hang')) ;
		
    END$$
DELIMITER ;    
CALL delete_name_department('Bao ve');
SELECT*FROM department;
SELECT*FROM `account`;

DROP PROCEDURE IF EXISTS DeletDep;
DELIMITER $$
CREATE PROCEDURE DeletDep(IN p_depName CHAR(30))
BEGIN
        UPDATE account a 
        JOIN department d ON d.DepartmentID = a.DepartmentID
		SET a.DepartmentID = 10
        WHERE d.DepartmentName = p_depName;

		DELETE
		FROM department
		WHERE DepartmentName = p_depName;
end$$
DELIMITER ;

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

Drop procedure if exists in_year;
Delimiter $$
	Create procedure in_year()
Begin
    SELECT allmonth.month ,count(q.QuestionID),GROUP_CONCAT(q.QuestionID)
    FROM 
	(SELECT  1 AS month UNION
	SELECT	2 AS month UNION
	SELECT	3 AS month UNION
	SELECT	4 AS month UNION
	SELECT	5 AS month UNION
	SELECT	6 AS month UNION
	SELECT	7 AS month UNION
	SELECT	8 AS month UNION
	SELECT	9 AS month UNION
	SELECT	10 AS month UNION
	SELECT	11 AS month UNION
	SELECT	12 AS month) AS allmonth
    LEFT JOIN Question q
    ON allmonth.month=month(q.CreateDate)
    GROUP BY	allmonth.month;
End $$
Delimiter ;
call in_year();

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất 
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
DROP PROCEDURE IF EXISTS in_month_6;
DELIMITER $$
	CREATE PROCEDURE in_month_6()
    BEGIN
    SELECT month_6.MONTH ,COUNT(q.QuestionID),GROUP_CONCAT(q.QuestionID)
    FROM 
	(SELECT	MONTH(NOW() - INTERVAL 0 MONTH) AS MONTH
	UNION	
	SELECT	MONTH(NOW() - INTERVAL 1 MONTH) AS MONTH
	UNION
	SELECT	MONTH(NOW() - INTERVAL 2 MONTH) AS MONTH
	UNION
	SELECT	MONTH(NOW() - INTERVAL 3 MONTH) AS MONTH
	UNION
	SELECT	MONTH(NOW() - INTERVAL 4 MONTH) AS MONTH
	UNION
	SELECT	MONTH(NOW() - INTERVAL 5 MONTH) AS MONTH)  AS month_6
    LEFT JOIN question q
    ON month_6.month=month(CreateDate)
    GROUP BY	month_6.Month;
    END$$
DELIMITER ;
CALL in_month_6(); 
