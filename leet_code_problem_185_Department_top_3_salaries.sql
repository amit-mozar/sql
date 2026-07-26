-- Write your PostgreSQL query statement below
select 
    Department
    , Employee
    , Salary
from
    (
    select 
        d.name as Department
        , e.name as Employee
        , e.salary as Salary
        , dense_rank() over(partition by e.departmentId order by e.salary desc) as dr
    from Employee e inner join Department d
    on e.departmentId = d.id
    )
where dr in (1, 2, 3)s