SELECT 
    d.department_id,
    EXTRACT(YEAR FROM CURRENT_DATE) AS year, 
    EXTRACT(QUARTER FROM CURRENT_DATE) AS quarter,  
    SUM(ep.hours_worked * e.hourly_rate) AS total_cost,
    d.budget
FROM 
    employee_projects ep
    JOIN employees e ON ep.employee_id = e.employee_id
    JOIN projects p ON ep.project_id = p.project_id
    JOIN departments d ON e.department_id = d.department_id
GROUP BY 
    d.department_id, year, quarter, d.budget
HAVING 
    SUM(ep.hours_worked * e.hourly_rate) > d.budget;
