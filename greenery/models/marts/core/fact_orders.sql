{{
    config(
        materialized='table'
    )
}}

select order_id
    ,   user_id
    ,   promo_id
    ,   address_id
    ,   created_at
    ,   order_cost
    ,   shipping_cost
    ,   order_total
    ,   tracking_id
    ,   shipping_service
    ,   estimated_delivery_at
    ,   delivered_at
    ,   date_part( 'days', delivered_at - created_at ) as len_order_to_delivery_days
    ,   order_status
from {{ ref('stg_postgres__orders') }} o
order by o.order_id