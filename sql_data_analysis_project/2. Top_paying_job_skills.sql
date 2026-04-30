/*
Question: What skills are required for the top paying data analyst jobs?
- use the top highest-paying data analyst jobs from the first query.
- Add specific skills required for these roles.
- why? It provides a detailed look at which high-paying jobs demand certain skills.
- Helping job seekers understand which skills to develop that align with top salaries.
*/

with top_paying_jobs as (
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
)
SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
LIMIT 10;