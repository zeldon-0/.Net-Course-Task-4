-- CREATE DATABASE Task4;
USE Task4;

CREATE TABLE Employees
(
	emp_id INT PRIMARY KEY IDENTITY,
	f_name VARCHAR(30),
	l_name VARCHAR(30)
);


CREATE TABLE Projects
(
	project_id INT PRIMARY KEY IDENTITY,
	p_name VARCHAR(30),
	date_started DATE,
	date_completed DATE NULL
);


CREATE TABLE Project_statuses
(
	status_id INT PRIMARY KEY IDENTITY,
	project_id INT,
	closed BIT,
	CONSTRAINT FK1_PROJECT FOREIGN KEY (project_id)
	REFERENCES Projects(project_id)
);


CREATE TABLE Roles
(
	role_id INT PRIMARY KEY IDENTITY,
	title VARCHAR(30)
)


CREATE TABLE Tasks
(
	task_id INT PRIMARY KEY IDENTITY,
	t_description VARCHAR(30),
	deadline Date
)


CREATE TABLE Task_statuses
(
	status_id INT PRIMARY KEY IDENTITY,
	task_id INT,
	s_description VARCHAR(30),
	change_date DATE,
	changer_id INT ,
	CONSTRAINT FK1_TASK FOREIGN KEY (task_id)
	REFERENCES Tasks(task_id),
	CONSTRAINT FK2_CHANGER FOREIGN KEY (changer_id)
	REFERENCES Employees(emp_id)
);


CREATE TABLE Role_assignment
(
	ra_id  INT PRIMARY KEY IDENTITY,
	emp_id INT,
	project_id INT,
	role_id INT,

	CONSTRAINT FK1_EMPLOYEE FOREIGN KEY (emp_id)
	REFERENCES Employees(emp_id),
	CONSTRAINT FK2_PROJECT FOREIGN KEY (project_id)
	REFERENCES Projects(project_id),
	CONSTRAINT FK3_ROLE FOREIGN KEY (role_id)
	REFERENCES Roles(role_id)

)


CREATE TABLE Task_assignment
(
	ta_id INT PRIMARY KEY IDENTITY,
	ra_id INT,
	task_id INT,
	CONSTRAINT FK1_ROLE_ASSIGNMENT FOREIGN KEY (ra_id)
	REFERENCES Role_assignment(ra_id),
	CONSTRAINT FK2_TASK FOREIGN KEY (task_id)
	REFERENCES Tasks(task_id)
);


