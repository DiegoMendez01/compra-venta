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
    `name` VARCHAR(200) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`))
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.enterprises definition
CREATE TABLE enterprises
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `RUC` VARCHAR(100) DEFAULT NULL,
    `company_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_company_id` (`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.branches definition
CREATE TABLE branches
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `enterprise_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`enterprise_id`) REFERENCES `enterprises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_enterprise_id` (`enterprise_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.identification_types definition
CREATE TABLE identification_types
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;


-- compra_ventadb.users definition
CREATE TABLE users
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `last_name` VARCHAR(200) DEFAULT NULL,
    `email` VARCHAR(100) DEFAULT NULL,
    `identification_type_id` INT(11) DEFAULT NULL,
    `identification` VARCHAR(30) DEFAULT NULL,
    `phone` VARCHAR(30) DEFAULT NULL,
    `password_hash` VARCHAR(200) DEFAULT NULL,
    `api_key` VARCHAR(200) DEFAULT NULL,
    `email_confirmed_token` VARCHAR(200) DEFAULT NULL,
	`phone_confirmed_token` VARCHAR(20) DEFAULT NULL,
    `validate` TINYINT(2) DEFAULT NULL DEFAULT 1,
    `branch_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`identification_type_id`) REFERENCES `identification_types` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_branch_id` (`branch_id`) USING BTREE,
    INDEX `idx_identification_type_id` (`identification_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.roles definition
CREATE TABLE roles
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.currencies definition
CREATE TABLE currencies
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.categories definition
CREATE TABLE categories
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
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
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.products definition
CREATE TABLE products
(
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) DEFAULT NULL,
    `description` VARCHAR(250) DEFAULT NULL,
    `stock` INT(11) DEFAULT NULL,
    `expiration_date` DATE DEFAULT NULL,
    `image` VARCHAR(500) DEFAULT NULL,
    `purchase_price` DECIMAL(18, 2) DEFAULT NULL,
    `selling_price` DECIMAL(18, 2) DEFAULT NULL,
	`category_id` INT(11) DEFAULT NULL,
    `currency_id` INT(11) DEFAULT NULL,
    `unit_id` INT(11) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
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
    `name` VARCHAR(200) DEFAULT NULL,
    `RUC` VARCHAR(100) DEFAULT NULL,
    `phone` VARCHAR(20) DEFAULT NULL,
	`address` VARCHAR(200) DEFAULT NULL,
    `email` VARCHAR(200) DEFAULT NULL,
    `enterprise_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`enterprise_id`) REFERENCES `enterprises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_enterprise_id` (`enterprise_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.suppliers definition
CREATE TABLE suppliers
(
    `id` INT(11) AUTO_INCREMENT,
	`name` VARCHAR(150) DEFAULT NULL,
    `RUC` VARCHAR(100) DEFAULT NULL,
    `phone` VARCHAR(20) DEFAULT NULL,
	`address` VARCHAR(200) DEFAULT NULL,
    `email` VARCHAR(200) DEFAULT NULL,
    `enterprise_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`),
    `custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
    FOREIGN KEY (`enterprise_id`) REFERENCES `enterprises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE, 
    INDEX `idx_enterprise_id` (`enterprise_id`) USING BTREE
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.payments definition
CREATE TABLE payments
(
	`id` INT(11) AUTO_INCREMENT,
	`name` VARCHAR(200) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	`custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.menus definition
CREATE TABLE menus
(
	`id` INT(11) AUTO_INCREMENT,
	`name` VARCHAR(200) DEFAULT NULL,
	`route` VARCHAR(150) DEFAULT NULL,
	`identification` VARCHAR(150) DEFAULT NULL,
	`group` VARCHAR(150) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	`custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.documents definition
CREATE TABLE documents
(
	`id` INT(11) AUTO_INCREMENT,
	`name` VARCHAR(200) DEFAULT NULL,
	`type` VARCHAR(150) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	`custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.purchases definition
CREATE TABLE purchases
(
	`id` INT(11) AUTO_INCREMENT,
	`supplier_ruc` VARCHAR(100) DEFAULT NULL,
	`supplier_address` VARCHAR(200) DEFAULT NULL,
	`supplier_email` VARCHAR(200) DEFAULT NULL,
	`subtotal` DECIMAL(18, 2) DEFAULT 0.00,
	`igv` DECIMAL(18, 2) DEFAULT 0.00,
	`total` DECIMAL(18, 2) DEFAULT 0.00,
	`comment` VARCHAR(300) DEFAULT NULL,
	`branch_id` INT(11) DEFAULT NULL,
	`payment_id` INT(11) DEFAULT NULL,
	`user_id` INT(11) DEFAULT NULL,
	`currency_id` INT(11) DEFAULT NULL,
	`document_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	`custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`payment_id`) REFERENCES payments (`id`),
	FOREIGN KEY (`branch_id`) REFERENCES branches (`id`),
	FOREIGN KEY (`user_id`) REFERENCES users (`id`),
	FOREIGN KEY (`currency_id`) REFERENCES currencies (`id`),
	FOREIGN KEY (`document_id`) REFERENCES documents (`id`),
	INDEX `idx_payment_id` (`payment_id`),
	INDEX `idx_branch_id` (`branch_id`),
	INDEX `idx_user_id` (`user_id`),
	INDEX `idx_currency_id` (`currency_id`),
	INDEX `idx_document_id` (`document_id`)
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.purchase_details definition
CREATE TABLE purchase_details
(
	`id` INT(11) AUTO_INCREMENT,
	`purchase_id` INT(11) DEFAULT NULL,
	`product_id` INT(11) DEFAULT NULL,
	`product_purchase_price` DECIMAL(18, 2) DEFAULT 0.00,
	`quantity` INT(11) DEFAULT NULL,
	`total` DECIMAL(18, 2) DEFAULT 0.00,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	`custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`product_id`) REFERENCES products (`id`),
	FOREIGN KEY (`purchase_id`) REFERENCES purchases (`id`),
	INDEX `idx_product_id` (`product_id`),
	INDEX `idx_purchase_id` (`purchase_id`)
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.sales definition
CREATE TABLE sales
(
	`id` INT(11) AUTO_INCREMENT,
	`customer_ruc` VARCHAR(100) DEFAULT NULL,
	`customer_address` VARCHAR(200) DEFAULT NULL,
	`customer_email` VARCHAR(200) DEFAULT NULL,
	`subtotal` DECIMAL(18, 2) DEFAULT NULL,
	`igv` DECIMAL(18, 2) DEFAULT NULL,
	`total` DECIMAL(18, 2) DEFAULT NULL,
	`comment` VARCHAR(500) DEFAULT NULL,
	`branch_id` INT(11) DEFAULT NULL,
	`payment_id` INT(11) DEFAULT NULL,
	`customer_id` INT(11) DEFAULT NULL,
	`user_id` INT(11) DEFAULT NULL,
	`currency_id` INT(11) DEFAULT NULL,
	`document_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	`custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`branch_id`) REFERENCES branches (`id`),
	FOREIGN KEY (`payment_id`) REFERENCES payments (`id`),
	FOREIGN KEY (`customer_id`) REFERENCES customers (`id`),
	FOREIGN KEY (`user_id`) REFERENCES users (`id`),
	FOREIGN KEY (`currency_id`) REFERENCES currencies (`id`),
	FOREIGN KEY (`document_id`) REFERENCES documents (`id`),
	INDEX `idx_branch_id` (`branch_id`),
	INDEX `idx_payment_id` (`payment_id`),
	INDEX `idx_customer_id` (`customer_id`),
	INDEX `idx_user_id` (`user_id`),
	INDEX `idx_currency_id` (`currency_id`),
	INDEX `idx_document_id` (`document_id`)
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;

-- compra_ventadb.sale_details definition
CREATE TABLE sale_details
(
	`id` INT(11) AUTO_INCREMENT,
	`product_purchase_price` DECIMAL(18, 2) DEFAULT 0.00,
	`quantity` INT(11) DEFAULT NULL,
	`total` DECIMAL(18, 2) DEFAULT 0.00,
	`product_id` INT(11) DEFAULT NULL,
	`sale_id` INT(11) DEFAULT NULL,
	`created` DATETIME NOT NULL,
    `modified` TIMESTAMP NOT NULL,
    `is_active` TINYINT(2) NOT NULL DEFAULT 1,
	`custom_fields` LONGTEXT CHECK (json_valid(`custom_fields`)) DEFAULT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`product_id`) REFERENCES products (`id`),
	FOREIGN KEY (`sale_id`) REFERENCES sales (`id`),
	INDEX `idx_product_id` (`product_id`),
	INDEX `idx_sale_id` (`sale_id`)
) ENGINE=InnoDB DEFAULT charset=utf8mb4 COLLATE=utf8mb4_bin;