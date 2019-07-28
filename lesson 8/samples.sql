SELECT * FROM movies;
SELECT * FROM rating;
SELECT * FROM persons;
SELECT * FROM users;
SELECT * FROM movie_creators;
-- 25 лучших фильмов
SELECT name AS movie_name, count(*) as number_ratings, AVG(rating) as total_rating FROM movies
  LEFT JOIN
  rating
  ON
  id=to_movie_id
  GROUP BY id
  HAVING number_ratings>5
  ORDER BY total_rating DESC
  LIMIT 25;
  
 -- Поиcк наиболее популярных фильмов где человек с id=7 играл в качетве актера 
  SELECT  name AS movie_name, CONCAT(firstname, ' ', lastname ) AS person_name,  AVG(rating) AS total_rating  FROM movies
    LEFT JOIN
    rating
    ON
    movies.id=to_movie_id 
    LEFT JOIN
    movie_creators
    ON
    movies.id=movie_id
    LEFT JOIN
    persons 
    ON
    persons.id=person_id
    WHERE person_id=7 and profession_type_id=1
    GROUP BY movies.id;
  
  
  
  -- Поиск троих самых активных пользователя (кто больше всего ставил оценок)
  SELECT CONCAT(firstname, ' ', lastname ) as name, count(*) as number_ratings  FROM USERS 
    LEFT JOIN 
    rating
    ON
    id=from_user_id
    GROUP BY id
    ORDER BY number_ratings DESC
    LIMIT 3;
  
  
