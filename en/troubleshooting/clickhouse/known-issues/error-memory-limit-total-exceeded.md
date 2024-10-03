# Fixing the request execution error: Exception Memory limit (total) exceeded


## Issue description {#issue-description}

When executing a query in ClickHouse, you get this error:

```
DB::Exception: Memory limit (total) exceeded: would use XX.XX GiB (attempt to allocate chunk of XXXXXXXX bytes), maximum: XX.X GiB. (MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

## Solution {#issue-resolution}

This error indicates that the database query size exceeds the user's RAM limit. You can increase it via the UI, on the **Users** tab. You need to change the `max_memory_usage` parameter.

Note that this limit should not exceed the `max_server_memory_usage` parameter.

If user management via SQL is enabled in the cluster, you can set this parameter:

* At the session level, via `set max_memory_usage`
* For all users by default, by [creating one settings profile](https://clickhouse.tech/docs/ru/operations/access-rights/#settings-profiles-management).

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
When creating the request, provide the following information:

1. ID of a Managed Service for Clickhouse cluster
2. Database query code
3. Full text of the error message.