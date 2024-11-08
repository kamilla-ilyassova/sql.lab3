SELECT 
    product_id,
    order_date,
    AVG(quantity) OVER (
        PARTITION BY product_id 
        ORDER BY order_date 
        RANGE BETWEEN INTERVAL '6 DAYS' PRECEDING AND CURRENT ROW
    ) AS rolling_avg_quantity
FROM 
    order_items oi
    JOIN orders o ON oi.order_id = o.order_id
WHERE 
    o.status = 'completed';