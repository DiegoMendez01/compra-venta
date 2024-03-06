/*
*
* SCRIPT DATABASE COMPRA_VENTA
*
*/

/* Entities for Database */

-- compra_ventadb.companies definition
CREATE TABLE companies
(
	`id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`))
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.enterprises definition
CREATE TABLE enterprises
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `RUC` VARCHAR(100) NOT NULL,
    `company_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_company_id` (`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.branches definition
CREATE TABLE branches
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `enterprise_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`enterprise_id`) REFERENCES `enterprises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_enterprise_id` (`enterprise_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.identification_types definition
CREATE TABLE identification_types
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`))
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;


-- compra_ventadb.users definition
CREATE TABLE users
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `last_name` VARCHAR(200) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `identification_type_id` INT(11) NOT NULL,
    `identification` VARCHAR(30) NOT NULL,
    `phone` VARCHAR(30) NOT NULL,
    `password_hash` VARCHAR(200) NOT NULL,
    `api_key` VARCHAR(200) NOT NULL,
    `email_confirmed_token` VARCHAR(200),
	`phone_confirmed_token` VARCHAR(20),
    `validate` TINYINT(2) NOT NULL DEFAULT 1,
    `branch_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`identification_type_id`) REFERENCES `identification_types` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_branch_id` (`branch_id`) USING BTREE,
    INDEX `idx_identification_type_id` (`identification_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.roles definition
CREATE TABLE roles
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `branch_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.currencies definition
CREATE TABLE currencies
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `branch_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.categories definition
CREATE TABLE categories
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `branch_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.units definition
CREATE TABLE units
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `branch_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.products definition
CREATE TABLE products
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `description` VARCHAR(250) NOT NULL,
    `stock` INT(11) NOT NULL,
    `expiration_date` DATE NOT NULL,
    `image` VARCHAR(500),
    `purchase_price` DECIMAL(18, 2),
    `selling_price` DECIMAL(18, 2),
	`category_id` INT(11) NOT NULL,
    `currency_id` INT(11) NOT NULL,
    `unit_id` INT(11) NOT NULL,
    `branch_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_branch_id` (`branch_id`) USING BTREE,
    INDEX `idx_category_id` (`category_id`) USING BTREE,
    INDEX `idx_currency_id` (`currency_id`) USING BTREE,
    INDEX `idx_unit_id` (`unit_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.customers definition
CREATE TABLE customers
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `RUC` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
	`address` VARCHAR(200) NOT NULL,
    `email` VARCHAR(200) NOT NULL,
    `enterprise_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`enterprise_id`) REFERENCES `enterprises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_enterprise_id` (`enterprise_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.suppliers definition
CREATE TABLE suppliers
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `RUC` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
	`address` VARCHAR(200) NOT NULL,
    `email` VARCHAR(200) NOT NULL,
    `enterprise_id` INT(11) NOT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)),
    FOREIGN KEY (`enterprise_id`) REFERENCES `enterprises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_enterprise_id` (`enterprise_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;
