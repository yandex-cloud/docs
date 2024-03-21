# Performance diagnostics in {{ mmy-name }}

{{ mmy-name }} has a built-in tool for collecting session and query statistics. These metrics can be useful when [analyzing the performance and optimizing the settings](../tutorials/profiling-mmy.md) of a cluster.

## Enabling statistics collection {#activate-stats-collector}

{% list tabs group=instructions %}

- Management console {#console}

   When [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings):

   1. Enable **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** (disabled by default).
   1. Configure **{{ ui-key.yacloud.mdb.forms.field_diagnostics-sessions-interval }}** and **{{ ui-key.yacloud.mdb.forms.field_diagnostics-statements-interval }}**. The values may range from `1` to `86400` seconds.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To enable and configure statistics collection, specify the `--performance-diagnostics` parameter in the update cluster command:

   ```bash
   {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
      ...
      --performance-diagnostics enabled=true,`
                               `sessions-sampling-interval=<session_sampling_interval>,`
                               `statements-sampling-interval=<statement_sampling_interval> \
       ...
   ```

   The values of the `sessions-sampling-interval` and the `statements-sampling-interval` parameters may range from `1` to `86400` seconds.

* {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To enable and configure statistics collection, add the `performance_diagnostics` section to the cluster configuration:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        performance_diagnostics {
          enabled = true
          sessions_sampling_interval = <session_sampling_interval>
          statements_sampling_interval = <statement_sampling_interval>
        }
        ...
      }
      ```

      The values of the `sessions_sampling_interval` and the `statements_sampling_interval` parameters may range from `1` to `86400` seconds.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

   To enable statistics collection, use the [create](../api-ref/Cluster/create.md) or [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) or [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get the ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * `true` value in the `configSpec.performanceDiagnostics.enabled` parameter.
   * Sessions sampling interval in the `configSpec.performanceDiagnostics.sessionsSamplingInterval` parameter. Acceptable values are between `1` and `86400` seconds.
   * Statement sampling interval in the `configSpec.performanceDiagnostics.statementsSamplingInterval` parameter. Acceptable values are between `1` and `86400` seconds.
   * List of fields to update in the `updateMask` parameter.

   {% note warning %}

   This API method resets any cluster settings that are not provided explicitly in the request to their defaults. To avoid this, make sure to provide the names of the fields to be changed in the `updateMask` parameter.

   {% endnote %}

{% endlist %}

## Getting session statistics {#get-sessions}

1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}** tab.

   To view session statistics or the history of queries executed within a session, select the appropriate tab.

   {% list tabs %}

   * Statistics

      To view session statistics:

      1. Specify the required time interval.
      1. (Optional) Set filters.
      1. Select the desired [data segment](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-quick-start.html).

      To show or hide individual categories, click the category name in the chart legend.

   * History

      To view the history of queries run during a session:

      1. Specify the required time interval.
      1. (Optional) Set filters.

   {% endlist %}


## Getting query statistics {#get-queries}

1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}** tab.

   To view query statistics or compare them in two time intervals, select the appropriate tab.

   {% list tabs %}

   * Interval

      To view query statistics:

      1. Select the time interval you need.
      1. (Optional) Set filters.

   * Two intervals

      To get information about the relative change in the query statistics:

      1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-first }}** field, select the time interval to be used as a calculation basis for statistics.
      1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-second }}** field, select the time interval to compare the statistics for interval 1 with.
      1. (Optional) Set filters.

      For example, 10 `SELECT * FROM cities` queries were executed in the first interval and 20 in the second. When comparing statistics, the difference by the <q>number of queries</q> metric (the `Calls` column in the table) will be `+100%`.

   {% endlist %}

For more information about what statistics you can get, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-quick-start.html).
