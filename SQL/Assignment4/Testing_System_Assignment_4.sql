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
('c??u h???i s??? n',2,1,4,'2016-07-010'),
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
-- SET SQL_SAFE_UPDATES = 0;
-- delete from Question where Content like 'c??u h???i%';

-- Question 14: Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v??o email th??nh loc.nguyenba@vti.com.vn
update `Account`
set FullName = "Nguy???n B?? L???c",
	Email = 'loc.nguyenba@vti.com.vn'
where AccountID = 5;

-- Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4
update `Account`
set PositionID = 4
where AccountID = 5;


-- "Testing_System_Assignment_4"
-- Exercise 1: Join
-- Question 1: Vi???t l???nh ????? l???y ra danh s??ch nh??n vi??n v?? th??ng tin ph??ng ban c???a h???
select a.AccountID, d.DepartmentID, d.DepartmentName
from Department d
left join `Account` a
on d.DepartmentID = a.DepartmentID; 

-- Question 2: Vi???t l???nh ????? l???y ra th??ng tin c??c account ???????c t???o sau ng??y 20/12/2010
select * from `Account` where CreateDate > '2010-12-20';

-- Question 3: Vi???t l???nh ????? l???y ra t???t c??? c??c developer
select a.AccountID, a.FullName, p.PositionName
from Position p
join `Account` a
on p.PositionID = a.PositionID
where p.PositionName = 'Dev';

-- Question 4: Vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban c?? >3 nh??n vi??n
select d.DepartmentID, d.DepartmentName, a.AccountID, Count(a.AccountID)
from `Account` a
join Department d
on d.DepartmentID = a.DepartmentID
Group by d.DepartmentID
Having Count(a.AccountID) >= 2; 

-- Question 5: Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t
select q.QuestionID, q.Content, eq.ExamID, count(eq.QuestionID)
from Question q
join ExamQuestion eq
on q.QuestionID = eq.QuestionID
Group by eq.QuestionID
Order by count(eq.QuestionID) desc
limit 1;

-- Question 6: Th??ng k?? m???i category Question ???????c s??? d???ng trong bao nhi??u Question
Select c.CategoryID, c.CategoryName, count(q.QuestionID)
from CategoryQuestion c
join Question q
on c.CategoryID = q.CategoryID
group by c.CategoryID;

-- Question 7: Th??ng k?? m???i Question ???????c s??? d???ng trong bao nhi??u Exam
select q.QuestionID, q.Content, count(eq.ExamID)
from Question q
join ExamQuestion eq
on q.QuestionID = eq.QuestionID
group by q.QuestionID;

-- Question 8: L???y ra Question c?? nhi???u c??u tr??? l???i nh???t
select  q.QuestionID, q.Content, count(a.AnswerID)
from Question q
join Answer a
on q.QuestionID = a.QuestionID
group by (q.QuestionID)
order by count(a.AnswerID) desc
limit 1;

-- Question 9: Th???ng k?? s??? l?????ng account trong m???i group
select g.GroupID, g.GroupName, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID;

-- Question 10: T??m ch???c v??? c?? ??t ng?????i nh???t
select p.PositionID, p.PositionName, count(a.AccountID)
from `Account` a
right join Position p
on a.PositionID = p.PositionID
group by p.PositionID;

-- Question 11: Th???ng k?? m???i ph??ng ban c?? bao nhi??u dev, test, scrum master, PM
select d.DepartmentID, d.DepartmentName,p.PositionName, count(a.AccountID) as 'sum'
from Department d
left join `Account` a
on a.DepartmentID = d.DepartmentID
cross join Position p
group by d.DepartmentName, p.PositionName;

-- Question 12: L???y th??ng tin chi ti???t c???a c??u h???i bao g???m: th??ng tin c?? b???n c???a question, lo???i c??u h???i, ai l?? ng?????i t???o ra c??u h???i, c??u tr??? l???i l?? g??, ...
Select q.QuestionID, q.Content, q.CategoryID, q.TypeID, q.CreatorID, a.AnswerID
from Question q
left join Answer a
on q.QuestionID = a.QuestionID;


-- Question 13: L???y ra s??? l?????ng c??u h???i c???a m???i lo???i t??? lu???n hay tr???c nghi???m
select tq.TypeID, tq.TypeName, count(q.QuestionID)
from TypeQuestion tq
left join Question q
on tq.TypeID =q.TypeID
Group by tq.TypeID;

-- Question 14:L???y ra group kh??ng c?? account n??o
SELECT*FROM `Group`;
select g.GroupID, g.GroupName, Count(ga.AccountID)
from `Group` g
left join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID
having  Count(ga.AccountID) = 0; 

-- Question 15: L???y ra group kh??ng c?? account n??o
select g.GroupID, g.GroupName, Count(ga.AccountID)
from `Group` g
left join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID
having  Count(ga.AccountID) = 0; 

-- Question 16: L???y ra question kh??ng c?? answer n??o
Select * from Question;
Select q.QuestionID, q.Content, count(a.AnswerID)
from Question q
left join Answer a
on q.QuestionID = a.QuestionID
group by q.QuestionID
having count(a.AnswerID) = 0;


-- Exercise 2: Union
-- Question 17:
-- a) L???y c??c account thu???c nh??m th??? 1
select a.*, ga.GroupID
from `Account` a
join GroupAccount ga
on a.AccountID = ga.AccountID
where ga.GroupID = 1;

-- b) L???y c??c account thu???c nh??m th??? 2
select a.* , ga.GroupID
from `Account` a
join GroupAccount ga
on a.AccountID = ga.AccountID
where ga.GroupID = 2;

-- c) Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b) sao cho kh??ng c?? record n??o tr??ng nhau
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
-- a) L???y c??c group c?? l???n h??n 5 th??nh vi??n
select g.*, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID 
having count(ga.AccountID) > 5;

-- b) L???y c??c group c?? nh??? h??n 7 th??nh vi??n
select g.*, count(ga.AccountID)
from `Group` g
join GroupAccount ga
on g.GroupID = ga.GroupID
group by g.GroupID 
having count(ga.AccountID) > 5;

-- c) Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b)
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

