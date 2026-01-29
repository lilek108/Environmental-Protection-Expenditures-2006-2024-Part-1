--- query for tables overview
/*
SELECT
	ee.idhod,
	ee.hodnota,
	ee.rok,
	ee.ukazatel_txt,
	ee.uzemi_txt,
	dnn_cis.text as dnn,
	ozp_cis.text as ozp,
	sector_cis.text as sector,
	stapro.text_en as stapro
FROM eco_expenses ee
LEFT JOIN dnn_cis ON dnn_cis.chodnota = ee.dnn_kod
LEFT JOIN sector_cis ON sector_cis.chodnota = ee.sektor_kod
LEFT JOIN ozp_cis ON ozp_cis.chodnota = ee.ozp_kod
LEFT JOIN stapro ON stapro.kod = ee.stapro_kod
LIMIT 100
*/

CREATE TEMP TABLE total_expenses_YoY as 
(SELECT 
	rok as Year,
	SUM(hodnota) as Total_expenses
FROM eco_expenses
GROUP BY rok
ORDER BY rok
);

CREATE TEMP TABLE expenses_by_location_YoY as
(SELECT 
	ee.rok as Year,
	CASE
		WHEN uzemi_txt = 'Česká republika' THEN 'Unspecified location'
		ELSE uzemi_txt
	END as Location,
	SUM(hodnota) as Total_expenses
FROM eco_expenses ee
GROUP BY uzemi_txt, ee.rok
ORDER BY ee.rok,uzemi_txt
);

CREATE TEMP TABLE expenses_by_sector_YoY as
(SELECT
	ee.rok as Year,
	sector_cis.text as Sector,
	SUM(hodnota) as Total_expenses
FROM eco_expenses ee
INNER JOIN sector_cis ON sector_cis.chodnota = ee.sektor_kod
GROUP BY sector_cis.text, ee.rok
ORDER BY ee.rok, sector_cis.text
);

CREATE TEMP TABLE expenses_by_type_YoY as
(SELECT
	ee.rok as Year,
	COALESCE(stapro.text_en, 'Unknown') as Expense_type,
	SUM(hodnota) as Total_expenses
FROM eco_expenses ee
LEFT JOIN stapro ON stapro.kod = ee.stapro_kod
GROUP BY stapro.text_en, ee.rok
ORDER BY ee.rok, stapro.text_en
);

CREATE TEMP TABLE non_investment_expenses_partition as
(SELECT
	ee.rok as Year,
	COALESCE(dnn_cis.text, 'Unknown') as Type_of_non_investment_expense,
	SUM(hodnota) as Total_expenses
FROM eco_expenses ee
INNER JOIN stapro ON stapro.kod = ee.stapro_kod
LEFT JOIN dnn_cis ON dnn_cis.chodnota = ee.dnn_kod
WHERE stapro.text_en LIKE 'Non_investment%'
GROUP BY dnn_cis.text, ee.rok
ORDER BY ee.rok, dnn_cis.text
);

CREATE TEMP TABLE expenses_by_program_YoY as
(WITH years as 
	(SELECT 
		DISTINCT rok 
	FROM eco_expenses
	),
expenses_by_program as
	(SELECT
	    y.rok AS Year,
	    o.text AS Program,
	    COALESCE(SUM(e.hodnota), 0) AS Total_expenses
	FROM years y
	CROSS JOIN ozp_cis o
	LEFT JOIN eco_expenses e
	    ON e.rok = y.rok
	    AND e.ozp_kod = o.chodnota
	GROUP BY y.rok, o.text
	ORDER BY y.rok, o.text
	),
expenses_overview as
	(SELECT 
		Year,
		Program,
		Total_expenses,
		SUM(Total_expenses) OVER(PARTITION BY Program) as Overall_expenses,
		CASE 
			WHEN Year = 2006 THEN NULL
			ELSE LAG(Total_expenses) OVER(ORDER BY Program, Year) 
		END AS Total_expenses_last_year
	FROM expenses_by_program
	)
SELECT
	Year,
	Program,
	Total_expenses,
	Total_expenses_last_year,
	Overall_expenses,
	CASE
		WHEN Overall_expenses != 0 THEN Total_expenses/Overall_expenses
		ELSE 0
	END as "%_of_total",
	CASE
		WHEN Total_expenses != 0 THEN CAST((Total_expenses - Total_expenses_last_year) as decimal)/Total_expenses_last_year
		WHEN Total_expenses_last_year IS NULL THEN NULL
		ELSE 0
	END AS "%_YoY_change"
FROM expenses_overview
);

SELECT 
	*
FROM total_expenses_YoY;

SELECT 
	*
FROM expenses_by_location_YoY;

SELECT 
	*
FROM expenses_by_sector_YoY;

SELECT 
	*
FROM expenses_by_type_YoY;

SELECT 
	*
FROM non_investment_expenses_partition;

SELECT 
	*
FROM expenses_by_program_YoY;











