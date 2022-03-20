{{
    config(
        materialized='table'
    )
}}

select  u.user_id
    ,   u.full_name
    ,   u.first_name
    ,   u.last_name
    ,   u.email
    ,   u.phone_number
    ,   u.created_at
    ,   u.updated_at
    ,   u.address_id
    ,   a.full_address
    ,   a.address
    ,   a.zipcode
    ,   a.state
    ,   a.country
from {{ ref('stg_postgres__users') }} u
left outer join {{ ref('stg_postgres__addresses') }} a
on u.address_id = a.address_id
