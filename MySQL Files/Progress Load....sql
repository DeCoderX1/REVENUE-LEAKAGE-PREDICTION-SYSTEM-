-- lets start:

	SELECT 
	  (SELECT COUNT(*) FROM sales_orders) AS sales_orders,
	  (SELECT COUNT(*) FROM invoices) AS invoices,
	  (SELECT COUNT(*) FROM salespersons) AS salespersons,
	  (SELECT COUNT(*) FROM discount_policy) AS discount_policy;

/*
🔹 Concept
		sales_orders    → expected price
		invoices        → actual billed price
		discount_policy → allowed discount
		salespersons    → accountability */
	SELECT
		so.order_id,
		so.order_date,
		so.product,
		so.region,
		so.salesperson_id,
		sp.salesperson_name,
		so.list_price,
		so.approved_discount_pct,
		dp.max_discount_pct,
		i.invoice_price 
	FROM sales_orders so
	JOIN invoices i 
	ON so.order_id = i.order_id
	JOIN salespersons sp 
	ON so.salesperson_id = sp.salesperson_id
	JOIN discount_policy dp 
	ON so.product = dp.product
	LIMIT 10;


-- calculate expected price:
select 
  so.order_id,
  so.list_price,
  so.approved_discount_pct,
  round(so.list_price* (1-so.approved_discount_pct/100),0) as Expected_Price,
  i.invoice_price
from sales_orders as so
join invoices i
on so.order_id=i.order_id
order by i.invoice_price desc
limit 10;
  
 select 
  so.order_id,
  so.list_price,
  so.product,
  so.approved_discount_pct,
  round(so.list_price* (1-so.approved_discount_pct/100),0) as Expected_Price,
  i.invoice_price
from sales_orders as so
join invoices i
on so.order_id=i.order_id
order by i.invoice_price desc
limit 10;


-- find revenue leakage :
-- invoice price < expected price ( MONEY LEAKED )
SELECT
    so.order_id,
    so.salesperson_id,
    so.product,
    ROUND(so.list_price * (1 - so.approved_discount_pct / 100),0) AS expected_price,
    i.invoice_price,
    ROUND((so.list_price * (1 - so.approved_discount_pct / 100)) - i.invoice_price,0) AS leakage_amount
FROM sales_orders so
JOIN invoices i 
ON so.order_id = i.order_id
WHERE i.invoice_price < (so.list_price * (1 - so.approved_discount_pct / 100)) -- expected_price > invoice price
ORDER BY leakage_amount DESC
;

   
-- Discount Policy viloation:
-- Approved Discount > policy allowed -->rule break
SELECT
    so.order_id,
    so.product,
    so.approved_discount_pct,
    dp.max_discount_pct
FROM sales_orders so
JOIN discount_policy dp
    ON so.product = dp.product
WHERE so.approved_discount_pct > dp.max_discount_pct;


-- Risky salesperson ( management view ) 
-- WHO causes most leakage 
SELECT
    sp.salesperson_name,COUNT(*) AS leakage_cases,
    round(SUM( (so.list_price * (1 - so.approved_discount_pct / 100)) - i.invoice_price)) AS total_leakage
FROM sales_orders so
JOIN invoices i 
ON so.order_id = i.order_id
JOIN salespersons sp 
ON so.salesperson_id = sp.salesperson_id
WHERE i.invoice_price < (so.list_price * (1 - so.approved_discount_pct / 100))
GROUP BY sp.salesperson_name
ORDER BY total_leakage DESC;


-- ADVANCED Milestone 
-- Top revenue Leakage Order:
WITH leakage_calculation AS (
    SELECT
        so.order_id,
        so.salesperson_id,
        so.list_price,
        so.approved_discount_pct,
        i.invoice_price,
        ROUND(so.list_price * (1 - so.approved_discount_pct / 100) - i.invoice_price,0 ) AS leakage_amount
    FROM sales_orders so
    JOIN invoices i
	ON so.order_id = i.order_id )
SELECT *, RANK() OVER (ORDER BY leakage_amount DESC) AS leakage_rank
FROM leakage_calculation
WHERE leakage_amount > 0
LIMIT 10;
select * from salespersons where salesperson_id='SP005';


-- Riskey Salesperson Detection ;
/*
BUSINESS QUESTION
       “Which salespersons consistently cause leakage, not just once?”
				One mistake = OK
				Repeated mistakes = 🚨 RISK */
WITH leakage_data AS (
    SELECT
        so.salesperson_id,
        sp.salesperson_name,
        ROUND(so.list_price * (1 - so.approved_discount_pct / 100) - i.invoice_price,0) AS leakage_amount
    FROM sales_orders so
    JOIN invoices i
	ON so.order_id = i.order_id
    JOIN salespersons sp
	ON so.salesperson_id = sp.salesperson_id
    WHERE i.invoice_price < (so.list_price * (1 - so.approved_discount_pct / 100)) )
SELECT
    salesperson_name,
    COUNT(*) OVER (PARTITION BY salesperson_name) AS leakage_cases,
    SUM(leakage_amount) OVER (PARTITION BY salesperson_name) AS total_leakage
FROM leakage_data
ORDER BY total_leakage DESC;



-- Discount Abuse Trend
WITH daily_leakage AS (
    SELECT
	    DATE(so.order_date) AS order_day,
        ROUND(so.list_price * (1 - so.approved_discount_pct / 100) - i.invoice_price,0) AS leakage_amount
    FROM sales_orders so
    JOIN invoices i
	ON so.order_id = i.order_id
    WHERE i.invoice_price <(so.list_price * (1 - so.approved_discount_pct / 100)))
SELECT
    order_day,
    SUM(leakage_amount) AS daily_leakage,
    SUM(SUM(leakage_amount)) OVER (ORDER BY order_day) AS cumulative_leakage
FROM daily_leakage
GROUP BY order_day
ORDER BY order_day;



                
