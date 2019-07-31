/*Михайловский Василий
Практическое задание тема №8
Задание 2
В таблице products есть два текстовых поля: name с названием товара и description с его
 описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля
 принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, 
 чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
 NULL-значение необходимо отменить операцию.*/



delimiter //


DROP TRIGGER IF EXISTS check_products//

CREATE TRIGGER check_products BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  -- DECLARE check_null VARCHAR(255);
  -- SELECT NEW.name INTO check_null FROM products;
  IF (NEW.name is NULL AND NEW.description is Null) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Отмена операции. Присвоение Null значения двум полям';
  ELSEIF (NEW.name is NULL AND OLD.description is Null) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Отмена операции. Присвоение Null значения двум полям';
  ELSEIF (OLD.name is NULL AND NEW.description is Null) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Отмена операции. Присвоение Null значения двум полям';
  END IF;
END//

