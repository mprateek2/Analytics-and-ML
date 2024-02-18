CREATE DATABASE db_SQLCaseStudies;
USE db_SQLCaseStudies;

--------------CREATE 3 TABLES------------
-- 1. BS_CUSTOMERS
-- 2. BS_CATEGORY
-- 3. BS_TRANSACTIONS

SELECT *
FROM CUSTOMER;

SELECT *
FROM CATEGORY;

SELECT *
FROM TRANS;

ALTER TABLE CUSTOMER 
ALTER COLUMN CUSTOMER_ID int NOT NULL;

ALTER TABLE CUSTOMER
ADD CONSTRAINT CUST_PK PRIMARY KEY (CUSTOMER_ID);

ALTER TABLE TRANS 
ALTER COLUMN TRANSACTION_ID BIGINT NOT NULL;

ALTER TABLE TRANS 
ALTER COLUMN CUST_ID INT;

ALTER TABLE TRANS 
ALTER COLUMN PROD_SUBCAT_CODE INT;

ALTER TABLE TRANS 
ALTER COLUMN PROD_CAT_CODE INT;

ALTER TABLE TRANS 
ALTER COLUMN QTY INT;

ALTER TABLE TRANS 
ALTER COLUMN RATE FLOAT;

ALTER TABLE TRANS 
ALTER COLUMN TAX FLOAT;

ALTER TABLE TRANS 
ALTER COLUMN TOTAL_AMT FLOAT;

ALTER TABLE TRANS
ADD CONSTRAINT FK_CUST_ID
FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER(CUSTOMER_ID);


/******************************** QUESTIONS AND ANSWERS (part 1) **************************/
--Q1.What is total number of rows in each of 3 tables in database?
--Customer table: 5647 rows
--Category table: 23 rows
--Transactions table: 23053 rows
SELECT *
FROM CUSTOMER;

SELECT *
FROM CATEGORY;

SELECT *
FROM TRANS;


--Q2.What is total number of transactions that have a return?
SELECT COUNT(*) AS RETURN_COUNT
FROM TRANS
WHERE Qty<0;

--Q3. As you have noticed, the date provided across the datasets are not in correct format.
-- As the first step please convert the date variable into valid date formats before procedding ahead?

SELECT CONVERT(DATE, DOB, 105) AS CON_DATE
FROM customer;

SELECT *, CONVERT(DATE, TRAN_DATE, 105) AS COV_DATE
FROM TRANS;

--Q4. What is the time range of transaction data available for analysis? Show the output
-- in number of days, month and year simultaneously in different column?

SELECT 
DATEDIFF(DAY, MIN(COV_DATE), MAX(COV_DATE)) AS [DAYS],
DATEDIFF(MONTH, MIN(COV_DATE), MAX(COV_DATE)) AS MONTHS,
DATEDIFF(YEAR, MIN(COV_DATE), MAX(COV_DATE)) AS YEARS
FROM (SELECT *, CONVERT(DATE, TRAN_DATE, 105) AS COV_DATE
FROM TRANS) AS T1;

--Q5. Which product category the sub-category 'DIY' belong to?
SELECT prod_cat
FROM CATEGORY
where prod_subcat = 'DIY';

/******************************** QUESTIONS AND ANSWERS (Part 2) **************************/

--Q1. Which channel is most frequently used for transactions?
SELECT TOP 1 STORE_TYPE, 
COUNT(STORE_TYPE) AS CHANNELS
FROM TRANS
GROUP BY STORE_TYPE
ORDER BY CHANNELS DESC;

--Q2. What is the count of Male and Female customers in the database?
SELECT GENDER, 
COUNT(GENDER) AS GEN_CNT
FROM CUSTOMER
WHERE GENDER IN ('M','F')
GROUP BY GENDER;

--Q3. From which city do we have the maximum number of customers and how many?
SELECT TOP 1 CITY_CODE, 
COUNT(CITY_CODE) AS CITY_CNT
FROM CUSTOMER
GROUP BY CITY_CODE
ORDER BY CITY_CNT DESC;

--Q4. How many sub-categories are there under the Books category?
SELECT COUNT(PROD_SUBCAT) AS CNT_CAT_BOOKS
FROM CATEGORY
WHERE PROD_CAT = 'BOOKS';

--Q5. What is the maximum quantity of products ever ordered?
SELECT MAX(QTY)
FROM TRANS;

--Q6. What is the net total revenue generated in categories Electronics and Books?

SELECT SUM(DISTINCT T.TOTAL_AMT) AS TOTAL_REV
FROM CATEGORY AS C
LEFT JOIN TRANS AS T ON T.PROD_CAT_CODE = C.PROD_CAT_CODE AND T.prod_subcat_code = C.prod_sub_cat_code
WHERE PROD_CAT IN ('ELECTRONICS', 'BOOKS');

--Q7. How many customers have >10 transactions with us, excluding returns?

SELECT CUSTOMER_ID, 
COUNT(*) AS CUST_TRANS
FROM CUSTOMER AS C
LEFT JOIN TRANS AS T ON C.CUSTOMER_ID =T.CUST_ID
WHERE TOTAL_AMT>0
GROUP BY CUSTOMER_ID
HAVING COUNT(*) >10;

--Q8. What is the combined revenue earned from the “Electronics” & “Clothing”
--categories, from “Flagship stores”?

SELECT SUM(T.TOTAL_AMT) AS TOTAL_REV
FROM CATEGORY AS C
LEFT JOIN TRANS AS T ON T.PROD_CAT_CODE = C.PROD_CAT_CODE AND T.prod_subcat_code = C.prod_sub_cat_code
WHERE C.PROD_CAT IN ('ELECTRONICS', 'BOOKS') AND T.STORE_TYPE = 'FLAGSHIP STORE';



--Q9. What is the total revenue generated from “Male” customers in “Electronics”
--category? Output should display total revenue by prod sub-cat.

SELECT CY.prod_subcat, 
SUM(T.TOTAL_AMT) AS TOTAL_REV
FROM CUSTOMER AS C
LEFT JOIN TRANS AS T ON C.customer_Id = T.cust_id
LEFT JOIN category AS CY ON CY.prod_cat_code = T.prod_cat_code AND CY.prod_sub_cat_code=T.prod_subcat_code
WHERE C.Gender='M'
GROUP BY CY.prod_cat, CY.prod_subcat
HAVING CY.prod_cat = 'ELECTRONICS';

--Q10. What is percentage of sales and returns by product sub category; display only top
--5 sub categories in terms of sales?
-- CONSIDERING SALES AS POSITIVE AND RETURNS AS NEGATIVE


SELECT TOP 5 C.prod_subcat, 
(SUM(CASE WHEN QTY>0 THEN TOTAL_AMT ELSE 0 END)/(SELECT SUM(TOTAL_AMT) FROM TRANS))*100 AS SALES_PERCENT,
ABS(SUM(CASE WHEN QTY>0 THEN 0 ELSE TOTAL_AMT END)/(SELECT SUM(TOTAL_AMT) FROM TRANS))*100 AS RETURN_PERCENT

FROM TRANS AS T
LEFT JOIN CATEGORY AS C 
ON C.prod_cat_code = T.prod_cat_code AND C.prod_sub_cat_code=T.prod_subcat_code
GROUP BY C.prod_subcat
ORDER BY SALES_PERCENT DESC;


--Q11. For all customers aged between 25 to 35 years find what is the net total revenue
--generated by these consumers in last 30 days of transactions from max transaction
--date available in the data?

SELECT SUM(TOTAL_AMT) AS TOTAL_REV
FROM
(SELECT TOTAL_AMT, 
DATEDIFF(DAY, TRAN_D, (SELECT MAX(CONVERT(DATE, TRAN_DATE, 105)) FROM TRANS)) AS TRANS_DAYS, 
DATEDIFF(YEAR, CUST_DOB, (SELECT MAX(CONVERT(DATE, TRAN_DATE, 105)) FROM TRANS)) AS CUST_AGE
FROM (SELECT T.TOTAL_AMT, 
		CONVERT(DATE, T.TRAN_DATE, 105) AS TRAN_D,
		CONVERT(DATE, C.DOB, 105) AS CUST_DOB
		FROM CUSTOMER AS C
		LEFT JOIN TRANS AS T ON C.customer_Id = T.cust_id) AS T1) AS T2
WHERE (CUST_AGE BETWEEN 25 AND 35) AND (TRANS_DAYS <= 30);


--Q12. Which product category has seen the max value of returns in the last 3 months of
--transactions?

SELECT DISTINCT PROD_CAT
FROM 
(SELECT TOP 1 PROD_CAT_CODE, SUM(QTY) AS NUM_RETURNS
	FROM
		(SELECT *,
			DATEDIFF(MONTH, TRAN_D, (SELECT MAX(CONVERT(DATE, TRAN_DATE, 105)) FROM TRANS)) AS TRANS_MONTH
			FROM (SELECT PROD_CAT_CODE, TOTAL_AMT, QTY, CONVERT(DATE, TRAN_DATE, 105) AS TRAN_D FROM TRANS) AS T1) AS T2
	WHERE TRANS_MONTH <=3
	GROUP BY PROD_CAT_CODE
	ORDER BY SUM(QTY) DESC) AS T3
INNER JOIN CATEGORY AS C ON C.prod_cat_code = T3.prod_cat_code;


--Q13. Which store-type sells the maximum products; by value of sales amount and by
--quantity sold?

SELECT TOP 1 STORE_TYPE, 
SUM(CASE WHEN QTY>0 THEN TOTAL_AMT ELSE 0 END) AS SALES_AMT
FROM TRANS
GROUP BY STORE_TYPE
ORDER BY SALES_AMT DESC;

SELECT TOP 1 STORE_TYPE, 
SUM(CASE WHEN QTY>0 THEN QTY ELSE 0 END) AS QTY_SOLD
FROM TRANS
GROUP BY STORE_TYPE
ORDER BY QTY_SOLD DESC;

--Q14. What are the categories for which average revenue is above the overall average.
SELECT C.PROD_CAT, 
AVG(T.TOTAL_AMT) AS AVG_REV_CAT
FROM TRANS AS T
LEFT JOIN CATEGORY AS C 
ON C.prod_cat_code = T.prod_cat_code AND C.prod_sub_cat_code=T.prod_subcat_code
GROUP BY C.PROD_CAT
HAVING AVG(T.TOTAL_AMT) > (SELECT AVG(TOTAL_AMT) FROM TRANS);

--Q15. Find the average and total revenue by each subcategory for the categories which
--are among top 5 categories in terms of quantity sold.

SELECT prod_subcat ,AVG(total_amt) AS Avg_Rev, SUM(total_amt) AS Total_Rev
FROM TRANS AS T
LEFT JOIN CATEGORY AS C 
ON C.prod_cat_code = T.prod_cat_code AND C.prod_sub_cat_code=T.prod_subcat_code
WHERE prod_cat IN (SELECT TOP 5 prod_cat
					FROM TRANS AS T
					LEFT JOIN CATEGORY AS C 
					ON C.prod_cat_code = T.prod_cat_code AND C.prod_sub_cat_code=T.prod_subcat_code
					GROUP BY prod_cat
					ORDER BY sum(Qty) desc)
GROUP BY prod_subcat;
