(SELECT media_type_id FROM media WHERE id=262);
(select(SELECT media_type_id FROM media WHERE id=262)!=2);

DELIMITER //

/* Далее идут два триггера вставку и обновление талицы медиа.
 Дело в том что в талице медиа хранятся фото пользователей для аватаров.
Афиши и трейлеры для фильмов и фатографии артистов
тригер проверяет для данной сушности наличие id в ее основнйо табице.
То есть допустм мы вставляем в таблицу медиа фотографию актера с id120.
Такого атера нет. Но есть пользователь. и без триггера данное фото вставится.
Только тут получается замкнутый круг. Ограниение внешнего ключа не позволит добавить в таблицу movies строку 
если в таблицу media не будут храниться фото и трейлер к фильму. А если включить триггер и попытаться добавть сначала файлы в таблицу media 
тогда тригер заругается что нет такго фильма в таблице movies. Я думал может выходом будет вводить значения null для в таблицу movies для 
для афиши и трейлера (trailer_id и  poster_id) при вставке нового фильма в movies. Затем добавляем в media трейдер и афишу.
 И потом обновляем строку с вновь добавденым  фильмом в медиа. В общем хотел услышать коментарии по поводу сложившейся ситуации  */
DROP TRIGGER IF EXISTS check_media_update//
CREATE TRIGGER check_media_update BEFORE UPDATE ON media
FOR EACH ROW
BEGIN
  IF ( NEW.subject_types_id=1 and EXISTS(SELECT * FROM users WHERE id=(NEW.subject_id))=0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.There is no such user';
  ELSEIF ( NEW.subject_types_id=2 and EXISTS(SELECT * FROM movies WHERE id=(NEW.subject_id))=0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.There is no such movie';
  ELSEIF ( NEW.subject_types_id=3 and EXISTS(SELECT * FROM persons WHERE id=(NEW.subject_id))=0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.There is no such persons';
  END IF;
END//

DROP TRIGGER IF EXISTS check_media_insert//
CREATE TRIGGER check_media_insert BEFORE INSERT ON media
FOR EACH ROW
BEGIN
  IF ( NEW.subject_types_id=1 and EXISTS(SELECT * FROM users WHERE id=(NEW.subject_id))=0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.There is no such user';
  ELSEIF ( NEW.subject_types_id=2 and EXISTS(SELECT * FROM movies WHERE id=(NEW.subject_id))=0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.There is no such movie';
  ELSEIF ( NEW.subject_types_id=3 and EXISTS(SELECT * FROM persons WHERE id=(NEW.subject_id))=0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.There is no such persons';
  END IF;
END//

/* Далее идут два тригера на вставку и обновление таблицы фильмовa
в таблице медиа могут хранится Афиши и трейлеры для фильмов. И по id афиш и трейлеров связаны таблицы медиа и мувис
  Если я дабавляю в мувис фильм и в стобец trailer_id записываю например id100 - тригер проверит тип  этого файла и если это окажется фото
  то он прервет операцию. */
DROP TRIGGER IF EXISTS check_trailer_update//
CREATE TRIGGER  check_trailer_update BEFORE UPDATE ON movies
FOR EACH ROW
BEGIN
  IF (select(SELECT media_type_id FROM media WHERE id=(NEW.trailer_id))!=2) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.trailer type is not a video';
  
  END IF;
END//



DROP TRIGGER IF EXISTS check_trailer_insert//
CREATE TRIGGER  check_trailer_insert BEFORE INSERT ON movies
FOR EACH ROW
BEGIN
  IF  (select(SELECT media_type_id FROM media WHERE id=(NEW.trailer_id))!=2) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cancel operation.trailer type is not a video';
  
  END IF;
END//

