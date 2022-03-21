{{
    config(
        materialized='table'
    )
}}

select  event_id
    ,   session_id
    ,   user_id
    ,   page_url
    ,   created_at
    ,   created_at_hour
    ,   created_at_day
    ,   event_type
    ,   order_id
    ,   product_id
from {{ ref('stg_postgres__events' )}}