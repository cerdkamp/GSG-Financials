
--ALTER  View XGSG_SalesRep as


    WITH [CTE]
    AS 
	(
    SELECT [Z].[Sales Rep Name]
		   ,[Z].[Year]
           ,[Z].[Month]
		   ,[Z].[Cost of Equipment]
		   ,Sum(cost01) YTD01
		   ,Sum(cost02) YTD02
		   ,Sum(cost03) YTD03
		   ,Sum(cost04) YTD04
		   ,Sum(cost05) YTD05
		   ,Sum(cost06) YTD06
		   ,Sum(cost07) YTD07
		   ,Sum(cost08) YTD08
		   ,Sum(cost09) YTD09
		   ,Sum(cost10) YTD10
		   ,Sum(cost11) YTD11
		   ,Sum(cost12) YTD12
    FROM (
	Select Y.Year
		, Y.Month
		, Y.Period
		, Y.[Sales Rep Name]
		,CASE month	When '01' then sum([cost of equipment]) else 0 end as cost01
		,CASE month When '02' then sum([cost of equipment]) else 0 end as cost02
		,CASE month When '03' then sum([cost of equipment]) else 0 end as cost03
		,CASE month When '04' then sum([cost of equipment]) else 0 end as cost04
		,CASE month When '05' then sum([cost of equipment]) else 0 end as cost05
		,CASE month When '06' then sum([cost of equipment]) else 0 end as cost06
		,CASE month When '07' then sum([cost of equipment]) else 0 end as cost07
		,CASE month When '08' then sum([cost of equipment]) else 0 end as cost08
		,CASE month When '09' then sum([cost of equipment]) else 0 end as cost09
		,CASE month When '10' then sum([cost of equipment]) else 0 end as cost10
		,CASE month When '11' then sum([cost of equipment]) else 0 end as cost11
		,CASE month When '12' then sum([cost of equipment]) else 0 end as cost12
		, Sum(Y.[Cost of Equipment]) [Cost of Equipment]
	From 
	(
	SELECT     [x].[Year]
             , [x].[Month]
			 , [x].Period
			 , [x].Lease_slsrep_name as [Sales Rep Name]
             , SUM([x].[Cost of Equipment]) AS [Cost of Equipment]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year]
                   ,RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month]
				   ,CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period]
				   ,isnull(lease_slsrep_name,'') Lease_slsrep_name
                   ,SUM([lease_booked_eq_cost]) AS [Cost of Equipment]
            FROM [LPlusLeaseVW]
            GROUP BY [lease_booked_post_date],lease_slsrep_name
        ) [x]

        GROUP BY [x].Lease_slsrep_name
				 ,[x].[Year]
                 ,[x].[Month]
				 ,[x].[Period]
                 )Y
		Group by [Sales Rep Name]
			,Year
			,Month
			,Period
			,[Cost of Equipment]
			)Z
    GROUP BY 
			  [Z].[Sales Rep Name]
			 ,[Z].[Month]
             ,[Z].[Year]
		     ,[Z].[Cost of Equipment]
)

Select C1.[Sales Rep Name]
	,C1.Year
	,C1.Month
	,C1.[Cost of Equipment]
	,Sum(C2.ytd01) Jan
	,Sum(C2.YTD02) Feb
	,Sum(C2.YTD03) Mar
	,Sum(C2.YTD04) APR
	,SUM(C2.YTD05) MAY
	,SUM(C2.YTD06) JUN
	,SUM(C2.YTD07) JUL
	,SUM(C2.YTD08) AUG
	,SUM(C2.YTD09) SEP
	,SUM(C2.YTD10) OCT
	,SUM(C2.YTD11) NOV
	,SUM(C2.YTD12) DEC
fROM CTE C1 JOIN CTE C2 ON C1.YEAR = C2.YEAR AND C1.MONTH >= C2.MONTH AND C1.[SALES REP NAME] = C2.[SALES REP NAME]
GROUP BY C1.[SALES REP NAME], C1.YEAR, C1.MONTH, C1.[COST OF EQUIPMENT];


