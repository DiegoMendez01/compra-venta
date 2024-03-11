/*
*
* Store Procedures Companies
*
*/

-- Listar todos los registros
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_L_COMPANY_01
BEGIN
	SELECT
		*
	FROM
		companies
	WHERE
		is_active = 1
END //
DELIMITER ;

-- Obtener registro por ID
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_L_COMPANY_02 (IN companyId INT)
BEGIN
	SELECT
		*
	FROM
		companies
	WHERE
		id = companyId AND is_active = 1
END //
DELIMITER ;

-- Eliminar registro por ID
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_D_COMPANY_01(IN companyId INT)
BEGIN
    UPDATE 
        companies
    SET
        is_active = 0
    WHERE
        id = companyId;
END //
DELIMITER ;

-- Registrar nuevo registro
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_I_COMPANY_01 (IN companyName VARCHAR(200))
BEGIN
	INSERT INTO
		companies (name, created)
	VALUES
		(companyName, NOW())
END //
DELIMITER ;

-- Actualizar registro
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_U_COMPANY_01 (IN companyId INT, companyName VARCHAR(200))
BEGIN
	UPDATE
		companies
	SET
		name = companyName
	WHERE
		id = companyId
END //
DELIMITER ;