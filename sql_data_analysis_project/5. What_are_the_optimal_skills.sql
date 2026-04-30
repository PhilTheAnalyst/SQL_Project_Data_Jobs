with skills_demanded as (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_work_from_home = True AND
        salary_year_avg is not NULL
    GROUP BY
        skills_dim.skill_id
), average_salary as (
    SELECT
        skills_job_dim.skill_id,
        round(AVG(job_postings_fact.salary_year_avg), 0) as avg_salary
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' and 
        salary_year_avg is not NULL and 
        job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demanded.skill_id,
    skills_demanded.skills,
    demand_count,
    avg_salary
FROM
    skills_demanded
INNER JOIN
    average_salary ON skills_demanded.skill_id = average_salary.skill_id
where   
    demand_count > 10
ORDER BY
    avg_salary DESC, demand_count DESC
LIMIT 10;
/* a more simplified version of the previous query, 
combining the demand and salary analysis into one query. 
It retrieves the top skills for data analyst roles that are in high demand (more than 10 job postings),
and have a significant average salary, providing insights into which skills are both valuable ,
and sought after in the job market. The results are ordered by average salary first, then by demand count, 
to highlight the most financially rewarding skills that are also in demand. 
*/
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(AVG(job_postings_fact.salary_year_avg), 0) as avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = True AND
    salary_year_avg is not NULL
GROUP BY
    skills_dim.skill_id
HAVING
    count(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC, demand_count DESC
LIMIT 25;

/* Below are the insights derived from the analysis of optimal skills for data analyst roles:
1. Strong link between high demand and core data skills
2. Python, R, Tableau → highest demand, moderate salaries
3. Cloud platforms (AWS, Azure, BigQuery) widely востребованы
4. Big data tools (Hadoop, Spark, Snowflake) remain important
5. Databases (SQL Server, Oracle, NoSQL) are essential
6. Enterprise tools (Jira, Confluence) support workflows
👉 Overall trend: Foundational skills = high demand; specialized skills = higher pay
This analysis highlights the importance of both foundational and specialized skills for data analysts. While core skills like Python, R, and Tableau are in high demand, specialized skills such as cloud platforms and big data tools can lead to higher salaries. Job seekers should focus on developing a strong foundation while also acquiring specialized skills to maximize their earning potential in the competitive job market.
*/  