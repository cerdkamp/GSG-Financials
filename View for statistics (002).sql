alter View XGSG_SummaryStatistics as 

WITH CTE AS (
	Select Year
	, Month
	, Period
	, Sum(Number) Number
	, Sum([Cost of Equipment]) [Cost of Equipment]
	, sum([Sum Implicit Rate])/ Sum(Number) [Implicit Rate]
	
	From (
Select convert(varchar(4),year(lease_booked_post_date)) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,convert(varchar(4),year(lease_booked_post_date))+right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2) Period
	,count(Lease_num) as Number
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
	,Sum(lease_implicit_rate) [Sum Implicit Rate]
from LPlusLeaseVW
group by lease_booked_post_date
)x
Group by  Year, Month,Period
)
SELECT C1.Year
	, c1.Period
	, c1.Month
	, c1.Number
	, c1.[Cost of Equipment]
	, [YTD Number] = SUM(C2.Number)
	, [YTD Equipment Cost] = Sum(c2.[Cost of Equipment])

from CTE c1 inner join CTE c2 
on  c1.Period >= c2.Period
GROUP BY C1.Year, C1.Period, C1.Month, C1.Number, C1.[Cost of Equipment]





