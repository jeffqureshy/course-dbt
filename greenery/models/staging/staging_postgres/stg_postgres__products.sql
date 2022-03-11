with  base as (

        select * from {{ source( 'postgres', 'products' ) }}
    )
    , final as (
        select product_id
            ,  name as product_name
            ,  price
            ,  inventory
        from base
    )
select * from final