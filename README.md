# 🏥 Hospital Patient Data Analytics & Business Intelligence Dashboard

## Project Summary
This project focuses on analyzing hospital patient data to uncover operational, financial, and clinical insights through data cleaning, transformation, SQL analysis, and interactive dashboards. The project simulates a real-world healthcare analytics workflow by taking messy raw patient records and converting them into a structured, analysis-ready dataset.

Using SQL, Excel, and Power BI, the project explores trends such as patient volume, diagnosis distribution, insurance impact, treatment costs, length of stay, and readmission behavior. The final outcome includes a cleaned healthcare dataset and a business intelligence dashboard designed to support data-driven healthcare decisions.

---

# 📌 Project Objectives

- Clean and standardize inconsistent healthcare data
- Build a structured analytics-ready database
- Perform exploratory data analysis (EDA)
- Create interactive Power BI dashboards
- Identify financial and operational trends in hospital data
- Simulate real-world healthcare analytics workflows

---

# 🛠 Methodology & Data Processing

## 1. Data Collection
The dataset used in this project is a synthetic hospital patient dataset containing over 5,000 patient records. The dataset includes information related to:

- Patient demographics
- Admission/discharge details
- Diagnoses and treatments
- Insurance information
- Financial charges
- Readmission indicators

---

## 2. Data Cleaning & Transformation

Data cleaning was performed primarily using MySQL.

### Cleaning Tasks Included:
- Standardizing inconsistent date formats
- Handling null and missing values
- Removing duplicate records
- Correcting invalid ZIP codes
- Normalizing categorical fields
- Cleaning inconsistent text capitalization
- Validating financial calculations
- Fixing incorrect length-of-stay calculations
- Standardizing insurance and smoking status categories

### Example SQL Cleaning Techniques
- `STR_TO_DATE()`
- `COALESCE()`
- `CASE WHEN`
- `ALTER TABLE`
- `UPDATE`
- `TRIM()`
- `UPPER()/LOWER()`

---

## 3. Exploratory Data Analysis (EDA)

EDA was performed using SQL queries and Power BI visualizations to identify patterns and trends such as:

- Monthly patient admissions
- Average length of stay
- Insurance vs patient responsibility
- Treatment costs by category
- Diagnosis frequency
- Visit type analysis
- Readmission trends

---

## 4. Dashboard Development

Interactive dashboards were created in Power BI to provide visual insights into hospital operations and financial performance.

### Dashboard Features
- Year and month slicers
- Financial breakdown charts
- Diagnosis distribution visuals
- Visit type vs length of stay analysis
- Insurance coverage insights
- Patient admission trends
- KPI summary cards

---

# 💻 Technologies Used

| Technology | Purpose |
|---|---|
| MySQL 8.x | Data cleaning and transformation |
| Power BI Desktop | Dashboard creation and visualization |
| Microsoft Excel | Initial data inspection |
| SQL | Data querying and analysis |
