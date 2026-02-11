create or replace view DIMDATE(
	"Date ID",
	"Date",
	"Display Date",
	"Year",
	"Month Name",
	"Month Number",
	"Quarter Number",
	"Week Number",
	"Day Number Of Week",
	"Day of Week",
	"Day Of Year",
	"Year-Month",
	"Year-Quarter",
	"Year-Week"
) as
 
WITH CTE_DATE_GENERATOR AS (
    SELECT DATEADD(DAY, SEQ4() * -1,DATEADD(DAY,-1,DATEADD(YEAR,1,DATE_TRUNC('YEAR', CURRENT_DATE)))) AS DAY_ROW FROM TABLE(GENERATOR(ROWCOUNT=>1460)) 
)
  SELECT CAST(TO_VARCHAR(DAY_ROW,'yyyyMMDD') AS BIGINT) AS "Date ID"
	,TO_DATE(CTE_DATE_GENERATOR.DAY_ROW) AS "Date"
  	,TO_CHAR((DAY_ROW),'DD Mon YYYY') AS "Display Date"
    ,YEAR(DAY_ROW) AS "Year"
    ,TO_CHAR(DAY_ROW,'MMMM') AS "Month Name"    
    ,TO_CHAR(DAY_ROW,'MM') AS "Month Number"    
    ,TO_CHAR(QUARTER(DAY_ROW),'00') AS "Quarter Number"   
    ,TO_CHAR(WEEKOFYEAR(DAY_ROW),'00') AS "Week Number"
    ,TO_CHAR(DAYOFWEEKISO(DAY_ROW),'00') AS "Day Number Of Week"
    ,DAYNAME(DAY_ROW) AS "Day of Week"    
	,TO_CHAR(DAYOFYEAR(DAY_ROW),'000') AS "Day Of Year"    
    ,TO_CHAR(DAY_ROW,'YY-Mon') AS "Year-Month"
    ,TO_CHAR(DAY_ROW,'YY')||' - Qt'||REPLACE(TO_CHAR(QUARTER(DAY_ROW),'00'),' ','') AS "Year-Quarter"
    ,TO_CHAR(DAY_ROW,'YY')||' - W'||REPLACE(TO_CHAR(WEEKOFYEAR(DAY_ROW),'00'),' ','') AS "Year-Week"
FROM CTE_DATE_GENERATOR order by 1 ;
