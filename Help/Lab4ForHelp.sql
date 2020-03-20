SET SEARCH_PATH TO DEMO, PUBLIC;

--a

--b

--c

--d

SELECT * FROM Project_cost WHERE budget > budget - (budget * 0.05)

--e

SELECT
referential_constraints.constraint_name,
referential_constraints.unique_constraint_name,
referential_constraints.update_rule,
referential_constraints.delete_rule
FROM
information_schema.referential_constraints
WHERE
referential_constraints.constraint_schema = 'demo';

--f

CREATE OR REPLACE FUNCTION apply_pay_rise (emp, numeric) RETURNS void AS 
$$
UPDATE emp SET hourly_rate = $1.hourly_rate * $2 WHERE emp_id = $1.emp_id;
$$
LANGUAGE SQL;

BEGIN;
SELECT apply_pay_rise(emp.*, 1.01)
FROM emp;
SELECT * FROM emp;
--ROLLBACK;
COMMIT;

--g

DROP FUNCTION apply_pay_rise(emp, numeric);

CREATE OR REPLACE FUNCTION apply_pay_rise (emp, numeric) RETURNS emp AS 
$$
UPDATE emp SET hourly_rate = $1.hourly_rate * $2 WHERE emp_id = $1.emp_id RETURNING emp;
$$

LANGUAGE SQL;

BEGIN;
SELECT * FROM apply_pay_rise(emp.*, 1.01);

--ROLLBACK;
COMMIT;

--h

CREATE LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION update_hourly_rate(txt TEXT, inte INTEGER) RETURNS void AS $$
DECLARE
title TEXT:= $1;
rating INTEGER:= $2;
BEGIN
CASE rating
WHEN 1 THEN
UPDATE demo.emp
SET hourly_rate = hourly_rate * 1.01
WHERE emp.title == title;
WHEN 2 THEN
UPDATE demo.emp
SET hourly_rate = hourly_rate * 1.03
WHERE emp.title == title;
ELSE
UPDATE demo.emp
SET hourly_rate = hourly_rate
WHERE emp.title = title;
END CASE;
END;$$
LANGUAGE PLPGSQL;

--i

CREATE TABLE emp_rate_changes (

	CHA_USER CHAR(30) NOT NULL,
	CHA_TIME TIMESTAMP NOT NULL,
	CHA_emp_id INTEGER NOT NULL,
	CHA_OLD DECIMAL NOT NULL,
	CHA_NEW DECIMAL NOT NULL,
	CONSTRAINT CHA_pk PRIMARY KEY (CHA_USER, CHA_TIME, CHA_emp_id)
	

);

CREATE OR REPLACE FUNCTION Maintain_Changes() RETURNS trigger AS $$
BEGIN
INSERT INTO emp_rate_changes VALUES 
(CHA_USER, CHA_TIME, )




