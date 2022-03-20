{{
    config(
        materialized='table'
    )
}}

select  product_id
    ,   product_name
    ,   price
    ,   inventory
from {{ ref('stg_postgres__products') }}
