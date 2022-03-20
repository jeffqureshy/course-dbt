with  base as (

        select * from {{ source( 'postgres', 'promos' ) }}
    )
    , final as (
        select promo_id
            ,  discount
            ,  status as promo_status
        from base
    )
select * from final