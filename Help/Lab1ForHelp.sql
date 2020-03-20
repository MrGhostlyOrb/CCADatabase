SET SEARCH_PATH TO DEMO, PUBLIC;
--a
SELECT * FROM emp;

--b
SELECT name, title FROM emp;

--c
SELECT DISTINCT title FROM emp;

--d
SELECT name, hourly_rate * 40 FROM emp;

--e
SELECT name, hourly_rate * 40 AS "Weekly Cost" FROM emp;

--f
SELECT name, 'is charged at : ', hourly_rate * 40 FROM emp;

--g
SELECT COUNT(*) FROM emp;

--h
SELECT MIN(hourly_rate), MAX(hourly_rate), AVG(hourly_rate) FROM emp;

--i
SELECT DISTINCT COUNT(hourly_rate) FROM emp;

--j
SELECT title, name, hourly_rate FROM emp ORDER BY title, name;

--k
SELECT name FROM emp WHERE title = 'Analyst';

--l
SELECT name FROM emp WHERE name LIKE '%Richard%';

--m
SELECT name, hourly_rate FROM emp WHERE hourly_rate > 30 AND title LIKE '%Programmer%';

--n
SELECT name FROM emp WHERE title = 'Analyst' OR title = 'Consultant' OR title = 'Project Leader';

--o
SELECT title, COUNT(title) FROM emp GROUP BY title;

--p
SELECT title, COUNT(title) FROM emp GROUP BY title HAVING COUNT(title) > 5 ORDER BY title;

--q
SELECT DISTINCT name, title, project_id FROM emp, task WHERE task.emp_id = emp.emp_id;

--r
SELECT DISTINCT emp.name, emp.title, project.description FROM emp, task, project WHERE task.emp_id = emp.emp_id AND task.project_id = project.project_id ORDER BY name, title;

--s
SELECT name, SUM(hours) FROM task, emp WHERE task.emp_id = emp.emp_id AND emp.title = 'Analyst' GROUP BY name;

--t
SELECT name, depname, emp.emp_id FROM emp LEFT JOIN dependent ON emp.emp_id = dependent.emp_id ORDER BY emp.name;

--u
SELECT name, COUNT(dependent) FROM emp LEFT JOIN dependent ON emp.emp_id = dependent.emp_id GROUP BY name ORDER BY name;
/**/ 
--v
SELECT DISTINCT project.project_id, budget - SUM(hourly_rate * hours) FROM project, emp, task WHERE task.emp_id = emp.emp_id AND project.project_id = task.project_id GROUP BY project.project_id ORDER BY project.project_id;

