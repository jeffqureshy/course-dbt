with fact_events as (
    select * from {{ref('fact_events')}}
)
select session_id
    ,   user_id
    {% for event_type in get_event_types() %}
        , {{ sum_event_type( event_type, 'event_type', 'count') }}
    {% endfor %}
from fact_events
--where product_id is not null
group by session_id
    ,   user_id



