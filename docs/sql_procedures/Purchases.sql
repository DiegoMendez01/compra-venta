/*
*
* Store Procedures Purchases
*
*/

-- Insertar compra
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS SP_I_PURCHASE_01 (IN userId INT, IN branchId INT)
BEGIN
    DECLARE lastId INT;
    
    INSERT INTO
		purchases (branch_id, user_id)
    VALUES
        (branchId, userId);
    
    SELECT LAST_INSERT_ID() INTO lastId;
    
    SELECT lastId AS id;
END //
DELIMITER;