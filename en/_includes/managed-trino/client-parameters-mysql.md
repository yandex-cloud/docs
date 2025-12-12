{% cut "Available parameters" %}

* `connectTimeout`: Maximum {{ MY }} connection timeout, in milliseconds.
* `socketTimeout`: Maximum socket operation timeout, in milliseconds.
* `connectionTimeZone`: Time zone used by {{ MY }}, e.g., `UTC` or `Europe/Moscow`.
* `serverTimezone`: Time zone used by {{ MY }}, e.g., `UTC` or `Europe/Moscow`.

   {% note info %}
   
   This parameter is deprecated, use `connectionTimeZone`.
   
   {% endnote %}

* `autoReconnect`: Automatic reconnection, `true` or `false`.
* `maxReconnects`: Maximum number of connection retry attempts.
* `useCompression`: Data compression, `true` or `false`.
* `cachePrepStmts`: Caching of prepared queries, `true` or `false`.
* `prepStmtCacheSize`: Maximum number of prepared queries stored in cache.
* `prepStmtCacheSqlLimit`: Maximum number of characters per prepared query that can be cached.

{% endcut %}
