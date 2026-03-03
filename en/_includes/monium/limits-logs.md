#### Quotas {#loggs-quotas}

#|
|| Type of limit | Value ||
|| Log stream size per project | 32,500 Bytes/sec (~31 Kbps) ||
|#

#### Limits {#loggs-limits}

**Data model limits**

Type of limit | Value
--------------- | --------
Maximum number of labels (`labels`) per log entry | 16
Log entry timestamp precision | Nanosecond precision
Maximum size of a single `meta` key value (larger values will be truncated to this limit) | 32 KB

**Query language limits**

Type of limit | Value
--------------- | --------
Maximum number of values per grouping expression/key | 10
Minimum window for calculating a grouping function | 15 seconds
Maximum number of time series resulting from grouping | 10,000