# Performance diagnostics in {{ mmg-name }}

{{ mmg-name }} provides a built-in tool for DBMS cluster performance diagnostics. Use it to analyze [{{ MG }} profiling](#get-profiling) and [index](#get-indexes) metrics.

{% note warning %}


This feature is at the [Preview stage](../../overview/concepts/launch-stages.md).


{% endnote %}

## Enabling statistics collection {#activate-stats-collector}

To use the diagnostics tool, enable statistics collection when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings). By default, statistics are only collected for queries longer than 300 ms. If required, in [DBMS settings](update.md#change-mongod-config), change the time threshold for collecting slow query statistics in the `slowOpThreshold` [parameter](../concepts/settings-list.md#setting-slow-op-threshold).

## Getting profiling data {#get-profiling}

For read/write and some other DB queries (such as `aggregate`), you can view the data collected by the [{{ MG }} profiler](tools.md#explore-profiler):

- A chart with metrics for the selected data segment. You can hide or show individual categories in the chart by clicking on the category name in the chart legend.
- Table with statistics by query type.

To get data:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mongodb.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_profiling }}** tab.
1. Specify the time interval and, if necessary, set filters.
1. Select:

   * Data segment:
       * `FORM`: By query type
       * `HOSTNAME`: By shard [PRIMARY host](../concepts/replication.md)
       * `NAMESPACE`: By collection name
       * `SHARD`: By [shard](../concepts/sharding.md)
       * `USER`: By user
   * Data grouping parameter:
       * `COUNT`: Number of queries.
       * `DOCUMENTS_EXAMINED`: Number of the collection documents scanned when executing the query.
       * `DOCUMENTS_RETURNED`: Number of returned documents.
       * `DURATION`: Query execution duration.
       * `KEYS_EXAMINED`: Number of index keys scanned when executing the query.
       * `RESPONSE_LENGTH`: Size of the document returned as a result of the query.
   * Aggregation function of the selected parameter:
       * `AVG`: Average value
       * `SUM`: Sum

For more information about what statistics you can get, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/database-profiler/#output-reference).

## Getting information about indexes {#get-indexes}

You can get collection access statistics for queries and recommendations for creating indexes of certain fields to speed up query processing.

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mongodb.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_indexes }}** tab.
1. Specify the time interval and, if necessary, set filters.

The table shows the fields to create indexes for and the number of times the collections were queried.
