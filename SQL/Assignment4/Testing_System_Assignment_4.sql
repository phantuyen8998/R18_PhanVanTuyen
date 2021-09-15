DROP DATABASE IF EXISTS testingsystem1;
create database testingsystem1;

use testingsystem1;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    DepartmentID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(30) unique key
);


insert into Department (DepartmentName) values ('Bao Ve'),
											   ('Nhan su'),
											   ('Marketing'),
											   ('Sale'),
											   ('San xuat'),
											   ('Khoa Hoc Cong Nghe'),
                                               ('Dao tao');

CREATE TABLE `Position` (
    PositionID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') not null
);

insert into `Position` (PositionName) values ('Dev'),
											 ('Test'),
											 ('Scrum Master'),
											 ('PM');

CREATE TABLE `Account` (
    AccountID INT UNSIGNED UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(30) UNIQUE KEY,
    Username VARCHAR(30) NOT NULL unique key,
    FullName VARCHAR(30) not null,
    DepartmentID TINYINT UNSIGNED not null,
    PositionID TINYINT UNSIGNED not null,
    CreateDate DATE ,
    FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID) ,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID)
);

insert into `Account` (Email,Username,FullName,DepartmentID,PositionID,CreateDate) values 
('phantuyen@gmail.com','phantuyen','Phan Van Tuyen',1,4,'2014-02-04'),
('quocdai@gmail.com','quocdai','Pham Quoc Dai',5,3,'2014-02-05'), 
('trankien@gmail.com','trankien','Tran Trung Kien',6,1,'2014-02-06'), 
('luonghieu@gmail.com','luonghieu','Luong Xuan Hieu',7,2,'2014-02-07'), 
('letuan@gmail.com','letuan','Le Anh Tuan',3,2,'2014-02-08'),
('phanhuong@gmail.com','phanhuong','Phan Quynh Huong',3,1,'2014-02-09'),
('Dantho@gmail.com','Dantho','Dan van Tho',4,3,'2014-02-10'),
('phanan@gmail.com','phanan','Phan Linh An',2,4,'2014-02-11'),
('letuanb@gmail.com','letuanb','Le Anh Tuanb',1,1,'2014-04-08');


-- delete from Department where DepartmentID = 1;

CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(30) unique key,
    CreatorID INT UNSIGNED not null,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

insert into `Group` (GroupName,CreatorID,CreateDate) values
('Lap Trinh Web FullStack',1,'2015-01-04'),
('Ban Hang Da Cap',2,'2015-02-04'),
('Frontend VN ',1,'2015-03-04'),
('Backend VN',1,'2015-05-04'),
('Tri Tue Nhan Tao',3,'2015-04-04');

CREATE TABLE GroupAccount (
    GroupID TINYINT UNSIGNED,
    AccountID INT  UNSIGNED,
    JoinDate DATE,
    PRIMARY KEY (GroupID , AccountID),
    FOREIGN KEY (GroupID) 	REFERENCES `Group`(GroupID) ,
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

insert into GroupAccount (GroupID, AccountID) values (1,1),(2,2),(3,1),(4,1),(5,3),(1,2),(1,3),(2,1),(2,5),(2,4);

CREATE TABLE TypeQuestion (
    TypeID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    TypeName ENUM('Essay', 'Multiple-Choice') not null
);

insert into TypeQuestion(TypeName) values ('Essay'),('Multiple-Choice');


CREATE TABLE CategoryQuestion (
    CategoryID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CategoryName ENUM('Java', '.NET', 'SQL', 'Postman', 'Ruby') not null
);

insert into CategoryQuestion(CategoryName) values ('Java'),('.NET'),('SQL'),('Postman'),('Ruby');

CREATE TABLE Question (
    QuestionID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(200) not null,
    CategoryID TINYINT UNSIGNED not null,
    TypeID INT UNSIGNED not null,
    CreatorID INT UNSIGNED not null,
    CreateDate DATE ,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

insert into Question(Content, CategoryID, TypeID, CreatorID,CreateDate) values
('Java la gi?',1,2,1,'2016-07-04'),
('Java thuong duoc su dung nhu the nao?',1,2,1,'2016-07-05'),
('.NET la gi?',2,1,3,'2016-07-06'),
('SQL la gi?',3,1,4,'2016-07-08'),
('Postman la gi?',4,2,2,'2016-07-09'),
('câu hỏi số n',2,1,4,'2016-07-010'),
('Ruby la gi?',5,2,5,'2016-07-011');

CREATE TABLE Answer (
    AnswerID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(200) not null,
    QuestionID INT UNSIGNED ,
    isCorrect ENUM('True', 'False') not null,
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);

insert into Answer(Content, QuestionID, isCorrect) values 
('SQL la ngon ngu lap trinh CSDL',4,'True'),
('SQL la ngon ngu lap trinh Frontend',4,'False'),
('Java la 1 ngon ngu lap trinh',1,'True'),
('Ruby la ngon ngu lap trinh CSDL',6,'False'),
('Postman la ngon ngu lap trinh CSDL',5,'False'),
('.NET la ngon ngu lap trinh CSDL',3,'False'),
('.NETla ngon ngu lap trinh phia backend',3,'True');

CREATE TABLE Exam (
    ExamID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code` TINYINT,
    Title VARCHAR(100),
    CategoryID TINYINT UNSIGNED,
    Duration TIME,
    CreatorID INT UNSIGNED,
    CreateDate DATE ,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
); 

insert into Exam(`Code`,Title,CategoryID,CreatorID,CreateDate) values
(01,'DE thi so 01',1,1,'2018-11-10'),
(02,'DE thi so 02',5,5,'2018-03-10'),
(03,'DE thi so 03',4,2,'2019-04-11'),
(04,'DE thi so 04',4,2,'2021-07-11'),
(05,'DE thi so 05',3,4,'2020-05-11'),
(06,'DE thi so 06',2,3,'2021-09-01');

CREATE TABLE ExamQuestion (
    ExamID INT UNSIGNED,
    QuestionID INT UNSIGNED,
    PRIMARY KEY (ExamID , QuestionID),
    FOREIGN KEY (ExamID)	REFERENCES Exam(ExamID) on delete cascade,
    FOREIGN KEY (QuestionID)REFERENCES Question(QuestionID)
);

insert into ExamQuestion (ExamID, QuestionID) values (1,1),(2,6),(3,5),(4,5),(5,4),(6,3),(4,4),(5,5),(5,3),(6,2);

SELECT * FROM Department;
SELECT * FROM Position;
SELECT * FROM `Account`;
SELECT * FROM `Group`;
SELECT * FROM GroupAccount;
SELECT * FROM TypeQuestion;
SELECT * FROM CategoryQuestion;
SELECT * FROM Question;
SELECT * FROM Answer;
SELECT * FROM Exam;
SELECT * FROM ExamQuestion;

-- Question 1: Thêm ít nhất 10 record vào mỗi table


-- Question 2: lấy ra tất cả các phòng ban
select DepartmentName from Department;

-- Question 3: lấy ra id của phòng ban "Sale"
select DepartmentID from Department
where DepartmentName = 'Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất
select * from `Account` 
order by length(FullName) desc
limit 1;

select  *, length(FullName) as Lengthfullname
from `Account`
order by Lengthfullname desc
limit 1;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
select  *, length(FullName) as Lengthfullname
from `Account`
where DepartmentID = 3
order by Lengthfullname desc
limit 1;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
select GroupName from `Group` where CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
select QuestionID, count(AnswerID) as NumberAnswer 
from Answer
group by QuestionID
having NumberAnswer >=  '4';

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
select ExamID, Duration, CreateDate 
from Exam
where Duration >= '60' and CreateDate <= '2019-12-20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
select GroupID, GroupName
from `Group`
order by CreateDate desc
limit 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2 
Select Count(AccountID) as NumberAccount
from `Account` 
where DepartmentID = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
Select * from `Account` where FullName like ('D%o');

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
SET SQL_SAFE_UPDATES = 0;
delete from Exam where CreateDate <= '2019-12-20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
-- SET SQL_SAFE_UPDATES = 0;
-- delete from Question where Content like 'câu hỏi%';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" vào email thành loc.nguyenba@vti.com.vn
update `Account`
set FullName = "Nguyễn Bá Lộc",
	Email = 'loc.nguyenba@vti.com.vn'
where AccountID = 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
update `Account`
set PositionID = 4
where AccountID = 5;


-- "Testing_System_Assignment_4"
-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
select a.AccountID, d.DepartmentID, d.DepartmentName
from Department d
left join `Account` a
on d.DepartmentID = a.DepartmentID; 

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
select * from `Account` where CreateDate > '2010-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
select a.AccountID, a.FullName, p.PositionName
from Position p
join `Account` a
on p.PositionID = a.PositionID
where p.PositionName = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
select d.DepartmentID, d.DepartmentName, a.AccountID, Count(a.AccountID)
from `Account` a
join Department d
on d.DepartmentID = a.DepartmentID
Group by d.DepartmentID
Having Count(a.AccountID) >= 2; 

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
select q.QuestionID, q.Content, eq.ExamID, count(eq.QuestionID)
from Question q
join ExamQuestion eq
on q.QuestionID = eq.QuestionID
Group by eq.QuestionID
Order by count(eq.QuestionID) desc
limit 1;

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
Select c.CategoryID, c.CategoryName, count(q.QuestionID)
from CategoryQuestion c
join Question q
on c.CategoryID = q.CategoryID
group by c.CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
select q.QuestionID, q.Content, count(eq.ExamID)
from Question q
join ExamQuestion eq
on q.QuestionID = eq.QuestionID
group by q.QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
select  q.QuestionID, q.Content, count(a.AnswerID)
from Question q
join Answer a
on q.QuestionID = a.QuestionID
group by (q.QuestionID)
order by count(a.AnswerID) desc
limit 1;

-- Question 9: Thống kê số lượng account trong mỗi group
select g.GroupID, g.GroupName, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
select p.PositionID, p.PositionName, count(a.AccountID)
from `Account` a
right join Position p
on a.PositionID = p.PositionID
group by p.PositionID;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
select d.DepartmentID, d.DepartmentName,p.PositionName, count(a.AccountID) as 'sum'
from Department d
left join `Account` a
on a.DepartmentID = d.DepartmentID
cross join Position p
group by d.DepartmentName, p.PositionName;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
Select q.QuestionID, q.Content, q.CategoryID, q.TypeID, q.CreatorID, a.AnswerID
from Question q
left join Answer a
on q.QuestionID = a.QuestionID;


-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
select tq.TypeID, tq.TypeName, count(q.QuestionID)
from TypeQuestion tq
left join Question q
on tq.TypeID =q.TypeID
Group by tq.TypeID;

-- Question 14:Lấy ra group không có account nào
SELECT*FROM `Group`;
select g.GroupID, g.GroupName, Count(ga.AccountID)
from `Group` g
left join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID
having  Count(ga.AccountID) = 0; 

-- Question 15: Lấy ra group không có account nào
select g.GroupID, g.GroupName, Count(ga.AccountID)
from `Group` g
left join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID
having  Count(ga.AccountID) = 0; 

-- Question 16: Lấy ra question không có answer nào
Select * from Question;
Select q.QuestionID, q.Content, count(a.AnswerID)
from Question q
left join Answer a
on q.QuestionID = a.QuestionID
group by q.QuestionID
having count(a.AnswerID) = 0;


-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
select a.*, ga.GroupID
from `Account` a
join GroupAccount ga
on a.AccountID = ga.AccountID
where ga.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
select a.* , ga.GroupID
from `Account` a
join GroupAccount ga
on a.AccountID = ga.AccountID
where ga.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
select a.*, ga.GroupID
from `Account` a
join GroupAccount ga
on a.AccountID = ga.AccountID
where ga.GroupID = 1
union
select a.* , ga.GroupID
from `Account` a
join GroupAccount ga
on a.AccountID = ga.AccountID
where ga.GroupID = 2;


-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
select g.*, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID 
having count(ga.AccountID) > 5;

-- b) Lấy các group có nhỏ hơn 7 thành viên
select g.*, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID 
having count(ga.AccountID) > 5;

-- c) Ghép 2 kết quả từ câu a) và câu b)
select g.*, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID 
having count(ga.AccountID) > 5
union all
select g.*, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID 
having count(ga.AccountID) < 7;

