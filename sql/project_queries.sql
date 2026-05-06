USE customer_revenue_db;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;


-- QUERY 1: Top 3 customers by revenue contribution
SELECT 
    t.customer_id,
    t.total_revenue,
    ROUND((t.total_revenue / tr.overall_revenue) * 100, 2) AS contribution_percentage
FROM (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * p.price) AS total_revenue
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY o.customer_id
) t
CROSS JOIN (
    SELECT SUM(oi.quantity * p.price) AS overall_revenue
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    JOIN products p 
        ON oi.product_id = p.product_id
) t
ORDER BY contribution_percentage DESC;


-- Query 2: Find monthly revenue growth rate (%)
SELECT 
    month,
    revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY month)) 
        / LAG(revenue) OVER (ORDER BY month)) * 100, 
    2) AS growth_percentage
FROM (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.quantity * p.price) AS revenue
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
) t;


-- Query 3: Find customers whose revenue is above average revenue of all customers
SELECT customer_id, ttl_rev_per_cust
FROM (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * p.price) AS ttl_rev_per_cust
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY o.customer_id
) t
WHERE ttl_rev_per_cust > (
    SELECT AVG(customer_revenue)
    FROM (
        SELECT 
            SUM(oi.quantity * p.price) AS customer_revenue
        FROM orders o
        JOIN order_items oi 
            ON o.order_id = oi.order_id
        JOIN products p 
            ON oi.product_id = p.product_id
        GROUP BY o.customer_id
    ) x
);


-- Query 4: Find top product category for each month (by revenue)
SELECT month, category, revenue
FROM (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        p.category,
        SUM(oi.quantity * p.price) AS revenue,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m')
            ORDER BY SUM(oi.quantity * p.price) DESC
        ) AS rnk
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m'), p.category
) t
WHERE rnk = 1;

