use Task4;

-- 1. Получить список всех должностей компании с количеством сотрудников на каждой из них

SELECT r.title, COUNT(ra.emp_id)
FROM Roles AS r
JOIN Role_assignment AS ra
on r.role_id=ra.role_id
GROUP BY r.title;


-- 2. Определить список должностей компании, на которых нет сотрудников


SELECT r.title, COUNT(ra.emp_id)
FROM Roles AS r
LEFT JOIN Role_assignment AS ra
on r.role_id=ra.role_id
GROUP BY r.title
HAVING COUNT(ra.emp_id)=0;

-- 3. Получить список проектов с указанием, сколько сотрудников каждой должности работает на проекте

SELECT p.p_name, r.title, COUNT(r.role_id)
FROM Projects AS p
JOIN Role_assignment AS ra
ON p.project_id=ra.project_id
JOIN Roles AS r
ON ra.role_id=r.role_id
GROUP BY p.p_name, r.title
ORDER BY p.p_name ASC;

-- 4. Посчитать на каждом проекте, какое в среднем количество задач приходится на каждого сотрудника

SELECT p.p_name, COUNT(ta.task_id)/COUNT(ta.ra_id)
FROM Projects AS p
JOIN Role_assignment AS ra
ON p.project_id=ra.project_id
JOIN Task_assignment AS ta
ON ra.ra_id=ta.ra_id
GROUP BY p.p_name;

-- 5. Подсчитать длительность выполнения каждого проекта

SELECT p.p_name, 
	IIF(p.date_completed IS NULL, 
	DATEDIFF(year, p.date_started, CONVERT(date, GETDATE())),
	DATEDIFF(year, p.date_started, p.date_completed)) AS 'Years',
	
	IIF(p.date_completed IS NULL, 
	DATEDIFF(month, p.date_started, CONVERT(date, GETDATE()))%12,
	DATEDIFF(month, p.date_started, p.date_completed)%12) AS 'Months',

	IIF(p.date_completed IS NULL, 
	DATEDIFF(day, p.date_started, CONVERT(date, GETDATE()))%365%30,
	DATEDIFF(day, p.date_started, p.date_completed)%365%30) AS 'Days'
FROM Projects AS p;

-- 6. Определить сотрудников с минимальным количеством незакрытых задач
WITH subquery AS (SELECT e.emp_id AS id, COUNT(ta.task_id) AS quantity
	FROM Employees AS e
	JOIN Role_assignment AS ra
	ON e.emp_id=ra.emp_id
	JOIN Task_assignment AS ta
	ON ra.ra_id=ta.ra_id
	JOIN Task_statuses AS ts
	ON ta.task_id=ts.task_id
	WHERE ts.s_description NOT LIKE 'Accepted'
	GROUP BY e.emp_id)

SELECT e.f_name, e.l_name, s.quantity as 'Unfinished'
FROM subquery AS s
JOIN Employees AS e
ON e.emp_id=s.id
WHERE s.quantity in (SELECT MIN(s1.quantity) FROM subquery AS s1); 

-- 7. Определить сотрудников с максимальным количеством незакрытых задач, дедлайн которых уже истек

WITH subquery AS (SELECT e.emp_id AS id, COUNT(ta.task_id) AS quantity
	FROM Employees AS e
	JOIN Role_assignment AS ra
	ON e.emp_id=ra.emp_id
	JOIN Task_assignment AS ta
	ON ra.ra_id=ta.ra_id
	JOIN Tasks AS t
	ON t.task_id=ta.ta_id
	JOIN Task_statuses AS ts
	ON ta.task_id=ts.task_id
	WHERE ts.s_description NOT LIKE 'Accepted' 
	AND DATEDIFF(day, t.deadline, GETDATE())>0
	GROUP BY e.emp_id)

SELECT e.f_name, e.l_name, s.quantity as 'Unfinished'
FROM subquery AS s
JOIN Employees AS e
ON e.emp_id=s.id;

-- 8. Продлить дедлайн незакрытых задач на 5 дней
UPDATE Tasks 
SET deadline=DATEADD (day, 5, deadline)
WHERE task_id IN
	(SELECT t.task_id
	FROM Employees AS e
	JOIN Role_assignment AS ra
	ON e.emp_id=ra.emp_id
	JOIN Task_assignment AS ta
	ON ra.ra_id=ta.ra_id
	JOIN Tasks AS t
	ON t.task_id=ta.ta_id
	JOIN Task_statuses AS ts
	ON ta.task_id=ts.task_id
	WHERE ts.s_description NOT LIKE 'Accepted');

-- 9. Посчитать на каждом проекте количество задач, к которым еще не приступили
WITH quantity AS
(SELECT p.p_name AS title, COUNT(*) AS num
FROM Projects AS p
JOIN Role_assignment AS ra
ON p.project_id=ra.project_id
JOIN Task_assignment AS ta
ON ra.ra_id=ta.ra_id
JOIN Task_statuses AS ts
ON ta.task_id=ts.task_id
WHERE ts.s_description LIKE 'Open'
GROUP BY p.p_name)

SELECT *
FROM quantity

UNION

SELECT p.p_name, 0
FROM Projects as p
WHERE p.p_name NOT IN
(SELECT title
FROM quantity);

-- 10.Перевести проекты в состояние закрыт, для которых все задачи закрыты и задать время закрытия временем закрытия задачи проекта, принятой последней
BEGIN TRANSACTION;

	DECLARE @p_ids TABLE (id INT) ;

	INSERT INTO @p_ids (id)
	(
	SELECT pr.project_id
	FROM Projects AS pr
	WHERE NOT EXISTS (
		SELECT p.project_id
		FROM Projects AS p
		JOIN Role_assignment AS ra
		ON p.project_id=ra.project_id
		JOIN Task_assignment AS ta
		ON ra.ra_id=ta.ra_id
		JOIN Task_statuses AS ts
		ON ta.task_id=ts.task_id
		WHERE ts.s_description NOT LIKE 'Accepted'
		AND p.project_id=pr.project_id)
	);
	
	UPDATE Project_statuses
	SET closed=1
	WHERE project_id IN (SELECT * 
					FROM @p_ids);

	UPDATE Projects 
	SET  date_completed= 
	(SELECT MAX(ts.change_date)
	FROM @p_ids AS p
	JOIN Role_assignment AS ra
	ON p.id=ra.project_id
	JOIN Task_assignment AS ta
	ON ra.ra_id= ta.ra_id
	JOIN Task_statuses AS ts
	ON ta.task_id=ts.task_id
	WHERE p.id= project_id)
	WHERE project_id IN (SELECT * FROM @p_ids)
	AND NOT date_completed IS NULL;

COMMIT;


-- 11.Выяснить по всем проектам, какие сотрудники на проекте не имеют незакрытых задач


WITH subquery AS (SELECT ra.ra_id AS id 
	FROM  Role_assignment AS ra
	WHERE NOT EXISTS 
	(SELECT *
	FROM Employees AS e
	JOIN Role_assignment AS ra1
	ON e.emp_id=ra1.emp_id
	JOIN Task_assignment AS ta
	ON ra.ra_id=ta.ra_id
	JOIN Task_statuses AS ts
	ON ta.task_id=ts.task_id
	WHERE ts.s_description NOT LIKE 'Accepted'
	AND ra1.ra_id=ra.ra_id))


SELECT p.p_name, f_name, e.l_name
FROM subquery AS s
JOIN Role_assignment AS ra
ON s.id=ra.ra_id
JOIN Projects AS p
ON ra.project_id=p.project_id
JOIN Employees AS e
ON ra.emp_id=e.emp_id;

-- 12.Заданную задачу (по названию) проекта перевести на сотрудника с минимальным количеством выполняемых им задач


GO
CREATE PROCEDURE Task12 @Name VARCHAR(30)
AS
BEGIN
	DECLARE @emp_ra_id INT
	

	SET @emp_ra_id=
	(SELECT TOP(1) s.id 
	FROM
	(SELECT ra.ra_id AS id, COUNT(ta.task_id) AS quantity
	FROM Role_assignment AS ra
	JOIN Task_assignment AS ta
	ON ra.ra_id=ta.ra_id
	WHERE ra.project_id IN 
	(
		SELECT ra.project_id
		FROM Role_assignment AS ra
		JOIN Task_assignment AS ta
		ON ra.ra_id = ta.ra_id
		JOIN Tasks AS t
		ON ta.task_id= t.task_id
		WHERE t.t_description LIKE @Name
	)
	GROUP BY ra.ra_id
	) AS s
	WHERE s.quantity in (SELECT MIN(s1.quantity)
	FROM 
	(
		SELECT ra.ra_id AS id, COUNT(ta.task_id) AS quantity
		FROM Role_assignment AS ra
		JOIN Task_assignment AS ta
		ON ra.ra_id=ta.ra_id
		GROUP BY ra.ra_id
	)
	AS s1));
	UPDATE Task_assignment
	SET ra_id=@emp_ra_id
	FROM 
		Task_assignment AS ta
		JOIN Tasks AS t
		ON ta.task_id=t.task_id
		WHERE t.t_description LIKE @Name;
END;

EXECUTE Task12 'SNS Advertising';


SELECT ta.ra_id
FROM Task_assignment AS ta
JOIN Tasks AS t
ON ta.task_id=t.task_id
WHERE t.t_description='SNS Advertising';
