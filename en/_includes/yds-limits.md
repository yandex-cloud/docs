#### Quotas {#yds-quotas}

#|
|| Type of limit | Value ||
|| Maximum number of data transmission streams | 10 ||
|| Maximum data retention period for a data stream| 24 hours ||
|#

#### Limits {#yds-limits}

Type of limit | Value
--- | ---
Maximum data write requests per second for a single data stream segment | 1,000 RPS
Maximum data write speed for a single segment | 1 MB/s
Maximum single-segment data read speed for all standard consumers | 2 MB/s
Maximum number of dedicated data consumers per data stream | 5 consumers
Number of shards in a {{ ydb-short-name }} serverless database | 100
