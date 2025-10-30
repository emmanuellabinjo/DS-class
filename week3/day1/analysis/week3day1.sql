CREATE TABLE employees_hr (
	emp_no				INT	PRIMARY KEY,
	gender				TEXT,
	marital_status		TEXT,
	age_band			TEXT,
	age					SMALLINT,
	department			TEXT,
	education			TEXT,
	education_fiekd		TEXT,
	job_role			TEXT,
	business_travel		TEXT,
	employee_count		INT,
	attrition			TEXT,
	attrition_label		TEXT,
	job_satisfaction	SMALLINT,
	active_employee		SMALLINT
	);

-- Fix the typo in the column name from 'education_fiekd' to 'education_field'
ALTER TABLE employees_hr
RENAME COLUMN education_fiekd TO education_field;

-- Count the total number of employees in each department
SELECT department, count(*) as employee_count
FROM employees_hr
GROUP BY department;

-- Calculate the average age of employees by department
SELECT department, avg(age) as average_age
FROM employees_hr
GROUP BY department;

-- Count the number of employees in each marital status category
SELECT marital_status, count(*) as marital_count
from employees_hr
GROUP BY marital_status;

-- Count the number of employees by department and job role, ordered alphabetically
select department, job_role, count(*) as job_count
from employees_hr
GROUP BY department, job_role
ORDER BY department, job_role
DESC;

-- Calculate the average job satisfaction score by education level
SELECT education, avg(job_satisfaction) as avg_job
from employees_hr
GROUP BY education;

-- Calculate the average job satisfaction by department, sorted from highest to lowest
SELECT department, avg(job_satisfaction) as avg_job
from employees_hr
GROUP BY department
ORDER BY avg_job
DESC;

-- Find the average job satisfaction for employees who travel frequently, grouped by education level
select education, AVG(job_satisfaction) AS average_satisfaction
FROM employees_hr
WHERE business_travel = 'Travel_Frequently'
GROUP BY education
ORDER BY average_satisfaction DESC;


select * from employees_hr;



