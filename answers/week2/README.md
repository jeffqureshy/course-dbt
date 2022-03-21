# Week 1 Answers

## Q&A Summary
| Question | Answer |
| --- | --- |
| What is our user repeat rate? | 79.8% |
| What are good indicators of a user who will likely purchase again? |  |
| What about indicators of users who are likely NOT to purchase again? |  |
| If you had more data, what features would you want to look into to answer this question? |  |
| Explain the marts models you added. Why did you organize the models in the way you did? |  |
| What assumptions are you making about each model? (i.e. why are you adding each test?) |  |
| Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests? |  |
| Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through. |  |


## Q&A SQL

### Repeat Rate
```sql
SELECT  sum( is_repeat_customer::int) as repeat_user_count
    ,   count(user_id) as total_user_count
    ,   sum( is_repeat_customer::int) * 1.00 / count(user_id) as repeat_rate
from fact_user_order_agg
```