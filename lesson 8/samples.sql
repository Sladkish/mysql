
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
  SELECT CONCAT(firstname, ' ', lastname ) as name, count(*) as number_ratings  FROM users
    RIHGT JOIN 
    rating
    ON
    id=from_user_id
    GROUP BY id
    ORDER BY number_ratings DESC
    LIMIT 3;
  
  -- Кто больше всего поставил оценок. Мужчины или женщины  
  SELECT  sex, count(*) as number_of_ratings FROM profiles
    RIGHT JOIN 
    rating
    ON
    user_id=from_user_id
    GROUP BY sex
    ORDER BY number_of_ratings DESC
    limit 1;
    
 -- Представление из 3х столбцов: пользователь, фильм и оценка     
CREATE OR REPLACE VIEW user_and_movies AS 
  SELECT CONCAT(firstname, ' ', lastname ) as user_name, movies.name, rating   FROM users
    RIHGT JOIN 
    rating
    ON
    id=from_user_id
    LEFT JOIN 
    movies
    ON
    to_movie_id=movies.id
    ORDER BY user_name;
SELECT * FROM user_and_movies;
DROP VIEW IF EXISTS  user_and_movies ;


-- Представление список режиcеров  
CREATE OR REPLACE VIEW all_directors AS
SELECT firstname, lastname, profession FROM persons
   RIGHT JOIN
   movie_creators
   ON
   id=person_id
   LEFT JOIN
   profession_types
   ON
   profession_type_id=profession_types.id
   WHERE profession_types.id=2
   GROUP BY persons.id;
   
SELECT * FROM all_directors;
DROP VIEW IF EXISTS  all_directors;

-- Представление которое выводиn имена всех людей принимавших участие в создании фильма.
-- Для примера взял фильм с id=11

CREATE OR REPLACE VIEW who_create_movie AS
SELECT  name as movie_title,  firstname, lastname, profession  FROM movie_creators
  RIGHT JOIN 
  persons
  ON
  id=person_id
  RIGHT JOIN 
  profession_types
  ON
  profession_type_id=profession_types.id
  RIGHT JOIN
  movies
  ON
  movies.id=movie_id
  WHERE movie_id=11;
  
SELECT * FROM who_create_movie;
DROP VIEW IF EXISTS  who_create_movie;
 
    
  
 
