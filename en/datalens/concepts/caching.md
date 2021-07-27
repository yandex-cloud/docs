---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Caching

_Cache_ stores frequently requested data and provides quick access to it.

{{ datalens-short-name }} caches the results of the user's query, so when the data in the source changes, dashboards and charts may not be updated immediately.

The cache lifetime depends on how the dataset accesses the data source:
* Direct access datasets: 5 minutes.
* Materialized datasets: 60 minutes with auto-renewal.
Example of auto-renewal: after the first user request, the data was written to the cache for 60 minutes. After 50 minutes, with a new request, the data is retrieved from the cache, and the cache lifetime becomes 60 minutes.

## Caching in {{ datalens-public }} {#caching-in-public}

The cache lifetime depends on how the dataset accesses the data source:
* Direct access datasets: 5 minutes.
* Materialized datasets: 6 hours with auto-renewal.
Example of auto-renewal: After the first user request, the data was written to the cache for 6 hours. After 5 hours 50 minutes, a new request is sent, the data is retrieved from the cache, and the cache lifetime becomes 6 hours.

## Purge cache conditions {#reset-cache}

The cache is purged in the following events:
* Re-materialization.
* Connection replacement.
* Update of dataset fields.
* Caching data for chart rendering (5 minutes).