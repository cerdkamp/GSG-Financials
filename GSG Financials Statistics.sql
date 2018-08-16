

-- Summary Report
Create View XGSG_SummaryStatistics as
	Select Year
	,Month
	,Sum(Number) Number
	, Sum([Cost of Equipment]) [Cost of Equipment]
	, sum([Sum Implicit Rate]) [Sum Implicit Rate]
	, (sum([Sum Implicit Rate])/Sum([Cost of Equipment]))*Sum(Number) [Average Yield]
	From (
Select year(lease_booked_post_date) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,count(Lease_num) as Number
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
	,Sum(lease_implicit_rate) [Sum Implicit Rate]
from LPlusLeaseVW
group by lease_booked_post_date)x
Group by  Year, Month

GO

grant select on XGSG_SummaryStatistics to GraphicCR1

GO


Create View XGSG_LeaseType as
	Select Year
	,Month
	,Lease_Type
	,Sum(Number) Number
	, isnull(Sum([Cost of Equipment]),0) [Cost of Equipment]
	From (
Select year(lease_booked_post_date) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,Lease_type
	,count(Lease_num) as Number
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
from LPlusLeaseVW
group by Lease_type, lease_booked_post_date)x
Group by  Year, Month, Lease_type

GO
Grant Select on XGSG_LeaseType to GrapnicCR1

GO	

Create View XGSG_VendorName as
	Select Year
	,Month
	,Lease_Vendor_Name
	,Sum(Number) Number
	, isnull(Sum([Cost of Equipment]),0) [Cost of Equipment]
	From (
Select year(lease_booked_post_date) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,Lease_Vendor_Name
	,count(Lease_num) as Number
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
from LPlusLeaseVW
group by Lease_Vendor_Name, lease_booked_post_date)x
Group by  Year, Month, Lease_Vendor_Name

go
Grant select on XGSG_VendorName to GraphicCR1

GO


Create View XGSG_CustomerName as 
	Select Year
	,Month
	,Lease_Customer_Name
	,Sum(Number) Number
	, isnull(Sum([Cost of Equipment]),0) [Cost of Equipment]
	From (
Select year(lease_booked_post_date) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,Lease_Customer_Name
	,count(Lease_num) as Number
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
from LPlusLeaseVW
group by Lease_customer_Name, lease_booked_post_date)x
Group by  Year, Month, Lease_Customer_Name

GO
Grant Select on XGSG_CustomerName to GraphicCR1
GO

Create View XGSG_SalesRep as
	Select Year
	,Month
	,[Sales Rep]
	,Sum(Number) Number
	, isnull(Sum([Cost of Equipment]),0) [Cost of Equipment]
	From (
Select year(lease_booked_post_date) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,isnull(lease_slsrep_name,'') [Sales Rep]
	,count(Lease_num) as Number
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
from LPlusLeaseVW
group by lease_slsrep_name, lease_booked_post_date)x
Group by  Year, Month, [Sales Rep]

GO
Grant Select on XGSG_SalesRep to GraphicCR1
GO

Create View XGSG_EquipmentType as
	Select Year
	,Month
	,[Equipment Type]
	,Sum(Number) Number
	, isnull(Sum([Cost of Equipment]),0) [Cost of Equipment]
	From (
Select year(lease_booked_post_date) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,isnull(E.Equip_type,'') [Equipment Type]
	,count(Lease_num) as Number
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
from LPlusLeaseVW L join LPlusEquipmentVW E on L.lease_num = E.equip_lease_num
group by Equip_type, lease_booked_post_date)x
Group by  Year, Month, [Equipment Type]
go
Grant select on XGSG_EquipmentType to GraphicCR1
GO

-- 