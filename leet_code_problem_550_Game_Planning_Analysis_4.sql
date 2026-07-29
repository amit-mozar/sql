with temp_table as(
  select *
  , lead(event_date) over(partition by player_id order by event_date) as next_login
  , row_number() over(partition by player_id order by event_date) as rn
  from Activity
)

select round(
  (
  select count(distinct(player_id)) 
  from temp_table
  where rn = 1 and next_login = event_date + interval '1 DAY'
  ) * 1.0
  /
  (
  select count(distinct(player_id))
  from temp_table
  ), 2) as fraction
