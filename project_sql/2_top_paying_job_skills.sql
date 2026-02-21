with top_paying_jobs as (
SELECT 
    job_id as id,
    job_title as title,
    job_location as location,
    job_schedule_type as schedule_type,
    salary_year_avg as salary,
    job_posted_date as posted_date,
    name as company_name
from job_postings_fact
     Left JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg IS NOT NULL 
      AND job_title_short = 'Data Analyst'
      and job_location = 'Anywhere'
ORDER BY 
    salary_year_avg DESC
LIMIT 
    10)

SELECT 
top_paying_jobs.*,
    skills 
from top_paying_jobs
     inner JOIN skills_job_dim ON top_paying_jobs.id = skills_job_dim.job_id
     inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
