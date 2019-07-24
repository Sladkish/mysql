-- Михайловский Василий
-- Пусть задан некоторый пользователь. Я выбрал пользователя с id=9
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.


-- смотрю с кем вообще переисывался наш пользователь. 
select from_user_id, to_user_id, count(*) as messages_count from messages
where from_user_id=9 or to_user_id=9
group by from_user_id, to_user_id
order by  messages_count desc;

-- смотрю друзей заддного пользователя

(select friend_id from friendship
where user_id=9 and status=1 )
union 
(select user_id from friendship
where friend_id=9 and status=1 );



-- выбрал друзей с которым переписывался user_id=9
(select ff.friend_id from messages
join 
((select friend_id from friendship
where user_id=9 and status=1 )
union 
(select user_id from friendship
where friend_id=9 and status=1 )) as ff
on 
from_user_id= ff.friend_id
where to_user_id=9)
union
(select ft.friend_id from messages
right join 
((select friend_id from friendship
where user_id=9 and status=1 )
union 
(select user_id from friendship
where friend_id=9 and status=1 )) as ft
on 
to_user_id= ft.friend_id
where from_user_id=9);
-- добавил максимальное колличество сообщений

(select ff.friend_id, count(*) as total_mes  from messages
join 
((select friend_id from friendship
where user_id=9 and status=1 )
union 
(select user_id from friendship
where friend_id=9 and status=1 )) as ff
on 
from_user_id= ff.friend_id
where to_user_id=9
group by ff.friend_id)
union
(select ft.friend_id, count(*) as total_mes from messages
right join 
((select friend_id from friendship
where user_id=9 and status=1 )
union 
(select user_id from friendship
where friend_id=9 and status=1 )) as ft
on 
to_user_id= ft.friend_id
where from_user_id=9
group by ft.friend_id);

--  создаю представление 
create or replace  view best_friends as
(select ff.friend_id, count(*) as total_mes  from messages
join 
((select friend_id from friendship
where user_id=9 and status=1 )
union 
(select user_id from friendship
where friend_id=9 and status=1 )) as ff
on 
from_user_id= ff.friend_id
where to_user_id=9
group by ff.friend_id)
union
(select ft.friend_id, count(*) as total_mes from messages
right join 
((select friend_id from friendship
where user_id=9 and status=1 )
union 
(select user_id from friendship
where friend_id=9 and status=1 )) as ft
on 
to_user_id= ft.friend_id
where from_user_id=9
group by ft.friend_id);

-- отфильтровываю недавно созданное представление и объединяю с таблицей юзерс для вывода имени
select firstname,  lastname from best_friends 
join users
on 
friend_id =id
order by total_mes desc
limit 2;

-- объединяю фамилию и имя. Я отфильровываю limit 2, потому что у меня 2 пользователя с одинаковым количесвом максимальных сообщений

select CONCAT(firstname, ' ', lastname) as friend_name   from best_friends 
join users
on 
friend_id =id
order by total_mes desc
limit 2;





    
    




