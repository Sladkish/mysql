-- Михайловский Василий
-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- выбираем id 10-ти самых малодых пользователей из таблицы профилей
select user_id from profiles
 order by birthday desc
 limit 10;
 
 
-- объединяем с тадлицей users для вывода фамилии и имени 10-ти самых малодых пользователей 
select *, CONCAT(firstname, ' ', lastname) as name from profiles
 left join 
 users
 on 
 user_id=id
 order by birthday desc
 limit 10;
 
-- ищю медифалы и 10ти молодых пользователей.
select profiles.user_id, birthday,  count(*) as media_count from profiles
 join 
 media 
 on
 profiles.user_id=media.user_id
 group by profiles.user_id
 order by birthday desc
 limit 10;
 
-- запрос для  поиска лайков колличсева лайков  к сушности
select *, count(*) as likes from likes
 group by to_subject_id;
 
 
-- далее я объединяю три тадлицы profiles и media (right join потому что не у всех пользователей есть медиа)
-- и таблицу likes (right join потому что мне нужно меди которые получили лаки,  не у всех медиа есть лайки)
select profiles.user_id, birthday, count(*) as likes from profiles
  right join 
  media 
  on
  profiles.user_id=media.user_id
  right join likes 
  on
  media.id= to_subject_id
  group by user_id
  order by birthday desc
  limit 10;
  
-- создаю представление из предыдущего запроса  

create or replace view likes_of_10 as 
select profiles.user_id, birthday, count(*) as likes from profiles
  right join 
  media 
  on
  profiles.user_id=media.user_id
  right join likes 
  on
  media.id= to_subject_id
  group by user_id
  order by birthday desc
  limit 10;

-- с помощью преставления ищю сумму лайков 10ти самых молодых пользоватлей  
SELECT SUM(likes) FROM (likes_of_10);


