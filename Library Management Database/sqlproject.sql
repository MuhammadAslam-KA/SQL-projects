create database librarydb;
use librarydb;

create table Books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
genre VARCHAR(100),
published_year YEAR,
is_available BOOLEAN DEFAULT TRUE
);

create table Members(
member_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
email VARCHAR(255),
phone_number VARCHAR(15),
join_date DATE DEFAULT (CURRENT_DATE)
);

create table Librarians(
librarian_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
email VARCHAR(255),
phone_number VARCHAR(15),
hire_date DATE DEFAULT (CURRENT_DATE)
);

create table Borrowing(
loan_id INT AUTO_INCREMENT PRIMARY KEY,
book_id INT,
member_id INT,
borrow_date DATE DEFAULT (CURRENT_DATE),
return_date DATE,
librarian_id INT,
FOREIGN KEY (book_id) REFERENCES Books(book_id),
FOREIGN KEY (member_id) REFERENCES Members(member_id),
FOREIGN KEY (librarian_id) REFERENCES Librarians(librarian_id)
);

insert into Books(title,author,genre,published_year) values
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
('1984', 'George Orwell', 'Dystopian', 1949),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960);

insert into Members(name,email,phone_number) values 
('Alen King', 'alenking@example.com', '1234567890'),
('Alece Hofman', 'alecehofman@example.com', '9876543210');

insert into Librarians(name,email,phone_number) values
('Nail Horn', 'nail@example.com', '4567891230'),
('Garden McGraw', 'garden@example.com', '7894561230');


#Borrowing a book
insert into Borrowing(book_id,member_id,librarian_id) values(1,1,1);
update Books set is_available = false where book_id=1;

# returning a book
update Borrowing set return_date = current_date where loan_id=1;
update Books set is_available = true where book_id=1;

#list of available books
select * from Books where is_available = True;

#Books by 'George Orwell'
select title,genre,published_year from Books where author = "George Orwell" ;

#book published after 2000
select title,genre,author from Books where published_year > 2000;

#total books in library
select count(book_id) from Books where is_available=True;

#avaialbe fiction books
select title,author,published_year from Books where genre = 'fiction' and is_available = true;

#member loan history
select m.name,b.title,br.borrow_date,br.return_date from Borrowing br 
join Members m on br.member_id=m.member_id
join Books b on br.book_id=b.book_id
where m.member_id=1;

#Overdue books (>14 days)
select m.name,b.title,br.borrow_date from Borrowing br
join Members m on br.member_id=m.member_id
join Books b on br.book_id = b.book_id
where br.return_date is null and br.borrow_date < current_date - interval 14 day;

# Members who borrowed '1984'
select m.name,br.borrow_date,br.return_date from Borrowing br
join  Members m on br.member_id=m.member_id
join Books b on br.book_id=b.book_id
where b.title="1984";

# Borrowing history for member 
select b.title,br.borrow_date,br.return_date from Borrowing br
join Books b on br.book_id=b.book_id
where br.member_id=1;

#Total books borrowed per member
select m.name,count(br.loan_id) as total_books_borrowed from Borrowing br
join Members m on br.member_id=m.member_id
group by m.name;

#Overdue books not returned (>30 days)
select m.name,b.title,br.borrow_date from Borrowing br
join Members m on br.member_id = m.member_id
join Books b on br.book_id = b.book_id
where br.return_date is null and br.borrow_date < current_date - interval 30 day;

#Top librarians by borrowings
select l.name,count(br.loan_id) as total_borrowings from Borrowing br 
join Librarians l on br.librarian_id=l.librarian_id 
group by l.name
order by total_borrowings desc;

#Currently borrowed books
select m.name,b.title,br.borrow_date from Borrowing br
join Members m on br.member_id = m.member_id
join Books b on br.book_id = b.book_id
where br.return_date is null;






