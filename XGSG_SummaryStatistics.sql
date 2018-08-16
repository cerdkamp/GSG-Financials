 Alter View XGSG_SummaryStatistics as

	Select Year
	, Month
	, Period
	, AssetCount
	, IntermRent
	, Number
	, [Cost of Equipment]
	, sum([Sum Implicit Rate])/ Sum(Number) [Average Yield]
	
	From (
Select convert(varchar(4),year(lease_booked_post_date)) as Year
	,right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2)as Month
	,convert(varchar(4),year(lease_booked_post_date))+right('0'+ convert(varchar(2),Month(lease_booked_post_date)),2) Period
	,count(L.Lease_num) as Number
	,sum(convert(decimal(10,2),(case when lease_user_fld3 = '' then '0' else lease_user_fld3 end)))  as IntermRent
	,Sum(AssetCount) AssetCount
	,Sum(lease_booked_eq_cost) [Cost of Equipment]
	,Sum(lease_implicit_rate) [Sum Implicit Rate]
from LPlusLeaseVW L join (

Select Equip_Lease_num
	, count(equip_seq_num) AssetCount
From LPlusequipmentvw
group by equip_lease_num
)W
on L.lease_num = W.equip_lease_num
Left Join LPlusLeaseUserDefinedVW U on L.Lease_num = U.Lease_num
group by lease_booked_post_date
,U.lease_user_fld3
)x

Group by  Year, Month,Period, AssetCount, number, [Cost of Equipment]	, IntermRent


