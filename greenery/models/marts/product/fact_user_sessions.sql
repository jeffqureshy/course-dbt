{{
    config(
        materialized='table'
    )
}}

{% set event_types = ["page_view", "checkout", "add_to_cart", "package_shipped"] %}

with fact_events as (
    select * from {{ ref('fact_events')}}
)
,   int_user_sessions_agg as ( 
    select * from {{ ref('int_user_sessions_agg') }}
)
,   dim_users as ( 
    select * from {{ ref('dim_users') }}
)
,   session_length as ( 
    select  session_id
        ,   min(created_at) as first_created_at
        ,   max(created_at) as last_created_at
    from fact_events
    group by session_id
)

select i.session_id
    ,   i.user_id
    ,   u.first_name
    ,   u.last_name
    ,   u.email
     {% for event_type in event_types %}
    ,   {{event_type}}_count
    {% endfor %}
   ,    session_length.first_created_at as first_session_at
   ,    session_length.last_created_at as last_session_at
   ,    date_part( 'day', session_length.last_created_at::timestamp - session_length.first_created_at::timestamp) * 24 +
        date_part( 'hour', session_length.last_created_at::timestamp - session_length.first_created_at::timestamp) * 60 +
        date_part( 'minute', session_length.last_created_at::timestamp - session_length.first_created_at::timestamp) 
        as session_length_minutes
from int_user_sessions_agg i
left outer join dim_users u
on i.user_id = u.user_id
left outer join session_length
on i.session_id = session_length.session_id