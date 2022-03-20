with  base as (

        select * from {{ source( 'postgres', 'addresses' ) }}
    )
    , final as (
        select address_id
            ,  address
            ,  to_char( zipcode, '000000' ) as zipcode
            ,  state
            ,  country
            ,  address || ', ' || to_char( zipcode, '000000' )  || ', ' || state || ', ' || country as full_address
        from base
    )
select * from final