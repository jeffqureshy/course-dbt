{{
    config(
        materialized='table'
    )
}}


select  u.user_id
    ,   u.full_name
    ,   u.first_name
    ,   u.last_name
    ,   u.created_at as account_created_at
    ,   u.updated_at as account_updated_at
    ,   uo.order_count > 1 as is_repeat_customer
    ,   {{ dbt_utils.star(from=ref('int_user_order_agg'), relation_alias='uo', except=["user_id"]) }}
    ,   {{ dbt_utils.star(from=ref('int_user_event_agg'), relation_alias='ue', except=["user_id"]) }}
from {{ ref('dim_users') }} u
join {{ ref('int_user_order_agg') }} uo
on u.user_id = uo.user_id
left outer join {{ ref('int_user_event_agg') }} ue
on u.user_id = ue.user_id