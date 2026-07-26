-- method 1 - 
delete
from person
where id in
    (
    select id 
    from
        (
        select 
            *
            , row_number() over(partition by email order by id) as rn
        from person
        ) t
    where rn > 1
    )

--method 2
with to_delete as (
    select *, row_number() over(partition by email order by id) as rn
    from person
)

delete from person
where id in 
    (
    select id 
    from to_delete 
    where rn > 1
    )