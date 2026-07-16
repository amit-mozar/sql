-- method 1 - using lead 
select distinct(num) as ConsecutiveNums
from
(
    select id, num , first_num, lead(first_num) over(order by id) as second_num
    from 
    (
        select id, num, lead(num) over(order by id) as first_num
        from logs
    )
)
where num = first_num and first_num = second_num

-- method 2 - using lag --> best resource utilization approach
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT num,
           LAG(num, 1) OVER (ORDER BY id) AS prev1,
           LAG(num, 2) OVER (ORDER BY id) AS prev2
    FROM Logs
) t
WHERE num = prev1 AND num = prev2;

-- method 3 - using inner join
select distinct(l1.num) as ConsecutiveNums
from Logs l1 inner join Logs l2
on l1.id = l2.id - 1 and l1.num = l2.num
inner join Logs l3
on l2.id = l3.id - 1 and l2.num = l3.num