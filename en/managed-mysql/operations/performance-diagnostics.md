# Performance diagnostics in {{ mmy-name }}

{{ mmy-name }} has a built-in tool for collecting session and query statistics. These metrics can be useful when [analyzing the performance and optimizing the settings](../tutorials/profiling-mmy.md) of a cluster.

## Enabling statistics collection {#activate-stats-collector}

{% list tabs group=instructions %}

- Management console {#console}

    When [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings):

    1. Enable **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** (disabled by default).
    1. Configure **{{ ui-key.yacloud.mdb.forms.field_diagnostics-sessions-interval }}** and **{{ ui-key.yacloud.mdb.forms.field_diagnostics-statements-interval }}**. The value range is from `1` to `86400` seconds.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable and configure statistics collection, provide the `--performance-diagnostics` parameter in the update cluster command:

    ```bash
    {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
       ...
       --performance-diagnostics enabled=true,`
                                `sessions-sampling-interval=<session_sampling_interval>,`
                                `statements-sampling-interval=<statement_sampling_interval> \
        ...
    ```

    For `sessions-sampling-interval` and `statements-sampling-interval`, possible values range from `1` to `86400` seconds.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

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

        For `sessions_sampling_interval` and `statements_sampling_interval`, possible values range from `1` to `86400` seconds.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

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
                --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters' \
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

            Where `configSpec.performanceDiagnostics` represents the statistics collection settings:

            * `enabled`: Enables statistics collection.
            * `sessionsSamplingInterval`: Session sampling interval, from `1` to `86400` seconds.
            * `statementsSamplingInterval`: Statement sampling interval, from `60` to `86400` seconds.

        1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To enable statistics collection when updating an existing cluster:

        1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
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

            Where `configSpec.performanceDiagnostics` represents the statistics collection settings:

            * `enabled`: Enables statistics collection.
            * `sessionsSamplingInterval`: Session sampling interval, from `1` to `86400` seconds.
            * `statementsSamplingInterval`: Statement sampling interval, from `60` to `86400` seconds.

        1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. To enable statistics collection when creating a cluster:

        1. Use the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) method and add the `config_spec.performance_diagnostics` parameter to the [gRPCurl cluster creation command](cluster-create.md#grpc-api):

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
                yandex.cloud.mdb.mysql.v1.ClusterService.Create
            ```

            Where `config_spec.performance_diagnostics` represents the statistics collection settings:

            * `enabled`: Enables statistics collection.
            * `sessions_sampling_interval`: Session sampling interval, from `1` to `86400` seconds.
            * `statements_sampling_interval`: Statement sampling interval, from `60` to `86400` seconds.

        1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To enable statistics collection when updating an existing cluster:

        1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
                yandex.cloud.mdb.mysql.v1.ClusterService.Update
            ```

            Where `config_spec.performance_diagnostics` represents the statistics collection settings:

            * `enabled`: Enables statistics collection.
            * `sessions_sampling_interval`: Session sampling interval, from `1` to `86400` seconds.
            * `statements_sampling_interval`: Statement sampling interval, from `60` to `86400` seconds.

        1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Getting session statistics {#get-sessions}

1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}** tab.

    To view session statistics or the history of queries executed within a session, select the appropriate tab.

    {% list tabs %}

    - Statistics

        To view session statistics:

        1. Specify the required time interval.
        1. (Optional) Set filters.
        1. Select the required [data segment](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-quick-start.html).

        To show or hide individual categories, click the category name in the chart legend.

    - History

        To view the history of queries run during a session:

        1. Specify the required time interval.
        1. (Optional) Set filters.

    {% endlist %}

## Getting query statistics {#get-queries}

1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}** tab.

    To view query statistics or compare them in two time intervals, select the appropriate tab.

    {% list tabs %}

    - Interval

        To view query statistics:

        1. Select the time interval you need.
        1. (Optional) Set filters.

    - Two intervals

        To get information about the relative change in the query statistics:

        1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-first }}** field, select the time interval to be used as a calculation basis for statistics.
        1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-second }}** field, select the time interval to compare the statistics for interval 1 with.
        1. (Optional) Set filters.

        Let’s assume, 10 `SELECT * FROM cities` queries were made in the first interval and 20 in the second. When comparing statistics, the difference in the <q>number of queries</q> metric (the `Calls` column in the table) will be `+100%`.

    {% endlist %}

### Available metrics {#metrics}

This section lists metrics used to collect query statistics and the associated {{ mmy-name }} metrics in [{{ monitoring-name }}](../../monitoring/).

Statistical metric | Metrica {{ monitoring-name }} | Description
----- | ----- | -----
**Total query latency** | - | Total query execution time
**Total lock latency** | - | Total lock wait time
**Avg query latency** | `mysql_latency_query_avg`<br/>`DGAUGE`, milliseconds | Average query execution time
**Avg lock latency** | - | Average lock wait time
**Rows examined** | - | Number of rows read
**Calls** | - | Number of database calls
**Rows sent** | - | Number of rows returned
**Rows affected** | - | Number of rows changed, deleted, added, or returned
**Tmp tables** | `mysql_Created_tmp_tables_rate`<br/>`DGAUGE`, tables per second | Rate of temporary tables created during query processing
**Tmp disk tables** | `mysql_Created_tmp_disk_tables_rate`<br/>`DGAUGE`, tables per second | Rate of temporary tables created on the disk during query processing
**Select full join** | `mysql_Select_full_join_rate`<br/>`DGAUGE`, requests per second | Number of joins using table scans instead of indexes
**Select full range join** | `mysql_Select_full_range_join_rate`<br/>`DGAUGE`, requests per second | Number of joins searching by range in the reference table
**Select range** | - | Number of selections by interval
**Select scan** | - | Number of selections using table scans
**Sort merge passes** | - | Number of sortings by table merge
**Sort range** | `mysql_Sort_range_rate`<br/>`DGAUGE`, requests per second | Number of sortings by range per unit of time
**Sort rows** | `mysql_Sort_rows_rate`<br/>`DGAUGE`, requests per second | Number of rows sorted per unit of time
**Sort scan** | `mysql_Sort_scan_rate`<br/>`DGAUGE`, requests per second | Number of sortings using table scans per unit of time
**No index used** | - | `1` if no index was used for the table scan, `0` otherwise
**No good index used** | - | `1` if no suitable index was found for the query, `0` otherwise
**Errors** | - | Number of query execution errors
**Warnings** | - | Number of query execution warnings

For more information about the statistics you can get, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-events-statements-current-table.html).
