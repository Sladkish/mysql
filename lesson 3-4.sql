-- ЗАДАЧА 3.1
UPDATE users SET  created_at =now() WHERE created_at = '' or created_at is null;
UPDATE users SET  updated_at =now() WHERE updated_at = '' or updated_at is null ;
-- или так
UPDATE users SET created_at = now(), updated_at = now()   where id =id;

-- ЗАДАЧА 3.2
UPDATE  users  SET  created_at = str_to_date(created_at,  '%d.%m.%Y %H:%i' ) WHERE id = id;
UPDATE  users  SET  updated_at = str_to_date(updated_at,  '%d.%m.%Y %H:%i' ) WHERE id = id;

ALTER TABLE users MODIFY created_at datetime;
ALTER TABLE users MODIFY updated_at datetime;

-- ЗАДАЧА 3.3
select  value  from  storehouses_products order by value=0, value ;

-- ЗАДАЧА 3.4
SELECT  name, MONTHNAME(birthday_at) FROM users WHERE MONTHNAME(birthday_at)= 'June' or MONTHNAME(birthday_at)= 'December';
-- ЗАДАЧА 3.5
SELECT * FROM catalogs WHERE id IN (5,1,2) order by id=2, id=1,id=5 ;

-- ЗАДАЧА 4.1
-- решение с  создание дополнительного столбца с возрастом
ALTER TABLE users ADD age INT( 11 ) NOT NULL;
UPDATE users SET  age = (YEAR(CURRENT_DATE)-YEAR(birthday_at)) - (RIGHT(CURRENT_DATE,5)<RIGHT(birthday_at,5)) ;
SELECT AVG(age) FROM users;

-- короткое решение
SELECT AVG((YEAR(CURRENT_DATE)-YEAR(birthday_at)) - (RIGHT(CURRENT_DATE,5)<RIGHT(birthday_at,5))) FROM users;

-- короткое решение c округлением
SELECT  ROUND(AVG((YEAR(CURRENT_DATE)-YEAR(birthday_at)) - (RIGHT(CURRENT_DATE,5)<RIGHT(birthday_at,5))),0) FROM users;

-- ЗАДАЧА 4.2
-- решение с  создание дополнительного столбца с днем когда в этом году будут отмечать др
ALTER TABLE users ADD birthday_this_year DATE NOT NULL;
UPDATE users SET  birthday_this_year = birthday_at ;
UPDATE users SET birthday_this_year=DATE_FORMAT(birthday_this_year,'2019-%m-%d');
SELECT COUNT(*), DAYNAME(birthday_this_year) AS party_day FROM users GROUP BY party_day ;

-- ЗАДАЧА 4.3
SELECT round(exp(SUM(log(val))),0) val FROM mult ;