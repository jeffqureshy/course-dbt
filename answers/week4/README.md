# Week 4 Answers

## Q&A Summary
| Question | Answer |
| --- | --- |
| How are our users moving through the product funnel? |  |
| Which steps in the funnel have largest drop off points?| see table below |




### Conversion Rate by Product
|step_order|step|count|lag|drop_off|
|-----|-----|-----|-----|-----|
|1|Page View|578|||
|2|Add To Cart|467|578|0.19|
|3|Checkout|361|467|0.23|



## Q&A SQL

### Conversion Rate
```sql
Select round(
          (count(distinct case when checkout_count > 0 then session_id else null end)::numeric 
            / count(distinct session_id)::numeric) * 100, 
           2) as conversion_rate
from fact_user_sessions
```


![DBT DAG](dbt-dag.png)