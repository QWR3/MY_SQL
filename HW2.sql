#1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
select * from bank.client where length(FirstName) <6;
#2.Вибрати львівські відділення банку.
select * from bank.department where DepartmentCity='Lviv';
#3.Вибрати клієнтів з вищою освітою та осортувати по прізвищу.
select * from bank.client where Education = 'high' order by LastName;
#4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
select * from bank.application order by idApplication desc limit 5 offset 10;
#5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
select * from bank.client where LastName like '%ov' or LastName like '%ova';
#6.Вивести клієнтів банку, які обслуговуються київськими відділеннями.
select * from bank.client join department on Department_idDepartment = idDepartment where DepartmentCity = 'Kyiv';
#7.Знайти унікальні імена клієнтів.
select distinct(FirstName) from bank.client; 
#8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
select * from bank.client join bank.application on idClient = Client_idClient where sum > 5000;
#9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
select count(idClient) from bank.client join bank.department on Department_idDepartment = idDepartment;
select count(idClient) from bank.client join bank.department on Department_idDepartment = idDepartment where DepartmentCity = "Lviv";
#10.Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
select  max(Sum), Client_idClient as 'Id' from bank.application group by Client_idClient; 
#11. Визначити кількість заявок на крдеит для кожного клієнта.
SELECT client_idclient, count(client_idclient) as count FROM bank.application group by client_idclient;
#12. Визначити найбільший та найменший кредити
select max(Sum) from bank.application;
select min(Sum) from bank.application;
#13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
select count(idApplication) as 'count' from bank.application join bank.client on client_idClient = idClient where Education = 'high';
#14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
select avg(sum) as avg, Client_idClient from bank.application join bank.client on Client_idClient = idClient  group by idClient order by avg desc limit 1 ;
#15. Вивести відділення, яке видало в кредити найбільше грошей
select idDepartment, DepartmentCity, sum(Sum) as sum from (SELECT * FROM bank.department join bank.client on idDepartment = Department_idDepartment join bank.application on Client_idClient = idClient) as s group by idDepartment order by sum desc limit 1;
#16. Вивести відділення, яке видало найбільший кредит.
select idDepartment, DepartmentCity, max(Sum) as max from (SELECT * FROM bank.department join bank.client on idDepartment = Department_idDepartment join bank.application on Client_idClient = idClient) as s group by idDepartment order by max desc limit 1;
#17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
update bank.application set sum = 6000 where client_idClient 
in (select idClient from (select * from bank.client join bank.application on idClient = Client_idClient where Education = 'high') as idClients);
select * from bank.client join bank.application on idClient = Client_idClient where Education = 'high';
#18. Усіх клієнтів київських відділень пересилити до Києва.
update bank.client set city = 'Kyiv' where idClient 
in(select idClient from(select * from bank.client join bank.department on idDepartment = Department_idDepartment where DepartmentCity = 'Kyiv') as idClients);
select * from bank.client join bank.department on idDepartment = Department_idDepartment where DepartmentCity = 'Kyiv';
#19. Видалити усі кредити, які є повернені.
delete from bank.application where CreditState = 'Returned' limit 1000;
#20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
select * from bank.client where LastName like '^.[aeiouy]';
#21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
 select * from (select idDepartment, DepartmentCity, CountOfWorkers, sum(Sum) as sum from
 (SELECT * FROM bank.department join bank.client on idDepartment = Department_idDepartment 
 join bank.application on Client_idClient = idClient where DepartmentCity = 'Lviv') as s group by idDepartment) as s2 where sum>5000;
#22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000 
select * from bank.client join bank.application on idClient = client_idClient where Sum > 5000 and CreditState = 'returned';
#23.Знайти максимальний неповернений кредит
select max(Sum), CreditState from bank.application where CreditState = 'not returned';
#24.Знайти клієнта, сума кредиту якого найменша
select * from bank.client where idClient = 
(select client_idClient from (select sum, Client_idClient from bank.application where sum = (select min(Sum) from bank.application)) as s);
#25.Знайти кредити, сума яких більша за середнє значення усіх кредитів
select * from bank.application where Sum > (select avg(sum) from bank.application);
#26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів
select * from bank.client where City = (select City from (select City, idClient from bank.client where idClient = (select client_idclient 
from (select sum,client_idclient from bank.application where sum = (select max(sum) from bank.application)) as s ))as s2);
#27. Місто клієнта з найбільшою кількістю кредитів
SELECT client_idclient, count(client_idclient) as count FROM bank.application group by client_idclient  order by count desc limit 1;
select City from bank.client where idClient= (select client_idClient 
from (SELECT client_idclient, count(client_idclient) as count FROM bank.application group by client_idclient  order by count desc limit 1) as s);










