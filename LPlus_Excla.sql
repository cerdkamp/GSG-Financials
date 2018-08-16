Create View XGSG_Exela as
Select   [Lease Number]
	, [Asset Number]
	, [Serial Number]
	, [Bill To Name]
	, [Address 1]
	, [Address 2]
	, [Address 3]
	, City
	, State
	, Zip
	, [Email Address]
	, [Vendor Number]
	, [Vendor Name]
	, [Month]
	, [Year]
	, [Period]
	, MON
	, [Install Date]
	, [In Service Date]
	, [Maturity Date]
	, [Lease Start Date]
	, [Sign Date]
	, [Invoice Due Date]  
	, [Pickup Date]
	, [Equipment Description]
	, MFG
	, Model
	, [List Price]
	, [Original Cost]
	, [Customer #]
	, [Customer Name]
	, [PO Number]
	, equip_vend_po_num
	, [Term]
	, [Lease Type]
	, [Invoice Number]
	, [Status]
	, CIP
	,sum([EquipmentSale]) as [Equipment Sale]
	,sum([Fee]) [Fee]
	,sum([PropertyTax]) [Property Tax]
	,Sum(Rent) Rent
	,Sum(SalesTax) [Sales Tax]
	,Sum([SecurityDeposit]) [Security Deposit]
From (
Select Distinct L.Lease_Num [Lease Number]
	, Isnull(Equip_Seq_Num,'') [Asset Number]
	, isnull(equip_serial_num,'') [Serial Number]
	, Isnull(equip_billto_name,'') [Bill To Name]
	, isnull(equip_billto_address1, '') [Address 1]
	, isnull(equip_billto_address2,'') [Address 2]
	, isnull(equip_billto_address3,'') [Address 3]
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
	, equip_billto_primary_email_address [Email Address]
	, Equip_Orig_Cost [Original Cost]
	, Lease_Cust_ID_Num [Customer #]
	, Lease_Customer_Name [Customer Name]
	, Lease_Lessee_Po_Num [PO Number]
	, equip_vend_po_num
	, Lease_Term [Term]
	, Lease_Type [Lease Type]
	, isnull(Equip_Model,'') Model
	, invdtl_inv_num [Invoice Number]
	, Lease_Status [Status]
	, ISNULL(A.EquipPurchaseAgreemt,'') [CIP]
	, CASE Invdtl_Tran_Code
		When 'BO2RTRN'	THEN INVDTL_AMOUNT
		WHEN 'SALBONT'	THEN INVDTL_AMOUNT
		WHEN 'SALE'		THEN INVDTL_AMOUNT
		WHEN 'SALE LS'	THEN INVDTL_AMOUNT
		WHEN 'SALEBO'	THEN INVDTL_AMOUNT
		WHEN 'SLNOAST'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [EquipmentSale]
	,CASE Invdtl_Tran_Code
		WHEN 'ADMIN'	THEN INVDTL_AMOUNT
		WHEN 'CC-FEE'	THEN INVDTL_AMOUNT
		WHEN 'COMMFEE'	THEN INVDTL_AMOUNT
		WHEN 'COMMIS'	THEN INVDTL_AMOUNT
		WHEN 'CPC REV'	THEN INVDTL_AMOUNT
		WHEN 'CSTRECV'	THEN INVDTL_AMOUNT
		WHEN 'DAMAGES'	THEN INVDTL_AMOUNT
		WHEN 'DOC FEE'	THEN INVDTL_AMOUNT
		WHEN 'FRTRBNT'	THEN INVDTL_AMOUNT
		WHEN 'FRTREBL'	THEN INVDTL_AMOUNT
		WHEN 'HDDRV'	THEN INVDTL_AMOUNT
		WHEN 'INSURAN'	THEN INVDTL_AMOUNT
		WHEN 'MAINT'	THEN INVDTL_AMOUNT
		WHEN 'MANTNON'	THEN INVDTL_AMOUNT
		WHEN 'MISC'		THEN INVDTL_AMOUNT
		WHEN 'MNTPASS'	THEN INVDTL_AMOUNT
		WHEN 'NMRHFRTP'	THEN INVDTL_AMOUNT
		WHEN 'PASNOAS'	THEN INVDTL_AMOUNT
		WHEN 'PROFFEE'	THEN INVDTL_AMOUNT
		WHEN 'RECUPFT'	THEN INVDTL_AMOUNT
		WHEN 'RESFRT'	THEN INVDTL_AMOUNT
		WHEN 'RSFRTNT'	THEN INVDTL_AMOUNT
		WHEN 'STMPTAX'	THEN INVDTL_AMOUNT
		WHEN 'VNDREIM'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [Fee]
	,CASE INVDTL_TRAN_CODE
		WHEN 'PPT'		THEN INVDTL_AMOUNT
		WHEN 'PPT FEE'	THEN INVDTL_AMOUNT
		WHEN 'PPT NON'	THEN INVDTL_AMOUNT
		WHEN 'PPTFENT'	THEN INVDTL_AMOUNT
		WHEN 'PPTNA'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [PropertyTax]
	,CASE INVDTL_TRAN_CODE
		WHEN 'AFTFCT'	THEN INVDTL_AMOUNT
		WHEN 'DISC2'	THEN INVDTL_AMOUNT
		WHEN 'DISC2OP'	THEN INVDTL_AMOUNT
		WHEN 'DISC3'	THEN INVDTL_AMOUNT
		WHEN 'DISC4'	THEN INVDTL_AMOUNT
		WHEN 'DISC5'	THEN INVDTL_AMOUNT
		WHEN 'DISC5OP'	THEN INVDTL_AMOUNT
		WHEN 'DISC6'	THEN INVDTL_AMOUNT
		WHEN 'DISC6OP'	THEN INVDTL_AMOUNT
		WHEN 'EXTEN'	THEN INVDTL_AMOUNT
		WHEN 'EXTN-KB'	THEN INVDTL_AMOUNT
		WHEN 'EXTN-SH'	THEN INVDTL_AMOUNT
		WHEN 'FITRM2'	THEN INVDTL_AMOUNT
		WHEN 'INRNTNT'	THEN INVDTL_AMOUNT
		WHEN 'INTOP'	THEN INVDTL_AMOUNT
		WHEN 'INTRNT'	THEN INVDTL_AMOUNT
		WHEN 'MOMO'		THEN INVDTL_AMOUNT
		WHEN 'MOMONA'	THEN INVDTL_AMOUNT
		WHEN 'NOTEREC'	THEN INVDTL_AMOUNT
		WHEN 'OITM2'	THEN INVDTL_AMOUNT
		WHEN 'RENT FN'	THEN INVDTL_AMOUNT
		WHEN 'RENT OP'	THEN INVDTL_AMOUNT
		WHEN 'RNTPASS'	THEN INVDTL_AMOUNT
		WHEN 'RRDTCIT'	THEN INVDTL_AMOUNT
		WHEN 'RRDTKBG'	THEN INVDTL_AMOUNT
		WHEN 'RRDTSB'	THEN INVDTL_AMOUNT
		WHEN 'RRDTSNB'	THEN INVDTL_AMOUNT
		WHEN 'RRPTJJB'	THEN INVDTL_AMOUNT
		WHEN 'RSDPSTH'	THEN INVDTL_AMOUNT
		WHEN 'RSDRMRK'	THEN INVDTL_AMOUNT
		ELSE 0 END AS RENT
	,CASE INVDTL_TRAN_CODE
		WHEN 'SALETAX'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [SalesTax]
	,CASE invdtl_tran_code
		when 'SECDEP'	THEN INVDTL_AMOUNT
		else 0 end as [SecurityDeposit]
from lplusleasevw L join lplusequipmentvw E on L.Lease_num = E.Equip_lease_num
Left Join LPlusOpenInvoiceDetailVW D on L.Lease_Num =  D.Invdtl_Lease_Num
	and E.equip_seq_num = D.Invdtl_Asset_num
LEFT Join LeaseEquipmentaux A on L.Lease_num = equipformerleasenum) X

group by [Lease Number] 
	, [Asset Number]
	, [Serial Number]
	, [Bill To Name]
	, [Address 1]
	, [Address 2]
	, [Address 3]
	, City
	, State
	, Zip
	, [Email Address]
	, [Vendor Number]
	, [Vendor Name]
	, [Month]
	, [Year]
	, [Period]
	, MON
	, [Install Date]
	, [In Service Date]
	, [Maturity Date]
	, [Lease Start Date]
	, [Sign Date]
	, [Invoice Due Date]  
	, [Pickup Date]
	, [Equipment Description]
	, MFG
	, Model
	, [List Price]
	, [Original Cost]
	, [Customer #]
	, [Customer Name]
	, [PO Number]
	, equip_vend_po_num
	, [Term]
	, [Lease Type]
	, [Invoice Number]
	, [Status]
	, CIP


union all

Select Y.invdtl_lease_num [Lease Number]
	, 0 [Asset Number]
	, '' [Serial Number]
	, '' [Bill To Name]
	, '' [Address 1]
	, '' [Address 2]
	, '' [Address 3]
	, '' City
	, ''  State
	, '' Zip
	, '' [Email Address]
	, 0 [Vendor Number]
	, '' [Vendor Name]
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
	, '1/1/1900' [Install Date]
	, '1/1/1900' [In Service Date]
	, CONVERT(DATE, isnull(Lease_Maturity_Date,'')) [Maturity Date]
	, CONVERT(DATE, isnull(lease_start_date,'')) [Lease Start Date]
	, convert(date, isnull(lease_sign_date,'')) [Sign Date]
	, CONVERT(DATE, Invdtl_Due_Date) [Invoice Due Date]
	, '1/1/1900' [Pickup Date]
	, '' [Equipment Description]
	, '' MFG
	, '' Model
	, 0 [List Price]
	, 0 [Original Cost]
	, Invdtl_cust_id_num [Customer #]
	, Lease_Customer_Name [Customer Name]
	, Lease_Lessee_Po_Num [PO Number]
	, '' equip_vend_po_num
	, Lease_Term [Term]
	, Lease_Type [Lease Type]
	, invdtl_inv_num [Invoice Number]
	, Lease_Status [Status]
	, '' [CIP]
	, [Equipment Sale]
	, Fee
	, [Property Tax]
	, Rent
	, [Sales Tax]
	, [Security Deposit]
From LPlusLeaseVW L 
Join (
Select invdtl_lease_num
	,Invdtl_cust_id_num
	,invdtl_inv_num
	,invdtl_due_date
	,invdtl_asset_num
	,Sum([EquipmentSale]) [Equipment Sale]
	,sum(fee) Fee
	,sum([PropertyTax]) [Property Tax]
	,sum([SalesTax]) [Sales Tax]
	,sum(rent) Rent
	,Sum([security Deposit]) [Security Deposit]
from (
Select invdtl_lease_num
	,invdtl_cust_id_num
	,invdtl_inv_num
	,invdtl_due_date
	,invdtl_asset_num
	, CASE Invdtl_Tran_Code
		When 'BO2RTRN'	THEN INVDTL_AMOUNT
		WHEN 'SALBONT'	THEN INVDTL_AMOUNT
		WHEN 'SALE'		THEN INVDTL_AMOUNT
		WHEN 'SALE LS'	THEN INVDTL_AMOUNT
		WHEN 'SALEBO'	THEN INVDTL_AMOUNT
		WHEN 'SLNOAST'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [EquipmentSale]
	,CASE Invdtl_Tran_Code
		WHEN 'ADMIN'	THEN INVDTL_AMOUNT
		WHEN 'CC-FEE'	THEN INVDTL_AMOUNT
		WHEN 'COMMFEE'	THEN INVDTL_AMOUNT
		WHEN 'COMMIS'	THEN INVDTL_AMOUNT
		WHEN 'CPC REV'	THEN INVDTL_AMOUNT
		WHEN 'CSTRECV'	THEN INVDTL_AMOUNT
		WHEN 'DAMAGES'	THEN INVDTL_AMOUNT
		WHEN 'DOC FEE'	THEN INVDTL_AMOUNT
		WHEN 'FRTRBNT'	THEN INVDTL_AMOUNT
		WHEN 'FRTREBL'	THEN INVDTL_AMOUNT
		WHEN 'HDDRV'	THEN INVDTL_AMOUNT
		WHEN 'INSURAN'	THEN INVDTL_AMOUNT
		WHEN 'MAINT'	THEN INVDTL_AMOUNT
		WHEN 'MANTNON'	THEN INVDTL_AMOUNT
		WHEN 'MISC'		THEN INVDTL_AMOUNT
		WHEN 'MNTPASS'	THEN INVDTL_AMOUNT
		WHEN 'NMRHFRTP'	THEN INVDTL_AMOUNT
		WHEN 'PASNOAS'	THEN INVDTL_AMOUNT
		WHEN 'PROFFEE'	THEN INVDTL_AMOUNT
		WHEN 'RECUPFT'	THEN INVDTL_AMOUNT
		WHEN 'RESFRT'	THEN INVDTL_AMOUNT
		WHEN 'RSFRTNT'	THEN INVDTL_AMOUNT
		WHEN 'STMPTAX'	THEN INVDTL_AMOUNT
		WHEN 'VNDREIM'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [Fee]
	,CASE INVDTL_TRAN_CODE
		WHEN 'PPT'		THEN INVDTL_AMOUNT
		WHEN 'PPT FEE'	THEN INVDTL_AMOUNT
		WHEN 'PPT NON'	THEN INVDTL_AMOUNT
		WHEN 'PPTFENT'	THEN INVDTL_AMOUNT
		WHEN 'PPTNA'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [PropertyTax]
	,CASE INVDTL_TRAN_CODE
		WHEN 'AFTFCT'	THEN INVDTL_AMOUNT
		WHEN 'DISC2'	THEN INVDTL_AMOUNT
		WHEN 'DISC2OP'	THEN INVDTL_AMOUNT
		WHEN 'DISC3'	THEN INVDTL_AMOUNT
		WHEN 'DISC4'	THEN INVDTL_AMOUNT
		WHEN 'DISC5'	THEN INVDTL_AMOUNT
		WHEN 'DISC5OP'	THEN INVDTL_AMOUNT
		WHEN 'DISC6'	THEN INVDTL_AMOUNT
		WHEN 'DISC6OP'	THEN INVDTL_AMOUNT
		WHEN 'EXTEN'	THEN INVDTL_AMOUNT
		WHEN 'EXTN-KB'	THEN INVDTL_AMOUNT
		WHEN 'EXTN-SH'	THEN INVDTL_AMOUNT
		WHEN 'FITRM2'	THEN INVDTL_AMOUNT
		WHEN 'INRNTNT'	THEN INVDTL_AMOUNT
		WHEN 'INTOP'	THEN INVDTL_AMOUNT
		WHEN 'INTRNT'	THEN INVDTL_AMOUNT
		WHEN 'MOMO'		THEN INVDTL_AMOUNT
		WHEN 'MOMONA'	THEN INVDTL_AMOUNT
		WHEN 'NOTEREC'	THEN INVDTL_AMOUNT
		WHEN 'OITM2'	THEN INVDTL_AMOUNT
		WHEN 'RENT FN'	THEN INVDTL_AMOUNT
		WHEN 'RENT OP'	THEN INVDTL_AMOUNT
		WHEN 'RNTPASS'	THEN INVDTL_AMOUNT
		WHEN 'RRDTCIT'	THEN INVDTL_AMOUNT
		WHEN 'RRDTKBG'	THEN INVDTL_AMOUNT
		WHEN 'RRDTSB'	THEN INVDTL_AMOUNT
		WHEN 'RRDTSNB'	THEN INVDTL_AMOUNT
		WHEN 'RRPTJJB'	THEN INVDTL_AMOUNT
		WHEN 'RSDPSTH'	THEN INVDTL_AMOUNT
		WHEN 'RSDRMRK'	THEN INVDTL_AMOUNT
		ELSE 0 END AS RENT
	,CASE INVDTL_TRAN_CODE
		WHEN 'SALETAX'	THEN INVDTL_AMOUNT
		ELSE 0 END AS [SalesTax]
	,CASE invdtl_tran_code
		when 'SECDEP'	THEN INVDTL_AMOUNT
		else 0 end as [Security Deposit]
from LPlusOpenInvoiceDetailVW where invdtl_asset_num= 0 

)X
Group by invdtl_lease_num
	,Invdtl_cust_id_num
	,invdtl_inv_num
	,invdtl_due_date
	,invdtl_asset_num
)Y
on L.Lease_Num =  Y.Invdtl_Lease_Num
	and Y.Invdtl_Asset_num = 0

	go

Grant Select on XGSG_Excla to GraphicCR1