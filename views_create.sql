use company_constraints;
show tables;

-- Número de empregados por departamento e localidade 
create or replace view num_employees_dept (qnt_employee, dept_number, location)
as 
select count(e.Ssn), d.Dnumber, l.Dlocation from employee as e
inner join department as d on d.Dnumber = e.Dno
inner join dept_locations as l on d.Dnumber = l.Dnumber
group by d.Dnumber, l.Dlocation;

select * from num_employees_dept;

-- Lista de departamentos e seus gerentes 
create or replace view dept_manager (department_name, manager_ssn, manager_name)
as
select d.Dname, e.Ssn, concat(e.fname,' ',minit,' ',Lname) from employee e
inner join department d on d.Mgr_ssn = Ssn
group by Dname;

select * from dept_manager;

-- Projetos com maior número de empregados
create or replace view most_employee_project (name_project,num_employees)
as
select p.Pname, count(e.Ssn)from employee e
inner join project p on e.Dno = p.Dnum
group by p.Pname
order by count(e.Ssn) desc;

select * from most_employee_project;
 
-- Lista de projetos, departamentos e gerentes 
desc employee;
create or replace view projects_department_and_manager (Project_name, Department_name, Manager, Manager_Ssn)
as
select p.Pname, d.Dname, concat(fname,' ',minit,' ',Lname), d.Mgr_ssn from department d
inner join project p on d.Dnumber = p.Dnum
inner join employee e on e.Ssn = d.Mgr_ssn
group by concat(fname,' ',minit,' ',Lname),p.Pname;

select * from projects_department_and_manager;

-- Quais empregados possuem dependentes e se são gerentes 
desc employee;
create or replace view employee_is_manager_and_have_dependent (Ssn_employee, employee_name, num_dependent, if_null_is_manager)
as
select e.Ssn, concat(e.fname,' ',e.minit,' ',e.Lname),  count(d.Essn), Super_ssn from employee e
inner join dependent d on e.Ssn = d.Essn
right outer join department dept on e.Dno = dept.Dnumber
group by e.Ssn, d.Essn, dept.Mgr_ssn;

select * from employee_is_manager_and_have_dependent;

