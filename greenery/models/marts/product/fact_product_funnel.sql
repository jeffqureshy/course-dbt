with 
page_view_step as (
    select 'Page View' as step
        , count(session_id) as count
    from {{ ref('fact_user_sessions') }}
    where page_view_count > 0 or add_to_cart_count > 0 or checkout_count > 0
)
, add_to_cart_step as (
    select 'Add To Cart' as step
        , count(session_id) as count
    from {{ ref('fact_user_sessions') }}
    where add_to_cart_count > 0 or checkout_count > 0
)
, checkout_step as (
    select 'Checkout' as step
        , count(session_id) as count
    from {{ ref('fact_user_sessions') }}
    where checkout_count > 0
)
, combined_steps as (
    select 1 as step_order
        ,  step
        ,  count
    from page_view_step
    union
    select 2 as step_order
        ,   step
        ,   count
    from add_to_cart_step
    union
    select  3 as step_order
        ,   step
        ,   count
    from checkout_step
    order by 1
)
select step_order
    ,   step
    ,   count
    ,   lag(count, 1) over ()
    ,   round((1.0 - count::numeric/lag(count, 1) over ()),2) as drop_off
from combined_steps
order by 1