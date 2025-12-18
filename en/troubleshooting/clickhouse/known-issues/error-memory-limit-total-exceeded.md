# Fixing the `Exception Memory limit (total) exceeded` error when running a query



## Issue description {#issue-description}

When running a {{ CH }} query, you get this error:

```
DB::Exception: Memory limit (total) exceeded: would use XX.XX GiB (attempt to allocate chunk of ******** bytes), maximum: **.* GiB. (MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

## Solution {#issue-resolution}

This error indicates that the database query size exceeds the user RAM limit. You can increase this limit on the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** tab in your [management console]({{ link-console-main }}) by editing the `max_memory_usage` parameter. 

{% note warning %}

The `max_memory_usage` limit value must not exceed that of `max_server_memory_usage`.

{% endnote %}

If user management via SQL is enabled in the cluster, you can set this parameter:

* At the session level, via `set max_memory_usage`.
* For all users by default, by [creating one settings profile](https://clickhouse.tech/docs/ru/operations/access-rights/#settings-profiles-management).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ mch-full-name }} cluster ID.
1. Database query code.
1. Full text of the error message.