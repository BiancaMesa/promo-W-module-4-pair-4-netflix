-- Insertar valores en la tabla users_has_movies = películas favoritas:

INSERT INTO users_has_movies(fk_idUsers, fk_idMovies)
VALUES (1, 1), (1,2), (3,3);

-- Añadir columna a tabla users_has_movies para especificar la puntuación que cada usuaria le da a sus películas favoritas:

ALTER TABLE users_has_movies DROP COLUMN score;

ALTER TABLE users_has_movies ADD score FLOAT not null;


-- Si queremos que todas las columnas tengan la misma puntuación:
UPDATE users_has_movies
SET score = 9.99
WHERE id_users_has_movies IN (1, 2, 3);


-- Si queremos que cada columna tenga una puntuación distinta
UPDATE users_has_movies
SET score = 9.99
WHERE id_users_has_movies = 1;

UPDATE users_has_movies
SET score = 8.6
WHERE id_users_has_movies = 2;

UPDATE users_has_movies
SET score = 6
WHERE id_users_has_movies = 3;

