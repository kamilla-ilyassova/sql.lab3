CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    budget NUMERIC(10, 2)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    department_id INTEGER REFERENCES departments(department_id),
    hourly_rate NUMERIC(10, 2)
);

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    department_id INTEGER REFERENCES departments(department_id),
    total_hours_allocated INTEGER
);

CREATE TABLE employee_projects (
    employee_project_id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(employee_id),
    project_id INTEGER REFERENCES projects(project_id),
    hours_worked INTEGER
);

INSERT INTO departments (budget) 
VALUES 
(10000.00),  
(15000.00),  
(20000.00); 

INSERT INTO employees (department_id, hourly_rate) 
VALUES 
(1, 30.00),  
(1, 25.00),  
(2, 35.00),  
(2, 40.00), 
(3, 50.00);  

INSERT INTO projects (department_id, total_hours_allocated) 
VALUES 
(1, 500),  
(2, 600),  
(3, 800);  

INSERT INTO employee_projects (employee_id, project_id, hours_worked)
VALUES 
(1, 1, 120),  
(1, 2, 150),  
(2, 1, 200),  
(2, 2, 180),  
(3, 2, 250),  
(3, 3, 300),  
(4, 2, 350),  
(5, 3, 400);  

SELECT 
    p.project_id,
    d.department_id,
    d.budget,
    SUM(ep.hours_worked * e.hourly_rate) AS total_cost
FROM 
    employee_projects ep
    JOIN employees e ON ep.employee_id = e.employee_id
    JOIN projects p ON ep.project_id = p.project_id
    JOIN departments d ON p.department_id = d.department_id
GROUP BY 
    p.project_id, d.department_id, d.budget
HAVING 
    SUM(ep.hours_worked * e.hourly_rate) > d.budget;
