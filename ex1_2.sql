WITH category_spend AS (
    SELECT 
        c.customer_id,
        p.category,
        SUM(p.price * oi.quantity) AS total_spend
    FROM 
        order_items oi
        JOIN orders o ON oi.order_id = o.order_id
        JOIN products p ON oi.product_id = p.product_id
        JOIN customers c ON o.customer_id = c.customer_id
    WHERE 
        o.status = 'completed'
    GROUP BY 
        c.customer_id, p.category
)
SELECT 
    category,
    customer_id,
    total_spend
FROM 
    category_spend
WHERE 
    (category, total_spend) IN (
        SELECT 
            category, MAX(total_spend)
        FROM 
            category_spend
        GROUP BY 
            category
    );