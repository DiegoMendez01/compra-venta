/*
*
* Store Procedures Categories
*
*/

-- Listar todos los registros por Sucursal
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_L_CATEGORY_01(IN branchId INT)
BEGIN
    SELECT 
        id,
        branch_id,
        name,
        DATE_FORMAT(created, '%d/%m/%Y') AS created,
        is_active
    FROM 
        categories
    WHERE
        branch_id = branchId AND is_active = 1;
END //
DELIMITER ;

-- Obtener registro por ID
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_L_CATEGORY_02(IN categoryId INT)
BEGIN
    SELECT 
        *
    FROM 
        categories
    WHERE
        id = categoryId AND is_active = 1;
END //
DELIMITER ;

-- Eliminar Registro por ID de forma logica
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_D_CATEGORY_01(IN categoryId INT)
BEGIN
    UPDATE 
        categories
    SET
        is_active = 0
    WHERE
        id = categoryId;
END //
DELIMITER ;

-- Registrar nuevo registro
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_I_CATEGORY_01(IN branchId INT, categoryName VARCHAR(200))
BEGIN
    INSERT INTO
        categories (branch_id, name, created)
    VALUES
        (branchId, categoryName, NOW());
END //
DELIMITER ;

-- Actualizar registro por id
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_U_CATEGORY_01(IN categoryId INT, branchId INT, categoryName VARCHAR(200))
BEGIN
    UPDATE
        categories
    SET
        branch_id = branchId,
        name = categoryName
    WHERE
        id = categoryId;
END //
DELIMITER ;