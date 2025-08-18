The metric name goes into the `name` label.

Labels shared by all {{ mtr-name }} metrics: 

Label | Value
----|----
service | Service ID: `managed-trino`
cluster_id | Cluster ID
component | Component type: `coordinator`

## Service metrics {#managed-kafka-metrics}

#|
|| **Name**

**Type, units** | **Description** ||
|| `trino_memory_discoverynodemanager_activenodecount.gauge`<br/>`DGAUGE`, count | Number of cluster hosts ||
|| `trino_memory_clustermemorymanager_totalavailableprocessors.gauge`<br/>`DGAUGE`, count | Number of available CPUs ||
|| `trino_memory_clustermemorypool_freedistributedbytes.gauge`<br/>`DGAUGE`, GB | Available cluster memory ||
|| `trino_execution_querymanager_queries_in_progress.gauge`<br/>`DGAUGE`, count | Queries (in progress).

The additional `status` label may take the following values:
* **Running**: At least one part of the query plan is in progress.
* **Queued**: Query is received and waiting to run.
* **Progressing**: Query is in progress and not blocked.
* **Finishing**: Query is almost complete. ||
|| `trino_execution_querymanager_queries_totalcount.gauge`<br/>`DGAUGE`, count | Queries (by status).

The additional `status` label may take the following values:
* **Submitted**: Received queries.
* **Started**: Queries in progress.
* **Failed**: Queries that resulted in an error.
* **Completed**: Completed queries, including failed ones.
* **Cancelled**: Queries cancelled by the user.
* **Abandoned**: Completed queries with unclaimed results. ||
|| `trino_execution_querymanager_failures_totalcount.gauge`<br/>`DGAUGE`, count | Number of errors.

The additional `error` label may take the following values:
* **UserError**: User-side errors.
* **Internal**: Server-side error.
* **InsufficientResources**: Errors caused by insufficient resources.
* **External**: External errors. ||
|| `trino_execution_querymanager_execution_time_oneminute.gauge`<br/>`DGAUGE`, milliseconds | Percentile of the query execution time with a one minute window.

The additional `quantile` label may take the following values:
* **0.50**.
* **0.75**.
* **0.90**.
* **0.95**.
* **0.99**. ||
|#
