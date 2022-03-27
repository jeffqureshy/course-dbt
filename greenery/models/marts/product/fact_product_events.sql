{{
    config(
        materialized='table'
    )
}}

with int_product_events_agg as (
    select * from {{ref('int_product_events_agg')}}
)
,   int_user_sessions_agg as (
    select * from {{ref('int_user_sessions_agg')}}
)
,   dim_users as (
    select * from {{ref('dim_users')}}
)
,   dim_products as (
    select * from {{ref('dim_products')}}
)
select product_events.product_id
    ,   product_events.created_at_day
    ,   dim_products.product_name
    {% for event_type in get_event_types() %}
    ,   sum( user_sessions.{{event_type}}_count ) as {{event_type}}_count
    {% endfor %}
from int_product_events_agg product_events
join int_user_sessions_agg user_sessions
on product_events.session_id = user_sessions.session_id
left outer join dim_products dim_products
on  dim_products.product_id = product_events.product_id
group by product_events.product_id
    ,   product_events.created_at_day
    ,   dim_products.product_name