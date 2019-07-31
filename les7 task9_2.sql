-- Михайловский Василий
-- Практическое задание тема №9
-- Задание 2
-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DELIMITER //

DROP PROCEDURE IF EXISTS million_rows//
CREATE PROCEDURE million_rows(N INT)
BEGIN
    SET @X = 0;
    REPEAT 
        
        SET @X = @X + 1; 
        INSERT INTO users (id) VALUES (@X);
    UNTIL @X > (N-1) END REPEAT;
END//


CALL million_rows(100)//

  
 