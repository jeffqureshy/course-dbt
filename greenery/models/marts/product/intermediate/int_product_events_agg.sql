with fact_events as (
    select * from {{ref('fact_events')}}
)
select  session_id
    ,   product_id
    ,   created_at_day
from fact_events
where product_id is not null
group by session_id
    ,   product_id
    ,   created_at_day
