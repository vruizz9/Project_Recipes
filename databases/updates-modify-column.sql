-- Modificacion a la estructura de la tabla usuarios para saber en que momento es creado el usuario y cuando se modifica.

ALTER TABLE `user`
ADD COLUMN `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `user`
ADD COLUMN `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Modificacion de la estructura para la tablas recipe se agrega el momento de creacion y tambien cuando se actualiza estoy es importante saberlo para las recetas.

ALTER TABLE `recipe`
ADD COLUMN `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `recipe`
ADD COLUMN `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Modifica estructura para la tabla recipe agrega titilo para la receta

ALTER TABLE `recipe`
ADD COLUMN `title` VARCHAR(255) NOT NULL;

-- Se modifica la estructura de la tabla user en la fila id para introducir el formato BIGING Para tener en cuenta que otras tablas tambien usan el id para relacionarse mediante el usuario asi que se debe modificar en esas tabla el tipo de dato.

ALTER TABLE `user`
MODIFY COLUMN `id` BIGINT UNSIGNED NOT NULL;