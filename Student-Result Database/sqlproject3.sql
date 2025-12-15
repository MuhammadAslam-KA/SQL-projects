#Student Result Database
create database stdntres_db;
use stdntres_db;
#Tables:

#Students (StudentID, Name, Department, Year)
create table Students(
student_id int primary key,
name varchar(50),
department varchar(50),
year int
);

#Subjects (SubjectID, SubjectName, Credits)
create table Subjects(
sub_id int primary key,
sub_name varchar(50),
credits int
);

#Marks (MarkID, StudentID, SubjectID, Marks)
create table Marks(
mark_id int primary key,
student_id int,
sub_id int,
marks int,
foreign key (student_id) references Students(student_id),
foreign key (sub_id) references Subjects(sub_id)
);

INSERT INTO Students (student_id, name, department, year) VALUES
(1, 'Arun Kumar', 'CSE', 2),
(2, 'Beena Joseph', 'ECE', 3),
(3, 'Charles Mathew', 'ME', 1),
(4, 'Diya Ravi', 'CSE', 2),
(5, 'Farhan Ali', 'ECE', 3),
(6, 'Greeshma S', 'ME', 1);

INSERT INTO Subjects (Sub_id, sub_name, credits) VALUES
(1, 'Data Structures', 4),
(2, 'Electronics', 3),
(3, 'Mechanics', 4),
(4, 'Mathematics', 3);

INSERT INTO Marks (mark_id, student_id, sub_id, marks) VALUES
-- Arun Kumar (CSE)
(1, 1, 1, 88),
(2, 1, 2, 67),
(3, 1, 3, 45),   -- failed
(4, 1, 4, 90),

-- Beena (ECE)
(5, 2, 1, 76),
(6, 2, 2, 81),
(7, 2, 3, 52),
(8, 2, 4, 60),

-- Charles (ME)
(9, 3, 1, 49),   -- failed
(10, 3, 2, 40),  -- failed
(11, 3, 3, 35),  -- failed
(12, 3, 4, 70),

-- Diya (CSE)
(13, 4, 1, 92),
(14, 4, 2, 58),
(15, 4, 3, 76),
(16, 4, 4, 85),

-- Farhan (ECE)
(17, 5, 1, 55),
(18, 5, 2, 37),  -- failed
(19, 5, 3, 42),  -- failed
(20, 5, 4, 65),

-- Greeshma (ME)
(21, 6, 1, 33),  -- failed
(22, 6, 2, 48),  -- failed
(23, 6, 3, 59),
(24, 6, 4, 44);  -- failed

#Queries:

#Get top 3 students in each subject
select s.name,su.sub_name,m.marks from Marks m
join Students s on m.student_id=s.student_id
join Subjects su on m.sub_id=su.sub_id
where su.sub_name='Data Structures'
order by marks desc limit 3;

select s.name,su.sub_name,m.marks from Marks m
join Students s on m.student_id=s.student_id
join Subjects su on m.sub_id=su.sub_id
where su.sub_name='Electronics'
order by marks desc limit 3;

select s.name,su.sub_name,m.marks from Marks m
join Students s on m.student_id=s.student_id
join Subjects su on m.sub_id=su.sub_id
where su.sub_name='Mechanics'
order by marks desc limit 3;

select s.name,su.sub_name,m.marks from Marks m
join Students s on m.student_id=s.student_id
join Subjects su on m.sub_id=su.sub_id
where su.sub_name='Mathematics'
order by marks desc limit 3;


#Calculate average marks per department
select s.department,avg(m.marks) as average_marks from Marks m
join Students s on m.student_id=s.student_id
group by s.department; 

#Find students who failed in more than 2 subjects
select s.name,count(*) as failed_subjects from Marks m
join Students s on m.student_id=s.student_id
where marks < 50 
group by s.name
HAVING COUNT(*) > 2;




