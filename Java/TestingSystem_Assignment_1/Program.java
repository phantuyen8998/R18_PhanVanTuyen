package TestingSystem_Assignment_1;

import java.time.LocalDate;

public class Program {

	public static void main(String[] args) {
		Department Department1 = new Department();
		Department1.id = 1;
		Department1.name = "Sale";

		Department Department2 = new Department();
		Department2.id = 2;
		Department2.name = "Marketing";

		Department Department3 = new Department();
		Department3.id = 3;
		Department3.name = "IT";

		Position Position1 = new Position();
		Position1.id = 1;
		Position1.name = PositionName.DEV;

		Position Position2 = new Position();
		Position2.id = 2;
		Position2.name = PositionName.TEST;

		Position Position3 = new Position();
		Position3.id = 3;
		Position3.name = PositionName.PM;

		Account Account1 = new Account();
		Account1.id = 1;
		Account1.Email = "phantuyen@gmail.com";
		Account1.Username = "phantuyen";
		Account1.FullName = "Phan Van Tuyen";
		Account1.Department = Department1;
		Account1.Position = Position1;
		Account1.CreateDate = LocalDate.of(2020, 01, 01);

		Account Account2 = new Account();
		Account2.id = 3;
		Account2.Email = "duyanh@gmail.com";
		Account2.Username = "duyanh";
		Account2.FullName = "Nguyen Duy Anh";
		Account2.Department = Department2;
		Account2.Position = Position2;
		Account2.CreateDate = LocalDate.of(2020, 03, 01);

		Account Account3 = new Account();
		Account3.id = 3;
		Account3.Email = "quocdai@gmail.com";
		Account3.Username = "quocdai";
		Account3.FullName = "Pham Quoc Dai";
		Account3.Department = Department3;
		Account3.Position = Position3;
		Account3.CreateDate = LocalDate.of(2020, 05, 01);

		Group Group1 = new Group();
		Group1.id = 1;
		Group1.name = "Lap trinh C#";
		Group1.Creator = Account1;
		Group1.CreateDate = LocalDate.of(2021, 01, 05);

		Group Group2 = new Group();
		Group2.id = 2;
		Group2.name = "Lap trinh JAVA";
		Group2.Creator = Account1;
		Group2.CreateDate = LocalDate.of(2021, 04, 05);

		Group Group3 = new Group();
		Group3.id = 3;
		Group3.name = "Lap trinh PHP";
		Group3.Creator = Account2;
		Group3.CreateDate = LocalDate.of(2021, 02, 25);

		Group[] GroupOfAccount1 = { Group1, Group2 };
		Account1.Groups = GroupOfAccount1;

		Group[] GroupOfAccount2 = { Group1, Group3 };
		Account2.Groups = GroupOfAccount2;

		Group[] GroupOfAccount3 = { Group3, Group2 };
		Account3.Groups = GroupOfAccount3;

		Account[] AccountOfGroup1 = { Account1, Account2 };
		Group1.Accounts = AccountOfGroup1;

		Account[] AccountOfGroup2 = { Account1, Account3 };
		Group2.Accounts = AccountOfGroup2;

		Account[] AccountOfGroup3 = { Account3, Account2 };
		Group3.Accounts = AccountOfGroup3;

		TypeQuestion TypeQuestion1 = new TypeQuestion();
		TypeQuestion1.id = 1;
		TypeQuestion1.name = TypeName.ESSAY;

		TypeQuestion TypeQuestion2 = new TypeQuestion();
		TypeQuestion2.id = 2;
		TypeQuestion2.name = TypeName.MULTIPLECHOICE;

		CategoryQuestion CategoryQuestion1 = new CategoryQuestion();
		CategoryQuestion1.id = 1;
		CategoryQuestion1.name = "JAVA";

		CategoryQuestion CategoryQuestion2 = new CategoryQuestion();
		CategoryQuestion2.id = 2;
		CategoryQuestion2.name = "SQL";

		CategoryQuestion CategoryQuestion3 = new CategoryQuestion();
		CategoryQuestion3.id = 3;
		CategoryQuestion3.name = ".Net";

		Question Question1 = new Question();
		Question1.id = 1;
		Question1.Content = "Java la gi?";
		Question1.Category = CategoryQuestion1;
		Question1.Creator = Account1;
		Question1.CreateDate = LocalDate.of(2021, 04, 05);
		Question1.Type = TypeQuestion1;

		Question Question2 = new Question();
		Question2.id = 2;
		Question2.Content = "SQL la gi?";
		Question2.Category = CategoryQuestion2;
		Question2.Creator = Account1;
		Question2.CreateDate = LocalDate.of(2021, 04, 06);
		Question2.Type = TypeQuestion1;

		Question Question3 = new Question();
		Question3.id = 3;
		Question3.Content = ".Net la gi?";
		Question3.Category = CategoryQuestion3;
		Question3.Creator = Account2;
		Question3.CreateDate = LocalDate.of(2021, 04, 07);
		Question3.Type = TypeQuestion2;

		Answer Answer1 = new Answer();
		Answer1.id = 1;
		Answer1.Content = "Java là ngôn ngữ lập trình.";
		Answer1.Question = Question1;
		Answer1.isCorrect = isCorrect.TRUE;

		Answer Answer2 = new Answer();
		Answer2.id = 2;
		Answer2.Content = "Java là ngôn ngữ lập trình hướng đối tượng.";
		Answer2.Question = Question1;
		Answer2.isCorrect = isCorrect.TRUE;

		Answer Answer3 = new Answer();
		Answer3.id = 3;
		Answer3.Content = "SQL là ngôn ngữ lập trình frontend.";
		Answer3.Question = Question2;
		Answer3.isCorrect = isCorrect.FALSE;

		Exam Exam1 = new Exam();
		Exam1.id = 1;
		Exam1.code = "A1";
		Exam1.Title = "Đề thi số 1";
		Exam1.Category = CategoryQuestion1;
		Exam1.Duration = 30;
		Exam1.Creator = Account1;
		Exam1.CreateDate = LocalDate.of(2021, 05, 05);

		Exam Exam2 = new Exam();
		Exam2.id = 2;
		Exam2.code = "A2";
		Exam2.Title = "Đề thi số 2";
		Exam2.Category = CategoryQuestion2;
		Exam2.Duration = 30;
		Exam2.Creator = Account2;
		Exam2.CreateDate = LocalDate.of(2021, 05, 06);

		Exam Exam3 = new Exam();
		Exam3.id = 3;
		Exam3.code = "A3";
		Exam3.Title = "Đề thi số 3";
		Exam3.Category = CategoryQuestion3;
		Exam3.Duration = 30;
		Exam3.Creator = Account1;
		Exam3.CreateDate = LocalDate.of(2021, 05, 07);

		Question[] QuestionOfExam1 = { Question1, Question2 };
		Exam1.Questions = QuestionOfExam1;

		Question[] QuestionOfExam2 = { Question1 };
		Exam2.Questions = QuestionOfExam2;

		Question[] QuestionOfExam3 = { Question3 };
		Exam3.Questions = QuestionOfExam3;

		Exam[] ExamOfQuestion1 = { Exam1, Exam2 };
		Question1.Exams = ExamOfQuestion1;

		Exam[] ExamOfQuestion2 = { Exam3 };
		Question2.Exams = ExamOfQuestion2;

		Exam[] ExamOfQuestion3 = { Exam1 };
		Question3.Exams = ExamOfQuestion3;

		// Department
		System.out.println("Phong ban Sale");
		System.out.println("Department ID:" + Department1.id);
		System.out.println("Department Name:" + Department1.name);
		System.out.println();

		// Position
		System.out.println("Chuc vu  dev ");
		System.out.println("Position ID:" + Position1.id);
		System.out.println("Position Name:" + Position1.name);
		System.out.println();

		// Account
		System.out.println("Account  Phan Van Tuyen");
		System.out.println("Id:" + Account1.id);
		System.out.println("Email:" + Account1.Email);
		System.out.println("UserName:" + Account1.Username);
		System.out.println("FullName:" + Account1.FullName);
		System.out.println("Department ID:" + Account1.Department.id);
		System.out.println("Position ID:" + Account1.Position.id);
		System.out.println("Ngay Tao:" + Account1.CreateDate);
		System.out.println("Cac nhom tham gia: ");
		for (int i = 0; i < Account1.Groups.length; i++) {
			System.out.print("      - "+Account1.Groups[i].name);
			System.out.println();
		}
		System.out.println();

		// Group
		System.out.println("Thong tin Group 1");
		System.out.println("Group ID:" + Group1.id);
		System.out.println("Group Name:" + Group1.name);
		System.out.println("Ngay tao: " + Group1.CreateDate);
		System.out.println("Creator ID:" + Group1.Creator.id);
		System.out.println("Cac thanh vien trong Group1: ");
		for (int i = 0; i < Group1.Accounts.length; i++) {
			System.out.print("      - "+Group1.Accounts[i].FullName);
			System.out.println();
		}
		System.out.println();
		
		//TypeQuestion
		System.out.println("Thong tin TypeQuestion 1");
		System.out.println("TypeID: " + TypeQuestion1.id);
		System.out.println("TypeName: " + TypeQuestion1.name);
		System.out.println();
		
		//CategoryQuestion
		System.out.println("Thong tin CategoryQuestion 1");
		System.out.println("CategoryID: " + CategoryQuestion1.id);
		System.out.println("CategoryName: " + CategoryQuestion1.name);
		System.out.println();
		
		//Question
		System.out.println("Thong tin Question 1");
		System.out.println("QuestionID: " + Question1.id);
		System.out.println("Content: " + Question1.Content);
		System.out.println("CategoryName: " + Question1.Category.name);
		System.out.println("TypeName: " + Question1.Type.name);
		System.out.println("CreatorName: " + Question1.Creator.FullName);
		System.out.println("CreateDate: " + Question1.CreateDate);
		System.out.println("Các Exam chứa Question 1: ");
		for (int i = 0; i < Question1.Exams.length; i++) {
			System.out.println("      - " +Question1.Exams[i].code);
		}
		System.out.println();
		
		//Answer
		System.out.println("Thong tin Answer 1");
		System.out.println("AnswerID: " + Answer1.id);
		System.out.println("Content: " + Answer1.Content);
		System.out.println("Question: " + Answer1.Question.id);
		System.out.println("isCorrect: " + Answer1.isCorrect);
		System.out.println();
		
		//Exam
		System.out.println("Thong tin Exam 1");
		System.out.println("ExamID: " + Exam1.id);
		System.out.println("Code: " + Exam1.code);
		System.out.println("Title: " + Exam1.Title);
		System.out.println("CategoryName: " + Exam1.Category.name);
		System.out.println("Duration: " + Exam1.Duration);
		System.out.println("CreatorName: " + Exam1.Creator.FullName);
		System.out.println("CreateDate: " + Exam1.CreateDate);
		System.out.println("Cac cau hoi trong exam 1 la: ");
		for (int i = 0; i < Exam1.Questions.length; i++) {
			System.out.println("      - " +Exam1.Questions[i].Content);
		}
		System.out.println();
	}

}
