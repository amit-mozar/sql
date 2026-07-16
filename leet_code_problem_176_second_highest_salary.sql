--method 1 - using max and distinct
SELECT MAX(DISTINCT SALARY) AS SecondHighestSalary
FROM Employee
WHERE SALARY < (
    SELECT MAX(DISTINCT SALARY) FROM Employee
)

--method 2 - dense_rank
SELECT COALESCE(
    (
        SELECT distinct salary
        FROM (
            SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS dr
            FROM Employee
        ) AS temp
        WHERE dr = 2
    ), NULL
) AS SecondHighestSalary;