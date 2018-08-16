
  Alter  View XGSG_EquipmentType as


    WITH [CTE]
    AS 
	(
    SELECT [Z].[Equipment Type]
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
		, Y.[Equipment Type]
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
			 , [x].Lease_Equip_type_desc as [Equipment Type]
             , SUM([x].[Cost of Equipment]) AS [Cost of Equipment]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year]
                   ,RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month]
				   ,CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period]
				   ,isnull(Lease_Equip_type_desc,'') Lease_Equip_type_desc
                   ,SUM([lease_booked_eq_cost]) AS [Cost of Equipment]
            FROM [LPlusLeaseVW]
            GROUP BY [lease_booked_post_date],Lease_Equip_type_desc
        ) [x]

        GROUP BY [x].Lease_Equip_type_desc
				 ,[x].[Year]
                 ,[x].[Month]
				 ,[x].[Period]
                 )Y
		Group by [Equipment Type]
			,Year
			,Month
			,Period
			,[Cost of Equipment]
			)Z
    GROUP BY 
			  [Z].[Equipment Type]
			 ,[Z].[Month]
             ,[Z].[Year]
		     ,[Z].[Cost of Equipment]
)
Select C1.[Equipment Type]
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
fROM CTE C1 JOIN CTE C2 ON C1.YEAR = C2.YEAR AND C1.MONTH >= C2.MONTH AND C1.[Equipment Type] = C2.[Equipment Type]
GROUP BY C1.[Equipment Type], C1.YEAR, C1.MONTH, C1.[COST OF EQUIPMENT];

GO

  Alter  View XGSG_LeaseType as


    WITH [CTE]
    AS 
	(
    SELECT [Z].[Lease Type]
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
		, Y.[Lease Type]
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
			 , [x].Lease_type as [Lease Type]
             , SUM([x].[Cost of Equipment]) AS [Cost of Equipment]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year]
                   ,RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month]
				   ,CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period]
				   ,isnull(lease_type,'') Lease_type
                   ,SUM([lease_booked_eq_cost]) AS [Cost of Equipment]
            FROM [LPlusLeaseVW]
            GROUP BY [lease_booked_post_date],lease_type
        ) [x]

        GROUP BY [x].lease_type
				 ,[x].[Year]
                 ,[x].[Month]
				 ,[x].[Period]
                 )Y
		Group by [Lease Type]
			,Year
			,Month
			,Period
			,[Cost of Equipment]
			)Z
    GROUP BY 
			  [Z].[Lease Type]
			 ,[Z].[Month]
             ,[Z].[Year]
		     ,[Z].[Cost of Equipment]
)
Select C1.[Lease Type]
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
fROM CTE C1 JOIN CTE C2 ON C1.YEAR = C2.YEAR AND C1.MONTH >= C2.MONTH AND C1.[Lease Type] = C2.[Lease Type]
GROUP BY C1.[Lease Type], C1.YEAR, C1.MONTH, C1.[COST OF EQUIPMENT];
GO


  Alter  View XGSG_VendorName AS

    WITH [CTE]
    AS 
	(
    SELECT [Z].[Vendor]
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
		, Y.[Vendor]
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
			 , [x].Lease_Vendor_Name as [Vendor]
             , SUM([x].[Cost of Equipment]) AS [Cost of Equipment]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year]
                   ,RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month]
				   ,CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period]
				   ,isnull(lease_Vendor_Name,'') lease_Vendor_Name
                   ,SUM([lease_booked_eq_cost]) AS [Cost of Equipment]
            FROM [LPlusLeaseVW]
            GROUP BY [lease_booked_post_date],lease_Vendor_Name
        ) [x]

        GROUP BY [x].lease_Vendor_Name
				 ,[x].[Year]
                 ,[x].[Month]
				 ,[x].[Period]
                 )Y
		Group by [Vendor]
			,Year
			,Month
			,Period
			,[Cost of Equipment]
			)Z
    GROUP BY 
			  [Z].[Vendor]
			 ,[Z].[Month]
             ,[Z].[Year]
		     ,[Z].[Cost of Equipment]
)

Select C1.[Vendor]
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
fROM CTE C1 JOIN CTE C2 ON C1.YEAR = C2.YEAR AND C1.MONTH >= C2.MONTH AND C1.[Vendor] = C2.[Vendor]
GROUP BY C1.[Vendor], C1.YEAR, C1.MONTH, C1.[COST OF EQUIPMENT];
GO

  Create  View XGSG_EquityOrigination as


    WITH [CTE]
    AS 
	(
    SELECT [Z].[Vendor ID]
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
		, Y.[Vendor ID]
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
			 , [x].lease_vendor_Num as [Vendor ID]
             , SUM([x].[Cost of Equipment]) AS [Cost of Equipment]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year]
                   ,RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month]
				   ,CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period]
				   ,isnull(lease_Vendor_Num,0) lease_Vendor_Num
                   ,SUM([lease_booked_eq_cost]) AS [Cost of Equipment]
            FROM [LPlusLeaseVW]
            GROUP BY [lease_booked_post_date],lease_Vendor_Num
        ) [x]

        GROUP BY [x].lease_Vendor_num
				 ,[x].[Year]
                 ,[x].[Month]
				 ,[x].[Period]
                 )Y
		Group by [Vendor ID]
			,Year
			,Month
			,Period
			,[Cost of Equipment]
			)Z
    GROUP BY 
			  [Z].[Vendor ID]
			 ,[Z].[Month]
             ,[Z].[Year]
		     ,[Z].[Cost of Equipment]
)
Select C1.[Vendor ID]
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
fROM CTE C1 JOIN CTE C2 ON C1.YEAR = C2.YEAR AND C1.MONTH >= C2.MONTH AND C1.[Vendor ID] = C2.[Vendor ID]
GROUP BY C1.[Vendor ID], C1.YEAR, C1.MONTH, C1.[COST OF EQUIPMENT];
GO

Grant select on XGSG_EquityOrigination to graphiccr1

go

  Alter  View XGSG_CustomerName as


    WITH [CTE]
    AS 
	(
    SELECT [Z].Customer
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
		, Y.Customer
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
			 , [x].lease_Billto_Name as Customer
             , SUM([x].[Cost of Equipment]) AS [Cost of Equipment]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year]
                   ,RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month]
				   ,CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period]
				   ,isnull(lease_Billto_Name,'') lease_Billto_Name
                   ,SUM([lease_booked_eq_cost]) AS [Cost of Equipment]
            FROM [LPlusLeaseVW]
            GROUP BY [lease_booked_post_date],lease_Billto_Name
        ) [x]

        GROUP BY [x].lease_Billto_Name
				 ,[x].[Year]
                 ,[x].[Month]
				 ,[x].[Period]
                 )Y
		Group by Customer
			,Year
			,Month
			,Period
			,[Cost of Equipment]
			)Z
    GROUP BY 
			  [Z].Customer
			 ,[Z].[Month]
             ,[Z].[Year]
		     ,[Z].[Cost of Equipment]
)
Select C1.Customer
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
fROM CTE C1 JOIN CTE C2 ON C1.YEAR = C2.YEAR AND C1.MONTH >= C2.MONTH AND C1.Customer = C2.Customer
GROUP BY C1.Customer, C1.YEAR, C1.MONTH, C1.[COST OF EQUIPMENT];
GO


--Create View XGSG_SlsRepSummary as

--Select [Sales Rep Name]
--	, Year
--	, Month
--	, [Cost of Equipment]
--	, Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec YTD
--	From xgsg_salesRep

--	go

--	grant select on XGSG_SLSRepSummary to GraphicCR1

GO

Alter View XGSG_EquipTypeSummary as

Select [Equipment Type]
	, Year
	, Month
	, [Cost of Equipment]
	, Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec YTD
	From XGSG_EquipmentType

	go

	grant select on XGSG_EquipmentType to GraphicCR1
GO


Alter View XGSG_LeaseTypeSummary as

Select [Lease Type]
	, Year
	, Month
	, [Cost of Equipment]
	, Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec YTD
	From XGSG_LeaseType

	go

	grant select on XGSG_LeaseTypeSummary to GraphicCR1
GO
Alter View XGSG_VendorNameSummary as

Select [Vendor]
	, Year
	, Month
	, [Cost of Equipment]
	, Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec YTD
	From XGSG_VendorName

	go

	grant select on XGSG_VendorNameSummary to GraphicCR1

GO


Create View XGSG_CustomerNameSummary as

Select [Customer]
	, Year
	, Month
	, [Cost of Equipment]
	, Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec YTD
	From XGSG_CustomerName

	go

	grant select on XGSG_CustomerNameSummary to GraphicCR1

GO

Create View XGSG_EquityOrginSummary as

Select [Vendor ID]
	, Year
	, Month
	, [Cost of Equipment]
	, Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec YTD
	From XGSG_EquityOrigination

	go

	grant select on XGSG_EquityOrginSummary to GraphicCR1


