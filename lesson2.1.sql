create database if not exists shop;
use shop;
drop table if exists catalogs;
create table catalogs (
	id serial primary key,
	name varchar(255) comment 'название раздела'  /*,
	unique unique_name(name(10)) */
) comment = 'Разделы интернет-магазина';

insert into catalogs values
	(default, 'Процессоры'),
    (default, Null ),
	(default, 'Мат. платы' ),
	(default, Null ),
    (default, 'Видеокарты' );
    
set sql_safe_updates = 0;
    
update 
	catalogs
set
	name = 'empty'
where
	name is null; 
  /*если не закоментировать nique unique_name(name(10)) в таблице  catalogs то вышеуказанная замена не произведется 
  так как несколько строк с одинаковым именем 'empty' не могут быть в уникальном столбце name */ 

select * from catalogs;
