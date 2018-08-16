Create View XGSG_SlsRepSummary as

Select [Sales Rep Name]
	, Year
	, Month
	, [Cost of Equipment]
	, Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec YTD
	From xgsg_salesRep

	go

	grant select on XGSG_SLSRepSummary to GraphicCR1