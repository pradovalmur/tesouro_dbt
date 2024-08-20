-- macros/hashColumns.sql

{% macro generate_hash(columns) %}

    md5(concat({{ ", ".join( columns ) }}))

{% endmacro %}