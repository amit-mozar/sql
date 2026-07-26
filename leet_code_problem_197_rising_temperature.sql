select id as Id from
(
    select *
    , lag(temperature) over(order by recordDate) as previous_temp
    , lag(recordDate) over(order by recordDate) as previous_day
    from Weather
)
where temperature > previous_temp and recordDate = previous_day + interval '1 DAY'