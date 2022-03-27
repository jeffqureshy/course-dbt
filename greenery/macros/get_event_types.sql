{% macro get_event_types() %}
    {{ return(["page_view", "checkout", "add_to_cart", "package_shipped"]) }}
{% endmacro %}