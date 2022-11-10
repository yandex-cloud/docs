#### Limits {#yds-limits}

| Type of limit | Value |
--- | ---
| Maximum query execution results storage time | 24 hours |
| Maximum streaming query runtime (at the preview stage) | 7 days |
| Maximum analytical query runtime | 24 hours |


#### Quotas {#yds-quotas}

| Type of limit | Value |
--- | ---
| Maximum query execution results size | 20 MB |
| Number of concurrent analytical queries | 100 |
| Number of concurrent streaming queries | 100 |
| Maximum analytical query duration | 30 minutes |
| Number of vCPUs allocated for running queries | 20 |

{% note warning %}

The maximum runtime of a streaming query (at the preview stage) is 7 days. Once expired, the query is forcibly stopped. To run streaming queries for an unlimited time, contact {{ yandex-cloud }} support.

{% endnote %}