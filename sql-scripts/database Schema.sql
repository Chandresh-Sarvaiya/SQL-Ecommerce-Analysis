-- SQL Schema for the Olist Brazilian E-Commerce Dataset

-- 1. Customers Table
-- Stores data about the customers.
CREATE TABLE customers (
    customer_id VARCHAR(32) NOT NULL,
    customer_unique_id VARCHAR(32) NOT NULL,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(255),
    customer_state VARCHAR(2),
    PRIMARY KEY (customer_id)
);

-- 2. Geolocation Table
-- Stores zip code prefixes and their lat/lng coordinates.
CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DOUBLE PRECISION,
    geolocation_lng DOUBLE PRECISION,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(2)
);

-- 3. Sellers Table
-- Stores data about the sellers.
CREATE TABLE sellers (
    seller_id VARCHAR(32) NOT NULL,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(255),
    seller_state VARCHAR(2),
    PRIMARY KEY (seller_id)
);

-- 4. Products Table
-- Stores data about the products.
CREATE TABLE products (
    product_id VARCHAR(32) NOT NULL,
    product_category_name VARCHAR(255),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT,
    PRIMARY KEY (product_id)
);

-- 5. Product Category Name Translation Table
-- Translates product category names to English.
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(255) NOT NULL,
    product_category_name_english VARCHAR(255),
    PRIMARY KEY (product_category_name)
);

-- 6. Orders Table
-- Stores data about the orders. This is a central table.
CREATE TABLE orders (
    order_id VARCHAR(32) NOT NULL,
    customer_id VARCHAR(32) NOT NULL,
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 7. Order Items Table
-- This is a junction table connecting Orders, Products, and Sellers.
CREATE TABLE order_items (
    order_id VARCHAR(32) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(32) NOT NULL,
    seller_id VARCHAR(32) NOT NULL,
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- 8. Order Payments Table
-- Stores data about order payment methods.
CREATE TABLE order_payments (
    order_id VARCHAR(32) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(20),
    payment_installments INT,
    payment_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 9. Order Reviews Table
-- Stores customer reviews for orders.
CREATE TABLE order_reviews (
    review_id VARCHAR(32) NOT NULL,
    order_id VARCHAR(32) NOT NULL,
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    PRIMARY KEY (review_id, order_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- PostgreSQL COPY Commands for importing data into the Olist E-Commerce database.

-- 1. Customers Table
COPY customers(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
FROM 'C:/sqldata/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 2. Geolocation Table
COPY geolocation(geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
FROM 'C:/sqldata/olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 3. Sellers Table
COPY sellers(seller_id, seller_zip_code_prefix, seller_city, seller_state)
FROM 'C:/sqldata/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 4. Products Table
COPY products(product_id, product_category_name, product_name_lenght, product_description_lenght, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
FROM 'C:/sqldata/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 5. Product Category Name Translation Table
COPY product_category_name_translation(product_category_name, product_category_name_english)
FROM 'C:/sqldata/product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;

-- 6. Orders Table
COPY orders(order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date)
FROM 'C:/sqldata/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 7. Order Items Table
COPY order_items(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
FROM 'C:/sqldata/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 8. Order Payments Table
COPY order_payments(order_id, payment_sequential, payment_type, payment_installments, payment_value)
FROM 'C:/sqldata/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 9. Order Reviews Table
COPY order_reviews(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp)
FROM 'C:/sqldata/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;