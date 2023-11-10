# Performance diagnostics in {{ mpg-name }}

{{ mpg-name }} provides a built-in tool for DBMS cluster performance diagnostics. Use it to analyze {{ PG }} performance metrics for [sessions](#get-sessions) and [queries](#get-queries).

## Enabling statistics collection {#activate-stats-collector}

{% list tabs %}

- Management console

   Enable the **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings) (the option is disabled by default).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To enable statistics collection, pass the `--performance-diagnostics` parameter in the update cluster command:

   ```bash
   {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
       ...
       --performance-diagnostics enabled=true,`
                                `sessions-sampling-interval=<session_sampling_interval>,`
                                `statements-sampling-interval=<statement_sampling_interval> \
       ...
   ```

   Acceptable parameter values include:

   - `sessions-sampling-interval`: Between `1` and `86400` seconds.
   - `statements-sampling-interval`: Between `60` and `86400` seconds.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To enable statistics collection, use the [create](../api-ref/Cluster/create.md) or [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) or [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID for the `clusterId` parameter.

      You can get the ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   * `True` value for the `config.performanceDiagnostics.enabled` parameter.
   * Sessions sampling interval for the `config.performanceDiagnostics.sessionsSamplingInterval` parameter. Acceptable values are between `1` and `86400` seconds.
   * Statements sampling interval for the `config.performanceDiagnostics.statementsSamplingInterval` parameter. Acceptable values are between `60` and `86400` seconds.
   * List of cluster configuration fields to be changed for the `updateMask` parameter.

   {% note warning %}

   This API method resets any cluster settings that are not provided explicitly in the request to their defaults. To avoid this, make sure to provide the names of the fields to be changed in the `updateMask` parameter.

   {% endnote %}

{% endlist %}

## Getting session statistics {#get-sessions}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}** tab.

   To view session statistics:

   1. Specify the required time interval.
   1. (Optional) Set filters.
   1. Select the required data segment.

   To show or hide individual categories, click the category name in the chart legend.

   To view the history of queries run during a session:

   1. Specify the required time interval.
   1. (Optional) Set filters.

- API

   To get statistics for sessions, use the [PerformanceDiagnosticsService/ListRawSessionStates](../api-ref/grpc/perf_diag_service#ListRawSessionStates) gRPC API call and deliver the following in your request:

   * Cluster ID for the `cluster_id` parameter.

      You can get the ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   * Period your request data for:

      * `from_time`: Period start
      * `to_time`: Period end

   * [Pagination](../../api-design-guide/concepts/pagination.md) parameters:

      * `page_size`: Maximum number of results per page.
      * `page_token`: Token of the previous results page used to get the next page.

{% endlist %}

For more information about what statistics you can get, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Getting query statistics {#get-queries}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}** tab.

   To view query statistics for a specific time interval:

   1. Select the time interval you need.
   1. (Optional) Set filters.

   To get information about the relative change in the query statistics:

   1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-first }}** field, select the time interval to be used as a calculation basis for statistics.
   1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-second }}** field, select the time interval to compare the statistics for interval 1 with.
   1. (Optional) Set filters.

   For example, 10 `SELECT * FROM cities` queries were executed in the first interval and 20 in the second. When comparing statistics, the difference by the <q>number of queries</q> metric (the `Calls` column in the table) will be `+100%`.

- API

   To get statistics for queries, use the [PerformanceDiagnosticsService/ListRawStatements](../api-ref/grpc/perf_diag_service#ListRawStatements) gRPC API call and deliver the following in your query:

   * Cluster ID for the `cluster_id` parameter.

      You can get the ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   * Period your request data for:

      * `from_time`: Period start
      * `to_time`: Period end

   * [Pagination](../../api-design-guide/concepts/pagination.md) parameters:

      * `page_size`: Maximum number of results per page.
      * `page_token`: Token of the previous results page used to get the next page.

   {% endlist %}

You can learn more about what statistics you can get in the [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6) and [pg_stat_kcache](https://pgstats.dev/pg_stat_kcache) extensions documentation.

## Getting information about query execution plans {#auto-explain-enable}

[The `auto_explain` module](https://www.postgresql.org/docs/current/auto-explain.html) allows you to log execution plans for slow queries automatically, without the [`EXPLAIN` command](https://www.postgresql.org/docs/current/sql-explain.html). This is useful for tracking non-optimized queries. This logging feature uses the general {{ PG }} log.

To enable query logging, [change the DBMS settings](update.md#change-postgresql-config):

1. Use the **Shared preload libraries** field to select the `auto_explain` option.
1. Enable the **Auto explain log analyze** setting.
1. Define the `auto_explain` module settings:

   {% note warning %}

   Selecting `0` for **Auto explain log min duration** or enabling **Auto explain log timing** can significantly reduce cluster performance.

   {% endnote %}

   * [**Auto explain log buffers**](../concepts/settings-list.md#setting-auto-explain-log-buffers)
   * [**Auto explain log min duration**](../concepts/settings-list.md#setting-auto-explain-log-min-duration)
   * [**Auto explain log nested statements**](../concepts/settings-list.md#setting-auto-explain-log-nested-statements)
   * [**Auto explain log timing**](../concepts/settings-list.md#setting-auto-explain-log-timing)
   * [**Auto explain log triggers**](../concepts/settings-list.md#setting-auto-explain-log-triggers)
   * [**Auto explain log verbose**](../concepts/settings-list.md#setting-auto-explain-log-verbose)
   * [**Auto explain sample rate**](../concepts/settings-list.md#setting-auto-explain-sample-rate)
