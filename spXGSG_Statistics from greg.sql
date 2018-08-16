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
    AS (SELECT [x].[Year],
               [x].[Month],
               [x].[Period],
               SUM([x].[Number]) AS [Number],
               SUM([x].[Cost of Equipment]) AS [Cost of Equipment],
               SUM([x].[Sum Implicit Rate]) / SUM([x].[Number]) AS [Implicit Rate]
        FROM
        (
            SELECT CONVERT(VARCHAR(4), YEAR([lease_booked_post_date])) AS [Year],
                   RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Month],
                   CONVERT(VARCHAR(4), YEAR([lease_booked_post_date]))
                   + RIGHT('0' + CONVERT(VARCHAR(2), MONTH([lease_booked_post_date])), 2) AS [Period],
                   COUNT([Lease_num]) AS [Number],
                   SUM([lease_booked_eq_cost]) AS [Cost of Equipment],
                   SUM([lease_implicit_rate]) AS [Sum Implicit Rate]
            FROM [LPlusLeaseVW]
            GROUP BY [lease_booked_post_date]
        ) [x]
        GROUP BY [x].[Year],
                 [x].[Month],
                 [x].[Period])
    SELECT [c1].[Period],
           [c1].[Month],
           [c1].[Number],
           SUM([c2].[Number]) AS [YTD]
    FROM [CTE] [c1]
        INNER JOIN [CTE] [c2]
            ON [c1].[Period] >= [c2].[Period]
    WHERE [c1].[Year] = @YEAR
          AND [c2].[Year] = @YEAR
          AND [c1].[Month] <= @Month
          AND [c2].[Month] <= @Month
    GROUP BY [c1].[Period],
             [c1].[Month],
             [c1].[Number]
    ORDER BY [c1].[Period];

END;
GO
