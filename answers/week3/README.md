# Week 3 Answers

## Q&A Summary
| Question | Answer |
| --- | --- |
| What is our overall conversion rate? | 62.46% |
| What is our conversion rate by product? | see table below |

### Conversion Rate by Product
|product_id|product_name|checkout_count|page_view_count|conversion_rate|
|-----|-----|-----|-----|-----|
|bb19d194-e1bd-4358-819e-cd1f1b401c0c|Birds Nest Fern|57|307|18.57|
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|57|287|19.86|
|689fb64e-a4a2-45c5-b9f2-480c2155624d|Bamboo|56|274|20.44|
|e8b6528e-a830-4d03-a027-473b411c7f02|Snake Plant|56|298|18.79|
|e18f33a6-b89a-4fbc-82ad-ccba5bb261cc|Ponytail Palm|55|288|19.10|
|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|ZZ Plant|55|273|20.15|
|5ceddd13-cf00-481f-9285-8340ab95d06d|Majesty Palm|55|295|18.64|
|c7050c3b-a898-424d-8d98-ab0aaad7bef4|Orchid|55|289|19.03|
|80eda933-749d-4fc6-91d5-613d29eb126f|Pink Anthurium|54|312|17.31|
|843b6553-dc6a-4fc4-bceb-02cd39af0168|Ficus|50|268|18.66|
|74aeb414-e3dd-4e8a-beef-0fa45225214d|Arrow Head|50|247|20.24|
|e706ab70-b396-4d30-a6b2-a1ccf3625b52|Fiddle Leaf Fig|50|232|21.55|
|64d39754-03e4-4fa0-b1ea-5f4293315f67|Spider Plant|49|268|18.28|
|37e0062f-bd15-4c3e-b272-558a86d90598|Dragon Tree|49|250|19.60|
|e5ee99b6-519f-4218-8b41-62f48f59f700|Peace Lily|48|260|18.46|
|c17e63f7-0d28-4a95-8248-b01ea354840e|Cactus|47|259|18.15|
|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|Philodendron|46|248|18.55|
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos|45|241|18.67|
|05df0866-1a66-41d8-9ed7-e2bbcddd6a3d|Bird of Paradise|45|255|17.65|
|58b575f2-2192-4a53-9d21-df9a0c14fc25|Angel Wings Begonia|45|232|19.40|
|e2e78dfc-f25c-4fec-a002-8e280d61a2f2|Boston Fern|45|254|17.72|
|5b50b820-1d0a-4231-9422-75e7f6b0cecf|Pilea Peperomioides|44|250|17.60|
|d3e228db-8ca5-42ad-bb0a-2148e876cc59|Money Tree|44|233|18.88|
|b86ae24b-6f59-47e8-8adc-b17d88cbd367|Calathea Makoyana|44|218|20.18|
|615695d3-8ffd-4850-bcf7-944cf6d3685b|Aloe Vera|43|258|16.67|
|be49171b-9f72-4fc9-bf7a-9a52e259836b|Monstera|43|211|20.38|
|579f4cd0-1f45-49d2-af55-9ab2b72c3b35|Rubber Plant|42|247|17.00|
|6f3a3072-a24d-4d11-9cef-25b0b5f8a4af|Alocasia Polly|34|186|18.28|
|35550082-a52d-4301-8f06-05b30f6f3616|Devil's Ivy|34|189|17.99|
|a88a23ef-679c-4743-b151-dc7722040d8c|Jade Plant|32|187|17.11|


## Q&A SQL

### Conversion Rate
```sql
Select round(
          (count(distinct case when checkout_count > 0 then session_id else null end)::numeric 
            / count(distinct session_id)::numeric) * 100, 
           2) as conversion_rate
from fact_user_sessions
```
### Conversion Rate by Product
```sql
select product_id
      , product_name
      , sum(checkout_count) as checkout_count
      , sum(page_view_count) as page_view_count
      , round(
         ( sum(checkout_count)::numeric 
            / sum(page_view_count)::numeric) * 100, 
           2) as conversion_rate
from dbt_jeff_q.fact_product_events
group by product_id, product_name
order by 3 desc
```

![DBT DAG](dbt-dag.png)