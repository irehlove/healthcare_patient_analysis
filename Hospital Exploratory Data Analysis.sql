SELECT *
FROM patients_cleaned;

-- By looking at this, it is visible to see that treatment types are targetting correctly 
SELECT treatment_type, COUNT(*) AS total_patients, SUM(readmission_30d_flag) AS readmitted_patients, ROUND(SUM(readmission_30d_flag) / COUNT(*), 3) AS readmission_rate
FROM patients_cleaned
WHERE readmission_30d_flag IS NOT NULL
GROUP BY treatment_type
ORDER BY readmission_rate DESC;

-- after the treatment type let us take a look at the efficiency of the hospital by looking at the average amount of time that patients stayed based off of the visit type. 
SELECT visit_type, COUNT(*) AS total_patients, AVG(length_of_stay_days) AS avg_los
FROM patients_cleaned
GROUP BY visit_type;

-- another metric that we could look at are certain diagnoses that could require longer hospital stay --> higher resource utilization
SELECT diagnosis, COUNT(*) AS total_cases, AVG(length_of_stay_days) AS avg_los
FROM patients_cleaned
GROUP BY diagnosis
ORDER BY avg_los DESC;

SELECT insurance_type, COUNT(*)
FROM patients_cleaned
GROUP BY insurance_type;

-- the one thing that customers are worried about is how much their pay will be after the treatment, so let's take a look at the average total charge for each specific insurance type. 
SELECT insurance_type, COUNT(*), AVG(total_charge_usd) AS avg_total_charge, AVG(co_pay_usd), AVG(patient_responsibility_usd), AVG(coinsurance_rate)
FROM patients_cleaned
GROUP BY insurance_type
ORDER BY avg_total_charge DESC;