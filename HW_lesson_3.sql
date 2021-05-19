-- 1. Создаем БД 'VK'
CREATE DATABASE vk;

USE vk;

-- 1.1 Создаём таблицу пользователей
CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи"; 


-- 1.2 Создаем таблицу профилей
CREATE TABLE IF NOT EXISTS profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили";


-- 1.3 Создаем таблицу сообщений
CREATE TABLE IF NOT EXISTS messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  status_id int UNSIGNED NOT NULL COMMENT "Ссылка на статус",
  media_id INT UNSIGNED
) COMMENT "Сообщения";


-- 1.4 Создаем Таблицу статусов сообщений
CREATE TABLE IF NOT EXISTS message_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы сообщений";


-- 1.5 Создаем таблицу дружбы
CREATE TABLE IF NOT EXISTS friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  friendship_status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";


-- 1.6 Создаем таблицу статусов дружеских отношений
CREATE TABLE IF NOT EXISTS friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы дружбы";


-- 1.7 Создаем таблицу групп
CREATE TABLE IF NOT EXISTS communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Группы";


-- 1.8 Создаем таблицу связи пользователей и групп
CREATE TABLE IF NOT EXISTS communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";


-- 1.9 Создаем таблицу медиафайлов
CREATE TABLE IF NOT EXISTS media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  name VARCHAR(100)
) COMMENT "Медиафайлы";


-- 1.10 Создаем таблицу типов медиафайлов
CREATE TABLE IF NOT EXISTS media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";


-- 2. Создать таблицы для лайков

-- 2.1 Создаем таблицу лайков для медиафайлов
CREATE TABLE media_likes(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
  mediafile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиафайл, которому поставили лайк",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время проставления лайка"
) COMMENT "Лайки медиафайлов";


-- 2.2 Создаем таблицу лайков для сообщений
CREATE TABLE messages_likes(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
  message_id INT UNSIGNED NOT NULL COMMENT "Ссылка на сообщение, которому поставили лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время проставления лайка"
) COMMENT "Лайки сообщений";


-- 2.3 Создаем таблицу лайков для пользователей
CREATE TABLE user_likes(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
  message_id INT UNSIGNED NOT NULL COMMENT "Ссылка на сообщение, которому поставили лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время проставления лайка"
) COMMENT "Лайки пользователей";


-- 3 Заполняем созданные выше таблицы данными с помощью ресурса filldb.info
-- Ниже будут приведены примеры по одной строке для каждой таблицы, информацию о всем заполнении можно посмотреть в dump файле -> 

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Oscar', 'Kris', 'lester47@example.net', '46586465531', '2017-10-21 17:59:07', '1981-07-04 19:10:07');
COMMIT;

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (100, '', '1997-11-08', 'Janiechester', '355124711', '2019-04-30 04:41:45', '2002-03-07 02:47:49');
COMMIT;

INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `status_id`, `media_id`) VALUES (100, 100, 2, 'Magnam ab ducimus minima magnam eaque. Officia ut mollitia rerum necessitatibus dolorem deserunt repudiandae. Quia eos animi quia quasi rerum ut deserunt. Totam at soluta nobis deserunt vel.', 0, 1, '2012-11-26 21:43:38', 100, 100);
COMMIT;

INSERT INTO `message_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES (100, 'unde', '1997-11-25 19:43:39', '2001-02-06 07:18:56');
COMMIT;

INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (100, 100, 100, '1990-04-14 11:51:34', '2003-03-24 19:57:30', '1981-05-05 11:39:26', '1998-03-31 08:19:48');
COMMIT;

INSERT INTO `friendship_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES (100, 'quam', '2018-08-12 15:18:27', '1971-03-10 06:00:55');
COMMIT;

INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (100, 'doloremque', '2006-01-18 00:05:45', '2017-02-07 09:41:28');
COMMIT;

INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (100, 100, '2001-11-29 22:25:19');
COMMIT;

-- Роман, когда я заполнял таблицу ‘media’ появилась ошибка “SQL Error [1062] [23000]: Duplicate entry 'dolores' for key 'media.name’” Я погуглил и заполнил через команду REPLACE, но строки добавились не все (менее 100). Очевидно, что я где-то накосячил.
Подскажите, пожалуйста в чем была ошибка?


INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (100, 'soluta', '2000-09-30 10:28:18', '1996-01-18 16:15:52');
COMMIT;

INSERT INTO `media_likes` (`id`, `from_user_id`, `mediafile_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`) VALUES (100, 100, 100, 'beatae', 8, NULL, 100, '1991-05-30 03:46:59');
COMMIT;

INSERT INTO `user_likes` (`id`, `from_user_id`, `message_id`, `created_at`) VALUES (100, 100, 100, '1984-03-15 11:52:13');
COMMIT;

INSERT INTO `messages_likes` (`id`, `from_user_id`, `message_id`, `created_at`) VALUES (100, 100, 100, '2002-01-05 14:27:22');
COMMIT;












