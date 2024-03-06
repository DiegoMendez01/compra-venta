/*
*
* Store Procedures Customers
*
*/

-- Listar todos los registros por Sucursal
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_L_CUSTOMER_01(IN enterpriseId INT)
BEGIN
    SELECT 
        *
    FROM 
        customers
    WHERE
        enterprise_id = enterpriseId AND is_active = 1;
END //
DELIMITER ;

-- Obtener registro por ID
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_L_CUSTOMER_02(IN customerId INT)
BEGIN
    SELECT 
        *
    FROM 
        customers
    WHERE
        id = customerId AND is_active = 1;
END //
DELIMITER ;

-- Eliminar Registro por ID de forma logica
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_D_CUSTOMER_01(IN customerId INT)
BEGIN
    UPDATE 
        customers
    SET
        is_active = 0
    WHERE
        id = customerId;
END //
DELIMITER ;

-- Registrar nuevo registro
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_I_CUSTOMER_01
	(
	IN
	enterpriseId INT,
	customerName VARCHAR(200),
	customerRuc VARCHAR(100),
	customerPhone VARCHAR(20),
	customerAddress VARCHAR(200),
	customerEmail VARCHAR(200)
	)
BEGIN
    INSERT INTO
        categories (enterprise_id, name, RUC, phone, address, email, created)
    VALUES
        (enterpriseId, customerName, customerRuc, customerPhone, customerAddress, customerEmail, NOW());
END //
DELIMITER ;

-- Actualizar registro por id
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS SP_U_CUSTOMER_01
(
    IN customerId INT,
    IN enterpriseId INT,
    IN customerName VARCHAR(200),
    IN customerRuc VARCHAR(100),
    IN customerPhone VARCHAR(20),
    IN customerAddress VARCHAR(200),
    IN customerEmail VARCHAR(200)
)
BEGIN
    UPDATE customers
    SET 
        enterprise_id = enterpriseId,
        name = customerName,
        RUC = customerRuc,
        phone = customerPhone,
        address = customerAddress,
        email = customerEmail
    WHERE
        id = customerId;
END //

DELIMITER ;