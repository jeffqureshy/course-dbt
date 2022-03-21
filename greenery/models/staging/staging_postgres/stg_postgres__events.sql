with  base as (

        select * from {{ source( 'postgres', 'events' ) }}
    )
    , final as (
        select event_id
            ,  session_id
            ,  user_id
            ,  page_url
            ,  created_at
            ,  event_type
            ,  order_id
            ,  product_id
            ,  date_trunc( 'hour', created_at ) as created_at_hour
            ,  date_trunc( 'day', created_at ) as created_at_day
        from base
    )
select * from final