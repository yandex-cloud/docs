#### Quotas {#logging-quotas}

#|
|| Type of limitation | Value ||
|| Number of custom log groups per cloud
`logging.groups.count` | 10 ||
|| Maximum write speed
`logging.write.rate` | 1,000 records per second ||
|| Maximum record retention period
`logging.retentionDays.count` | 31 days ||
|#

There is no guarantee that records will be deleted as soon as the specified retention period expires: deletion may occur later.

#### Limits {#logging-limits}

Type of limitation | Value
----- | -----
**Adding records** |
Maximum number of records per request | 100
Maximum record size | 1.6 MB
Maximum `message` size | 0.8 MB
Maximum `json-payload` size | 0.8 MB
**Reading records** |
Maximum number of requests per second | 5
**Other restrictions** |
Minimum record retention period | 1 hour
Maximum [filter](../../logging/concepts/filter.md#how-to) length | 1,000 characters
