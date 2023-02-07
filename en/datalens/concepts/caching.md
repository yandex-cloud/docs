# Caching

_Cache_ stores frequently requested data and provides quick access to it.

{{ datalens-short-name }} caches the results of the user's query, so when the data in the source changes, dashboards and charts may not be updated immediately.

Default cache lifetime: 5 minute The user can change the cache lifetime in the [connection](../operations/connection/create-clickhouse.md) settings.

{% if audience == "internal" %}

{% note info %}

Some connection types don't support caching (for example, Statface and CH over YT with authentication as a user).

{% endnote %}

For more information about caching in ChartEditor, see [Data sources](../editor/sources/index.md).

{% else %}

## Caching in {{ datalens-public }} {#caching-in-public}

Default cache lifetime: 5 minute The user can change the cache lifetime in the connection settings.

{% endif %}

## Purge cache conditions {#reset-cache}

The cache is purged in the following events:

* Connection replacement.
* SQL query update when generating a dataset.
