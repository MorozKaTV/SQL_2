with top_paying_skills AS (
SELECT
sd.skill_id,
sd.skills,
round(avg(jpf.salary_year_avg)) as avg_salary
from skills_job_dim as sjd
     inner JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
     inner JOIN job_postings_fact as jpf ON sjd.job_id = jpf.job_id
     WHERE jpf.job_title_short = 'Data Analyst' and 
              jpf.salary_year_avg IS NOT NULL AND
                jpf.job_work_from_home = True
           
group by sd.skill_id, sd.skills
),

top_demanded_skills AS (SELECT
sd.skill_id,
sd.skills,
count(sjd.*) as demand_count
from skills_job_dim as sjd
     inner JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
     inner JOIN job_postings_fact as jpf ON sjd.job_id = jpf.job_id
     WHERE jpf.job_title_short = 'Data Analyst'
     and jpf.salary_year_avg IS NOT NULL
     and   jpf.job_work_from_home = True
           
group by sd.skill_id, sd.skills
)

SELECT 
    tds.skill_id,
    tds.skills,
    tds.demand_count,
    tps.avg_salary
FROM top_demanded_skills tds
     INNER JOIN top_paying_skills tps ON tds.skill_id = tps.skill_id
     WHERE tds.demand_count > 10
     ORDER BY demand_count DESC
LIMIT 25;