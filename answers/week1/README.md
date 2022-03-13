# Week 1 Answers

## Q&A Summary
| Question | Answer |
| --- | --- |
| How many users do we have? | 130 |
| On average, how many orders do we receive per hour? | 7.5 |
| On average, how long does an order take from being placed to being delivered? | 3 seconds |
| On average, how many unique sessions do we have per hour? | 16 |
| How many users have only made one purchase? Two purchases? Three+ purchases? | 1 = 25; 2 = 28; 3+ = 71 |


## Q&A SQL
```sql
with user_count as 
(   -- How many users do we have?
    -- 130
    select count(user_id)
    from "stg_postgres__users"
)
, order_checkout_events as 
(   
    select order_id
        , event_id as checkout_event_id
        , event_type as checkout_event_type
        , created_at as checkout_created_at
        , user_id
        , created_at_hour
    from "stg_postgres__events" checkout
    where event_type = 'checkout'
)
, order_count_by_hour as
(
    select created_at_hour
        ,   count( order_id ) as order_count
    from order_checkout_events
    group by created_at_hour
)
, avg_order_count_per_hour as 
(   -- On average, how many orders do we receive per hour?
    -- 7.5
    select avg( order_count ) as avg_order_count
    from order_count_by_hour
)
, order_shipped_events as
(   
    select order_id as order_id
        ,   event_id as shipped_event_id
        ,   event_type as shipped_event_type
        ,   created_at as shipped_created_at
    from "stg_postgres__events" shipped
    where event_type = 'package_shipped'
)
, order_checkout_and_shipped_events as
( 
    select checkout.order_id
        ,   checkout.checkout_created_at
        ,   shipped.shipped_created_at
        ,   date_part( 'second', shipped.shipped_created_at - checkout.checkout_created_at ) as len_order_to_delivery_secs
    from order_checkout_events checkout
    join order_shipped_events shipped
    on checkout.order_id = shipped.order_id
)
, avg_length_order_to_delivery as 
(   -- On average, how long does an order take from being placed to being delivered?
    -- 3 seconds
    select avg( len_order_to_delivery_secs ) as avg_len_order_to_delivery_secs
    from order_checkout_and_shipped_events
)
, session_count_by_hour as
( 
    select created_at_hour
        , count( distinct session_id ) session_count
    from "stg_postgres__events" 
    group by created_at_hour
)
, avg_session_count_per_hour as
(   -- On average, how many unique sessions do we have per hour?
    -- 16
    select avg( session_count ) as avg_session_count
    from session_count_by_hour
)
, order_count_by_user as
(  
    select user_id
        ,   count( distinct order_id ) as order_count
        ,   case 
                when count( distinct order_id ) >= 3 
                then  '3+' 
                else cast( count( distinct order_id ) as text )
            end as order_count_grouping
    from order_checkout_events
    group by user_id
)
, user_count_by_grouping as
(   -- How many users have only made one purchase? Two purchases? Three+ purchases?
    -- 1 = 25; 2 = 28; 3+ = 71
    select  order_count_grouping
        ,   count( user_id ) as user_count
    from order_count_by_user
    group by order_count_grouping
    order by order_count_grouping
)
select * from user_count_by_grouping
limit 100
```

