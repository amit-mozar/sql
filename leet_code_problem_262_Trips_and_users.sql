select
    request_at as "Day"
    , ROUND
        (
        SUM(
            CASE 
                WHEN status <> 'completed' THEN 1
                ELSE 0
            END
            ) * 1.0 / COUNT(*), 2
        ) AS "Cancellation Rate"
from Trips t inner join Users u
on t.client_id = u.users_id
inner join Users u2
on t.driver_id = u2.users_id
where (u.banned = 'No' and u2.banned = 'No')
and t.request_at between '2013-10-01' and '2013-10-03'
group by t.request_at



-- Unsuccessful attempt - cleared only 9 test cases out of 12
-- it has problems at total and total_count
select request_at as "Day", round(((total_count - total) * 1.0)/total_count, 2) as "Cancellation Rate"
from
(
select *, lead(total) over(partition by request_at order by total) as total_count 
from
(
select t.request_at, count(*) as total
from Trips t inner join Users u
on t.client_id = u.users_id
inner join Users u2
on t.driver_id = u2.users_id
where (u.banned = 'No' and u2.banned = 'No') and status = 'completed' 
group by t.request_at
union all
select t.request_at, count(*) as total
from Trips t inner join Users u
on t.client_id = u.users_id
inner join Users u2
on t.driver_id = u2.users_id
where (u.banned = 'No' and u2.banned = 'No') 
group by t.request_at
)
)
where total_count is not null
