-- Run as a single batch. Requires InnoDB.
use NorthWind;
SET FOREIGN_KEY_CHECKS = 0;


ALTER TABLE categories
  MODIFY COLUMN categoryID INT NOT NULL;

ALTER TABLE suppliers
  MODIFY COLUMN supplierID INT NOT NULL,
  MODIFY COLUMN postalCode VARCHAR(20);

ALTER TABLE products
  MODIFY COLUMN productID INT NOT NULL,
  MODIFY COLUMN supplierID INT,
  MODIFY COLUMN categoryID INT,
  MODIFY COLUMN unitPrice DECIMAL(10,2),
  MODIFY COLUMN discontinued TINYINT(1);

ALTER TABLE `orders`
  MODIFY COLUMN orderID INT NOT NULL,
  MODIFY COLUMN customerID VARCHAR(10),
  MODIFY COLUMN employeeID INT,
  MODIFY COLUMN orderDate DATE,
  MODIFY COLUMN requiredDate DATE,
  MODIFY COLUMN shippedDate DATE,
  MODIFY COLUMN shipVia INT,
  MODIFY COLUMN freight DECIMAL(10,2),
  MODIFY COLUMN shipPostalCode VARCHAR(20);

ALTER TABLE `order-details`
  MODIFY COLUMN orderID INT NOT NULL,
  MODIFY COLUMN productID INT NOT NULL,
  MODIFY COLUMN unitPrice DECIMAL(10,2),
  MODIFY COLUMN quantity INT,
  MODIFY COLUMN discount DECIMAL(5,2) DEFAULT 0;

-- 2) Primary keys (skip if already added)
ALTER TABLE customers     ADD PRIMARY KEY (customerID);
ALTER TABLE categories    ADD PRIMARY KEY (categoryID);
ALTER TABLE suppliers     ADD PRIMARY KEY (supplierID);
ALTER TABLE products      ADD PRIMARY KEY (productID);
ALTER TABLE `orders`      ADD PRIMARY KEY (orderID);

-- Order-Details composite PK
ALTER TABLE `order-details`
  ADD PRIMARY KEY (orderID, productID);

-- 3) Indexes for FK columns
CREATE INDEX idx_orders_customer   ON `orders`(customerID);
CREATE INDEX idx_products_category ON products(categoryID);
CREATE INDEX idx_products_supplier ON products(supplierID);
CREATE INDEX idx_od_product        ON `order-details`(productID);

-- 4) Foreign keys between the tables you have
ALTER TABLE `orders`
  ADD CONSTRAINT fk_orders_customer
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE products
  ADD CONSTRAINT fk_products_category
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  ADD CONSTRAINT fk_products_supplier
    FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE `order-details`
  ADD CONSTRAINT fk_od_order
    FOREIGN KEY (orderID) REFERENCES `orders`(orderID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  ADD CONSTRAINT fk_od_product
    FOREIGN KEY (productID) REFERENCES products(productID)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

SET FOREIGN_KEY_CHECKS = 1;
