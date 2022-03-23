

Select round(
          (count(distinct case when checkout_count > 0 then session_id else null end)::numeric 
            / count(distinct session_id)::numeric) * 100, 
           2) as conversion_rate
from dbt_jeff_q.fact_user_sessions


select product_id
      , product_name
      , sum(checkout_count) as checkout_count
      , sum(page_view_count) as page_view_count
      , round(
         ( sum(checkout_count)::numeric 
            / sum(page_view_count)::numeric) * 100, 
           2) as conversion_rate
from dbt_jeff_q.fact_product_events
group by product_id, product_name
order by 3 desc