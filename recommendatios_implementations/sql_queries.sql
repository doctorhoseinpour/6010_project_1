use Recommendation;

-- CATEGORY 1: SIMPLE LOOKUPS
-- 1 Find person by name
SELECT * FROM persons WHERE name = 'Tom Hanks';

-- CATEGORY 2: ONE-HOP RELATIONSHIPS
-- Find all movies an actor appeared in
SELECT m.title, m.year, m.imdbRating
FROM movies m
JOIN actedIn a ON m.id = a.movie_id
JOIN persons p ON a.person_id = p.id
WHERE p.name = 'Tom Hanks';


-- CATEGORY 3: TWO-HOP RELATIONSHIPS
-- Find common movies between two actors
SELECT m.title, m.year
FROM movies m
JOIN actedIn a1 ON m.id = a1.movie_id
JOIN actedIn a2 ON m.id = a2.movie_id
JOIN persons p1 ON a1.person_id = p1.id
JOIN persons p2 ON a2.person_id = p2.id
WHERE p1.name = 'Tom Hanks' AND p2.name = 'Meg Ryan';

-- Find co-actors (actors who worked together)
SELECT DISTINCT p2.name as coactor
FROM persons p1
JOIN actedIn a1 ON p1.id = a1.person_id
JOIN movies m ON a1.movie_id = m.id
JOIN actedIn a2 ON m.id = a2.movie_id
JOIN persons p2 ON a2.person_id = p2.id
WHERE p1.name = 'Tom Hanks' 
  AND p2.name != 'Tom Hanks'
  AND p1.actor = 1 AND p2.actor = 1;


-- CATEGORY 4: AGGREGATION AND ANALYTICS
-- Count movies by genre
SELECT g.name, COUNT(*) as movie_count
FROM genre g
JOIN inGenere ig ON g.id = ig.genre_id
GROUP BY g.id, g.name
ORDER BY movie_count DESC;


-- Top 10 most prolific actors
SELECT p.name, COUNT(*) as movie_count
FROM persons p
JOIN actedIn a ON p.id = a.person_id
WHERE p.actor = 1
GROUP BY p.id, p.name
ORDER BY movie_count DESC
LIMIT 10;


-- CATEGORY 5: TIME-BASED ANALYSIS
-- Find high-rated action movies from the 1990s
SELECT m.title, m.year, m.imdbRating
FROM movies m
JOIN inGenere ig ON m.id = ig.movie_id
JOIN genre g ON ig.genre_id = g.id
WHERE g.name = 'Action' 
  AND m.year BETWEEN 1990 AND 1999
  AND m.imdbRating > 7.0
ORDER BY m.imdbRating DESC;

-- Genre popularity over time
SELECT g.name, 
       CASE 
           WHEN m.year < 1980 THEN 'Pre-1980'
           WHEN m.year < 1990 THEN '1980s'
           WHEN m.year < 2000 THEN '1990s'
           WHEN m.year < 2010 THEN '2000s'
           ELSE '2010s+'
       END as era,
       COUNT(*) as movie_count
FROM movies m
JOIN inGenere ig ON m.id = ig.movie_id
JOIN genre g ON ig.genre_id = g.id
WHERE m.year IS NOT NULL
GROUP BY g.name, era
ORDER BY g.name, era;

-- CATEGORY 6: RECOMMENDATION QUERIES
-- Recommend movies based on user's rated genres

SELECT DISTINCT m.title, m.imdbRating, g.name as genre
FROM users u
JOIN ratings r1 ON u.id = r1.user_id
JOIN movies m1 ON r1.movie_id = m1.id
JOIN inGenere ig1 ON m1.id = ig1.movie_id
JOIN genre g ON ig1.genre_id = g.id
JOIN inGenere ig2 ON g.id = ig2.genre_id
JOIN movies m ON ig2.movie_id = m.id
LEFT JOIN ratings r2 ON (u.id = r2.user_id AND m.id = r2.movie_id)
WHERE u.name = 'Angela Thompson' 
  AND r2.movie_id IS NULL  -- User hasn't rated this movie
  AND m.imdbRating > 7.0
ORDER BY m.imdbRating DESC
LIMIT 10;



-- Find similar users (users who rated similar movies)

SELECT u2.name, COUNT(*) as common_ratings
FROM users u1
JOIN ratings r1 ON u1.id = r1.user_id
JOIN ratings r2 ON r1.movie_id = r2.movie_id
JOIN users u2 ON r2.user_id = u2.id
WHERE u1.name = 'Angela Thompson' AND u2.name != 'Angela Thompson'
GROUP BY u2.id, u2.name
HAVING common_ratings >= 5
ORDER BY common_ratings DESC;
