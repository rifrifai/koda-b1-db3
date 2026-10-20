-- SELECT * FROM movies
-- INNER JOIN movies_genres ON movies.id = movies_genres.movie_id
-- INNER JOIN movies_directors ON movies_directors.movie_id = movies_genres.movie_id
-- LIMIT 50;

-- SELECT a.first_name, a.last_name, a.gender, m.name, m.rating, r.role FROM actors a
-- INNER JOIN roles r ON a.id = r.actor_id
-- INNER JOIN movies m ON r.movie_id = m.id;
