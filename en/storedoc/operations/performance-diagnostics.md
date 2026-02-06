# Performance diagnostics in {{ mmg-name }}

{{ mmg-name }} provides a built-in tool for diagnosing your database cluster performance. You can use it to analyze [{{ SD }} profiling](#get-profiling) and [index](#get-indexes) metrics.

{% note warning %}


This feature is in [Preview](../../overview/concepts/launch-stages.md).


{% endnote %}

## Enabling statistics collection {#activate-stats-collector}

To use this diagnostic tool, enable statistics collection during cluster [creation](cluster-create.md) or [update](update.md#change-additional-settings). By default, the system only collects statistics for queries longer than 300 ms. If necessary, change the slow query collection threshold by adjusting the `slowOpThreshold` [setting](../concepts/settings-list.md#setting-slow-op-threshold) in your [database configuration](update.md#change-mongod-config).

## Getting profiling data {#get-profiling}

For read, write, and other database queries, such as `aggregate` operations, you can view the data collected by the [{{ SD }} profiler](tools.md#explore-profiler):

- Chart with metrics for the selected data slice. You can toggle individual categories in the chart by clicking the category name in the chart legend.
- Table with statistics broken down by query type.

To get this data:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
1. Click the name of your cluster and select **{{ ui-key.yacloud.mongodb.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_profiling }}**.
1. Specify a time range and adjust filters as needed.
1. Select:

   * Data segment:
       * `FORM`: By query type
       * `HOSTNAME`: By shard’s [primary host](../concepts/replication.md)
       * `NAMESPACE`: By collection name
       * `SHARD`: By [shard](../concepts/sharding.md)
       * `USER`: By user
   * Data grouping:
       * `COUNT`: Number of queries.
       * `DOCUMENTS_EXAMINED`: Number of collection documents scanned per query.
       * `DOCUMENTS_RETURNED`: Number of returned documents.
       * `DURATION`: Query execution duration.
       * `KEYS_EXAMINED`: Number of index keys scanned per query.
       * `RESPONSE_LENGTH`: Size of the document returned by the query.
   * Aggregation function for the selected metric:
       * `AVG`: Average
       * `SUM`: Sum
   

## Getting information about indexes {#get-indexes}

The system provides collection access statistics and indexing recommendations for specific fields to improve query speed.

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
1. Click the name of your cluster and select **{{ ui-key.yacloud.mongodb.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_indexes }}**.
1. Specify a time range and adjust filters as needed.

The table shows recommended index fields and collection access counts.
