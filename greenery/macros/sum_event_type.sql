{% macro sum_event_type( event_type, event_column, amount_type ) %}
    sum( case when {{event_column}} = '{{event_type}}' then 1 else 0 end ) as {{event_type}}_{{amount_type}}
{% endmacro %}
