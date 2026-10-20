-- select tablename from pg_tables;
-- mendapatkan director, berapa genre yang di direct
-- mendapatkan actors yang memiliki roles > 5
-- mendapatkan directors paling produktif sepanjang masa
-- mendapatkan tahun tersibuk sepanjang masa
-- mendapatkan movies dengan genres yang dibuatkan menjadi 1 column  (value dipisahkan oleh comma ,) dengan menggunakan string_agg

-- SELECT COUNT(dg.genre) AS total_genre, CONCAT(d.first_name, ' ', d.last_name) AS fullname 
-- FROM directors d JOIN directors_genres dg
--     ON dg.director_id = d.id
-- GROUP BY fullname
-- ORDER BY total_genre DESC;

-- SELECT CONCAT(a.first_name, ' ', a.last_name) AS fullname, COUNT(r.role) AS total_role
-- FROM actors a 
-- JOIN roles r ON r.actor_id = a.id
-- GROUP BY fullname
-- HAVING COUNT(r.role) > 5
-- ORDER BY total_role DESC;

-- SELECT CONCAT(d.first_name, ' ', d.last_name) AS fullname, COUNT(md.movie_id)
-- FROM directors d
-- JOIN movies_directors md ON md.director_id = d.id
-- GROUP BY fullname
-- ORDER BY COUNT(md.movie_id) DESC;

-- SELECT m.year, COUNT(m.id) AS total FROM movies m
-- GROUP BY m.year
-- ORDER BY total DESC
-- LIMIT 1;

SELECT STRING_AGG(mg.genre, ', ') AS genre, m.name FROM movies m
JOIN movies_genres mg ON mg.movie_id = m.id
GROUP BY m.name;

-- coba coba
-- SELECT mg.genre, m.name FROM movies m
-- JOIN movies_genres mg ON mg.movie_id = m.id
-- GROUP BY mg.genre, m.name;



