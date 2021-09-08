DROP DATABASE testingsystem1;
create database testingsystem1;

use testingsystem1;

CREATE TABLE Department (
    DepartmentID TINYINT,
    DepartmentName VARCHAR(30)
);

CREATE TABLE Position (
    PositionID TINYINT UNSIGNED,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

CREATE TABLE `Account` (
    AccountID INT UNSIGNED,
    Email VARCHAR(30),
    Username VARCHAR(30),
    FullName VARCHAR(30),
    DepartmentID TINYINT,
    PositionID TINYINT,
    CreateDate DATE
);

CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED,
    GroupName VARCHAR(30),
    CreatorID INT,
    CreateDate DATE
);

CREATE TABLE GroupAccount (
    GroupID TINYINT,
    AccountID INT,
    JoinDate DATE
);

CREATE TABLE TypeQuestion (
    TypeID INT,
    TypeName ENUM('Essay', 'Multiple-Choice')
);

CREATE TABLE CategoryQuestion (
    CategoryID TINYINT,
    CategoryName ENUM('Java', '.NET', 'SQL', 'Postman', 'Ruby')
);

CREATE TABLE Question (
    QuestionID INT,
    Content VARCHAR(200),
    CategoryID TINYINT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE
);

CREATE TABLE Answer (
    AnswerID INT,
    Content VARCHAR(200),
    QuestionID INT,
    isCorrect ENUM('True', 'False')
);

CREATE TABLE Exam (
    ExamID INT,
    `Code` TINYINT,
    Title VARCHAR(100),
    CategoryID TINYINT,
    Duration TIME,
    CreatorID INT,
    CreateDate DATE
);

CREATE TABLE ExamQuestion (
    ExamID INT,
    QuestionID INT
);

