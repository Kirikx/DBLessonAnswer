-- Сделать запрос, в котором мы выберем все данные о городе – регион, страна.

select cit.title, reg.title, count.title
from lesson2._cities as "cit"
         left join lesson2._regions as "reg" on cit.region_id = reg.id
         left join lesson2._countries as "count" on cit.country_id = count.id
where cit.title = 'Москва';

-- Выбрать все города из Московской области.

select cit.title
from lesson2._cities as "cit"
where region_id = 1053480;

-- Выбрать среднюю зарплату по отделам.

select d.dept_name as depart, avg(s.salary) as AVG_sal
from departments d
         join (dept_emp de, salaries s) on (d.dept_no = de.dept_no and de.emp_no = s.emp_no)
group by depart
order by AVG_sal desc;

-- Выбрать максимальную зарплату у сотрудника.

select s.emp_no, max(s.salary) as salary_emp
from salaries s
group by s.emp_no
order by salary_emp desc
limit 1;

-- Удалить одного сотрудника, у которого максимальная зарплата.

delete
from employees e
where e.emp_no = (select s.emp_no
                  from (select s.emp_no, max(s.salary) as salary_emp
                        from salaries s
                        group by s.emp_no
                        order by salary_emp desc
                        limit 1) as s);

-- Посчитать количество сотрудников во всех отделах.

select count(distinct (e.emp_no))
from employees e
         inner join dept_emp de on e.emp_no = de.emp_no;

-- Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.

select d.dept_name as depart, count(distinct de.emp_no) as COUNT_emp, sum(s.salary) as SUM_sal
from departments d
         join (dept_emp de, salaries s) on (d.dept_no = de.dept_no and de.emp_no = s.emp_no)
group by depart;