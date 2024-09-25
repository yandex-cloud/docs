{% note info %}

The username may contain Latin letters, numbers, hyphens, and underscores but must begin with a letter (except the `pg_` combination), number, or underscore. The name may be up to 63 characters long.

The names `mysql`, `sys`, `information_schema`, and `performance_schema` are reserved for {{ mmy-name }}. You cannot create users with these names.


The password must be between 8 and 128 characters.


{% endnote %}
