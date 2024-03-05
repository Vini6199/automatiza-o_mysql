-- Atualização do salário base. 
use company_constraints;
show tables;

alter table employee add Message_error varchar(255);
drop trigger update_salary_company;
delimiter //

create trigger update_salary_company before update on employee
for each row 
begin
    if (new.Salary > old.Salary * 1.20) or (old.Dno !=4)then
        set new.Message_error = 'Aumento maior que o permitido ou departamento errado';
        signal sqlstate '45000' set message_text = new.Message_error;
	else
		set new.Salary = old.Salary *1.20;
    end if;
end //

delimiter ;

-- teste
select * from employee;
update employee set Salary = Salary * 1.20 where Ssn = '156797389';
	
        
		
		
    
