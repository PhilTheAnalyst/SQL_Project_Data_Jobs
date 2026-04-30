/* 
Question: What are the top paying data analyst jobs?
- identify the top ten highest paying data analyst roles that are available remotely.
- Focus on job postings with specified salaries (remove null).
- Why? Highlight the top paying opportunities for data analysts, offering insights into employment.
*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM
    job_postings_fact as job_postings
LEFT JOIN
    company_dim as company ON job_postings.company_id = company.company_id

WHERE
    job_title_short = 'Data Analyst' and job_location = 'Anywhere' and salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

