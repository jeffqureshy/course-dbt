with  base as (

        select * from {{ source( 'postgres', 'order_items' ) }}
    )
    , final as (
        select order_id
            ,  product_id
            ,  quantity
        from base
    )
select * from final