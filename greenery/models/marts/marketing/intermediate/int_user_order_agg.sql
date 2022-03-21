
{% set promos = dbt_utils.get_column_values(
            table=ref('stg_postgres__promos')
        ,   column='promo_id') 
%}

select  user_id
    ,   sum(order_cost) as sum_order_cost
    ,   sum(shipping_cost) as sum_shipping_cost
    ,   sum(order_total) as sum_order_total
    ,   sum(promo_discount) as sum_promo_discount
    ,   avg(len_order_to_delivery_days) as avg_len_order_to_delivery_days
    ,   min(created_at) as first_order_created_at
    ,   max(created_at) as last_order_created_at
    ,   min(delivered_at) as first_delivered_at
    ,   max(delivered_at) as last_delivered_at
    ,   count(distinct order_id) as order_count
{% for promo in promos %}
    ,   count(distinct CASE promo_id WHEN '{{promo}}' then order_id else NULL END ) as "{{promo}}_order_count"
{% endfor %}
from {{ ref('fact_orders') }}
group by user_id