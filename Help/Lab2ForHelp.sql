SET SEARCH_PATH TO DEMO, PUBLIC;

--a
INSERT INTO emp VALUES (902, 'Brown, Peter', 'Consultant', 55, 663);

SELECT * FROM emp;

--b
SELECT * FROM emp WHERE manager_id = 786 AND name != 'Parsons, Carol';

SELECT * FROM emp;
--c
UPDATE emp SET hourly_rate = hourly_rate * 1.1 WHERE name != 'Brown, Peter';

--d
UPDATE emp SET hourly_rate = hourly_rate * 1.1 WHERE name = 'Parsons, Carol';

SELECT * FROM emp;

--e
SELECT * FROM emp, dependent WHERE dependent.emp_id = emp.emp_id AND birth > '2016-01-01';

--f
SELECT SUM((hourly_rate * 1.05) - hourly_rate) FROM emp, dependent WHERE dependent.emp_id = emp.emp_id AND birth > '2016-01-01'

--g

--Begin transaction
BEGIN;

DELETE FROM task WHERE 'Consultant' = (SELECT title FROM emp WHERE task.emp_id = emp.emp_id);

--h
DELETE FROM emp WHERE title = 'Consultant';

--End transaction
COMMIT;


SELECT * FROM emp;
SELECT * FROM task;
