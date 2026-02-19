show databases;
create database subquiries;
use subquiries;

CREATE TABLE EmployeeDataset (
    emp_id INT PRIMARY KEY,
    name VARCHAR(255) not null,
    department_id VARCHAR(10) not null,
    salary INT
);

INSERT INTO EmployeeDataset (emp_id, name, department_id, salary) VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

select * from EmployeeDataset;

CREATE TABLE Department (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50) not null,
    location VARCHAR(50) not null
);
INSERT INTO Department (department_id, department_name, location) VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');
select * from Department;

CREATE TABLE Sales_Dataset (
    sale_id INT PRIMARY KEY,
    emp_id INT not null,
    sale_amount INT,
    sale_date DATE
);
INSERT INTO Sales_Dataset (sale_id, emp_id, sale_amount, sale_date) VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');
select * from Sales_Dataset;
select * from EmployeeDataset;
select * from Department;
select name,salary from EmployeeDataset where salary > (select avg(salary) as avg_sal from EmployeeDataset);

#Find the employees who belong to the department with the highest average salary.
select max(avg(salary)) from (select avg(salary) from EmployeeDataset as DepartmentAverageSalaries);
SELECT
    E.emp_id,
    E.name,
    E.salary,
    D.department_name,
    D.location
FROM
    EmployeeDataset AS E
JOIN
    Department AS D ON E.department_id = D.department_id
WHERE
    E.department_id IN (
        SELECT
            department_id
        FROM
            EmployeeDataset
        GROUP BY
            department_id
        HAVING
            AVG(salary) = (
                SELECT
                    MAX(avg_salary)
                FROM
                    (
                        SELECT
                            AVG(salary) AS avg_salary
                        FROM
                            EmployeeDataset
                        GROUP BY
                            department_id
                    ) AS DepartmentAverageSalaries
            )
    );
    
    #ind the employees who belong to the department with the highest average salary
    select * from EmployeeDataset;
    select department_id, max(avg_sal) from 
    (
    (select  avg(salary) as avg_sal,department_id from EmployeeDataset group by department_id)
    )
    as max_sal group by department_id;
    
    #List all employees who have made at least one sale.
    select * from Sales_Dataset;
    select * from EmployeeDataset;
    
     select e.emp_id,e.name,s.sale_id,s.sale_amount
    from EmployeeDataset e
    left join Sales_Dataset s
    on e.emp_id=s.emp_id ;
    
    #Find the employee with the highest sale amount.
   
    select e.emp_id,e.name,s.sale_id,s.sale_amount
    from EmployeeDataset e
    left join Sales_Dataset s
    on e.emp_id=s.emp_id order by s.sale_amount desc
    limit 1;
    
    #Retrieve the names of employees whose salaries are higher than Shubham’s salary.
    select * from Sales_Dataset;
    select * from EmployeeDataset;
    select name from EmployeeDataset where salary >
    (select salary from EmployeeDataset where name="Shubham");
    
    #Find employees who work in the same department as Abhishek
    select * from Sales_Dataset;
    select * from EmployeeDataset;
    select * from Department;
    select name from EmployeeDataset where department_id =
    (select department_id from EmployeeDataset e where name="Abhishek");
    
    #List departments that have at least one employee earning more than ₹60,000
    select * from Department;
    select * from EmployeeDataset;
    select department_name from Department where department_id in
    (select department_id from EmployeeDataset where salary>"60,000");
    
    #Find the department name of the employee who made the highest sale.
    select * from Department;
    select * from EmployeeDataset;
    select * from Sales_Dataset;
   select d.department_name,e.name,sale_amount
   from Department d
   left join EmployeeDataset e
   on d.department_id=e.department_id
   left join Sales_Dataset s
   on e.emp_id=s.emp_id
   where sale_amount =(select max(sale_amount) from Sales_Dataset) ;
   
   #Retrieve employees who have made sales greater than the average sale amount.
   select * from Department;
    select * from EmployeeDataset;
    select * from Sales_Dataset;
   select e.name,s.sale_amount
   from EmployeeDataset e
   left join Sales_Dataset s
   on e.emp_id=s.emp_id
   where sale_amount >
   (select avg(sale_amount) as avg_sale_amt from Sales_Dataset ) order by sale_amount desc;
   
   #Find the total sales made by employees who earn more than the average salary.
   select * from Department;
    select * from EmployeeDataset;
    select * from Sales_Dataset;
   select avg(salary) from EmployeeDataset;
   select  e.name,e.salary,s.sale_amount
   from EmployeeDataset e
   left join Sales_Dataset s
   on e.emp_id=s.emp_id;
   
   
   select sum(s.sale_amount) as total_sales
   from Sales_Dataset s
   left join EmployeeDataset e
   on s.emp_id=e.emp_id
   where (select avg(salary) from EmployeeDataset);
   
   #Find employees who have not made any sales.
   select * from EmployeeDataset;
    select * from Sales_Dataset; 
    select e.name,s.sale_id
    from EmployeeDataset e
    left join Sales_Dataset s
    on e.emp_id=s.emp_id
    where s.sale_id is null;
    
    #List departments where the average salary is above ₹55,000.
    select * from EmployeeDataset;
    select * from Sales_Dataset; 
    select * from Department;
    
  SELECT D.department_name
FROM EmployeeDataset E
JOIN Department D ON E.department_id = D.department_id
GROUP BY D.department_name
HAVING AVG(E.salary) > 55000;

#Retrieve department names where the total sales exceed ₹10,000
 select * from Sales_Dataset; 
select * from Department;
select * from EmployeeDataset;
select d.department_name
from EmployeeDataset e
join Department d
on e.department_id=d.department_id
join Sales_Dataset s
on e.emp_id=s.emp_id
group by d.department_name
having sum(s.sale_amount)>10000;

#Find the employee who has made the second-highest sale.
select * from Sales_Dataset; 
select * from Department;
select * from EmployeeDataset;
select sale_amount from Sales_Dataset order by sale_amount desc limit 1 offset 1;
select e.emp_id,e.name 
from EmployeeDataset e
join Sales_Dataset s
on e.emp_id=s.emp_id
where sale_amount = 
(
select sale_amount from Sales_Dataset order by sale_amount desc limit 1 offset 1
);

#Retrieve the names of employees whose salary is greater than the highest sale amount recorded
select name,salary from EmployeeDataset where salary >
 (
select max(sale_amount) from Sales_Dataset
) order by salary desc;

