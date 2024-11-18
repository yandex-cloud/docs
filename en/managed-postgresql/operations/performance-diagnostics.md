# Performance diagnostics in {{ mpg-name }}

{{ mpg-name }} provides a built-in tool for DBMS cluster performance diagnostics. Use it to analyze {{ PG }} performance metrics for [sessions](#get-sessions) and [queries](#get-queries).

For information on how to identify and troubleshoot cluster performance problems, see the [Performance analysis and optimization](../tutorials/profiling.md) and [Searching for cluster performance issues](../tutorials/performance-problems.md) sections.

## Enabling statistics collection {#activate-stats-collector}

{% list tabs %}

- Management console {#console}

    Enable the **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings) (the option is disabled by default).

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable statistics collection, provide the `--performance-diagnostics` parameter in the update cluster command:

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

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To enable statistics collection when creating a cluster:

     1. Use the [Cluster.create](../api-ref/Cluster/create.md) method and add the `configSpec.performanceDiagnostics` parameter to the [cURL command for cluster creation](cluster-create.md#create-cluster):

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters' \
          --data '{
                    "configSpec": {
                      "performanceDiagnostics": {
                        "enabled": <activate_statistics_collection:_true_or_false>,
                        "sessionsSamplingInterval": "<session_sampling_interval>",
                        "statementsSamplingInterval": "<statement_sampling_interval>"
                      },
                      ...
                    },
                    ...
                  }'
        ```

        Where `configSpec.performanceDiagnostics` represents the statistics settings:

        * `enabled`: Enables statistics collection.
        * `sessionsSamplingInterval`: Session sampling interval. The possible values range from `1` to `86400`.
        * `statementsSamplingInterval`: Statement sampling interval. The possible values range from `60` to `86400`.

     1. View the [server response](../api-ref/Cluster/create.md#responses) to make sure the request was successful.

  1. To enable statistics collection when updating an existing cluster:

     1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.performanceDiagnostics",
                    "configSpec": {
                      "performanceDiagnostics": {
                        "enabled": <activate_statistics_collection:_true_or_false>,
                        "sessionsSamplingInterval": "<session_sampling_interval>",
                        "statementsSamplingInterval": "<statement_sampling_interval>"
                      }
                    }
                  }'
        ```

        Where `configSpec.performanceDiagnostics` represents the statistics settings:

        * `enabled`: Enables statistics collection.
        * `sessionsSamplingInterval`: Session sampling interval. The possible values range from `1` to `86400`.
        * `statementsSamplingInterval`: Statement sampling interval. The possible values range from `60` to `86400`.

     1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. To enable statistics collection when creating a cluster:

     1. Use the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) method and add the `config_spec.performance_diagnostics` parameter to the [grpcurl cluster creation command](cluster-create.md#grpc-api):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "config_spec": {
                  "performance_diagnostics": {
                    "enabled": <activate_statistics_collection:_true_or_false>,
                    "sessions_sampling_interval": "<session_sampling_interval>",
                    "statements_sampling_interval": "<statement_sampling_interval>"
                  },
                  ...
                },
                ...
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.ClusterService.Create
        ```

        Where `config_spec.performance_diagnostics` represents the statistics collection settings:

        * `enabled`: Enables statistics collection.
        * `sessions_sampling_interval`: Session sampling interval. The possible values range from `1` to `86400`.
        * `statements_sampling_interval`: Statement sampling interval. The possible values range from `60` to `86400`.

     1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

  1. To enable statistics collection when updating an existing cluster:

     1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.performance_diagnostics"
                  ]
                },
                "config_spec": {
                  "performance_diagnostics": {
                    "enabled": <activate_statistics_collection:_true_or_false>,
                    "sessions_sampling_interval": "<session_sampling_interval>",
                    "statements_sampling_interval": "<statement_sampling_interval>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.ClusterService.Update
        ```

        Where `config_spec.performance_diagnostics` represents the statistics collection settings:

        * `enabled`: Enables statistics collection.
        * `sessions_sampling_interval`: Session sampling interval. The possible values range from `1` to `86400`.
        * `statements_sampling_interval`: Statement sampling interval. The possible values range from `60` to `86400`.

     1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Getting session statistics {#get-sessions}

{% list tabs %}

- Management console {#console}

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

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [PerformanceDiagnosticsService/ListRawSessionStates](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/perf_diag_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "from_time": "<time_range_left_boundary>",
             "to_time": "<time_range_right_boundary>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.PerformanceDiagnosticsService.ListRawSessionStates
     ```

     Where:

     * `from_time`: Left boundary of a time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
     * `to_time`: Right boundary of a time range, the format is the same as for `from_time`.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse) to make sure the request was successful.

{% endlist %}

For more information about what statistics you can get, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Getting query statistics {#get-queries}

{% list tabs %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}** tab.

    To view the query statistics for a specific time interval:

    1. Select the time interval you need.
    1. (Optional) Set filters.

    To get information about the relative change in the query statistics:

    1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-first }}** field, select the time interval to be used as a calculation basis for statistics.
    1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-second }}** field, select the time interval to compare the statistics for interval 1 with.
    1. (Optional) Set filters.

    Let’s assume, 10 `SELECT * FROM cities` queries were made in the first interval and 20 in the second. When comparing statistics, the difference by the <q>number of queries</q> metric (the `Calls` column in the table) will be `+100%`.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [PerformanceDiagnosticsService/ListRawSessionStates](../api-ref/grpc/PerformanceDiagnostics/listRawStatements.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/perf_diag_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "from_time": "<time_range_left_boundary>",
             "to_time": "<time_range_right_boundary>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.PerformanceDiagnosticsService.ListRawStatements
     ```

     Where:

     * `from_time`: Left boundary of a time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
     * `to_time`: Right boundary of a time range, the format is the same as for `from_time`.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/PerformanceDiagnostics/listRawStatements.md#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse) to make sure the request was successful.

{% endlist %}

You can learn more about what statistics you can get in the [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6) and [pg_stat_kcache](https://pgstats.dev/pg_stat_kcache) extensions documentation.

## Getting information about query execution plans {#auto-explain-enable}

The [`auto_explain` module](https://www.postgresql.org/docs/current/auto-explain.html) allows you to log execution plans for slow queries automatically, without the [`EXPLAIN` command](https://www.postgresql.org/docs/current/sql-explain.html). This is useful for tracking non-optimized queries. This logging feature uses the general {{ PG }} log.

To enable query logging, [change the DBMS settings](update.md#change-postgresql-config):

1. Use the **Shared preload libraries** field to select the `auto_explain` option.
1. Enable the **Auto explain log analyze** setting.
1. Specify the `auto_explain` module settings:

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
