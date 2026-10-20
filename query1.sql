-- DROP DATABASE imdb;
-- CREATE DATABASE imdb;

-- -- 1. Bersihkan tabel lama jika sudah terlanjur dibuat
-- DROP TABLE IF EXISTS roles CASCADE;
-- DROP TABLE IF EXISTS movies_genres CASCADE;
-- DROP TABLE IF EXISTS movies_directors CASCADE;
-- DROP TABLE IF EXISTS directors_genres CASCADE;
-- DROP TABLE IF EXISTS movies CASCADE;
-- DROP TABLE IF EXISTS directors CASCADE;
-- DROP TABLE IF EXISTS actors CASCADE;

-- 2. Buat 7 Tabel sesuai struktur IMDb

-- CREATE TABLE directors (
--     id int8 PRIMARY KEY,
--     first_name varchar(100),
--     last_name varchar(100)
-- );

-- CREATE TABLE directors_genres (
--     director_id int8 REFERENCES directors(id),
--     genre varchar(100),
--     prob float4
-- );

-- CREATE TABLE movies (
--     id int8 PRIMARY KEY,
--     name varchar(100),
--     year int4,
--     "rank" float4,
--     rating float4
-- );

-- CREATE TABLE movies_directors (
--     director_id int8 REFERENCES directors(id),
--     movie_id int8 REFERENCES movies(id)
-- );

-- CREATE TABLE movies_genres (
--     movie_id int8 REFERENCES movies(id),
--     genre varchar(100)
-- );

-- CREATE TABLE actors (
--     id int8 PRIMARY KEY,
--     first_name varchar(100),
--     last_name varchar(100),
--     gender bpchar(1)
-- );

-- CREATE TABLE roles (
--     actor_id int8 REFERENCES actors(id),
--     movie_id int8 REFERENCES movies(id),
--     "role" varchar(100)
-- );

-- -- 3. Generate 1.000 data actors otomatis
-- INSERT INTO actors (id, first_name, last_name, gender)
-- SELECT
--     id,
--     (ARRAY[
--         'John', 'Johnny', 'Jonah', 'Johan', 'James',
--         'Chris', 'Thomas', 'Lucas', 'Marcus', 'Michael',
--         'Robert', 'David', 'William', 'Richard', 'Charles',
--         'Johna', 'Johnnetta', 'Mary', 'Patricia', 'Jennifer',
--         'Linda', 'Elizabeth', 'Barbara', 'Jessica', 'Sarah',
--         'Karen', 'Alexis', 'Iris', 'Gladys', 'Dolores'
--     ])[name_idx],
--     (ARRAY[
--         'Smith', 'Johnson', 'Johnstone', 'Williams', 'Brown',
--         'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez',
--         'Martinez', 'Hernandez', 'Lopez', 'Gonzalez', 'Wilson',
--         'Anderson', 'Taylor', 'Moore', 'Jackson', 'Martin'
--     ])[last_idx],
--     CASE WHEN name_idx <= 15 THEN 'M' ELSE 'F' END
-- FROM (
--     SELECT
--         g AS id,
--         floor(random() * 30 + 1)::int AS name_idx,
--         floor(random() * 20 + 1)::int AS last_idx
--     FROM generate_series(1, 1000) AS g
-- ) AS dummy_actors;

-- -- 4. Tambahkan data spesifik
-- INSERT INTO actors (id, first_name, last_name, gender) VALUES
-- (671521, 'Johan', 'Smith', 'M'),       
-- (845465, 'Michael', 'Johnstone', 'M')  
-- ON CONFLICT (id) DO NOTHING;

-- -- 5. Generate 200 data directors otomatis
-- INSERT INTO directors (id, first_name, last_name)
-- SELECT
--     g,
--     (ARRAY['Christopher', 'Steven', 'Quentin', 'Martin', 'James', 'Ridley', 'Peter', 'David', 'Denis', 'Greta'])[floor(random() * 10 + 1)::int],
--     (ARRAY['Nolan', 'Spielberg', 'Tarantino', 'Scorsese', 'Cameron', 'Scott', 'Jackson', 'Fincher', 'Villeneuve', 'Gerwig'])[floor(random() * 10 + 1)::int]
-- FROM generate_series(1, 200) AS g;

-- -- 6. Generate 400 data directors_genres otomatis
-- INSERT INTO directors_genres (director_id, genre, prob)
-- SELECT
--     floor(random() * 200 + 1)::int,
--     (ARRAY['Action', 'Drama', 'Sci-Fi', 'Thriller', 'Comedy', 'Horror', 'Adventure', 'Crime'])[floor(random() * 8 + 1)::int],
--     round((random()::numeric), 2)::float4
-- FROM generate_series(1, 400);

-- -- 7. Generate 1.000 data movies otomatis 
-- INSERT INTO movies (id, name, year, "rank", rating)
-- SELECT
--     id,
--     (ARRAY['The Last', 'Secret', 'Dark', 'Eternal', 'Lost', 'Silent', 'Golden', 'Broken', 'Hidden', 'Infinite'])[t1] || ' ' ||
--     (ARRAY['Horizon', 'Empire', 'Shadow', 'Journey', 'Knight', 'Legacy', 'Protocol', 'Symphony', 'Paradox', 'Odyssey'])[t2] || ' ' || id,
--     yr,
--     val_rating,
--     val_rating
-- FROM (
--     SELECT
--         g AS id,
--         floor(random() * 10 + 1)::int AS t1,
--         floor(random() * 10 + 1)::int AS t2,
--         floor(random() * (2024 - 1980 + 1) + 1980)::int AS yr,
--         CASE 
--             WHEN g % 5 = 0 THEN 6.0::float4
--             WHEN g % 7 = 0 THEN 5.0::float4
--             WHEN g % 9 = 0 THEN 7.0::float4
--             ELSE round((random() * (9.5 - 4.0) + 4.0)::numeric, 1)::float4
--         END AS val_rating
--     FROM generate_series(1, 1000) AS g
-- ) AS dummy_movies;

-- -- 8. Generate relasi movies_directors, movies_genres, dan roles
-- INSERT INTO movies_directors (director_id, movie_id)
-- SELECT floor(random() * 200 + 1)::int, g FROM generate_series(1, 1000) AS g;

-- INSERT INTO movies_genres (movie_id, genre)
-- SELECT floor(random() * 1000 + 1)::int,
--        (ARRAY['Action', 'Drama', 'Sci-Fi', 'Thriller', 'Comedy', 'Horror', 'Adventure', 'Crime', 'Romance'])[floor(random() * 9 + 1)::int]
-- FROM generate_series(1, 1500);

-- INSERT INTO roles (actor_id, movie_id, "role")
-- SELECT floor(random() * 1000 + 1)::int,
--        floor(random() * 1000 + 1)::int,
--        (ARRAY['Detective', 'Captain', 'Doctor', 'Agent', 'Professor', 'Hero', 'Villain', 'Pilot', 'Reporter', 'Soldier'])[floor(random() * 10 + 1)::int]
-- FROM generate_series(1, 2000);

-- -- Jawaban dari minitask!
-- SELECT name FROM movies WHERE year > 2000;
-- SELECT first_name FROM actors WHERE first_name ILIKE '%s';
-- SELECT rating FROM movies WHERE rating BETWEEN  5 AND 7 AND year BETWEEN 2004 AND 2006;
-- SELECT COUNT(rating) FROM movies WHERE rating = 6;

SELECT m.name, mg.genre, md.director_id FROM movies m
INNER JOIN movies_genres mg ON m.id = mg.movie_id
INNER JOIN movies_directors md ON md.movie_id = mg.movie_id
LIMIT 100
OFFSET 100;
