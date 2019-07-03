CREATE DATABASE IF NOT EXISTS media;
USE media;

DROP TABLE IF EXISTS sound;
CREATE TABLE sound (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название аудиодорожки',
  url TEXT COMMENT 'Путь к файлу',
  users_id INT COMMENT 'Принадлежность к пользователю',
  key_words VARCHAR(512) COMMENT 'Ключевае слова'
  
) COMMENT = 'раздел звуки';

INSERT INTO sound VALUES
  (DEFAULT, 'Миллион роз','https://music.yandex.ru/album/3662717/track/30252280', 1, 'пуначева, алла, рэтро' ),
  (DEFAULT, 'Reise, Reise','https://music.yandex.ru/album/9752/track/55568', 2, 'Rammstein, рок' );
  
  
  DROP TABLE IF EXISTS video;
CREATE TABLE video (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название видеодорожки',
  url TEXT COMMENT 'Путь к файлу',
  users_id INT COMMENT 'Принадлежность к пользователю',
  key_words VARCHAR(512) COMMENT 'Ключевае слова'
  
) COMMENT = 'раздел видео';

INSERT INTO video VALUES
  (DEFAULT, 'Выпуская дым','https://www.youtube.com/watch?v=f960Bxzb8UM&list=RDMMf960Bxzb8UM&start_radio=1', 3, 'клип, Slavik Pogosov, рэп' ),
  (DEFAULT, 'How To Get Girls To Kiss You','https://www.youtube.com/watch?v=RTuBf4BrIgE', 1, 'прикол, пикап, виталий здоровецкий' ),
  (DEFAULT, 'Что? Где? Когда?','https://www.youtube.com/watch?v=cvxChbkMFSY', 2, 'игра, 1 канал, 30.06.2019,Финал летней серии игр' );
  
  
    DROP TABLE IF EXISTS pictures;
CREATE TABLE pictures (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название фото',
  url TEXT COMMENT 'Путь к файлу',
  users_id INT COMMENT 'Принадлежность к пользователю',
  key_words VARCHAR(512) COMMENT 'Ключевае слова'
  
) COMMENT = 'раздел фото';

INSERT INTO pictures VALUES
  (DEFAULT, 'девушка','https://www.goodfon.ru/download/sarah-hyland-devushka-poza-plate-vzgliad/2200x1238/', 1, 'девушка, сиськи,' ),
  (DEFAULT, 'автомобиль','https://avto.goodfon.ru/download/ford-mustang-gt-fastback-v82017-desert/3840x2160/', 1, 'ford, Mustang' ),
  (DEFAULT, 'лес','https://www.goodfon.ru/download/derevia-doroga-les/2048x1233/', 3, 'лес, природа' );
  
  DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя пользователя',
  birthday_at DATE COMMENT 'Дата рождения'
) COMMENT = 'пользователи';

INSERT INTO users VALUES
  (DEFAULT, 'путин', '1958_07_10'),
  (DEFAULT, 'назарбаев', '1940_06_06'),
  (DEFAULT, 'лукашенко', '1958_07_30');


SELECT * FROM users