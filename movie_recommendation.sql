-- =========================================
-- MOVIE RECOMMENDATION & ANALYSIS PROJECT
-- =========================================

-- Drop tables if they already exist
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS movie_genres;
DROP TABLE IF EXISTS movies;

-- =====================
-- CREATE TABLES
-- =====================

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT
);

CREATE TABLE movie_genres (
    movie_id INT REFERENCES movies(movie_id),
    genre VARCHAR(50) NOT NULL,
    PRIMARY KEY (movie_id, genre)
);

CREATE TABLE ratings (
    user_id INT,
    movie_id INT REFERENCES movies(movie_id),
    rating NUMERIC(2,1) CHECK (rating >= 0 AND rating <= 5),
    rating_timestamp TIMESTAMP,
    PRIMARY KEY (user_id, movie_id)
);

CREATE TABLE tags (
    user_id INT,
    movie_id INT REFERENCES movies(movie_id),
    tag VARCHAR(50),
    tag_timestamp TIMESTAMP
);

-- =====================
-- INSERT DATA
-- =====================

-- Movies
INSERT INTO movies (movie_id, title, release_year) VALUES
(1, 'The Shawshank Redemption', 1994),
(2, 'The Godfather', 1972),
(3, 'The Dark Knight', 2008),
(4, 'Pulp Fiction', 1994),
(5, 'Forrest Gump', 1994),
(6, 'Inception', 2010),
(7, 'The Matrix', 1999),
(8, 'Interstellar', 2014),
(9, 'Fight Club', 1999),
(10, 'The Lord of the Rings: The Fellowship of the Ring', 2001);

-- Movie Genres
INSERT INTO movie_genres (movie_id, genre) VALUES
(1, 'Drama'),
(2, 'Crime'), (2, 'Drama'),
(3, 'Action'), (3, 'Drama'),
(4, 'Crime'), (4, 'Drama'),
(5, 'Drama'), (5, 'Romance'),
(6, 'Action'), (6, 'Sci-Fi'),
(7, 'Action'), (7, 'Sci-Fi'),
(8, 'Sci-Fi'), (8, 'Drama'),
(9, 'Drama'), (9, 'Thriller'),
(10, 'Adventure'), (10, 'Fantasy');

-- Ratings
INSERT INTO ratings (user_id, movie_id, rating, rating_timestamp) VALUES
(1, 1, 5.0, '2023-01-05'),
(1, 2, 4.5, '2023-01-06'),
(1, 3, 4.0, '2023-01-07'),
(1, 6, 4.5, '2023-01-08'),

(2, 1, 4.5, '2023-01-05'),
(2, 3, 5.0, '2023-01-06'),
(2, 4, 4.0, '2023-01-07'),
(2, 6, 4.0, '2023-01-08'),

(3, 1, 5.0, '2023-02-05'),
(3, 2, 5.0, '2023-02-06'),
(3, 5, 4.0, '2023-02-07'),
(3, 8, 4.5, '2023-02-08'),

(4, 3, 4.0, '2023-03-05'),
(4, 6, 4.5, '2023-03-06'),
(4, 7, 5.0, '2023-03-07'),
(4, 9, 4.0, '2023-03-08'),

(5, 5, 4.5, '2023-04-05'),
(5, 8, 5.0, '2023-04-06'),
(5, 9, 4.5, '2023-04-07'),
(5, 10, 5.0, '2023-04-08');

-- Tags
INSERT INTO tags (user_id, movie_id, tag, tag_timestamp) VALUES
(1, 1, 'inspiring', '2023-01-05'),
(2, 3, 'dark', '2023-01-06'),
(3, 5, 'romantic', '2023-02-07'),
(4, 7, 'mind-bending', '2023-03-07'),
(5, 8, 'space', '2023-04-06');

-- =====================
-- ANALYSIS QUERIES
-- =====================

-- 1. Top 5 movies by average rating (min 2 ratings)
SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating, COUNT(*) AS num_ratings
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING COUNT(*) >= 2
ORDER BY avg_rating DESC
LIMIT 5;

-- 2. Most active users
SELECT user_id, COUNT(*) AS ratings_count
FROM ratings
GROUP BY user_id
ORDER BY ratings_count DESC;

-- 3. Average rating by genre
SELECT g.genre, ROUND(AVG(r.rating), 2) AS avg_rating
FROM movie_genres g
JOIN ratings r ON g.movie_id = r.movie_id
GROUP BY g.genre
ORDER BY avg_rating DESC;

-- 4. Number of ratings per month
SELECT DATE_TRUNC('month', rating_timestamp) AS month, COUNT(*) AS num_ratings
FROM ratings
GROUP BY month
ORDER BY month;

-- 5. Simple recommendations for user_id = 1
WITH target_user AS (
    SELECT movie_id
    FROM ratings
    WHERE user_id = 1 AND rating >= 4
),
similar_users AS (
    SELECT DISTINCT r.user_id
    FROM ratings r
    JOIN target_user t ON r.movie_id = t.movie_id
    WHERE r.rating >= 4 AND r.user_id != 1
)
SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating, COUNT(*) AS num_ratings
FROM ratings r
JOIN similar_users su ON r.user_id = su.user_id
JOIN movies m ON r.movie_id = m.movie_id
WHERE m.movie_id NOT IN (SELECT movie_id FROM target_user)
GROUP BY m.title
HAVING COUNT(*) >= 2
ORDER BY avg_rating DESC;
