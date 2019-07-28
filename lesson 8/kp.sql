CREATE DATABASE IF NOT EXISTS kp;
USE kp;

DROP TABLE IF EXISTS movies;
CREATE TABLE IF NOT EXISTS movies (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    release_date DATE
    
    );

DROP TABLE persons;
CREATE TABLE persons(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    sex CHAR(1) NOT NULL,
    birthday DATE,
    hometown VARCHAR(100),
    photo_id INT UNSIGNED NOT NULL


    );
  
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
    
   
    
DROP TABLE profession_types;
CREATE TABLE profession_types(   
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    profession VARCHAR(255) NOT NULL

);

DROP TABLE IF EXISTS movie_genres;
CREATE TABLE IF NOT EXISTS movie_genres(   
    movie_id INT UNSIGNED NOT NULL,
    genre_type_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (movie_id, genre_type_id),
    CONSTRAINT genres_movie_id_fk FOREIGN KEY (movie_id) REFERENCES movies(id),
    CONSTRAINT genres_genre_type_id_fk FOREIGN KEY (genre_type_id) REFERENCES genre_types(id)
    
);  
  

DROP TABLE  IF EXISTS genre_types;
CREATE TABLE IF NOT EXISTS  genre_types(   
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genre VARCHAR(255) NOT NULL

);

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

-- Таблица профилей
DROP TABLE  IF EXISTS profiles;
CREATE TABLE  IF NOT EXISTS profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  hometown VARCHAR(100),
  photo_id INT UNSIGNED NOT NULL,
  CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id)
  -- CONSTRAINT profiles_photo_id_fk FOREIGN KEY (photo_id) REFERENCES media(id) 
);

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



-- Таблица медиафайлов
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

    