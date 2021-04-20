-- ДЗ_4

-- Роман, не могу выполнить следующие команды

ALTER TABLE media_likes ADD CONSTRAINT fk_media_likes_mediafile_id FOREIGN KEY (mediafile_id) REFERENCES media (id);
ALTER TABLE media ADD CONSTRAINT fk_entity_type FOREIGN KEY (entity_id) REFERENCES entity_types (id);

-- Появляется ошибка: Reason: SQL Error [1452] [23000]: Cannot add or update a child row: a foreign key constraint fails (`vk`.`#sql-82_18`, CONSTRAINT `fk_entity_type` FOREIGN KEY (`entity_id`) REFERENCES `entity_types` (`id`)) 

-- Роман, как и было указано в домашнем задании я потренировался со всеми функциями CRUD. Это можно увидеть в моем дамп файле к 4 дз. 