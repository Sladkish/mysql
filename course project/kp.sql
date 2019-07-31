-- Сайт кинопоиск.
CREATE DATABASE IF NOT EXISTS kp;
USE kp;
-- Таблица Кинофильмов
DROP TABLE IF EXISTS movies;
CREATE TABLE IF NOT EXISTS movies (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    release_date DATE,
    poster_id INT UNSIGNED COMMENT 'Постер, афиша на главной странице фильма',
    trailer_id INT UNSIGNED COMMENT 'Трейлер на главной странице фильма',
    INDEX movies_id_indx (id),
	CONSTRAINT movies_poster_id_fk FOREIGN KEY (poster_id) REFERENCES media(id) , 
    CONSTRAINT movies_trailer_id_fk FOREIGN KEY (trailer_id) REFERENCES media(id) 
    );
-- Таблица людей задейсвованных в создании фильма без привязки к их професии 
DROP TABLE  IF EXISTS persons;
CREATE TABLE  IF NOT EXISTS persons(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    sex CHAR(1) NOT NULL,
    birthday DATE,
    hometown VARCHAR(100),
    photo_id INT UNSIGNED NOT NULL,
    CONSTRAINT persons_photo_id_fk FOREIGN KEY (photo_id) REFERENCES media(id) 

    );
 
-- Таблица професий людей задействованных в создании фильма (актеров, режисеров, сценаристов, сценаристов и т.п.)
DROP TABLE IF EXISTS profession_types;
CREATE TABLE IF NOT EXISTS profession_types(   
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    profession VARCHAR(255) NOT NULL

);
 -- В этой таблице я связываю фильм, имя человека и в качетве кого он был в этом фильме.
 -- Я так сделал потому что в одном фильме человек может играть как актер , но вдругом выспупать в качесве режисера и т.п
DROP TABLE IF EXISTS movie_creators;
CREATE TABLE IF NOT EXISTS movie_creators(   
	person_id INT UNSIGNED NOT NULL,
    profession_type_id INT UNSIGNED NOT NULL,
    movie_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (person_id , profession_type_id, movie_id),
    CONSTRAINT creators_profession_type_id_fk FOREIGN KEY (profession_type_id) REFERENCES profession_types(id),
    CONSTRAINT creators_person_id_fk FOREIGN KEY (person_id) REFERENCES persons(id),
    CONSTRAINT creators_movie_id_fk FOREIGN KEY (movie_id) REFERENCES movies(id)
    
); 
    
-- Таблица типов жанров  без привязки к конкретному к фильму . Драма, боевик, комедия и т.п. 
DROP TABLE  IF EXISTS genre_types;
CREATE TABLE IF NOT EXISTS  genre_types(   
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genre VARCHAR(255) NOT NULL

);
  

-- Таблица жанров конкретного фильма. Зачастую фильм может принимать несколько жанров.Например: боевик, триллер .
DROP TABLE IF EXISTS movie_genres;
CREATE TABLE IF NOT EXISTS movie_genres(   
    movie_id INT UNSIGNED NOT NULL,
    genre_type_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (movie_id, genre_type_id),
    CONSTRAINT genres_movie_id_fk FOREIGN KEY (movie_id) REFERENCES movies(id),
    CONSTRAINT genres_genre_type_id_fk FOREIGN KEY (genre_type_id) REFERENCES genre_types(id)
    
);  
  
-- Таблица пользоватлей которые регистрируются на сайте кинопоиска чтобы ставить оценки. 
DROP TABLE  IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  INDEX users_firstname_lastname_idx (firstname, lastname),
  INDEX users_email_idx (email)
);

-- Таблица профилей пользователей
DROP TABLE  IF EXISTS profiles;
CREATE TABLE  IF NOT EXISTS profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  hometown VARCHAR(100),
  photo_id INT UNSIGNED ,
  CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT profiles_photo_id_fk FOREIGN KEY (photo_id) REFERENCES media(id) 
);

-- Таблица, которая хранит оценки,  которые ставят пользователи к фильмам. 
DROP TABLE IF EXISTS  rating;
CREATE TABLE  IF NOT EXISTS rating (
	
    from_user_id INT UNSIGNED NOT NULL,
    to_movie_id INT UNSIGNED NOT NULL,
    rating INT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    PRIMARY KEY (from_user_id, to_movie_id),
    CONSTRAINT rating_from_user_id_fk FOREIGN KEY (from_user_id) REFERENCES users(id),
    CONSTRAINT rating_to_movie_id_fk FOREIGN KEY (to_movie_id) REFERENCES movies(id)
    
    );



/* Таблица медиафайлов. Здесь по моей задумке могут хранится файлы:
 1. пользователей кторые ставят оценки(например аватар пользователя). 
 2. Фотографии актеров и режисеров, сценаристов и тд.
 3. Фотографии связанные с фильмом (постер, афиша, кадры ) и видеотрейлеры фильма
Честно говоря, я как-то сомнительно отношусь к этому своему решению. 
 Дело в том что данное решение привело к необходимости создания таблицы  subject_types
 ( где я планирую хранить такие сушности как артисты, пользователи и фильмы.) и привело к необходимости связывания этой таблицы
 с таблицей media. Помимо этого я решил что необходимо создать таблицу media_types (photo или video)
 и тоже связал ее с таблицей  media
 По моему как-то замутренно получилось. ведь может произойти множество конфлитных ситуаций.
 Наример афиша может иметь тип видео и ссылаться на эту афишу будет не таблица фильмов а таблица пользователей
 я попытался решить данную проблему с помощью тригеров.
 
 И думаю может было бы лучше создать несколько таблиц медия. для каждой из сушностей. 
 Но проверить это на пратике времени не хватило.
 
*/
DROP TABLE IF EXISTS  media;
CREATE TABLE IF NOT EXISTS  media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  subject_id INT UNSIGNED NOT NULL,
  subject_types_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL UNIQUE,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX media_user_id_idx(subject_id),
  INDEX media_media_type_id_idx(media_type_id),
  CONSTRAINT media_type_id_fk FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  CONSTRAINT subject_types_id_fk FOREIGN KEY (subject_types_id) REFERENCES subject_types(id)

);

-- Таблица типов сущностей, которые могут хранить медиа файлы
DROP TABLE IF EXISTS subject_types;

CREATE TABLE IF NOT EXISTS  subject_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица типов медиафайлов
DROP TABLE IF EXISTS  media_types;
CREATE TABLE IF NOT EXISTS  media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
