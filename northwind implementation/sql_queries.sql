use NorthWind;

-- CATEGORY 1: SIMPLE LOOKUPS
-- Find a customer by name
SELECT * 
FROM customers 
WHERE contactName = 'Maria Anders';

-- CATEGORY 2: ONE-HOP RELATIONSHIPS
-- Find all products supplied by a supplier
SELECT p.productName, p.unitPrice
FROM products p
JOIN suppliers s ON p.supplierID = s.supplierID
WHERE s.companyName = 'Exotic Liquids';


-- CATEGORY 3: TWO-HOP RELATIONSHIPS
-- Find all orders made by a specific customer and the products ordered
SELECT o.orderID, p.productName, od.quantity
FROM orders o
JOIN `order-details` od ON o.orderID = od.orderID
JOIN products p ON od.productID = p.productID
JOIN customers c ON o.customerID = c.customerID
WHERE c.contactName = 'Maria Anders'
ORDER BY o.orderID, p.productName;

-- Suppliers of products in a category
SELECT DISTINCT s.companyName
FROM suppliers s
JOIN products p   ON s.supplierID = p.supplierID
JOIN categories c ON p.categoryID = c.categoryID
WHERE c.categoryName = 'Beverages'
ORDER BY s.companyName;


-- CATEGORY 4: AGGREGATION AND ANALYTICS
-- Count products by category
SELECT c.categoryName, COUNT(*) AS product_count
FROM categories c
JOIN products   p ON p.categoryID = c.categoryID
GROUP BY c.categoryName
ORDER BY product_count DESC, c.categoryName;


-- Top 5 customers by number of orders
SELECT c.contactName, COUNT(*) AS order_count
FROM customers c
JOIN orders o ON o.customerID = c.customerID
GROUP BY c.contactName
ORDER BY order_count DESC, c.contactName
LIMIT 5;

-- CATEGORY 5: TIME-BASED ANALYSIS
-- Orders placed in 1997 (with customer)
SELECT o.orderID, o.orderDate, c.contactName
FROM orders o
JOIN customers c ON c.customerID = o.customerID
WHERE YEAR(o.orderDate) = 1997
ORDER BY o.orderDate, o.orderID;

-- Monthly order counts for 1997
SELECT MONTH(o.orderDate) AS month, COUNT(*) AS order_count
FROM orders o
WHERE YEAR(o.orderDate) = 1997
GROUP BY MONTH(o.orderDate)
ORDER BY month;


-- CATEGORY 6: RECOMMENDATION QUERIES
-- “Bought together” with a seed product (‘Chai’)

SELECT p2.productName, COUNT(*) AS freq
FROM `order-details` od1
JOIN products p1 ON p1.productID = od1.productID
JOIN `order-details` od2 ON od2.orderID = od1.orderID
JOIN products p2 ON p2.productID = od2.productID
WHERE p1.productName = 'Chai' AND p2.productName <> 'Chai'
GROUP BY p2.productName
ORDER BY freq DESC, p2.productName
LIMIT 5;



-- Customers similar to ‘Maria Anders’ (shared products)

SELECT c2.contactName, COUNT(DISTINCT od1.productID) AS common_products
FROM customers c1
JOIN orders o1          ON o1.customerID = c1.customerID
JOIN `order-details` od1 ON od1.orderID   = o1.orderID
JOIN `order-details` od2 ON od2.productID = od1.productID
JOIN orders o2          ON o2.orderID     = od2.orderID
JOIN customers c2       ON c2.customerID  = o2.customerID
WHERE c1.contactName = 'Maria Anders' AND c2.contactName <> 'Maria Anders'
GROUP BY c2.contactName
HAVING common_products >= 2
ORDER BY common_products DESC, c2.contactName;
