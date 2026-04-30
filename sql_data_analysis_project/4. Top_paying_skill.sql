/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary for levels for data analsyst roles.
  helps identify the mos financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    round(AVG(salary_year_avg), 0) as avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' and 
    salary_year_avg is not NULL
    -- AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/* 
This analysis delivers the following results:
High-paying roles go beyond traditional data analysis
Strong demand for AI & Machine Learning skills
Data engineering tools (Kafka, Airflow) are highly valued
DevOps & cloud integration increase earning potential
Advanced programming skills are essential
Niche skills (e.g., blockchain) command premium pay

👉 Overall trend: Shift toward hybrid (analytics + engineering + AI) roles

This analysis provides insights into the evolving landscape of data analyst roles, highlighting the increasing importance of technical and specialized skills in securing higher salaries. It underscores the need for data analysts to continuously upskill and adapt to emerging technologies to remain competitive in the job market.
*/ 