
select  user_id
    ,   sum(order_cost) as sum_order_cost
    ,   sum(shipping_cost) as sum_shipping_cost
    ,   sum(order_total) as sum_order_total
    ,   avg(len_order_to_delivery_days) as avg_len_order_to_delivery_days
    ,   min(created_at) as first_created_at
    ,   max(created_at) as last_created_at
    ,   min(delivered_at) as first_delivered_at
    ,   max(delivered_at) as last_delivered_at
    ,   count(distinct order_id) as order_count
from {{ ref('fact_orders') }}
group by user_id