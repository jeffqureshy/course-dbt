{{
    config(
        materialized='table'
    )
}}

select order_id
    ,   user_id
    ,   o.promo_id
    ,   p.discount as promo_discount
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
left outer join {{ ref('stg_postgres__promos') }} p
on o.promo_id = p.promo_id
order by o.order_id