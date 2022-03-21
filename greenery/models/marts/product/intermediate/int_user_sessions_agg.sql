
{% set event_types = ["page_view", "checkout", "add_to_cart", "package_shipped"] %}

with fact_events as (
    select * from {{ref('fact_events')}}
)
select session_id
    ,   user_id
    ,   created_at
    {% for event_type in event_types %}
    ,   sum( case when event_type = '{{event_type}}' then 1 else 0 end ) as {{event_type}}_count
    {% endfor %}
from fact_events
--where product_id is not null
group by session_id
    ,   user_id
    ,   created_at


