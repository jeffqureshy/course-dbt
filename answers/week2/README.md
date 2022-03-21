# Week 1 Answers

## Q&A Summary
| Question | Answer |
| --- | --- |
| What is our user repeat rate? | 79.8% |
| What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? | Potential good indicators a user is likely to purchase again or not is whether they used a promotion for an order, total session length, pages/products viewed |
| If you had more data, what features would you want to look into to answer this question? | It would be interesting to explore product types of their initial order and addition user demographic information such as marital status, household income, etc. |
| Explain the marts models you added. Why did you organize the models in the way you did? | In the core mart, I created dim_products, dim_users, fact_events, fact_orders because I felt they were generalized models that were applicable to multiple domains. In the marketing mart, I created two intermediate models to summarize events by user and orders by user. I then used these two intermediate models to create a fact models that summarizes both user orders and events for complete view of a user's lifecycle. In the product market, I created two intermediate models to summarize product events and user sessions.  I then created a fact model to analyze user session information and a fact model to analyze product event metrics by day. |
| What assumptions are you making about each model? (i.e. why are you adding each test?) | I added test to validate the grain of the models |
| Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests? | Yes, I found I was duplicating session_ids in my intermediate user sessions model because I included the created_at timestamp.  I resolved the issue by updating the model and ensuring the grain was unique by session_id |
| Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through. |  I would ensure we are performing dbt test and dbt docs generate everytime when performing a dbt run in our orchestration tool.  Then I would configure the orchestration tool to alert the data team when dbt test fails so we can notify stakeholders and log a PR to resolve the issue. |


## Q&A SQL

### Repeat Rate
```sql
SELECT  sum( is_repeat_customer::int) as repeat_user_count
    ,   count(user_id) as total_user_count
    ,   sum( is_repeat_customer::int) * 1.00 / count(user_id) as repeat_rate
from fact_user_order_agg
```

![DBT DAG(dbt-dag.png)