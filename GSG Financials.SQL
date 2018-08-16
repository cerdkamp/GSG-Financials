
-- ALTER VIEW XGSG_LPLUSINVOICEDATA AS

Select  [Lease Number]
	, [Asset Number]
	, [Serial Number]
	, [Address]
	, City
	, State
	, Zip
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
	, equip_vend_po_num
	, Lease_Term [Term]
	, Lease_Type [Lease Type]
	, isnull(Equip_Model,'') Model
	, invdtl_inv_num [Invoice Number]
	, Lease_Status [Status]
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

from lplusequipmentvw  E join lplusleasevw L 
on E.equip_lease_num = L.lease_num
left Join LPlusOpenInvoiceDetailVW D on L.lease_num = D.invdtl_lease_num
 )X
 where [Customer #] = '21861' and period = '201805' and [Lease Number] = '21861-205'
group by [Lease Number]
	, [Asset Number]
	, [Serial Number]
	, [Address]
	, City
	, State
	, Zip
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

