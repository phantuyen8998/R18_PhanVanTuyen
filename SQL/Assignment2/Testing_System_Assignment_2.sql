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
    FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID) ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID) ON DELETE CASCADE
);

insert into `Account` (Email,Username,FullName,DepartmentID,PositionID) values 
('phantuyen@gmail.com','phantuyen','Phan Van Tuyen',1,4),
('quocdai@gmail.com','quocdai','Pham Quoc Dai',5,3), 
('trankien@gmail.com','trankien','Tran Trung Kien',6,1), 
('luonghieu@gmail.com','luonghieu','Luong Xuan Hieu',7,2), 
('letuan@gmail.com','letuan','Le Anh Tuan',3,2), 
('phanan@gmail.com','phanan','Phan Linh An',2,4);

-- delete from Department where DepartmentID = 1;

CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(30) unique key,
    CreatorID INT UNSIGNED not null,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
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
    FOREIGN KEY (GroupID) 	REFERENCES `Group`(GroupID) ON DELETE CASCADE,
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
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
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON DELETE CASCADE,
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID) ON DELETE CASCADE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

insert into Question(Content, CategoryID, TypeID, CreatorID) values
('Java la gi?',1,2,1),
('Java thuong duoc su dung nhu the nao?',1,2,1),
('.NET la gi?',2,1,3),
('SQL la gi?',3,1,4),
('Postman la gi?',4,2,2),
('Ruby la gi?',5,2,5);

CREATE TABLE Answer (
    AnswerID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(200) not null,
    QuestionID INT UNSIGNED ,
    isCorrect ENUM('True', 'False') not null,
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID) ON DELETE CASCADE
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
    CreateDate DATETIME,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON DELETE CASCADE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
); 

insert into Exam(`Code`,Title,CategoryID,CreatorID) values
(01,'DE thi so 01',1,1),
(02,'DE thi so 02',5,5),
(03,'DE thi so 03',4,2),
(04,'DE thi so 04',4,2),
(05,'DE thi so 05',3,4),
(06,'DE thi so 06',2,3);

CREATE TABLE ExamQuestion (
    ExamID INT UNSIGNED,
    QuestionID INT UNSIGNED,
    PRIMARY KEY (ExamID , QuestionID),
    FOREIGN KEY (ExamID)	REFERENCES Exam(ExamID) ON DELETE CASCADE,
    FOREIGN KEY (QuestionID)REFERENCES Question(QuestionID) ON DELETE CASCADE
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



