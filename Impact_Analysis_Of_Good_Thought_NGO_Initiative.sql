WITH donation_information AS (
    SELECT
        d.assignment_id,
        ROUND(SUM(d.amount), 2) AS rounded_total_donation_amount,
        s.donor_type
    FROM
        donations d
    JOIN donors s ON d.donor_id = s.donor_id
    GROUP BY
        d.assignment_id, s.donor_type
)
SELECT
a.assignment_name, a.region, dd.rounded_total_donation_amount, dd.donor_type
FROM assignments a
JOIN donation_information dd ON a.assignment_id = dd.assignment_id
ORDER BY dd.rounded_total_donation_amount DESC
LIMIT 5;

WITH donation_informations AS (
	SELECT 
		d.assignment_id,
		COUNT(d.donation_id) AS num_total_donations
	FROM
		donations d
	GROUP BY 
		d.assignment_id
),
ranked_assignments AS (
	SELECT 
		a.assignment_name, 
		a.region, 
		a.impact_score, 
		dc.num_total_donations,
		ROW_NUMBER() OVER (PARTITION BY a.region ORDER BY a.impact_score DESC) AS rank_in_region
	FROM 
		assignments a
	JOIN 
		donation_informations dc ON a.assignment_id = dc.assignment_id
	WHERE 
		dc.num_total_donations > 0
)
SELECT 
	assignment_name, 
	region, 
	impact_score, 
	num_total_donations
FROM 
	ranked_assignments 
WHERE 
	rank_in_region = 1
ORDER BY 
	region ASC;