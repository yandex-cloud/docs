# Caching

_Cache_ stores frequently requested data and provides quick access to it.

{{ datalens-short-name }} caches the results of the user's query, so when the data in the source changes, dashboards and charts may not be updated immediately.

{% if audience == "internal" %}

Default cache lifetime: 5 minute 

{% else %}

The default cache lifetime depends on how the dataset accesses the data source:

* Direct access datasets: 5 minutes.
* Materialized datasets: 60 minutes with auto-renewal.
  Example of auto-renewal: after the first user request, the data was written to the cache for 60 minutes. After 50 minutes, with a new request, the data is retrieved from the cache, and the cache lifetime becomes 60 minutes.

{% endif %}

The user can change the cache lifetime in the [connection](../operations/connection/create-clickhouse.md) settings.

{% if audience == "internal" %}

{% note info %}

Some connection types don't support caching (for example, Statface and CH over YT with authentication as a user).

{% endnote %}

For more information about caching in ChartEditor, see [Data sources](../editor/sources/index.md).

{% else %}

## Caching in {{ datalens-public }} {#caching-in-public}

The default cache lifetime depends on how the dataset accesses the data source:
* Direct access datasets: 5 minutes.
* Materialized datasets: 6 hours with auto-renewal.
   Example of auto-renewal: After the first user request, the data was written to the cache for 6 hours. After 5 hours 50 minutes, a new request is sent, the data is retrieved from the cache, and the cache lifetime becomes 6 hours.

The user can change the cache lifetime in the connection settings.

{% endif %}

## Purge cache conditions {#reset-cache}

The cache is purged in the following events:   
{% if audience != "internal" %} * Re-materialization. {% endif %}
* Connection replacement.
* SQL query update when generating a dataset.