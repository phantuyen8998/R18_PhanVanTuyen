-- "Testing_System_Assignment_5"

use testingsystem1;
-- Exercise 1: Tiếp tục với Database Testing System (Sử dụng subquery hoặc CTE
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- Cách 1
Create View DanhSachNV As
Select a.AccountID, a.FullName from `Account` a
join Department d
on a.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sale';

select * from DanhSachNV;

-- Cách 2
With DSNV as (Select a.AccountID, a.FullName from `Account` a
join Department d
on a.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sale')
select *from DSNV;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- Cách 1

Drop view thongtin;
Create view thongtin as
select a.AccountID, a.FullName, count(ga.GroupID) as TGmax
from `Account` a
join GroupAccount ga
on  a.AccountID =  ga.AccountID
group by a.AccountID
having TGmax = ( select max(TGmax) From (
				Select count(ga.GroupID) as TGmax
                from `Account` a
				join GroupAccount ga
				on  a.AccountID =  ga.AccountID
				group by a.AccountID ) as maxi
);
select * from thongtin;

-- Cách 2
SELECT a.*,COUNT(a.AccountID)  as thamgianhieunhat
FROM Account a
JOIN GroupAccount ga
ON a.AccountID=ga.AccountID
GROUP BY ga.AccountID
HAVING thamgianhieunhat= (
	SELECT Max(thamgianhieunhat) 
	FROM (SELECT COUNT(a.AccountID) as thamgianhieunhat  
	FROM `Account` a  
	JOIN GroupAccount ga
	ON a.AccountID=ga.AccountID
	GROUP BY ga.AccountID) as max );

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 30 từ được coi là quá dài) và xóa nó đi
Create view DeleteContent as
Select QuestionID, Content, Length(Content)
From Question
Where Length(Content) > 30 ;

commit;

Delete
From Question 
Where Length(Content) > 30;

rollback;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
Drop view DSPB;
Create view DSPB as
Select d.DepartmentID, d.DepartmentName, Count(a.AccountID) as NVMax
From Department d 
Join `Account` a
on d.DepartmentID = a.DepartmentID
group by d.DepartmentID
having NVMax = (
Select max(NVMax) From (
	Select Count(a.AccountID) as NVMax
    From Department d 
	Join `Account` a
	on d.DepartmentID = a.DepartmentID
    group by d.DepartmentID
) as NVM
);

select * from DSPB;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
Drop view QuestionNg;
Create View QuestionNg as
select q.QuestionID, q.Content, a.FullName
from Question q
join `Account` a
on q.CreatorID = a.AccountID
where FullName like 'Nguyen%';  

select * from QuestionNg;

