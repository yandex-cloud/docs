#### Limits {#yq-limits}

Type of limitation | Value
--- | ---
Maximum query result retention time | 24 hours
Maximum streaming query runtime (preview) | 7 days
Maximum analytical query runtime | 24 hours
Maximum query result size | 20 MB

#### Quotas {#yq-quotas}

#|
|| Type of limitation | Value ||
|| Maximum concurrent analytical queries
`yq.analyticsQuery.count` | 100 ||
|| Maximum concurrent streaming queries
`yq.streamingQuery.count` | 100 ||
|| Maximum analytical query runtime
`yq.analyticsQueryDurationMinutes.count` | 30 minutes ||
|#

{% note warning %}

In preview, the maximum streaming query runtime is 7 days, after which the query is forcibly terminated. If you need to run streaming queries without time limits, contact {{ yandex-cloud }} support.

{% endnote %}
