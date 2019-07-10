show databases;
create database if not exists example;
use example;
create table if not exists users (
id tinyint,
name varchar(255)
);

show tables;
select * from users ;

/*выхожу из mysql и ввожу команду
 $ mysqldump example > dump_example.sql
 далее вновь вхожу в mysql и создаю базу данных sample чтобы  развернуть в нее содержание дампа
 если этого не сделать выводится ошибка ERROR 1049 (42000): Unknown database 'sample'*/
 
 create database sample
 
 /*далее выхожу из mysql и ввожу команду
 $ mysql sample < dump_example.sql
 и разворачиваю содержимое дампа */
