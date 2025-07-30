-- GOAL: Segment customers based on their purchasing behavior using Recency, Frequency, and Monetary (RFM) analysis.

--RFM Analysis
-- We use a CTE to first calculate the raw R, F, and M values for each customer.
WITH
	RFM_CALCS AS (
		SELECT
			C.CUSTOMER_UNIQUE_ID,
			MAX(O.ORDER_PURCHASE_TIMESTAMP) AS LAST_PURCHASE_DATE,
			COUNT(DISTINCT O.ORDER_ID) AS FREQUENCY,
			SUM(P.PAYMENT_VALUE) AS MONETARY
		FROM
			CUSTOMERS C
			JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
			JOIN ORDER_PAYMENTS P ON O.ORDER_ID = P.ORDER_ID
		WHERE
			O.ORDER_STATUS = 'delivered'
		GROUP BY
			C.CUSTOMER_UNIQUE_ID
	),
	-- CTE to calculate the Recency value and the scoring percentiles
	RFM_SCORES AS (
		SELECT
			*,
			EXTRACT(
				DAY
				FROM
					(
						SELECT
							MAX(LAST_PURCHASE_DATE)
						FROM
							RFM_CALCS
					) - LAST_PURCHASE_DATE
			) AS RECENCY_DAYS,
			-- Using NTILE to create 5 bins (quintiles) for each metric.
			NTILE(5) OVER (
				ORDER BY
					(
						SELECT
							MAX(LAST_PURCHASE_DATE)
						FROM
							RFM_CALCS
					) - LAST_PURCHASE_DATE
			) AS R_SCORE,
			NTILE(5) OVER (
				ORDER BY
					FREQUENCY
			) AS F_SCORE,
			NTILE(5) OVER (
				ORDER BY
					MONETARY
			) AS M_SCORE
		FROM
			RFM_CALCS
	)
SELECT
	CUSTOMER_UNIQUE_ID,
	RECENCY_DAYS,
	FREQUENCY,
	MONETARY,
	R_SCORE,
	F_SCORE,
	M_SCORE,
	CAST(R_SCORE AS VARCHAR) || CAST(F_SCORE AS VARCHAR) || CAST(M_SCORE AS VARCHAR) AS RFM_SEGMENT
FROM
	RFM_SCORES
ORDER BY
	R_SCORE DESC,
	F_SCORE DESC,
	M_SCORE DESC;
