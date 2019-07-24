-- Михайловский Василий
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
-- В моем сулчае пол мужчины это 1, а женщины это 0. 


 SELECT sex, COUNT(*) AS likes FROM likes
  LEFT JOIN /*LEFT JOIN потому, что нам надо именно лайки а не пользователи, пользователи не ставишие лайки не будут учтены*/
  profiles
  ON
  from_user_id=user_id
  GROUP BY sex
  ORDER BY likes DESC
  LIMIT 1;
 
