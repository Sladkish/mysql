use vk;
-- Задение №1. В моем случае дан user_id=9 

 select  user_id, friend_id, from_user_id, to_user_id, `status` from messages 
inner join friendship  on friend_id=to_user_id where user_id=9   having from_user_id=9 and `status`=1;
-- далее я не смог одуматься как отсотировать по колличесву сообщений  и потому создал временнную талицу
drop table temp;
CREATE TEMPORARY TABLE temp AS (
 select  from_user_id, to_user_id, `status` from messages 
inner join friendship  on friend_id=to_user_id where user_id=9   having from_user_id=9 and `status`=1
 );

select count(*) as mess_count, (SELECT CONCAT(firstname, ' ', lastname) 
    FROM users u  WHERE u.id = t.to_user_id) as friend 
    from temp t group by to_user_id having  mess_count>=3 ;
 

-- также пробовал решить задачу подругому. я пытался подсчитать  кому больше всего отправил 
-- user_id=9 сообщений. Но не смог добавить проверку на то находится ли этот польователь в друзьях или нет

 select from_user_id, (SELECT CONCAT(firstname, ' ', lastname) 
    FROM users u  WHERE u.id = m.to_user_id), 
    count(*) as mess_count
    from messages m where from_user_id = 9 
    GROUP BY to_user_id 
    having mess_count>=4;
 

 
-- ксожалению это все что я наработал((
