# Caching

_Cache_ stores frequently requested data and provides quick access to it.

{{ datalens-short-name }} caches the results of the user's query, so when the data in the source changes, dashboards and charts may not be updated immediately.

Default cache lifetime: 300 seconds (5 minutes). The user can change cache lifetime in the [connection](connection.md) settings up to 86,400 seconds (1 day).


## Caching in public objects {#caching-in-public}

[Public](./datalens-public.md) charts and dashboards benefit from additional caching, so the cache lifetime for them is five minutes or more.


## Purge cache conditions {#reset-cache}

The cache is purged in the following events:

* Cache lifetime expired.
* Connection changed.
* Dataset fields were updated.
* SQL query was updated in the dataset source.
