select Department, Employee, salary
from
(
  select d.name as Department, e.name as Employee, salary, dense_rank() over(partition by d.id order by salary desc) as dr
  from Employee e inner join Department d
  on e.departmentId = d.id
)
where dr = 1
