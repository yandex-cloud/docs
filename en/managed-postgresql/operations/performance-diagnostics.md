# Performance diagnostics in {{ mpg-name }}

{{ mpg-name }} provides a built-in tool for diagnosing your database cluster performance. This tool helps you analyze {{ PG }} performance metrics for [sessions](#get-sessions) and [queries](#get-queries).

To learn how to identify and resolve cluster performance issues, see the [Performance analysis and optimization](../tutorials/profiling.md) and [Troubleshooting cluster performance](../tutorials/performance-problems.md) sections.

## Enabling statistics collection {#activate-stats-collector}

{% list tabs %}

- Management console {#console}

    Enable the **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings). This option is disabled by default.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable statistics collection, add the `--performance-diagnostics` option to the cluster update command:

    ```bash
    {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
        ...
        --performance-diagnostics enabled=true,`
                                 `sessions-sampling-interval=<session_sampling_interval>,`
                                 `statements-sampling-interval=<statement_sampling_interval> \
        ...
    ```

    Allowed values:

    - `sessions-sampling-interval`: From `1` to `86400` seconds.
    - `statements-sampling-interval`: From `60` to `86400` seconds.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).

    1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

    1. Check if the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To enable statistics collection when creating a cluster:

     1. Include `configSpec.performanceDiagnostics` option to the [cURL command](cluster-create.md#create-cluster) implementing the [Cluster.Create](../api-ref/Cluster/create.md) method:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters' \
          --data '{
                    "configSpec": {
                      "performanceDiagnostics": {
                        "enabled": <enable_statistics_collection>,
                        "sessionsSamplingInterval": "<session_sampling_interval>",
                        "statementsSamplingInterval": "<statement_sampling_interval>"
                      },
                      ...
                    },
                    ...
                  }'
        ```

        Where `configSpec.performanceDiagnostics` represents the statistics collection settings:

        * `enabled`: Enables statistics collection, `true` or `false`.
        * `sessionsSamplingInterval`: Session sampling interval. Allowed values range from `1` to `86400`.
        * `statementsSamplingInterval`: Statement sampling interval. Allowed values range from `60` to `86400`.

     1. Check the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  1. To enable statistics collection when updating an existing cluster:

     1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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
                        "enabled": <enable_statistics_collection>,
                        "sessionsSamplingInterval": "<session_sampling_interval>",
                        "statementsSamplingInterval": "<statement_sampling_interval>"
                      }
                    }
                  }'
        ```

        Where `configSpec.performanceDiagnostics` represents the statistics collection settings:

        * `enabled`: Enables statistics collection, `true` or `false`.
        * `sessionsSamplingInterval`: Session sampling interval. Allowed values range from `1` to `86400`.
        * `statementsSamplingInterval`: Statement sampling interval. Allowed values range from `60` to `86400`.

     1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. To enable statistics collection when creating a cluster:

     1. Include the `config_spec.performance_diagnostics` option to the [grpcurl command](cluster-create.md#grpc-api) implementing the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method:

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
                    "enabled": <enable_statistics_collection>,
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

        * `enabled`: Enables statistics collection, `true` or `false`.
        * `sessions_sampling_interval`: Session sampling interval. Allowed values range from `1` to `86400`.
        * `statements_sampling_interval`: Statement sampling interval. Allowed values range from `60` to `86400`.

     1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  1. To enable statistics collection when updating an existing cluster:

     1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                    "enabled": <enable_statistics_collection>,
                    "sessions_sampling_interval": "<session_sampling_interval>",
                    "statements_sampling_interval": "<statement_sampling_interval>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.ClusterService.Update
        ```

        Where `config_spec.performance_diagnostics` represents the statistics collection settings:

        * `enabled`: Enables statistics collection, `true` or `false`.
        * `sessions_sampling_interval`: Session sampling interval. Allowed values range from `1` to `86400`.
        * `statements_sampling_interval`: Statement sampling interval. Allowed values range from `60` to `86400`.

     1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Getting session statistics {#get-sessions}

{% list tabs %}

- Management console {#console}

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}** tab.

    To view session statistics:

    1. Specify the time interval.
    1. Optionally, configure filters.
    1. Select a data segment.

    To show or hide individual categories, click the category name in the chart legend.

    To see the query history within a session:

    1. Specify the required time interval.
    1. Optionally, configure filters.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [PerformanceDiagnosticsService.ListRawSessionStates](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
     * `to_time`: End of the time range in the same format as `from_time`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse) to make sure your request was successful.

{% endlist %}

To learn what statistics you can get, see the [{{ PG }} guides](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Getting query statistics {#get-queries}

{% list tabs %}

- Management console {#console}

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}** tab.

    To view query statistics for a specific time interval:

    1. Select the time interval.
    1. Optionally, configure filters.

    To get details on relative changes in query statistics:

    1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-first }}** field, select the time interval to use as the baseline for calculations.
    1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-second }}** field, select the time interval to compare against the baseline interval.
    1. Optionally, configure filters.

    Suppose, 10 `SELECT * FROM cities` queries were executed in the first interval and 20 in the second. A comparison of the statistics will show a `+100%` difference for the <q>query count</q> metric (the `Calls` table column).

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [PerformanceDiagnosticsService.ListRawStatements](../api-ref/grpc/PerformanceDiagnostics/listRawStatements.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
     * `to_time`: End of the time range in the same format as `from_time`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/PerformanceDiagnostics/listRawStatements.md#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse) to make sure your request was successful.

{% endlist %}

To learn more about available statistics, refer to the [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html) and [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache/blob/master/README.rst) extension guides.

## Getting query execution plan details {#auto-explain-enable}

The [`auto_explain` module](https://www.postgresql.org/docs/current/auto-explain.html) allows you to log slow query execution plans automatically, eliminating the need for the [`EXPLAIN` command](https://www.postgresql.org/docs/current/sql-explain.html). It helps to identify non-optimized queries. This module uses the general {{ PG }} log.

You can enable query logging in the [DBMS settings](update.md#change-postgresql-config):

1. In the **Shared preload libraries** field, select `auto_explain`.
1. Enable **Auto explain log analyze**.
1. Configure the `auto_explain` module settings:

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
