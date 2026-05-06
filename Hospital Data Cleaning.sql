SELECT *
FROM patients_table;

SELECT diagnosis, COUNT(*)
FROM patients_staging
GROUP BY diagnosis;

ALTER TABLE patients_staging
ADD COLUMN diagnosis_clean VARCHAR(100);

UPDATE patients_staging
SET diagnosis_clean =
CASE
    WHEN diagnosis IS NULL THEN NULL
    WHEN TRIM(LOWER(diagnosis)) IN ('null', 'nan', 'na', '') THEN NULL
    WHEN TRIM(LOWER(diagnosis)) = 'gerd' THEN 'GERD'
    WHEN TRIM(LOWER(diagnosis)) = 'uti' THEN 'UTI'
    WHEN TRIM(LOWER(diagnosis)) = 'copd' THEN 'COPD'
    WHEN TRIM(LOWER(diagnosis)) = 'acute uri' THEN 'Acute URI'
    WHEN TRIM(LOWER(diagnosis)) = 'covid19' THEN 'COVID-19'
    WHEN TRIM(LOWER(diagnosis)) = 'coronaryarterydisease' THEN 'Coronary Artery Disease'
    WHEN TRIM(LOWER(diagnosis)) = 'coronary artery disease' THEN 'Coronary Artery Disease'
    WHEN TRIM(LOWER(diagnosis)) = 'type 2 diabetes' THEN 'Type 2 Diabetes'
    WHEN TRIM(LOWER(diagnosis)) = 'heart failure' THEN 'Heart Failure'
    WHEN TRIM(LOWER(diagnosis)) = 'chronic kidney disease' THEN 'Chronic Kidney Disease'
    WHEN TRIM(LOWER(diagnosis)) = 'low back pain' THEN 'Low Back Pain'
    WHEN TRIM(LOWER(diagnosis)) = 'skin infection' THEN 'Skin Infection'
    WHEN TRIM(LOWER(diagnosis)) = 'allergic rhinitis' THEN 'Allergic Rhinitis'
    WHEN TRIM(LOWER(diagnosis)) = 'prostate cancer' THEN 'Prostate Cancer'
    WHEN TRIM(LOWER(diagnosis)) = 'breast cancer' THEN 'Breast Cancer'
    WHEN TRIM(LOWER(diagnosis)) = 'stroke(ischemic)' THEN 'Stroke (Ischemic)'
    ELSE CONCAT(
        UPPER(LEFT(TRIM(diagnosis), 1)),
        LOWER(SUBSTRING(TRIM(diagnosis), 2))
    )
END;

SELECT diagnosis_clean, COUNT(*)
FROM patients_staging
GROUP BY diagnosis_clean
ORDER BY COUNT(*) DESC;

SELECT diagnosis, diagnosis_clean, COUNT(*) AS count
FROM patients_staging
GROUP BY diagnosis, diagnosis_clean
ORDER BY diagnosis, count DESC;

SELECT 
insurance_type, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(insurance_type, '''', ''), '"', ''), ' ', ''), '-', ''), '/', ''), '.', ''), ',', '') AS cleaned_insurance_type, 
smoking_status, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(smoking_status, '''', ''), '"', ''), ' ', ''), '-', ''), '/', ''), '.', ''), ',', '') AS cleaned_smoking_status
FROM patients_table;

UPDATE patients_table
SET insurance_type = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(insurance_type, '''', ''), '"', ''), ' ', ''), '-', ''), '/', ''), '.', ''), ',', ''), 
smoking_status = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(smoking_status, '''', ''), '"', ''), ' ', ''), '-', ''), '/', ''), '.', ''), ',', '');

SELECT 
first_name, last_name, first_name is null, last_name is null
FROM patients_table
where first_name is null OR last_name is null;

SELECT zip_code, COUNT(zip_code)
FROM patients_table
GROUP BY zip_code;

UPDATE patients_table
SET diagnosis = TRIM(LOWER(diagnosis));

SELECT diagnosis, count(*)
FROM patients_table
WHERE diagnosis LIKE '%hyper%'
GROUP BY diagnosis;

SELECT diagnosis AS before_value, 'prostate cancer' AS after_value
FROM patients_table
WHERE diagnosis LIKE '%prostatecancer%';

UPDATE patients_table
SET diagnosis = 'prostate cancer'
WHERE diagnosis LIKE '%prostatecancer%';

SELECT *
FROM patients_table
WHERE diagnosis LIKE 'tx';

-- take a look at treatment type, zipcode, insurance type, smoking status, BMI

-- 85916Outpatient825202482520240HYPERLIPIDEMIAPsychotherapyCommercialPPOFormer221$724101000%112350 671356196jessicathomas

-- 48155OUTPATIENT292024020920240hypertensionMedicationManagementmedicaidNever17141799186402US$10224No541954381SarahJohnson



SELECT zip_code
FROM patients_table
GROUP BY zip_code;

CREATE TABLE patients_staging
LIKE patients_table;

SELECT *
FROM patients_staging;
-- WHERE patient_id = 671223261;

INSERT patients_staging
SELECT *
FROM patients_table;

SELECT *
FROM patients_staging
WHERE patient_id = 541954381;

SELECT *
FROM patients_staging
WHERE zip_code LIKE '48155%';

UPDATE patients_staging
SET
	zip_code = '85916', visit_type = 'Outpatient', admission_date = '2024-08-25', discharge_date = '2024-08-25', length_of_stay_days = 0, diagnosis = 'HYPERLIPIDEMIA', treatment_type = 'Psychotherapy',
    insurance_type = 'Commercial PPO', smoking_status = 'Former', bmi = 22.1, total_charge_usd = 724.10, co_pay_usd = 112.35, coinsurance_rate = 1.0, patient_responsibility_usd = 112.35, 
    readmission_30d_flag = 0
WHERE patient_id = 671223261;

INSERT INTO patients_staging (patient_id, first_name, last_name, age, gender, state, zip_code, visit_type, admission_date, discharge_date, length_of_stay_days, diagnosis, treatment_type, insurance_type, 
	smoking_status, bmi, total_charge_usd, co_pay_usd, coinsurance_rate, patient_responsibility_usd, readmission_30d_flag)
VALUES (671356196, 'jessica', 'thomas', 40, 'MALE', 'TX', '75550', 'ER', '2024-02-23', '2024-02-23', 0, 'DEPRESSION', 'Psychotherapy', 'Medicaid', 'Never', 27.7, 758.05, 32.89, 0.1, 108.70, 0);

UPDATE patients_staging
SET
	zip_code = '48155', visit_type = 'Outpatient', admission_date = '2024-02-09', discharge_date = '2024-02-09', length_of_stay_days = 0, diagnosis = 'hypertension', treatment_type = 'Medication Management',
    insurance_type = 'Medicaid', smoking_status = 'Never', bmi = 17.1, total_charge_usd = 417.99, co_pay_usd = 18.64, coinsurance_rate = 0.2, patient_responsibility_usd = 102.24, 
    readmission_30d_flag = 0
WHERE patient_id = 541890684;

INSERT INTO patients_staging (patient_id, first_name, last_name, age, gender, state, zip_code, visit_type, admission_date, discharge_date, length_of_stay_days, diagnosis, treatment_type, insurance_type, 
	smoking_status, bmi, total_charge_usd, co_pay_usd, coinsurance_rate, patient_responsibility_usd, readmission_30d_flag)
VALUES (541954381, 'Sarah', 'Johnson', 21, 'Female', 'MD', '88628', 'Outpatient', '2024-07-04', '2024-07-05', 1, 'Coronary Artery Disease', 'Medication Management', 'Medicare', 'Never', 21.9, 1315.43, 26.36, null, 289.47, 0);

SELECT patient_id, first_name, last_name, age as original_age, CAST(age as unsigned) AS cleaned_age
FROM patients_staging
WHERE age REGEXP '^[0-9]+$';

SELECT patient_id, first_name, last_name, age as original_age, null AS cleaned_age
FROM patients_staging
WHERE age IN ('N/A', 'NA', 'null', '');

UPDATE patients_staging
SET age = NULL
WHERE age IN ('N/A', 'NA', 'null', '');

UPDATE patients_staging
SET age = CAST(age AS UNSIGNED)
WHERE age REGEXP '^[0-9]+$';

SELECT patient_id, first_name, last_name, age
FROM patients_staging
WHERE age REGEXP '[^0-9]';

UPDATE patients_staging
SET age = NULL
WHERE LOWER(age) IN ('nan','n/a','na','null','');

UPDATE patients_staging
SET age = FLOOR(age)
WHERE age REGEXP '^[0-9]+(\.[0-9]+)?$';

UPDATE patients_staging
SET age = CAST(age AS UNSIGNED)
WHERE age REGEXP '^[0-9]+$';

SELECT patient_id, first_name, last_name, age
FROM patients_staging
WHERE age IS NOT NULL AND age REGEXP '[^0-9]';

UPDATE patients_staging
SET age = NULL
WHERE TRIM(LOWER(age)) IN ('nan','n/a','na','null','');

UPDATE patients_staging
SET age = FLOOR(CAST(age AS DECIMAL(10,2)))
WHERE age REGEXP '^[0-9]+\\.[0-9]+$';

UPDATE patients_staging
SET age = CAST(age AS UNSIGNED)
WHERE age REGEXP '^0+[0-9]+$';

UPDATE patients_staging
SET age = CAST(age AS UNSIGNED)
WHERE age REGEXP '^[0-9]+$';

SELECT patient_id, first_name, last_name, age
FROM patients_staging
WHERE age IS NOT NULL AND age REGEXP '[^0-9]';

UPDATE patients_staging
SET age = FLOOR(CAST(age AS DECIMAL(10,2)))
WHERE age REGEXP '^[0-9]+\\.[0-9]+$';

UPDATE patients_staging
SET age = TRIM(age);

UPDATE patients_staging
SET age = FLOOR(CAST(age AS DECIMAL(10,2)))
WHERE age LIKE '%.%';

ALTER TABLE patients_staging
MODIFY age INT;

SELECT gender, COUNT(gender)
FROM patients_staging
GROUP BY gender;

SELECT DISTINCT gender
FROM patients_staging
ORDER BY gender;


UPDATE patients_staging
SET gender = LOWER(gender);

UPDATE patients_staging
SET gender = 'unknown'
WHERE gender IS NULL;


SELECT DISTINCT(visit_type)
FROM patients_staging
GROUP BY visit_type;

UPDATE patients_staging
SET visit_type = LOWER(visit_type);

UPDATE patients_staging
SET visit_type = 'unknown'
WHERE visit_type IN ('na', 'nan', 'null', '');

UPDATE patients_staging
SET visit_type = 'unknown'
WHERE visit_type IS NULL;

SELECT *
FROM patients_staging
WHERE patient_id IN (446077829, 446107660);

-- 334729663
-- ,12/31/2024,  2024-12-31   ,0,'Anemia',Medication Management,'Commercial PPO',Never,28,USD 275.21,$38.67 ,20.00%,93.71,N 335026000,'   Jessica   ',""Davis"""

SELECT patient_id, first_name, last_name, admission_date
FROM patients_staging
WHERE admission_date REGEXP '[^0-9]';

UPDATE patients_staging
SET
  admission_date = '2024-12-31', 
  discharge_date = '2025-01-01',
  length_of_stay_days = 1,
  diagnosis = 'hypertension',
  treatment_type = 'Medication Management',
  insurance_type = 'Medicaid',
  smoking_status = 'Current',
  bmi = 25.9,
  total_charge_usd = 2959.67,
  co_pay_usd = 53.79,
  coinsurance_rate = 0.10,
  patient_responsibility_usd = 349.76,
  readmission_30d_flag = 0
WHERE patient_id = 446077829;

INSERT INTO patients_staging (
  patient_id, first_name, last_name, age, gender, state, zip_code,
  visit_type, admission_date, diagnosis, treatment_type, insurance_type,
  smoking_status, bmi, total_charge_usd, co_pay_usd,
  patient_responsibility_usd, readmission_30d_flag
)
VALUES (
  446107660, 'Elizabeth', 'Thomas', NULL, 'female', 'PA', '37807',
  'outpatient', '2023-03-19', 'asthma', 'Respiratory Therapy',
  'Medicare', 'unknown', 28.7, 2460.52, 9.74, 974, 0
);

SELECT *
FROM patients_staging
WHERE patient_id = '207489777';

UPDATE patients_staging
SET
  visit_type = 'inpatient',
  admission_date = '2024-10-25',
  discharge_date = '2024-10-31',
  length_of_stay_days = 6,
  diagnosis = 'Anxiety',
  treatment_type = 'Psychotherapy',
  insurance_type = 'Commercial PPO',
  smoking_status = 'Never',
  bmi = null,
  total_charge_usd = 12464.47,
  co_pay_usd = 295.21,
  coinsurance_rate = 0.10,
  patient_responsibility_usd = 1541.66,
  readmission_30d_flag = 0
WHERE patient_id = 548537092;

INSERT INTO patients_staging (
  patient_id, first_name, last_name, age, gender, state, zip_code,
  visit_type, admission_date, discharge_date, length_of_stay_days,
  diagnosis, treatment_type, insurance_type, smoking_status, bmi, total_charge_usd,
  co_pay_usd, coinsurance_rate, patient_responsibility_usd, readmission_30d_flag
)
VALUES (
  472623484, 'Patricia', 'Moore', 70, 'male', 'MO', '36778',
  'er', '2023-06-23', '2023-06-24', 1,
  'osteoarthritis', 'physical therapy', 'Commercial PPO', 'Unknown', 20.6, 2528.05, 
  170.38, 0.10, 423.19, 0
);

SELECT admission_date, COUNT(admission_date)
FROM patients_staging
GROUP BY admission_date;

-- imaging&diagnosticsCommercialHMONever231USD19087201US$22134FALSE 472623484PATRICIAMoore70MaleMO

UPDATE patients_staging
SET
  treatment_type = 'Imaging&Diagnostics',
  insurance_type = 'Commercial HMO',
  smoking_status = 'Never',
  bmi = 23.1,
  total_charge_usd = 1908.72,
  co_pay_usd = '',
  coinsurance_rate = 0.10,
  patient_responsibility_usd = 221.34,
  readmission_30d_flag = 0
WHERE patient_id = 472588638;

-- COMMERCIALHMONEVER222NULL267372000%217529No 207553364Davidna45MaleOH80279329202333020231GERDMEDICATIONMANAGEMENTCommercialPPOUnknown3332373331839na65857nan 207790749LindaAnderson36FemaleFL33596Inpatient

UPDATE patients_staging
SET
  insurance_type = 'Commercial HMO',
  smoking_status = 'Never',
  bmi = 22.2,
  total_charge_usd = null,
  co_pay_usd = 267.37,
  coinsurance_rate = 0.20,
  patient_responsibility_usd = 2175.29,
  readmission_30d_flag = 0
WHERE patient_id = 207489777;

SELECT *
FROM patients_staging;

SELECT DISTINCT admission_date
FROM patients_staging
ORDER BY admission_date;

SELECT admission_date AS original_date,
	CASE
		WHEN admission_date LIKE '%/%/%' THEN
			DATE_FORMAT(
				STR_TO_DATE(admission_date, '%m/%d/%Y'), '%Y-%m-%d')
		WHEN admission_date LIKE '%-%-%' THEN
			admission_date
		ELSE NULL
	END AS converted_date
FROM patients_staging;

UPDATE patients_staging
SET admission_date =
CASE
  WHEN admission_date REGEXP '^(0?[1-9]|1[0-2])/(0?[1-9]|[12][0-9]|3[01])/[0-9]{4}$' THEN
    DATE_FORMAT(STR_TO_DATE(admission_date, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN admission_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' THEN
    DATE_FORMAT(STR_TO_DATE(admission_date, '%Y/%m/%d'), '%Y-%m-%d')
  WHEN admission_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN
    admission_date
  ELSE NULL
END;

UPDATE patients_staging
SET discharge_date = TRIM(discharge_date)
WHERE discharge_date IS NOT NULL;

SELECT
  discharge_date AS original_date,
  CASE
    WHEN discharge_date REGEXP '^(0?[1-9]|1[0-2])/(0?[1-9]|[12][0-9]|3[01])/[0-9]{4}$' THEN
      DATE_FORMAT(STR_TO_DATE(discharge_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN discharge_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' THEN
      DATE_FORMAT(STR_TO_DATE(discharge_date, '%Y/%m/%d'), '%Y-%m-%d')
    WHEN discharge_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN
      discharge_date
    ELSE NULL
  END AS converted_date
FROM patients_staging;

UPDATE patients_staging
SET discharge_date =
CASE
  WHEN discharge_date REGEXP '^(0?[1-9]|1[0-2])/(0?[1-9]|[12][0-9]|3[01])/[0-9]{4}$' THEN
    DATE_FORMAT(STR_TO_DATE(discharge_date, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN discharge_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' THEN
    DATE_FORMAT(STR_TO_DATE(discharge_date, '%Y/%m/%d'), '%Y-%m-%d')
  WHEN discharge_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN
    discharge_date
  ELSE NULL
END;

SELECT *
FROM patients_staging;

SELECT DISTINCT length_of_stay_days
FROM patients_staging;

SELECT length_of_stay_days, COUNT(length_of_stay_days)
FROM patients_staging
GROUP BY length_of_stay_days;

SELECT
  patient_id,
  length_of_stay_days,
  CASE
    WHEN length_of_stay_days IS NULL THEN NULL
    WHEN TRIM(length_of_stay_days) IN ('', 'N/A', 'NA', 'null', 'NULL') THEN NULL
    WHEN TRIM(length_of_stay_days) REGEXP '^[0-9]+(\\.[0-9]+)?$'
      THEN CAST(TRIM(length_of_stay_days) AS DECIMAL(10,2))
    ELSE NULL
  END AS los_clean
FROM patients_staging;

UPDATE patients_staging
SET length_of_stay_days =
  CAST(CAST(TRIM(length_of_stay_days) AS DECIMAL(10,2)) AS UNSIGNED)
WHERE length_of_stay_days IS NOT NULL
  AND TRIM(length_of_stay_days) NOT IN ('', 'N/A', 'NA', 'null', 'NULL')
  AND TRIM(length_of_stay_days) REGEXP '^[0-9]+(\\.[0-9]+)?$';
  
UPDATE patients_staging
SET length_of_stay_days = NULL
WHERE TRIM(length_of_stay_days) IN ('N/A', 'n/a', 'NA', 'nan', 'null', 'NULL');

SELECT length_of_stay_days, COUNT(*) AS cnt
FROM patients_staging
GROUP BY length_of_stay_days;

UPDATE patients_staging
SET length_of_stay_days = TRIM(length_of_stay_days)
WHERE length_of_stay_days IS NOT NULL;

UPDATE patients_staging
SET length_of_stay_days = NULL
WHERE length_of_stay_days IS NOT NULL
  AND TRIM(length_of_stay_days) = '';

SELECT patient_id, admission_date, discharge_date, length_of_stay_days AS stored_los, DATEDIFF(discharge_date, admission_date) AS calc_los
FROM patients_staging
WHERE admission_date IS NOT NULL AND discharge_date IS NOT NULL AND length_of_stay_days IS NOT NULL AND length_of_stay_days <> DATEDIFF(discharge_date, admission_date);

SELECT *
FROM patients_staging
WHERE length_of_stay_days = 1;

SELECT discharge_date
FROM patients_staging
WHERE discharge_date LIKE '%-00-%';

SELECT patient_id, discharge_date
FROM patients_staging
WHERE discharge_date IS NOT NULL AND discharge_date <> '' AND STR_TO_DATE(discharge_date, '%Y-%m-%d') IS NULL;

UPDATE patients_staging
SET discharge_date = NULL
WHERE discharge_date = '2025-00-12';

SELECT COUNT(*) AS remaining_bad_dates
FROM patients_staging
WHERE discharge_date IS NOT NULL AND discharge_date LIKE '%-00-%';

SELECT patient_id, admission_date
FROM patients_staging
WHERE admission_date IS NOT NULL AND TRIM(admission_date) <> '' AND STR_TO_DATE(admission_date, '%Y-%m-%d') IS NULL;

ALTER TABLE patients_staging
MODIFY admission_date DATE, MODIFY discharge_date DATE;

SELECT *
FROM patients_staging;

SELECT patient_id, admission_date, discharge_date, length_of_stay_days, DATE_SUB(STR_TO_DATE(discharge_date, '%Y-%m-%d'), INTERVAL CAST(length_of_stay_days AS UNSIGNED) DAY) AS would_be_admission
FROM patients_staging
WHERE admission_date IS NULL AND discharge_date IS NOT NULL AND length_of_stay_days IS NOT NULL;

UPDATE patients_staging
SET admission_date = DATE_FORMAT(DATE_SUB(STR_TO_DATE(discharge_date, '%Y-%m-%d'),INTERVAL CAST(length_of_stay_days AS UNSIGNED) DAY),'%Y-%m-%d')
WHERE admission_date IS NULL AND discharge_date IS NOT NULL AND length_of_stay_days IS NOT NULL AND discharge_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' AND length_of_stay_days REGEXP '^[0-9]+$';

SELECT patient_id, admission_date, discharge_date, length_of_stay_days, DATE_ADD(STR_TO_DATE(admission_date, '%Y-%m-%d'), INTERVAL CAST(length_of_stay_days AS UNSIGNED) DAY) AS would_be_discharge
FROM patients_staging
WHERE discharge_date IS NULL AND admission_date IS NOT NULL AND length_of_stay_days IS NOT NULL;

UPDATE patients_staging
SET discharge_date = DATE_FORMAT(DATE_ADD(STR_TO_DATE(admission_date, '%Y-%m-%d'), INTERVAL CAST(length_of_stay_days AS UNSIGNED) DAY), '%Y-%m-%d')
WHERE discharge_date IS NULL AND admission_date IS NOT NULL AND length_of_stay_days IS NOT NULL AND admission_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' AND length_of_stay_days REGEXP '^[0-9]+$';

UPDATE patients_staging
SET length_of_stay_days = DATEDIFF(discharge_date, admission_date)
WHERE admission_date IS NOT NULL AND discharge_date IS NOT NULL;

SELECT *
FROM patients_staging;

UPDATE patients_staging
SET length_of_stay_days = NULL
WHERE admission_date IS NULL AND discharge_date IS NULL;

ALTER TABLE patients_staging
MODIFY length_of_stay_days INT NULL;

SELECT state, COUNT(*) AS cnt
FROM patients_staging
GROUP BY state
ORDER BY cnt DESC;

UPDATE patients_staging
SET state = UPPER(TRIM(state))
WHERE state IS NOT NULL;

UPDATE patients_staging
SET state = NULL
WHERE state IS NOT NULL AND LOWER(state) IN ('na', 'nan', 'null', '');

SELECT visit_type, COUNT(*)
FROM patients_staging
GROUP BY visit_type
ORDER BY COUNT(*) DESC;

UPDATE patients_staging
SET visit_type = 'ER'
WHERE visit_type = 'er';

-- MONEY THINGS
SELECT co_pay_usd, COUNT(*) cnt
FROM patients_staging
GROUP BY co_pay_usd
ORDER BY cnt DESC
LIMIT 25;

ALTER TABLE patients_staging
ADD COLUMN co_pay_amount DECIMAL(12,2) NULL;

UPDATE patients_staging
SET co_pay_amount =
  CASE
    WHEN co_pay_usd IS NULL THEN NULL
    WHEN LOWER(TRIM(co_pay_usd)) IN ('', 'na', 'n/a', 'nan', 'null') THEN NULL
    ELSE CAST(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(TRIM(co_pay_usd)), 'usd', ''), 'us$', ''), '$', ''), ' ', ''), ',', '') AS DECIMAL(12,2))
  END;
  
  
UPDATE patients_staging
SET co_pay_amount =
  CASE
    WHEN co_pay_usd IS NULL THEN NULL
    WHEN LOWER(TRIM(co_pay_usd)) IN ('', 'na', 'n/a', 'nan', 'null') THEN NULL
    ELSE CAST(
      CASE
        WHEN co_pay_usd LIKE '%,%' AND co_pay_usd NOT LIKE '%.%' THEN
          REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(TRIM(co_pay_usd)), 'usd', ''), 'us$', ''), '$', ''), ' ', ''), ',', '.')
        -- normal case (1,234.56 -> 1234.56)
        ELSE
          REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(TRIM(co_pay_usd)), 'usd', ''), 'us$', ''), '$', ''), ' ', ''), ',', '')
      END
    AS DECIMAL(12,2))
  END;


SELECT co_pay_usd, co_pay_amount
FROM patients_staging
WHERE co_pay_usd LIKE '%,%' AND co_pay_usd NOT LIKE '%.%'
LIMIT 50;


SELECT co_pay_usd, COUNT(*) AS cnt
FROM patients_staging
WHERE co_pay_usd IS NOT NULL
  AND LOWER(TRIM(co_pay_usd)) NOT IN ('', 'na', 'n/a', 'nan', 'null')
  AND co_pay_amount IS NULL
GROUP BY co_pay_usd
ORDER BY cnt DESC
LIMIT 50;

SELECT *
FROM patients_table;

SELECT *
FROM patients_staging;

SELECT treatment_type, COUNT(*)
FROM patients_staging
GROUP BY treatment_type;

UPDATE patients_staging
SET treatment_type = NULL
WHERE TRIM(LOWER(treatment_type)) IN ('na', 'nan', 'null', '');

UPDATE patients_staging
SET treatment_type = 'Imaging & Diagnostics'
WHERE TRIM(LOWER(treatment_type)) = 'imaging&diagnostics';

SELECT insurance_type, COUNT(*)
FROM patients_staging
GROUP BY insurance_type;

UPDATE patients_staging
SET insurance_type = NULL
WHERE TRIM(LOWER(insurance_type)) IN ('na', 'nan', 'null', '');

UPDATE patients_staging
SET insurance_type = 'VA Tricare'
WHERE TRIM(LOWER(insurance_type)) IN ('vatricare', 'va tricare');

SELECT smoking_status, COUNT(*)
FROM patients_staging
GROUP BY smoking_status;

UPDATE patients_staging
SET smoking_status = NULL
WHERE TRIM(LOWER(smoking_status)) IN ('null', 'na', 'nan', '');

UPDATE patients_staging
SET smoking_status = 'Unknown'
WHERE TRIM(LOWER(smoking_status)) = 'unknown';

SELECT readmission_30d_flag, COUNT(*)
FROM patients_staging
GROUP BY readmission_30d_flag;

UPDATE patients_staging
SET readmission_30d_flag = '0'
WHERE TRIM(LOWER(readmission_30d_flag)) IN ('no', 'n', 'false', '0');

SELECT coinsurance_rate, COUNT(*)
FROM patients_staging
GROUP BY coinsurance_rate;

UPDATE patients_staging
SET coinsurance_rate = NULL
WHERE TRIM(LOWER(coinsurance_rate)) IN ('null', 'nan', 'na', 'n/a', '');

UPDATE patients_staging
SET coinsurance_rate = REPLACE(coinsurance_rate, ',', '.')
WHERE coinsurance_rate LIKE '%,%';

UPDATE patients_staging
SET coinsurance_rate = 
    CAST(REPLACE(REPLACE(REPLACE(LOWER(coinsurance_rate), ' percent', ''),'%', ''),' ', '') AS DECIMAL(5,2)) / 100
WHERE LOWER(coinsurance_rate) LIKE '%percent%' OR coinsurance_rate LIKE '%';

UPDATE patients_staging
SET coinsurance_rate = coinsurance_rate * 100
WHERE coinsurance_rate > 0 AND coinsurance_rate < 0.01;

ALTER TABLE patients_staging
MODIFY coinsurance_rate DECIMAL(5,2);

SELECT patient_responsibility_usd
FROM patients_staging; 

SELECT *
FROM patients_staging;

ALTER TABLE patients_staging
ADD COLUMN patient_responsibility_clean DECIMAL(10,2);

    
SELECT DISTINCT patient_responsibility_usd
FROM patients_staging
WHERE patient_responsibility_usd IS NOT NULL AND TRIM(patient_responsibility_usd) NOT IN ('', 'nan', 'N/A', 'NULL')
ORDER BY patient_responsibility_usd;

UPDATE patients_staging
SET patient_responsibility_clean =
    CASE
        WHEN patient_responsibility_usd IS NULL THEN NULL
        WHEN TRIM(patient_responsibility_usd) IN ('', 'nan', 'N/A', 'NULL') THEN NULL
        WHEN TRIM(REPLACE(REPLACE(REPLACE(patient_responsibility_usd, 'USD', ''), '$', ''), ',', '')) REGEXP '^[0-9]+(\\.[0-9]+)?$'
        THEN CAST(TRIM(REPLACE(REPLACE(REPLACE(patient_responsibility_usd, 'USD', ''),'$', ''),',', '')) AS DECIMAL(10,2))
        ELSE NULL
    END;
    
SELECT patient_id, total_charge_amount, co_pay_amount, coinsurance_rate, patient_responsibility_clean, ROUND(co_pay_amount + (total_charge_amount * coinsurance_rate), 2) AS expected_value
FROM patients_staging
LIMIT 20;

SELECT *
FROM patients_staging;

ALTER TABLE patients_staging
DROP COLUMN total_charge_usd, DROP COLUMN co_pay_usd, DROP COLUMN patient_responsibility_usd;

SELECT first_name
FROM patients_staging
WHERE first_name = '';

UPDATE patients_staging
SET last_name = NULL
WHERE last_name = '';

UPDATE patients_staging
SET last_name = CONCAT(
    UPPER(SUBSTRING(last_name, 1, 1)),
    LOWER(SUBSTRING(last_name, 2))
)
WHERE last_name IS NOT NULL;

ALTER TABLE patients_staging
MODIFY COLUMN patient_id int;

SELECT zip_code, COUNT(*)
FROM patients_staging
GROUP BY zip_code;

UPDATE patients_staging
SET zip_code = NULL
WHERE LOWER(TRIM(zip_code)) IN ('nan', 'na', 'null', '');

select *
FROM patients_staging;

SELECT smoking_status, COUNT(*)
FROM patients_staging
GROUP BY smoking_status;

ALTER TABLE patients_staging
MODIFY COLUMN readmission_30d_flag int;

SELECT bmi, COUNT(*)
FROM patients_staging
GROUP BY bmi;

UPDATE patients_staging
SET bmi = NULL
WHERE bmi IS NOT NULL
  AND LOWER(TRIM(bmi)) IN ('', 'null', 'n/a', 'na', 'nan');
  
UPDATE patients_staging
SET bmi = REPLACE(TRIM(bmi), ',', '.')
WHERE bmi IS NOT NULL AND TRIM(bmi) LIKE '%,%';
  
SELECT DISTINCT bmi
FROM patients_staging
WHERE bmi IS NOT NULL AND TRIM(bmi) NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
ORDER BY bmi;

CREATE TABLE patients_cleaned AS
SELECT patient_id, first_name, last_name, age, gender, state, zip_code, visit_type, admission_date, discharge_date, length_of_stay_days, diagnosis_clean AS diagnosis, treatment_type, insurance_type, 
	smoking_status, bmi, total_charge_amount AS total_charge_usd, co_pay_amount AS co_pay_usd, coinsurance_rate, patient_responsibility_clean AS patient_responsibility_usd, readmission_30d_flag
FROM patients_staging;

SELECT *
FROM patients_cleaned;

SELECT diagnosis, COUNT(*)
FROM patients_cleaned
GROUP BY diagnosis;