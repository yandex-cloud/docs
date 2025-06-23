#### Limits {#yq-limits}

Type of limitation | Value
--- | ---
Maximum query result retention time | 24 hours
Maximum streaming query runtime (preview stage) | 7 days
Maximum analytical query duration | 24 hours
Maximum query execution results size | 20 MB

#### Quotas {#yq-quotas}

#|
|| Type of limitation | Value ||
|| Number of concurrent analytical queries
`yq.analyticsQuery.count` | 100 ||
|| Number of concurrent streaming queries
`yq.streamingQuery.count` | 100 ||
|| Maximum analytical query duration
`yq.analyticsQueryDurationMinutes.count` | 30 minutes ||
|#

{% note warning %}

The maximum streaming query runtime (preview stage) is 7 days. Once expired, the query is forced to stop. To run streaming queries for an unlimited time, contact {{ yandex-cloud }} support.

{% endnote %}
