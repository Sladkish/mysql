use shop;

-- Задание 1
 select count(*), user_id from orders group by user_id;
 
select count(*), (select name from users where id=user_id) as name 
 from orders
 group by name;
 
 -- Задание 2 вариант 1

select products.name,
(select catalogs.name from catalogs where catalogs.id=products.catalog_id) as product_type from products;
select * from catalogs;

  -- Задание 2 вариант 2
select products.name as product, catalogs.name as product_type from products
inner join catalogs on products.catalog_id=catalogs.id;

 -- Задание 3
 
select id, 
(select name from city where lable=`from`) as from_city, 
(select name from city where lable=`to`) as to_city
from flights;

-- Задача №4
START TRANSACTION;

select @var1:= name from shop.users where id=1;
select @var2:= birthday_at from shop.users where id=1;
select @var3:= created_at from shop.users where id=1;
select @var4:= updated_at from shop.users where id=1;
insert into sample.users value (1, @var1, @var2, @var3, @var4);
delete from shop.users where id=1;

commit;


  
  -- Задание 5 вариант 1
  create or replace view prod (name, product_type ) as select name, 
  (select name from catalogs where id=catalog_id) 
  FROM products;
  select * from prod;
  
  --  Задание 5 вариант 2
  
create or replace view prod (name, product_type )  as select
 products.name , catalogs.name  from products
inner join catalogs on products.catalog_id=catalogs.id;
select * from prod;




