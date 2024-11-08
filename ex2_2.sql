WITH RECURSIVE employee_worked_hours AS (
    
    SELECT 
        ep.employee_id,
        ep.hours_worked,
        CURRENT_DATE::timestamp AS work_date 
    FROM 
        employee_projects ep
    WHERE 
        ep.hours_worked > 0
    UNION ALL
    SELECT 
        ep.employee_id,
        ep.hours_worked,
        ew.work_date + INTERVAL '7 days' AS work_date
    FROM 
        employee_projects ep
        JOIN employee_worked_hours ew ON ep.employee_id = ew.employee_id
    WHERE 
        ew.work_date + INTERVAL '7 days' <= CURRENT_DATE
)

SELECT 
    employee_id,
    SUM(hours_worked) / 4 AS avg_weekly_hours 
FROM 
    employee_worked_hours
GROUP BY 
    employee_id
HAVING 
    SUM(hours_worked) / 4 > 40; 
