EXEC [dbo].[populate_library]

--1--

USE [Library]
GO

CREATE PROCEDURE dbo.uspQ1 @branch varchar(15), @book varchar(30)
AS

	SELECT BranchName, Title, Number_of_Copies
	FROM book_copies
		INNER JOIN library_branch ON book_copies.BranchID = library_branch.BranchID
		INNER JOIN books ON book_copies.BookID = books.BookID
	WHERE
		books.Title = @book AND
		library_branch.BranchName = @branch
GO

EXECUTE dbo.uspQ1 @branch = 'Sharpstown', @book = 'The Lost Tribe'

--2--

USE [Library]
GO

CREATE PROC dbo.uspQ2 @book varchar(30)
AS
	SELECT BranchName, Number_of_Copies
	FROM library_branch
		INNER JOIN book_copies ON library_branch.BranchID = book_copies.BranchID
		INNER JOIN books ON book_copies.BookID = books.BookID
	WHERE
		books.Title = @book
GO

EXEC dbo.uspQ2 @book = 'The Lost Tribe'

--3--

USE [Library]
GO

CREATE PROC dbo.uspQ3
AS
	SELECT Name FROM borrower
		LEFT JOIN book_loans ON borrower.CardNo = book_loans.CardNo
	WHERE book_loans.BookID IS NULL
GO

EXEC dbo.uspQ3

--4--

USE [Library]
GO

CREATE PROC dbo.uspQ4 @dueDate DATETIME
AS
	SELECT books.Title, borrower.Name, borrower.Address
	FROM book_loans
		INNER JOIN borrower ON book_loans.CardNo = borrower.CardNo
		INNER JOIN books ON book_loans.BookID = books.BookID
	WHERE book_loans.DateDue = @dueDate
GO

EXEC dbo.uspQ4 @dueDate = GETDATE()

--5--

USE [Library]
GO

CREATE PROC dbo.uspQ5
AS
	SELECT BranchName, COUNT(*)
	FROM library_branch
		INNER JOIN book_loans ON library_branch.BranchID = book_loans.BranchID
	GROUP BY BranchName
GO

EXEC dbo.uspQ5

--6--

USE [Library]
GO

CREATE PROC dbo.uspQ6
AS
	SELECT borrower.Name, borrower.Address, COUNT(book_loans.CardNo)
	FROM borrower
		INNER JOIN book_loans ON borrower.CardNo = book_loans.CardNo
	GROUP BY borrower.Name, borrower.Address
	HAVING COUNT(book_loans.CardNo) > 5
GO

EXEC dbo.uspQ6

--7--

USE [Library]
GO

CREATE PROC uspQ7 @branch VARCHAR(15), @author VARCHAR(30)
AS
	SELECT books.Title, book_copies.Number_Of_Copies
	FROM book_copies
		INNER JOIN library_branch ON book_copies.BranchID = library_branch.BranchID
		INNER JOIN books ON book_copies.BookID = books.BookID
		INNER JOIN book_authors ON books.BookID = book_authors.BookID
	WHERE library_branch.BranchName = @branch and book_authors.AuthorName = @author
GO

EXEC dbo.uspQ7 @branch = 'Central', @author = 'Stephen King'