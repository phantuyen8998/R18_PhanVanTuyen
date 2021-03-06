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

insert into `Account` (Email,Username,FullName,DepartmentID,PositionID) values 
('phantuyen@gmail.com','phantuyen','Phan Van Tuyen',1,4),
('quocdai@gmail.com','quocdai','Pham Quoc Dai',5,3), 
('trankien@gmail.com','trankien','Tran Trung Kien',6,1), 
('luonghieu@gmail.com','luonghieu','Luong Xuan Hieu',7,2), 
('letuan@gmail.com','letuan','Le Anh Tuan',3,2),
('phanhuong@gmail.com','phanhuong','Phan Quynh Huong',3,1),
('Dantho@gmail.com','Dantho','Dan van Tho',4,3),
('phanan@gmail.com','phanan','Phan Linh An',2,4);


-- delete from Department where DepartmentID = 1;

CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(30) unique key,
    CreatorID INT UNSIGNED not null,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

insert into `Group` (GroupName,CreatorID) values
('Lap Trinh Web FullStack',1),
('Ban Hang Da Cap',2),
('Frontend VN ',1),
('Backend VN',1),
('Tri Tue Nhan Tao',3);

CREATE TABLE GroupAccount (
    GroupID TINYINT UNSIGNED,
    AccountID INT  UNSIGNED,
    JoinDate DATE,
    PRIMARY KEY (GroupID , AccountID),
    FOREIGN KEY (GroupID) 	REFERENCES `Group`(GroupID) ,
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

insert into GroupAccount (GroupID, AccountID) values (1,1),(2,2),(3,1),(4,1),(5,3);

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

insert into Question(Content, CategoryID, TypeID, CreatorID) values
('Java la gi?',1,2,1),
('Java thuong duoc su dung nhu the nao?',1,2,1),
('.NET la gi?',2,1,3),
('SQL la gi?',3,1,4),
('Postman la gi?',4,2,2),
('c??u h???i s??? n',2,1,4),
('Ruby la gi?',5,2,5);

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
(01,'DE thi so 01',1,1,'2000-11-10'),
(02,'DE thi so 02',5,5,'2000-03-10'),
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

insert into ExamQuestion (ExamID, QuestionID) values (1,1),(2,6),(3,5),(4,5),(5,4),(6,3);

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

-- Question 1: Th??m ??t nh???t 10 record v??o m???i table


-- Question 2: l???y ra t???t c??? c??c ph??ng ban
select DepartmentName from Department;

-- Question 3: l???y ra id c???a ph??ng ban "Sale"
select DepartmentID from Department
where DepartmentName = 'Sale';

-- Question 4: l???y ra th??ng tin account c?? full name d??i nh???t
select * from `Account` 
order by length(FullName) desc
limit 1;

select  *, length(FullName) as Lengthfullname
from `Account`
order by Lengthfullname desc
limit 1;

-- Question 5: L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id = 3
select  *, length(FullName) as Lengthfullname
from `Account`
where DepartmentID = 3
order by Lengthfullname desc
limit 1;

-- Question 6: L???y ra t??n group ???? tham gia tr?????c ng??y 20/12/2019
select GroupName from `Group` where CreateDate < '2019-12-20';

-- Question 7: L???y ra ID c???a question c?? >= 4 c??u tr??? l???i
select QuestionID, count(AnswerID) as NumberAnswer 
from Answer
group by QuestionID
having NumberAnswer >=  '4';

-- Question 8: L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019
select ExamID, Duration, CreateDate 
from Exam
where Duration >= '60' and CreateDate <= '2019-12-20';

-- Question 9: L???y ra 5 group ???????c t???o g???n ????y nh???t
select GroupID, GroupName
from `Group`
order by CreateDate desc
limit 5;

-- Question 10: ?????m s??? nh??n vi??n thu???c department c?? id = 2 
Select Count(AccountID) as NumberAccount
from `Account` 
where DepartmentID = 2;

-- Question 11: L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"
Select * from `Account` where FullName like ('D%o');

-- Question 12: X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019
SET SQL_SAFE_UPDATES = 0;
delete from Exam where CreateDate <= '2019-12-20';

-- Question 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"
SET SQL_SAFE_UPDATES = 0;
delete from Question where Content like 'c??u h???i%';

-- Question 14: Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v??o email th??nh loc.nguyenba@vti.com.vn
update `Account`
set FullName = "Nguy???n B?? L???c",
	Email = 'loc.nguyenba@vti.com.vn'
where AccountID = 5;

-- Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4
update `Account`
set PositionID = 4
where AccountID = 5;

