SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		Chuck Erdkamp	
-- Create date: 6.22.18
-- Description:	XGSG Statistics Report
-- =============================================
CREATE PROCEDURE [spXGSG_Statistics]
    @YEAR CHAR(4),
    @Month CHAR(2)
AS
BEGIN
    SET NOCOUNT ON;

    WITH [CTE]
    AS 
	(
	
	Select Y.Year
		, Y.Month
		, Y.Period
		, Y.[Sales Rep Name]
		, Sum(Y.[Cost of Equipment]
	From 
	(
	SELECT     [x].[Year]
             , [x].[Month]
			 , x.Period
			 , [x].Lease_slsrep_name as [Sales Rep Name]
             , SUM([x].[Cost of Equipment]) AS [Cost of Equipment]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year],
                   RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month],
				   CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period],
				   isnull(lease_slsrep_name,'') Lease_slsrep_name,
                   SUM([lease_booked_eq_cost]) AS [Cost of Equipment]
            FROM [LPlusLeaseVW]
			Where CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) = '2018'
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
			)
    SELECT [c1].[Sales Rep Name],
		   [c1].[Year],
           [c1].[Month],
		   [c1].[Period],
		   [c1].[Cost of Equipment],
		   Sum([c2].[Cost of Equipment]) as [YTD Equipment Cost]
    FROM [CTE] [c1]
        INNER JOIN [CTE] [c2]
            ON [c1].[Period] = [c2].[Period]  and [c1].[Sales Rep Name] = [c2].[Sales Rep Name]
    WHERE [c1].[Year] =	'2018'		--@YEAR
          AND [c2].[Year] = '2018'	--=	@YEAR
          AND [c1].[Month] <= '05'	--<= @Month
          AND [c2].[Month] <= '05'	-- <= @Month
    GROUP BY [C1].[Period],
			 [c1].[Sales Rep Name],
			 [c1].[Month],
             [c1].[Year],
		     [c1].[Cost of Equipment]
    ORDER BY --c1.[sales rep name], 
	C1.Year, [c1].[Month];

END;
GO
