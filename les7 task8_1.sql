-- Михайловский Василий
-- Практическое задание тема №8
-- Задание 1
/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от 
текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".*/


delimiter //

DROP PROCEDURE IF EXISTS hello//

CREATE PROCEDURE hello()
BEGIN
  IF (CURTIME() >='06:00:01' and CURTIME() <= '12:00:00') THEN
      SELECT 'Good morning';
  ELSEIF (CURTIME() >='12:00:01' and CURTIME() <= '18:00:00') THEN
      SELECT 'Good afternoon';
  ELSEIF (CURTIME() >='18:00:01' and CURTIME() <= '00:00:00') THEN
      SELECT 'Good evening';
  ELSEIF (CURTIME() >='00:00:01' and CURTIME() <= '06:00:00') THEN    
      SELECT 'Good night';
  END IF;
END//

CALL hello()//


