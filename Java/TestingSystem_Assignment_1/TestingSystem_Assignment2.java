package TestingSystem_Assignment_1;

import java.util.Scanner;
import java.lang.String;
import java.time.LocalDate;

public class TestingSystem_Assignment2 {
	public static void main(String[] args) {

		// Exercise 5: Input from console
		// Question 1:
		// Viết lệnh cho phép người dùng nhập 3 số nguyên vào chương trình
		int a, b, c;
		Scanner sc = new Scanner(System.in);
		System.out.printf("Nhập vào số nguyên a: ");
		a = sc.nextInt();
		System.out.printf("Nhập vào số nguyên b: ");
		b = sc.nextInt();
		System.out.printf("Nhập vào số nguyên c: ");
		c = sc.nextInt();
		// Question 2:
		// Viết lệnh cho phép người dùng nhập 2 số thực vào chương trình
		float x, y;
		System.out.printf("Nhập vào số thực x: ");
		x = sc.nextFloat();
		System.out.printf("Nhập vào số thực y: ");
		y = sc.nextFloat();
		// Question 3:
		// Viết lệnh cho phép người dùng nhập họ và tên

		System.out.printf("Nhập họ và tên: ");
		String hovaten = sc.next();

		// Question 4:
		// Viết lệnh cho phép người dùng nhập vào ngày sinh nhật của họ
		String birthday = "yyyy-mm-dd";
		System.out.printf("Nhập ngày sinh: ");
		birthday = sc.next();
		
	}

	// Question 5:
	// Viết lệnh cho phép người dùng tạo account (viết thành method)
	// Đối với property Position, Người dùng nhập vào 1 2 3 4 5 và vào
	// chương trình sẽ chuyển thành Position.Dev, Position.Test,
	// Position.ScrumMaster, Position.PM
	void Q5() {
		Scanner sc = new Scanner(System.in);
		Account Account_n = new Account();
		System.out.println("Acc ID: ");
		Account_n.id = sc.nextInt();
		System.out.println("Email : ");
		Account_n.Email = sc.nextLine();
		System.out.println("User Name: ");
		Account_n.Username = sc.nextLine();
		System.out.println("DepartmentID: ");
		Account_n.Department.id = sc.nextByte();
		System.out.println("PositionID: ");
		Account_n.Position.id = sc.nextInt();
		switch (Account_n.Position.id) {
		case 1:
			Account_n.Position.name = PositionName.DEV;
			break;
		case 2:
			
			Account_n.Position.name = PositionName.TEST;
			break;
		case 3:
			Account_n.Position.name = PositionName.PM;
			break;
		case 4:
			Account_n.Position.name = PositionName.SCRUMMATER;
			break;
		default:
			break;

		}
		//System.out.println("Create Date: ");
		//Account_n.CreateDate = sc.nextLine();

	}

	// Question 6:
	// Viết lệnh cho phép người dùng tạo department (viết thành method)
	void Q6(){
		Scanner sc = new Scanner(System.in);
        Department dep = new Department();
        System.out.println("Dep ID: ");
        dep.id = sc.nextByte();
        System.out.println("Dep Name: ");
        dep.name = sc.nextLine();
    }
	// Question 7:
	// Nhập số chẵn từ console
	void Q7(){
		Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if(n%2 == 0){
            System.out.println("So Chan");
        }else{
            System.out.println("So le");
        }
    }
	// Question 8:
	// Viết chương trình thực hiện theo flow sau:
	// Bước 1:
	// Chương trình in ra text "mời bạn nhập vào chức năng muốn sử
	// dụng"
	// Bước 2:
	// Nếu người dùng nhập vào 1 thì sẽ thực hiện tạo account
	// Nếu người dùng nhập vào 2 thì sẽ thực hiện chức năng tạo
	// department
	// Nếu người dùng nhập vào số khác thì in ra text "Mời bạn nhập
	// lại" và quay trở lại bước 1
	
	void Q8(){
		Scanner sc = new Scanner(System.in);
        int n = 0;
        do {
            System.out.println("mời bạn nhập vào chức năng muốn sử dụng: ");
            n = sc.nextInt();
            switch (n) {

                case 1:
                    System.out.println("Nhập thông tin");
                    Account acc = new Account();
                    Department dep = new Department();
                    System.out.println("Acc ID: ");
                    acc.id = sc.nextInt();
                    System.out.println("Email : ");
                    acc.Email = sc.next();
                    System.out.println("User Name: ");
                    acc.Username = sc.next();
                    System.out.println("DepartmentID: ");
                    acc.Department.id = sc.nextByte();
                    System.out.println("PositionID: ");
                    acc.Position.id = sc.nextInt();
                    System.out.println("Create Date: ");
                    //acc.CreateDate = sc.next();

                    break;
                case 2:
                    System.out.println("Nhập thông tin");
                    Department dep1 = new Department();
                    System.out.println("Dep ID: ");
                    dep1.id = sc.nextByte();
                    System.out.println("Dep Name: ");
                    dep1.name = sc.next();
                    break;
            }
        }while (n!=0);
    }


	// Question 9:
	// Viết method cho phép người dùng thêm group vào account theo flow sau:
	// Bước 1:
	// In ra tên các usernames của user cho người dùng xem
	// Bước 2:
	// Yêu cầu người dùng nhập vào username của account
	// Bước 3:
	// In ra tên các group cho người dùng xem
	// Bước 4:
	// Yêu cầu người dùng nhập vào tên của group
	// Bước 5:
	// Dựa vào username và tên của group người dùng vừa chọn, hãy
	// thêm account vào group đó .
	
	

	// Question 10: Tiếp tục Question 8 và Question 9
	// Bổ sung thêm vào bước 2 của Question 8 như sau:
	// Nếu người dùng nhập vào 3 thì sẽ thực hiện chức năng thêm group vào
	// account
	// Bổ sung thêm Bước 3 của Question 8 như sau:
	// Sau khi người dùng thực hiện xong chức năng ở bước 2 thì in ra dòng
	// text để hỏi người dùng "Bạn có muốn thực hiện chức năng khác
	// không?". Nếu người dùng chọn "Có" thì quay lại bước 1, nếu người
	// dùng chọn "Không" thì kết thúc chương trình (sử dụng lệnh return để
	// kết thúc chương trình)
	// Question 11: Tiếp tục Question 10
	// Bổ sung thêm vào bước 2 của Question 8 như sau:
	// Nếu người dùng nhập vào 4 thì sẽ thực hiện chức năng thêm account
	// vào 1 nhóm ngẫu nhiên, chức năng sẽ được cài đặt như sau:
	// Bước 1:
	// In ra tên các usernames của user cho người dùng xem

}
