create database testingsystem1;

use testingsystem1;

create table Department (
	DepartmentID tinyint,
    DepartmentName varchar(30)
);

create table Position (
	PositionID tinyint unsigned auto_increment,
    PositionName enum('Dev','Test','Scrum Master','PM')
);

create table `Account` (
	AccountID int unsigned auto_increment,
    Email varchar(30),
    Username varchar(30),
    FullName varchar(30),
    DepartmentID tinyint,
    PositionID tinyint,
    CreateDate datetime
);

create table `Group` (
	GroupID tinyint unsigned auto_increment,
    GroupName varchar(30),
    CreatorID int,
    CreateDate datetime
);

create table GroupAccount (
	GroupID tinyint,
    AccountID tinyint,
    JoinDate datetime
);

create table TypeQuestion(
	TypeID tinyint auto_increment,
    TypeName enum('Essay','Multiple-Choice')
);

create table CategoryQuestion (
	CategoryID tinyint auto_increment,
    CategoryName enum('Java', '.NET', 'SQL', 'Postman', 'Ruby')
);

create table Question (
	QuestionID tinyint auto_increment,
    Content varchar(200),
    CategoryID tinyint,
    TypeID tinyint,
    CreatorID tinyint,
    CreateDate datetime
);

create table Answer (
	AnswerID tinyint auto_increment,
    Content varchar(200),
    QuestionID tinyint,
    isCorrect enum('True', 'False')
);

create table Exam (
	ExamID tinyint auto_increment,
    `Code` tinyint,
    
);

create table ExamQuestion ();

