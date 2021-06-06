DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50), 
    mail VARCHAR(120) UNIQUE,
    phone BIGINT UNSIGNED UNIQUE,
    gender CHAR(1),
    birthday DATE,
    photo_id BIGINT UNSIGNED NULL,
    hometown VARCHAR(100),
    password_hash VARCHAR(100),
    created_at DATETIME DEFAULT NOW(),
	
    INDEX users_name_idx(firstname, lastname)
) COMMENT 'Пользователи';

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
    initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    requested_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
 
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id),
    CHECK (initiator_user_id <> target_user_id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
    id SERIAL PRIMARY KEY,
    `name` VARCHAR(150) UNIQUE,
    admin_user_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
    user_id BIGINT UNSIGNED NOT NULL,
    community_id BIGINT UNSIGNED NOT NULL,
  
    PRIMARY KEY (user_id, community_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
    `name` VARCHAR(255) PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
    id SERIAL,
    media_type BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    body text,
    filename VARCHAR(255), 	
    size INT,
    metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type) REFERENCES media_types(name)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),

    PRIMARY KEY (user_id, media_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums (
    id SERIAL PRIMARY KEY,
    `name` varchar(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    album_id BIGINT unsigned NULL,
    media_id BIGINT unsigned NOT NULL,

    FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS games;
CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS players;
CREATE TABLE players (
	user_id BIGINT UNSIGNED NOT NULL,
    game_id BIGINT UNSIGNED NOT NULL,
    start_play DATETIME DEFAULT NOW(),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id)
);

DROP TABLE IF EXISTS manufactures_device;
CREATE TABLE manufactures_device (
	id SERIAL PRIMARY KEY,
    `name` VARCHAR(255) UNIQUE
);

DROP TABLE IF EXISTS models_device;
CREATE TABLE models_device (
	id SERIAL PRIMARY KEY,
    `name` VARCHAR(255),
    manufacture_id BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (manufacture_id) REFERENCES manufactures_device(id)
);

DROP TABLE IF EXISTS devices;
CREATE TABLE devices (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    `type` ENUM('tablet', 'mobilphone', 'computer'),
    model_id BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (model_id) REFERENCES models_device(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

ALTER TABLE vk.users 
ADD CONSTRAINT users_fk 
FOREIGN KEY (photo_id) REFERENCES media(id);
