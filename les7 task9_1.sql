-- Михайловский Василий
-- Практическое задание тема №9
-- Задание 1
/*Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
 catalogs и products в таблицу logs помещается время и дата создания записи, название
 таблицы, идентификатор первичного ключа и содержимое поля name.*/


delimiter //

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  insert_table VARCHAR(255),
  id_from_table INT,
  name_from_table VARCHAR(255),
  create_date DATETIME
) ENGINE=ARCHIVE//

DROP TRIGGER IF EXISTS fill_logs_products//
CREATE TRIGGER fill_logs_products AFTER INSERT ON products
FOR EACH ROW BEGIN
    INSERT INTO logs (insert_table, id_from_table ,name_from_table, create_date) 
    VALUES ('products', NEW.id, NEW.name, Now());
END//

DROP TRIGGER IF EXISTS fill_logs_users//
CREATE TRIGGER fill_logs_users AFTER INSERT ON users
FOR EACH ROW BEGIN
    INSERT INTO logs (insert_table, id_from_table ,name_from_table, create_date) 
    VALUES ('users', NEW.id, NEW.name, Now());
END//

DROP TRIGGER IF EXISTS fill_logs_catalogs//
CREATE TRIGGER fill_logs_catalogs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
    INSERT INTO logs (insert_table, id_from_table ,name_from_table, create_date) 
    VALUES ('catalogs', NEW.id, NEW.name, Now());
END//


