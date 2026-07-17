--User Defined functions
CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) 
RETURNS TABLE (Salary INT) AS 
$$
BEGIN
  RETURN QUERY (
    select coalesce((
        select temp.salary  from(
        select *, dense_rank() over(order by e.salary desc) as dr
        from Employee e
        ) as temp
        where temp.dr = N 
        limit 1
    ), NULL
   ) as getNthHighestSalary  
  );
END;
$$ LANGUAGE plpgsql;