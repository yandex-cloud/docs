---
title: '{{ datalens-full-name }} error ERR.DS_API.DB.MEMORY_LIMIT_EXCEEDED'
description: This page describes the Memory limit has been exceeded during query execution {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Memory limit has been exceeded during query execution

`ERR.DS_API.DB.MEMORY_LIMIT_EXCEEDED`

There is not enough memory in the data source to run the query.

This error occurs when the database does not have enough memory to execute a {{ datalens-short-name }} query.



To fix this error, optimize the source table or reduce the amount of data in the query using chart filters.

To optimize tables, contact your database administrator.

If you are going to perform optimization yourself, try enhancing your database with indexes and sorts.

{% note tip %}

If you use a {{ CH }} database as a data source, find the {{ datalens-short-name }} queries in [system.query_log]({{ ch.docs }}{{ lang }}/operations/system-tables/query_log).


If you use a {{ PG }} MDB as a data source, check the [performance analysis]({{ link-docs }}/tutorials/dataplatform/mpg-profiling).


{% endnote %}


{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
