use Testingsystem1;

-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước

DROP TRIGGER IF EXISTS Question1;
DELIMITER $$
CREATE TRIGGER Question1
BEFORE	INSERT ON `Group`
FOR EACH ROW
	BEGIN
		IF NEW.CreateDate < (CURRENT_DATE - INTERVAL 1 YEAR) THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Loi tao ngay';
        END IF;
    END $$
DELIMITER ;

INSERT INTO `Group`(CreateDate) VALUE ('2015-09-09');

-- Viết trigger để xóa group id của bảng GroupAccount  nếu xóa đi 1 dòng tương ứng ở bảng Group

DROP TRIGGER IF EXISTS update_id;
DELIMITER $$
create trigger update_id
before DELETE on `Group`
for each row
begin
	delete
    from GroupAccount g
    where g.GroupID = old.GroupID;
end $$
delimiter ;
	
delete from `Group` where GroupID = 6;

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
DROP TRIGGER IF EXISTS no_add_user;
DELIMITER $$
CREATE TRIGGER no_add_user
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
	IF NEW.DepartmentID = 4
    THEN SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'Department "Sale" cannot add more user';
	END IF;
END$$
DELIMITER ;

INSERT INTO `Account`(Email,Username,FullName,DepartmentID,PositionID,CreateDate) VALUES 
('phantuyen2@gmail.com','phantuyen2','Phan Van Tuyen2',4,4,'2014-05-04')


-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS group_max5;
DELIMITER $$
CREATE TRIGGER group_max5
BEFORE INSERT ON GroupAccount
FOR EACH ROW
BEGIN
	DECLARE sluser INT;
	SELECT COUNT(a.AccountID) INTO sluser  
    FROM `Account` a 
    JOIN GroupAccount ga 
	ON a.AccountID=ga.AccountID 
	WHERE 	NEW.GroupID= ga.GroupID;
    IF 
		sluser >= 4
	THEN SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT = '1 group có nhiều nhất là 4 user';
    END IF;

END$$
DELIMITER ;


INSERT INTO GroupAccount (GroupID, AccountID) VALUES (2,3);

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS exam_max3;
DELIMITER $$
CREATE TRIGGER exam_max3
BEFORE INSERT ON ExamQuestion
FOR EACH ROW
BEGIN
	DECLARE slquestion INT;
	SELECT COUNT(q.QuestionID) INTO slquestion 
    FROM Question q
    JOIN ExamQuestion eq
	ON q.QuestionID = eq.QuestionID 
	WHERE 	NEW.ExamID= eq.ExamID;
    IF 
		slquestion >= 3
	THEN SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT = ' 1 bài thi có nhiều nhất là 3 Question';
    END IF;

END$$
DELIMITER ;

INSERT INTO ExamQuestion (ExamID,QuestionID) VALUES (5,1);


-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DROP TRIGGER IF EXISTS no_dele_tk;
DELIMITER $$
CREATE TRIGGER no_dele_tk
BEFORE DELETE ON `Account`
FOR EACH ROW
BEGIN
	IF OLD.Email = 'phantuyen@gmail.com'
    THEN SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT = 'đây là tài khoản admin, không cho phép user xóa';
    END IF;
END$$
DELIMITER ;

DELETE FROM `Account` WHERE Email = 'phantuyen@gmail.com';


-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
DROP TRIGGER IF EXISTS Depart_waiting;
DELIMITER $$
CREATE TRIGGER  Depart_waiting
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
	IF (NEW.DepartmentID IS NULL)
    THEN 
        SET NEW.DepartmentID = 4;
    END IF;
END$$
DELIMITER ;

INSERT INTO `Account`(Email,Username,FullName,PositionID,CreateDate) VALUES 
('phantuyen2@gmail.com','phantuyen2','Phan Van Tuyen2',4,'2014-05-04');


-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS max_4answers;
DELIMITER $$
CREATE TRIGGER max_4answers
BEFORE INSERT ON Exam  
FOR EACH ROW
BEGIN
	IF 
    (
		SELECT count(answer) 
        FROM 
    )
    THEN
END$$
DELIMITER ;


-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
ALTER TABLE `Account`
ADD COLUMN Gender varchar(10);

DROP TRIGGER IF EXISTS Q8;
DELIMITER $$
CREATE TRIGGER Q8
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
	IF NEW.Gender ='Nam' THEN SET NEW.Gender = 'M';
	END IF;
    IF NEW.Gender ='Nu' THEN SET NEW.Gender = 'F';
	END IF;
    IF NEW.Gender ='Null' THEN SET NEW.Gender = 'U';
    END IF;
END$$
DELIMITER ;

INSERT INTO `Account` (Email,Username,FullName,PositionID,CreateDate,Gender) VALUES 
('phantuyen3@gmail.com','phantuyen3','Phan Van Tuyen3',3,'2014-06-04','Nam');

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS exam_dele;
DELIMITER $$
CREATE TRIGGER exam_dele
BEFORE DELETE ON Exam
FOR EACH ROW
BEGIN
	IF (current_date - INTERVAL 50 day) < old.CreateDate
    THEN SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT= 'không cho phép người dùng xóa bài thi mới tạo được 50 ngày';
	END IF;
END$$
DELIMITER ;

DELETE FROM Exam Where CreateDate ='2021-09-01';

-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS Q10;
DELIMITER $$
CREATE TRIGGER Q10
BEFORE DELETE ON Question 
FOR EACH ROW
BEGIN
	IF OLD.QuestionID IN (
		SELECT q.QuestionID 
        FROM Question q
		JOIN ExamQuestion eq
        ON q.QuestionID = eq.QuestionID )
	THEN SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT= 'không thể xóa';
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS Q10b;
DELIMITER $$
CREATE TRIGGER Q10b
BEFORE UPDATE ON Question 
FOR EACH ROW
BEGIN
	IF NEW.QuestionID IN (
		SELECT q.QuestionID 
        FROM Question q
		JOIN ExamQuestion eq
        ON q.QuestionID = eq.QuestionID )
	THEN SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT= 'không thể sửa';
	END IF;
END$$
DELIMITER ;

DELETE FROM Question WHERE QuestionID = 2;
UPDATE Question SET Content = 10 WHERE QuestionID = 2;

-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT *, CASE
			WHEN Duration <= 30 THEN 'Short time'
			WHEN 30 < Duration <= 60 THEN 'Medium time'
			ELSE 'Long time'
            END AS thoigian
FROM Exam;

-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT GroupID, count(AccountID), CASE
									WHEN count(AccountID) <= 5 THEN 'few'
                                    WHEN count(AccountID) > 20 THEN 'higher'
                                    ELSE 'normal'
								  END AS the_number_user_amount
FROM GroupAccount
GROUP BY GroupID;

-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT d.*, count(a.AccountID), CASE
								WHEN count(a.AccountID) = 0 THEN 'Khong Co User'
                                END As Soluongaccount
FROM Department d
JOIN `Account` a 
ON d.DepartmentID= a.DepartmentID
GROUP BY d.DepartmentID;
