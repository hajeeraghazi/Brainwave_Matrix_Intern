-- Create the library database
CREATE DATABASE LibraryDB;

-- Create the Books table
CREATE TABLE Books (
    Book_id INT NOT NULL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Published_Year INT,
    Genre VARCHAR(50),
    Available_Copies INT
);

-- Create the Members table
CREATE TABLE Members (
    Member_id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Join_Date DATE
);

-- Create the Borrowed_Books table
CREATE TABLE Borrowed_Books (
    Borrow_id INT NOT NULL PRIMARY KEY,
    Book_Id INT,
    Member_Id INT,
    Borrow_Date DATE,
    Return_Date DATE,
    FOREIGN KEY (Book_Id) REFERENCES Books (Book_Id),
    FOREIGN KEY (Member_Id) REFERENCES Members (Member_Id)
);

-- Insert sample records (you can add more)
INSERT INTO Books (Book_Id, Title, Author, Published_Year, Genre, Available_Copies)
VALUES
    (551, 'The Great Gatsby', 'F. Scott Fitzgerald', 19250410, 'Tragedy', 10000),
    -- ... (other book records)
    ;

INSERT INTO Members (Member_Id, Name, Email, Join_Date)
VALUES
    (1, 'John Doe', 'john@example.com', '2024-06-01'),
    -- ... (other member records)
    ;

INSERT INTO Borrowed_Books (Borrow_id, Book_Id, Member_Id, Borrow_Date, Return_Date)
VALUES
    (1, 551, 1, '2024-06-10', '2024-06-20'),
    -- ... (other borrowing records)
    ;
