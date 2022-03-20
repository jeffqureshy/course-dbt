SELECT  sum( is_repeat_customer::int) as repeat_user_count
    ,   count(user_id) as total_user_count
    ,   sum( is_repeat_customer::int) * 1.00 / count(user_id) as repeat_rate
from fact_user_order_agg