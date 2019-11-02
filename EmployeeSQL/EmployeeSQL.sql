---Create Tables to impot data into
CREATE TABLE employees (
	emp_no INTEGER NOT NULL,
	PRIMARY KEY(emp_no),
	birth_date VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
);
CREATE TABLE departments (
	dept_no VARCHAR,
	PRIMARY KEY (dept_no),
	dept_name VARCHAR	
);
CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL, 	
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date DATE,
	to_date DATE
);
CREATE TABLE dept_manager(
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INTEGER NOT NULL, 	
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date DATE,
	to_date DATE
);

CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	salary INTEGER,
	from_date DATE,
	to_date DATE
);

CREATE TABLE titles(
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR,
	from_date DATE,
	to_date DATE
);

--Check to make sure data was properly imported
SELECT * FROM employees LIMIT 10;

----------Data Analysis--------------

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary 
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no);

-- List employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- List the manager of each department with the following information: 
--department number,department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT m.dept_no, d.dept_name, m.emp_no , e.last_name, e.first_name, m.from_date, m.to_date 
FROM dept_manager m
JOIN departments d ON (m.dept_no = d.dept_no)
JOIN employees e ON (m.emp_no = e.emp_no);

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON (de.emp_no = e.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no);

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON (de.emp_no = e.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON (de.emp_no = e.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';


-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Frequency Count"
FROM employees
GROUP BY last_name 
ORDER BY "Frequency Count" DESC;
