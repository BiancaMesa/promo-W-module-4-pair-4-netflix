use Netflix; 

create table movies (
	idMovies int auto_increment not null primary key, 
    title varchar(45) not null, 
    genre varchar(45) not null, 
    image varchar(1000) not null, 
    category varchar(45) not null, 
    movieYear int
);

create table Users (
	idUsers int auto_increment not null primary key, 
    users varchar(45) not null, 
    passwordUsers varchar(45) not null, 
    nameUsers varchar(45) not null, 
    email varchar(45) not null,
    plan_details varchar(45) not null
);

create table Actors (
	idActors int auto_increment not null primary key, 
    nameActors varchar(45) not null,
    lastName varchar(45) not null,
    country varchar(45) not null,
    birthday date
);


-- DAY 2 
-- MOVIES 
SELECT title, genre FROM movies;
SELECT title FROM movies WHERE category = 'Top 10';
UPDATE movies SET movieYear = 1997 WHERE idMovies = 2;

-- ACTORS 
SELECT * FROM Actors; 
SELECT nameActors FROM Actors WHERE birthday BETWEEN '1950-01-01' AND '1960-12-31';  
SELECT nameActors, lastName FROM Actors WHERE country = 'United States';  

-- USERS 
SELECT * FROM Users WHERE plan_details = "standard"; 
DELETE FROM Users WHERE idUsers >= 1 AND nameUsers LIKE 'M%';

-- BONUS
ALTER TABLE Actors ADD COLUMN image varchar(1000) not null;
INSERT INTO Actors (image)
VALUES 
('https://upload.wikimedia.org/wikipedia/commons/a/a9/Tom_Hanks_TIFF_2019.jpg'), 
('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Roberto_Benigni-5274.jpg/1200px-Roberto_Benigni-5274.jpg'), 
('https://m.media-amazon.com/images/M/MV5BMTMyMjZlYzgtZWRjMC00OTRmLTllZTktMmM1ODVmNjljMTQyXkEyXkFqcGdeQXVyMTExNzQ3MzAw._V1_.jpg');

UPDATE Actors SET image = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Tom_Hanks_TIFF_2019.jpg' WHERE idActors = 1; 
UPDATE Actors SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Roberto_Benigni-5274.jpg/1200px-Roberto_Benigni-5274.jpg', image = 'https://m.media-amazon.com/images/M/MV5BMTMyMjZlYzgtZWRjMC00OTRmLTllZTktMmM1ODVmNjljMTQyXkEyXkFqcGdeQXVyMTExNzQ3MzAw._V1_.jpg' WHERE idActors > 1; 

-- BORRAR TABLA: DROP TABLE nombre_tabla; 
-- BORRAR BASE DATOS: DROP DATABASE nombre_database;

