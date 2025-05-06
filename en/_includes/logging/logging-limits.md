#### Quotas {#logging-quotas}

| Type of limit | Value |
----- | -----
| Number of custom log groups per cloud | 10 |
| Maximum write speed | 1,000 entries per second |
| Maximum record retention period | 31 days |

There is no guarantee that records will be deleted as soon as the specified retention period expires: they may be deleted later.

#### Limits {#logging-limits}

| Type of limit | Value |
----- | -----
| **Adding records** |
| Maximum number of records per request | 100 |
| Maximum record size | 1.6 MB |
| Maximum `message` size | 0.8 MB |
| Maximum `json-payload` size | 0.8 MB |
| **Reading records** |
| Maximum number of requests per second | 5 |
| **Other restrictions** |
| Minimum record retention period | 1 hour |
| Maximum [filter](../../logging/concepts/filter.md#how-to) length | 1,000 characters |
