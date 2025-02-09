-- 1. Створення бази даних
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- 2. Створення таблиці authors
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- 3. Створення таблиці genres
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

-- 4. Створення таблиці books
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);

-- 5. Створення таблиці users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- 6. Створення таблиці borrowed_books
CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 7. Наповнення таблиць тестовими даними

-- Додавання авторів
INSERT INTO authors (author_name) VALUES 
('George Orwell'),
('J.K. Rowling');

-- Додавання жанрів
INSERT INTO genres (genre_name) VALUES 
('Dystopian'),
('Fantasy');

-- Додавання книг
INSERT INTO books (title, publication_year, author_id, genre_id) VALUES 
('1984', 1949, 1, 1),
('Harry Potter and the Sorcerer\'s Stone', 1997, 2, 2);

-- Додавання користувачів
INSERT INTO users (username, email) VALUES 
('john_doe', 'john@example.com'),
('alice_smith', 'alice@example.com');

-- Додавання записів про взяті книги
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES 
(1, 1, '2024-02-01', '2024-02-15'),
(2, 2, '2024-02-05', NULL);

