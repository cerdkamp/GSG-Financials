
Create View XGSG_Invoice_Detail as

Select L.Lease_Num [Lease Number]
	, Isnull(Equip_Seq_Num,'') [Asset Number]
	, isnull(equip_serial_num,'') [Serial Number]
	, rtrim((isnull(equiploc_address1, '')+ isnull(equiploc_address2,''))) [address]
	, isnull(equiploc_city,'') City
	, isnull(Equiploc_state,'') State
	, isnull(Equiploc_zip_Code,'') Zip
	, isnull(equip_Vendor_Num,0) [Vendor Number]
	, isnull(Equip_Vendor_Name,'') [Vendor Name]
	, Right( '00' + convert(varchar,DatePart(Month,Invdtl_Due_Date)),2) [Month]
	, datepart(Year,Invdtl_Due_Date) [Year]
	, convert(varchar,datepart(Year,Invdtl_Due_Date)) +  Right( '00' + convert(varchar,DatePart(Month,Invdtl_Due_Date)),2)  [Period]
	, CASE 
		When isnull(DatePart(Month,Invdtl_Due_Date),'') = '1' then 'JAN'
		When isnull(DatePart(Month,Invdtl_Due_Date),'') = '2' then 'FEB'
		When isnull(DatePart(Month,Invdtl_Due_Date),'') = '3' then 'MAR'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '4' THEN 'APR'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '5' THEN 'MAY'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '6' THEN 'JUN'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '7' THEN 'JUL'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '8' THEN 'AUG'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '9' THEN 'SEP'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '10' THEN 'OCT'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '11' THEN 'NOV'
		WHEN isnull(DatePart(Month,Invdtl_Due_Date),'') = '12' THEN 'DEC'
		ELSE '' END AS MON
	, CONVERT(DATE, isnull(Equip_Install_date,'')) [Install Date]
	, CONVERT(DATE, isnull(Equip_In_Service_Date,'')) [In Service Date]
	, CONVERT(DATE, isnull(Lease_Maturity_Date,'')) [Maturity Date]
	, CONVERT(DATE, isnull(lease_start_date,'')) [Lease Start Date]
	, convert(date, isnull(lease_sign_date,'')) [Sign Date]
	, CONVERT(DATE, isnull(Equip_Pickup_Date,'')) [Pickup Date]
	, CONVERT(DATE, Invdtl_Due_Date) [Invoice Due Date]
	, Isnull(Equip_Desc,'') [Equipment Description]
	, IsNull(Equip_Manufacturer,'') MFG
	, Equip_List_Price [List Price]
	, Equip_Orig_Cost [Original Cost]
	, Lease_Cust_ID_Num [Customer #]
	, Lease_Customer_Name [Customer Name]
	, Lease_Lessee_Po_Num [PO Number]
	, Lease_Term [Term]
	, Lease_Type [Lease Type]
	, isnull(Equip_Model,'') Model
	, invdtl_inv_num [Invoice Number]
	, Lease_Status [Status]
	, ISNULL(A.EquipPurchaseAgreemt,'') [CIP]
	, invdtl_inv_desc
	, Invdtl_Tran_Code
	, INVDTL_AMOUNT
from lplusleasevw L join lplusequipmentvw E on L.Lease_num = E.Equip_lease_num
Join LPlusOpenInvoiceDetailVW D on L.Lease_Num =  D.Invdtl_Lease_Num
	and E.equip_seq_num = D.Invdtl_Asset_num
LEFT Join LeaseEquipmentaux A on L.Lease_num = equipformerleasenum



go


grant select on XGSG_Invoice_Detail to GraphicCR1
