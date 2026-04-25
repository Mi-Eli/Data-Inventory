CREATE DATABASE IF NOT EXISTS inventory_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE inventory_db;

CREATE TABLE IF NOT EXISTS users (
    id          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    fname       VARCHAR(50)     NOT NULL,
    lname       VARCHAR(50)     NOT NULL,
    bdate       DATE            NOT NULL,
    gender      ENUM('Male','Female','Prefer not to say') NOT NULL,
    gmail       VARCHAR(120)    NOT NULL,
    contact     VARCHAR(20)     NOT NULL,
    username    VARCHAR(30)     NOT NULL,
    password    VARCHAR(255)    NOT NULL,
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uq_username (username),
    UNIQUE KEY uq_gmail (gmail)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS products (
    id          INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    user_id     INT UNSIGNED    NOT NULL,
    name        VARCHAR(100)    NOT NULL,
    category    ENUM(
                  'Food','Drinks','Snacks','Fruits','Vegetables',
                  'Meat','Dairy','Bakery','Frozen','Seafood'
                ) NOT NULL,
    qty         INT UNSIGNED    NOT NULL DEFAULT 0,
    price       DECIMAL(10,2)   NOT NULL DEFAULT 0.00 CHECK (price >= 0),
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    KEY idx_name (name),
    KEY idx_user_id (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS stock_movements (
    id              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    product_id      INT UNSIGNED    NOT NULL,
    user_id         INT UNSIGNED    NOT NULL,
    movement_type   ENUM('purchase','sale','adjustment','damage','return') NOT NULL,
    quantity_change INT NOT NULL,
    reference_num   VARCHAR(50),
    notes           TEXT,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    KEY idx_product (product_id),
    KEY idx_user (user_id),
    KEY idx_type (movement_type),
    KEY idx_date (created_at),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
