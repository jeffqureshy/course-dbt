with  base as (

        select * from {{ source( 'postgres', 'promos' ) }}
    )
    , final as (
        select promo_id
            ,  discount
            ,  status
        from base
    )
select * from final