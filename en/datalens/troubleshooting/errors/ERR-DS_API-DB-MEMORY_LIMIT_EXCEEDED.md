# Memory limit has been exceeded during query execution

`ERR.DS_API.DB.MEMORY_LIMIT_EXCEEDED`

There is not enough memory in the data source to run the query.

The error occurs when the database does not have enough memory to run a query from {{ datalens-short-name }}.



To correct the error, optimize the source table or reduce the amount of data in the query using chart filters.

To optimize tables, contact your database administrator.

If you are going to perform optimization yourself, try enhancing your database with indexes and sorts.

{% note tip %}

If {{ CH }} is your data source, find queries from {{ datalens-short-name }} in [system.query_log]({{ ch.docs }}/operations/system-tables/query_log/).

If {{ PG }} MBD is your data source, review the [performance analysis](../../../tutorials/dataplatform/mpg-profiling.md).

{% endnote %}


{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
