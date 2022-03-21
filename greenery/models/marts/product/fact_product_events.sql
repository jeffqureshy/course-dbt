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
    ,   sum( user_sessions.page_view_count ) as page_view_count
    ,   sum( user_sessions.checkout_count ) as checkout_count
    ,   sum( user_sessions.add_to_cart_count ) as add_to_cart_count
    ,   sum( user_sessions.package_shipped_count ) as package_shipped_count
from int_product_events_agg product_events
join int_user_sessions_agg user_sessions
on product_events.session_id = user_sessions.session_id
left outer join dim_products dim_products
on  dim_products.product_id = product_events.product_id
group by product_events.product_id
    ,   product_events.created_at_day
    ,   dim_products.product_name