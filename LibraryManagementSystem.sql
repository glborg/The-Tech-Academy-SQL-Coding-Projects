CREATE DATABASE Library
GO

USE [Library];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[populate_library]
AS
BEGIN

/*	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES )
		DROP TABLE ; */

--CREATE TABLES--

	CREATE TABLE library_branch (
		BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		BranchName VARCHAR (50) NOT NULL,
		Address VARCHAR (50) NOT NULL
	);

	CREATE TABLE publisher (
		PublisherName VARCHAR (50) PRIMARY KEY NOT NULL,
		Address VARCHAR (50) NOT NULL,
		Phone VARCHAR (15) NOT NULL,
	);

	CREATE TABLE books (
		BookID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Title VARCHAR(50) NOT NULL,
		PublisherName VARCHAR (50) NOT NULL
	);

	CREATE TABLE book_authors (
		BookID INT NOT NULL CONSTRAINT fk_BookIDAuthors FOREIGN KEY REFERENCES books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		AuthorName VARCHAR(50) NOT NULL
	);

	CREATE TABLE book_copies (
		BookID INT NOT NULL CONSTRAINT fk_BookIDCopies FOREIGN KEY REFERENCES books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL,
		Number_Of_Copies INT NOT NULL
	);

	CREATE TABLE borrower (
		CardNo INT PRIMARY KEY NOT NULL IDENTITY (3000,1),
		Name VARCHAR(50) NOT NULL,
		Address VARCHAR(50) NOT NULL,
		Phone VARCHAR(15) NOT NULL
	);

	CREATE TABLE book_loans (
		BookID INT NOT NULL CONSTRAINT fk_BookIDLoans FOREIGN KEY REFERENCES books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT fk_BranchIDLoans FOREIGN KEY REFERENCES library_branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		CardNo INT NOT NULL CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		DateOut DATETIME NOT NULL,
		DateDue DATETIME NOT NULL
	);

--INSERT DATA--

	INSERT INTO library_branch
		(BranchName, Address)
		VALUES
		('Sharpstown', '1131 NE 10th Pl'),
		('Central', '6037 SW 6th Ave'),
		('Downtown', '302 S Lincoln St'),
		('Satellite', '9999 BFE Ter')
	;

	INSERT INTO publisher
		(Name, Address, Phone)
		VALUES
		('Penguin', '580 N 1st Dr', '352-393-9686'),
		('Random House', '109 Integer Way', '484-859-2947'),
		('Simon and Schuster', '337 E 6th St', '384-954-9279')
	;
	INSERT INTO books
		(Title, PublisherName)
		VALUES
		('The Lost Tribe', 'Random House'),
		('It', 'Random House'),
		('The Shining', 'Random House'),
		('Misery', 'Random House'),
		('Dune', 'Penguin'),
		('1984', 'Penguin'),
		('The Martian', 'Penguin'),
		('Fahrenheit 451', 'Simon and Schuster'),
		('The Forever War', 'Simon and Schuster'),
		('The Left Hand of Darkness', 'Simon and Schuster'),
		('Neuromancer', 'Simon and Schuster'),
		('Frankenstein', 'Random House'),
		('Brave New World', 'Penguin'),
		('Slaughterhosue-Five', 'Simon and Schuster'),
		('The Time Machine', 'Random Hosue'),
		('Stranger in a Strange Land', 'Penguin'),
		('Snow Crash', 'Simon and Schuster'),
		('The Martian Chronicles', 'Random House'),
		('A Wrinkle In Time', 'Penguin'),
		('Ancillary Justice', 'Simon and Schuster')
	;

	INSERT INTO book_authors
		(BookID, AuthorName)
		VALUES
		(1, 'Mark Lee'),
		(2, 'Stephen King'),
		(3, 'Stephen King'),
		(4, 'Stephen King'),
		(5, 'Frank Herbert'),
		(6, 'George Orwell'),
		(7, 'Andy Weir'),
		(8, 'Ray Bradbury'),
		(9, 'Joe Haldeman'),
		(10, 'Ursula K. LeGuin'),
		(11, 'William Gibson'),
		(12, 'Mary Shelley'),
		(13, 'Aldous Huxley'),
		(14, 'Kurt Vonnegut'),
		(15, 'H. G. Wells'),
		(16, 'Robert A. Heinlein'),
		(17, 'Neal Stephenson'),
		(18, 'Ray Bradbury'),
		(19, 'Madeleine LEngle'),
		(20, 'Ann Leckie')
	;

	INSERT INTO book_copies
		(BookID, BranchID, Number_Of_Copies)
		VALUES
		(1, 1, 3),
		(1, 2, 4),
		(1, 3, 2),
		(1, 4, 0),
		(2, 1, 2),
		(2, 2, 3),
		(2, 3, 1),
		(2, 4, 1),
		(3, 1, 4),
		(3, 2, 3),
		(3, 3, 7),
		(3, 4, 4),
		(4, 1, 3),
		(4, 2, 0),
		(4, 3, 3),
		(4, 4, 1),
		(5, 1, 3),
		(5, 2, 1),
		(5, 3, 1),
		(5, 4, 0),
		(6, 1, 4),
		(6, 2, 3),
		(6, 3, 8),
		(6, 4, 2),
		(7, 1, 0),
		(7, 2, 3),
		(7, 3, 2),
		(7, 4, 6),
		(8, 1, 2),
		(8, 2, 5),
		(8, 3, 3),
		(8, 4, 1),
		(9, 1, 6),
		(9, 2, 3),
		(9, 3, 7),
		(9, 4, 3),
		(10, 1, 6),
		(10, 2, 5),
		(10, 3, 2),
		(10, 4, 2),
		(11, 1, 4),
		(11, 2, 3),
		(11, 3, 5),
		(11, 4, 3),
		(12, 1, 4),
		(12, 2, 1),
		(12, 3, 2),
		(12, 4, 0),
		(13, 1, 4),
		(13, 2, 2),
		(13, 3, 3),
		(13, 4, 1),
		(14, 1, 2),
		(14, 2, 3),
		(14, 3, 6),
		(14, 4, 2),
		(15, 1, 4),
		(15, 2, 6),
		(15, 3, 4),
		(15, 4, 3),
		(16, 1, 1),
		(16, 2, 5),
		(16, 3, 6),
		(16, 4, 2),
		(17, 1, 7),
		(17, 2, 9),
		(17, 3, 4),
		(17, 4, 5),
		(18, 1, 6),
		(18, 2, 2),
		(18, 3, 3),
		(18, 4, 6),
		(19, 1, 7),
		(19, 2, 4),
		(19, 3, 3),
		(19, 4, 5),
		(20, 1, 5),
		(20, 2, 4),
		(20, 3, 7),
		(20, 4, 2),
	;
	INSERT INTO borrower
		(Name, Address, Phone)
		VALUES
		('Jennifer Bluth', '939 W 7th Ter', '383-959-8631'),
		('Todd Glass', '23 N Parkway Ave', '383-591-9800'),
		('Jack Ryan', '591 Main Street', '803-817-9383'),
		('Anne Gibson', '5 SW Parker Street', '393-020-9480'),
		('Sandra Lackie', '1177 Depot Way', '944-826-4314'),
		('Matthew Heim', '0303 W Marshal Ave', '383-928-9388'),
		('Audrey Anderson', '300 NE 10th Dr', '383-290-3939'),
		('Reagon Madison', '0939 S Archer Rd', '202-596-9239')
	;

	INSERT INTO  book_loans
		(BookID, BranchID, CardNo, DateOut, DateDue)
		VALUES
		(1, 1, 3001, '2018-09-25', '2018-10-25'),
		(3, 1, 3001, '2018-09-25', '2018-10-25'),
		(15, 1, 3001, '2018-09-25', '2018-10-25'),
		(17, 1, 3001, '2018-09-25', '2018-10-25'),
		(18, 1, 3001, '2018-09-25', '2018-10-25'),
		(19, 1, 3001, '2018-09-25', '2018-10-25'),
		(20, 1, 3001, '2018-09-25', '2018-10-25'),
		(3, 3, 3002, '2018-09-25', '2018-10-25'),
		(4, 3, 3002, '2018-09-25', '2018-10-25'),
		(5, 3, 3002, '2018-09-25', '2018-10-25'),
		(6, 3, 3002, '2018-09-25', '2018-10-25'),
		(7, 3, 3002, '2018-09-25', '2018-10-25'),
		(8, 3, 3002, '2018-09-25', '2018-10-25'),
		(9, 3, 3002, '2018-09-25', '2018-10-25'),
		(10, 3, 3002, '2018-09-25', '2018-10-25'),
		(11, 3, 3002, '2018-09-25', '2018-10-25'),
		(12, 3, 3002, '2018-09-25', '2018-10-25'),
		(13, 3, 3002, '2018-09-25', '2018-10-25'),
		(11, 1, 3003, '2018-09-25', '2018-10-25'),
		(15, 2, 3003, '2018-09-25', '2018-10-25'),
		(19, 1, 3004, '2018-09-25', '2018-10-25'),
		(17, 3, 3005, '2018-09-25', '2018-10-25'),
		(18, 2, 3006, '2018-09-25', '2018-10-25'),
		(2, 1, 3007, '2018-09-25', '2018-10-25'),
		(3, 3, 3008, '2018-09-25', '2018-10-25'),
		(4, 4, 3004, '2018-08-25', '2018-09-25'),
		(5, 2, 3002, '2018-08-25', '2018-09-25'),
		(7, 4, 3001, '2018-08-25', '2018-09-25'),
		(10, 2, 3008, '2018-08-25', '2018-09-25'),
		(15, 2, 3008, '2018-08-25', '2018-09-25'),
		(16, 1, 3002, '2018-08-25', '2018-09-25'),
		(1, 4, 3007, '2018-08-25', '2018-09-25'),
		(8, 3, 3006, '2018-08-25', '2018-09-25'),
		(9, 1, 3001, '2018-08-25', '2018-09-25'),
		(11, 2, 3004, '2018-08-25', '2018-09-25'),
		(12, 3, 3005, '2018-08-25', '2018-09-25'),
		(13, 4, 3006, '2018-08-25', '2018-09-25'),
		(14, 2, 3004, '2018-08-25', '2018-09-25'),
		(15, 3, 3007, '2018-08-25', '2018-09-25'),
		(16, 4, 3008, '2018-08-25', '2018-09-25'),
		(17, 1, 3001, '2018-08-25', '2018-09-25'),
		(18, 2, 3002, '2018-08-25', '2018-09-25'),
		(19, 3, 3003, '2018-08-25', '2018-09-25'),
		(20, 4, 3004, '2018-08-25', '2018-09-25'),
		(1, 1, 3001, '2018-08-25', '2018-09-25'),
		(2, 2, 3002, '2018-08-25', '2018-09-25'),
		(3, 2, 3003, '2018-08-25', '2018-09-25'),
		(4, 1, 3004, '2018-08-25', '2018-09-25'),
		(5, 2, 3005, '2018-08-25', '2018-09-25'),
		(6, 2, 3006, '2018-08-25', '2018-09-25')
	;