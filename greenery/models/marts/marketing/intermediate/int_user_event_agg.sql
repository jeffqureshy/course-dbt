

select user_id
    ,   count(distinct session_id) as session_count
    ,   min(created_at) as first_event_created_at
    ,   max(created_at) as last_event_created_at
from {{ ref('fact_events') }}
group by user_id