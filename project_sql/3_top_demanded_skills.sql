SELECT
sd.skills,
count(sjd.*) as demand_count
from skills_job_dim as sjd
     inner JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
     inner JOIN job_postings_fact as jpf ON sjd.job_id = jpf.job_id
     WHERE jpf.job_title_short = 'Data Analyst'
           
group by sd.skill_id, sd.skills
order by demand_count DESC
limit 5;