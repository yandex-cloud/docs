# Caching

_Cache_ stores frequently queried data and provides quick access to it.

{% note info %}

{{ datalens-short-name }} cache does not store the source data; it only stores the results of queries for a certain time. To store analytical data marts, you can use, e.g., [{{ mch-full-name }}](../../managed-clickhouse/).

{% endnote %}

{{ datalens-short-name }} caches the results of the user's query, so when the data in the source changes, dashboards and charts may not be updated immediately. The maximum amount of cached data per query is 512 MB.

The default cache lifetime is 300 seconds (5 minutes). The user can change cache lifetime in the [connection](connection.md) settings up to 86,400 seconds (1 day).

## Specifics of using {{ datalens-short-name }} cache {#using}

{{ datalens-short-name }} does not query data stored in the cache. The cache returns only the whole result of the query, which is not used for data aggregation or in subqueries. Query results that differ from each other are cached separately.

If a query uses the [`NOW()`](../function-ref/NOW.md) time function, the value of this function retrieved from the cache may differ from the real time by a value not exceeding the cache lifetime.

If [RLS](../security/row-level-security.md) is used, additional filtering is added to the query. For each RLS rule, their own query will be generated with results cached separately. Identical queries from users with the same RLS rules use the same cache.

{{ datalens-short-name }} caches the results of queries generated using [selectors](../dashboard/selector.md). To reduce the number of DB queries, use the default values in the selectors.


## Caching in public objects {#caching-in-public}

[Public](./datalens-public.md) charts and dashboards benefit from additional caching, so the cache lifetime for them is five minutes or more.


## Cache purge conditions {#reset-cache}

The cache will be purged if:

* Cache lifetime expires.
* Any connection parameters, except names, are updated.
* Dataset fields are updated.
* SQL query is updated in the dataset source.

## Questions and answers {#qa}

{% cut "Can I track it in the Chart inspector whether a query has been cached?" %}

This is not supported yet. However, if you use time functions, such as `NOW()`, you can see the difference between the current real time and the current cached time. By this difference you can understand how current the cached data is.

{% endcut %}

{% cut "Is there a limit on the cache size per query or per user?" %}

The only limit on the amount of data that can be cached per query is the cache storage size which is 512 MB.
There is no cache size limit per user or {{ datalens-short-name }} instance.

{% endcut %}

{% cut "Is caching used in a chart's color selection settings?" %}

Caching will be used if you add to the **Colors** section a field already used to build the chart.
If you add a new field to the **Colors** section, a new query to the source data will be made.

{% endcut %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}