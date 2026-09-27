{% macro majuscule(colonne_name) %}
    UPPER({{colonne_name}})
{% endmacro %}