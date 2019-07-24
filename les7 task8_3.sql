-- Михайловский Василий
/*Практическое задание тема №8
Задание 3
Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи
 называется последовательность в которой число равно сумме двух предыдущих чисел.
 Вызов функции FIBONACCI(10) должен возвращать число 55.

*/

-- Вариант ршения 1. Самый простой для счасливых обладателей обладателей MYSQL версии 8 (коим я и являюсь).
--  Здесь у меня возник большой соблаз прекратить на этом решение задачи, но я кое-как с ним совладал и продолжил)))
WITH RECURSIVE fibonacci (n, fib_n, next_fib_n) AS
(
  SELECT 0, 0, 1
  UNION ALL
  SELECT n + 1, next_fib_n, fib_n + next_fib_n
    FROM fibonacci WHERE n < 16
)
-- SELECT fib_n FROM fibonacci WHERE n = 10;
SELECT * FROM fibonacci;

-- Вариант ршения 2. То как я вижу решение

DELIMITER //

DROP PROCEDURE IF EXISTS FIBONACCI//
CREATE PROCEDURE FIBONACCI(M INT)
BEGIN

    IF M=0 THEN
	  SET @fib=0;
    ELSEIF M=1 or M=2 THEN
	  SET @fib=1;
   	ELSEIF M>2 THEN
      SET @fib=0;
	  SET @x = 1;
	  SET @y = 1;
	  SET @n = 2;
	  REPEAT 
		  SET @fib = @x + @y;
		  SET @y = @x;
		  SET @x = @fib;
		  SET @n = @n+1;
     UNTIL @n = M END REPEAT;
	 END IF;
     SELECT @fib;
END//


CALL FIBONACCI(15)//