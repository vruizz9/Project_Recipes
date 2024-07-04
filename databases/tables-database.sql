CREATE DATABASE IF NOT EXISTS `shared_meal`;

USE `shared_meal`;

-- Estructura de la tabla usuarios

CREATE TABLE IF NOT EXISTS `user` (
    `id` BINARY(16) NOT NULL,
    `user_name` VARCHAR(28) NOT NULL UNIQUE,
    `password` VARCHAR(16) NOT NULL,
    PRIMARY KEY (`id`)
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- TRIGGER agrega el id binario al usuario

DELIMITER $$

CREATE TRIGGER before_insert_user
BEFORE INSERT ON `user`
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = UUID_TO_BIN(UUID());
    END IF;
END $$

DELIMITER ;

-- Estructura para la table step

CREATE TABLE IF NOT EXISTS `step` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` BINARY(16) NOT NULL,
    `description` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `step_user_id_fk`
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) 
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- Estructura para tabla de recetas

CREATE TABLE IF NOT EXISTS `recipe` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` BINARY(16) NOT NULL,
    `step_1_id` INT NOT NULL,
    `step_2_id` INT DEFAULT NULL,
    `step_3_id` INT DEFAULT NULL,
    `step_4_id` INT DEFAULT NULL,
    `step_5_id` INT DEFAULT NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `recipe_user_fk`
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`),

    CONSTRAINT `recipe_step1_fk`
    FOREIGN KEY (`step_1_id`) REFERENCES `step`(`id`),

    CONSTRAINT `recipe_step2_fk`
    FOREIGN KEY (`step_2_id`) REFERENCES `step`(`id`),

    CONSTRAINT `recipe_step3_fk`
    FOREIGN KEY (`step_3_id`) REFERENCES `step`(`id`),

    CONSTRAINT `recipe_step4_fk`
    FOREIGN KEY (`step_4_id`) REFERENCES `step`(`id`),

    CONSTRAINT `recipe_step5_fk`
    FOREIGN KEY (`step_5_id`) REFERENCES `step`(`id`)
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- Estructura para la tabla de rating

CREATE TABLE IF NOT EXISTS `rating` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` BINARY(16) NOT NULL,
    `recipe_id` INT NOT NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `rating_user_id_fk`
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),

    CONSTRAINT `rating_recipe_id_fk`
    FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- Estructura para la tabla favorite recipe

CREATE TABLE IF NOT EXISTS `favorite_recipe` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` BINARY(16) NOT NULL,
    `recipe_id` INT NOT NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `favorite_recipe_user_id_fk`
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
    
    CONSTRAINT `favorite_recipe_recipe_id_fk`
    FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- Estructura para la tabla de shared recipes

CREATE TABLE IF NOT EXISTS `shared_recipes`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` BINARY(16) NOT NULL,
    `recipe_id` INT NOT NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `shared_recipes_user_id_fk`
    FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),

    CONSTRAINT `shared_recipes_recipe_id_fk`
    FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;