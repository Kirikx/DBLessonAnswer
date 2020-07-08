-- 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.

-- Выбрать среднюю зарплату по отделам - avg_salary_dep_view

CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`%` SQL SECURITY DEFINER VIEW `avg_salary_dep_view` AS
SELECT `d`.`dept_name`   AS `depart`,
       AVG(`s`.`salary`) AS `AVG_sal`
FROM (`departments` `d`
         JOIN (`dept_emp` `de`
    JOIN `salaries` `s`) ON (((`d`.`dept_no` = `de`.`dept_no`)
    AND (`de`.`emp_no` = `s`.`emp_no`))))
GROUP BY `depart`
ORDER BY `AVG_sal` DESC;

-- Выбрать максимальную зарплату у сотрудника - max_salary_emp_view

CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`%` SQL SECURITY DEFINER VIEW `max_salary_emp_view` AS
SELECT `s`.`emp_no`      AS `emp_no`,
       MAX(`s`.`salary`) AS `salary_emp`
FROM `salaries` `s`
GROUP BY `s`.`emp_no`
ORDER BY `salary_emp` DESC
LIMIT 1;

-- Cотрудник, у которого максимальная зарплата - emp_max_salary_view

CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`%` SQL SECURITY DEFINER VIEW `emp_max_salary_view` AS
SELECT CONCAT(`e`.`first_name`, ' ', `e`.`last_name`) AS `CONCAT(e.first_name, ' ', e.last_name)`
FROM `employees` `e`
WHERE (`e`.`emp_no` = (SELECT `s`.`emp_no`
                       FROM (SELECT `s`.`emp_no`      AS `emp_no`,
                                    MAX(`s`.`salary`) AS `salary_emp`
                             FROM `salaries` `s`
                             GROUP BY `s`.`emp_no`
                             ORDER BY `salary_emp` DESC
                             LIMIT 1) `s`));

-- Посчитать количество сотрудников во всех отделах - count_emp_all_view
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`%` SQL SECURITY DEFINER VIEW `count_emp_all_view` AS
SELECT COUNT(DISTINCT `e`.`emp_no`) AS `count(distinct (e.emp_no))`
FROM (`employees` `e`
         JOIN `dept_emp` `de` ON ((`e`.`emp_no` = `de`.`emp_no`)));

-- Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел - count_emp_sum_dep

CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`%` SQL SECURITY DEFINER VIEW `count_emp_sum_dep` AS
SELECT `d`.`dept_name`               AS `depart`,
       COUNT(DISTINCT `de`.`emp_no`) AS `COUNT_emp`,
       SUM(`s`.`salary`)             AS `SUM_sal`
FROM (`departments` `d`
         JOIN (`dept_emp` `de`
    JOIN `salaries` `s`) ON (((`d`.`dept_no` = `de`.`dept_no`)
    AND (`de`.`emp_no` = `s`.`emp_no`))))
GROUP BY `depart`;


-- 2. Создать функцию, которая найдет менеджера по имени и фамилии.

USE `employees`;
DROP function IF EXISTS `FunctFindEmp`;

DELIMITER $$
USE `employees`$$
CREATE
    DEFINER = `root`@`%` FUNCTION `FunctFindEmp`(first_name VARCHAR(14), last_name VARCHAR(16)) RETURNS int
    READS SQL DATA
BEGIN
    RETURN (SELECT e.emp_no from employees e where e.first_name = first_name and e.last_name = last_name);
END$$

DELIMITER ;


-- 3. Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.

DROP TRIGGER IF EXISTS `employees`.`employees_AFTER_INSERT`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER =`root`@`%` TRIGGER `employees_AFTER_INSERT`
    AFTER INSERT
    ON `employees`
    FOR EACH ROW
BEGIN
    insert into salaries set salary=10000, emp_no=NEW.emp_no, from_date=curdate(), to_date='9999-01-01';
END$$
DELIMITER ;


