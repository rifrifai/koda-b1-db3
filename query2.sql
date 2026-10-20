SELECT m.name, m.rank, mg.genre FROM movies m
INNER JOIN movies_genres mg ON m.id = mg.movie_id
INNER JOIN movies_directors md ON md.movie_id = mg.movie_id
LIMIT 50;

SELECT a.first_name, a.last_name, a.gender, m.name, m.rating, r.role FROM actors a
INNER JOIN roles r ON a.id = r.actor_id
INNER JOIN movies m ON r.movie_id = m.id;
