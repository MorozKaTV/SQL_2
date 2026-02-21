SELECT
sd.skills,
round(avg(jpf.salary_year_avg)) as avg_salary
from skills_job_dim as sjd
     inner JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
     inner JOIN job_postings_fact as jpf ON sjd.job_id = jpf.job_id
     WHERE jpf.job_title_short = 'Data Analyst' and 
              jpf.salary_year_avg IS NOT NULL AND
                jpf.job_location = 'Anywhere'
           
group by sd.skill_id, sd.skills
order by avg_salary DESC
limit 25;