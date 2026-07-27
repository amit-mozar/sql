select e2.name as name
from Employee e1 inner join Employee e2
on e1.managerId = e2.id
group by e1.managerId, e2.name
having count(*) >= 5
