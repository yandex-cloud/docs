# Expanding a cluster

You can expand a {{ mgp-name }} cluster by adding segment hosts to it. You need to add at least two hosts. You can also increase the [number of segments per host](../concepts/index.md).

When a cluster is being expanded, its data is automatically redistributed evenly across all hosts in the cluster (including added hosts). To learn more, see [{#T}](../concepts/expand.md).

## Expanding a cluster {#add-hosts}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select a cluster and open the ![hosts-edit](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.action_expand-open }}** in the top-right corner.
    1. Specify cluster expansion settings:

        * **{{ ui-key.yacloud.greenplum.field_expand-segment-host-count }}**: Number of segment hosts to expand the cluster by.

            {% include [mgp-expand-setting-host-count](../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-add-segments-per-host-count }}**: Number of segments added per host.

            {% include [setting-segment-count](../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-close-cluster }}**: [Closing the cluster for access](../concepts/expand.md#setting-close-cluster).

            If this setting is enabled, you cannot connect to the cluster and it receives no new user requests. This will accelerate cluster expansion.
            
            {% include [close-and-delay-warning](../../_includes/mdb/mgp/expand/close-and-delay-warning.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-delay-redistribution }}**: [Using background data redistribution](../concepts/expand.md#setting-delay-redistribution).

            * If background mode is disabled, the redistribution process will be run once as soon as the cluster expansion preparation is over.

                {% include [updating-long](../../_includes/mdb/mgp/expand/updating-long.md) %}

                {% note warning %}

                {% include [manual-redistribution](../../_includes/mdb/mgp/expand/manual-redistribution.md) %}

                {% endnote %}

            * If background mode is enabled, the redistribution process will be delayed. The process will run on a schedule as a [routine maintenance operation](../concepts/maintenance.md#regular-ops).

                {% include [updating-short](../../_includes/mdb/mgp/expand/updating-short.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-duration }}**: [Timeout (in seconds), after which the data redistribution process will be interrupted](../concepts/expand.md#setting-duration).

            {% include [setting-expand-duration](../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-parallel }}**: [Number of threads that will be started during the data redistribution process](../concepts/expand.md#setting-parallel).

            {% include [setting-expand-parallel](../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

    1. Click **{{ ui-key.yacloud.greenplum.action_expand-start }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To expand a cluster:

    1. View the description of the CLI cluster expand command:

        ```bash
        {{ yc-mdb-gp }} cluster expand --help
        ```

    1. To expand a cluster, run this command:

        ```bash
        {{ yc-mdb-gp }} cluster expand <cluster_name_or_ID> \
           --segment-host-count <number_of_added_segment_hosts> \
           --add-segments-per-host-count <number_of_added_segments_per_host> \
           --close-cluster <temporary_ban_on_connection_to_cluster> \
           --delay-redistribution <background_data_redistribution> \
           --duration-seconds <data_redistribution_timeout> \
           --parallel <number_of_data_redistribution_threads>
        ```

        Where:

        * `--segment-host-count`: Number of segment hosts to expand the cluster by.

            {% include [mgp-expand-setting-host-count](../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * `--add-segments-per-host-count`: Number of segments added per host.

            {% include [setting-segment-count](../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `--close-cluster`: [Closing the cluster for access](../concepts/expand.md#setting-close-cluster): `true` or `false`.

            {% include [setting-close-cluster](../../_includes/mdb/mgp/expand/setting-close-cluster.md) %}

        * `--delay-redistribution`: [Using background data redistribution](../concepts/expand.md#setting-delay-redistribution): `true` or `false`.

            {% include [setting-delay-redistribution](../../_includes/mdb/mgp/expand/setting-delay-redistribution.md) %}

        * `--duration-seconds`: [Timeout (in seconds), after which the data redistribution process will be interrupted](../concepts/expand.md#setting-duration).

            {% include [setting-expand-duration](../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * `--parallel`: [Number of threads that will be started during the data redistribution process](../concepts/expand.md#setting-parallel).

            {% include [setting-expand-parallel](../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

        You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Expand](../api-ref/Cluster/expand.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/expand' \
            --data '{
                      "segmentHostCount": "<number_of_added_segment_hosts>",
                      "addSegmentsPerHostCount": "<number_of_added_segments_per_host>",
                      "duration": "<data_redistribution_timeout>",
                      "parallel": "<number_of_data_redistribution_threads>",
                      "closeCluster": "<temporary_ban_on_connection_to_cluster>",
                      "delayRedistribution": "<background_data_redistribution>"
                    }'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        Request body parameters:

        * `segmentHostCount`: Number of segment hosts to expand the cluster by.

            {% include [mgp-expand-setting-host-count](../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * `addSegmentsPerHostCount`: Number of segments added per host.

            {% include [setting-segment-count](../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `duration`: [Timeout](../concepts/expand.md#setting-duration) (in seconds), after which the data redistribution process will be interrupted.

            {% include [setting-expand-duration](../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * `parallel`: [Number of threads](../concepts/expand.md#setting-parallel) that will be started during the data redistribution process.

            {% include [setting-expand-parallel](../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

        * `closeCluster`: [Closing the cluster](../concepts/expand.md#setting-close-cluster) for access, `true` or `false`.

            {% include [setting-close-cluster](../../_includes/mdb/mgp/expand/setting-close-cluster.md) %}

        * `delayRedistribution`: [Using background data redistribution](../concepts/expand.md#setting-delay-redistribution), `true` or `false`.

            {% include [setting-delay-redistribution](../../_includes/mdb/mgp/expand/setting-delay-redistribution.md) %}

    1. View the [server response](../api-ref/Cluster/expand.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Expand](../api-ref/grpc/Cluster/expand.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "segment_host_count": "<number_of_added_segment_hosts>",
                  "add_segments_per_host_count": "<number_of_added_segments_per_host>",
                  "duration": "<data_redistribution_timeout>",
                  "parallel": "<number_of_data_redistribution_threads>",
                  "close_cluster": "<temporary_ban_on_connection_to_cluster>",
                  "delay_redistribution": "<background_data_redistribution>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Expand
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        Request body parameters:

        * `segment_host_count`: Number of segment hosts to expand the cluster by.

            {% include [mgp-expand-setting-host-count](../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * `add_segments_per_host_count`: Number of segments added per host.

            {% include [setting-segment-count](../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `duration`: [Timeout](../concepts/expand.md#setting-duration) (in seconds), after which the data redistribution process will be interrupted.

            {% include [setting-expand-duration](../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * `parallel`: [Number of threads](../concepts/expand.md#setting-parallel) that will be started during the data redistribution process.

            {% include [setting-expand-parallel](../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

        * `close_cluster`: [Closing the cluster](../concepts/expand.md#setting-close-cluster) for access, `true` or `false`.

            {% include [setting-close-cluster](../../_includes/mdb/mgp/expand/setting-close-cluster.md) %}

        * `delay_redistribution`: [Using background data redistribution](../concepts/expand.md#setting-delay-redistribution), `true` or `false`.

            {% include [setting-delay-redistribution](../../_includes/mdb/mgp/expand/setting-delay-redistribution.md) %}

    1. View the [server response](../api-ref/Cluster/expand.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Data redistribution monitoring {#redistribute-monitoring}

There are several ways to monitor the [data redistribution process](../concepts/expand.md#redistribution):

* If the cluster is [closed from load](../concepts/expand.md#setting-close-cluster) and [background data redistribution](../concepts/expand.md#setting-delay-redistribution) is disabled, you can only track progress using {{ yandex-cloud }} monitoring tools.

    [Follow](monitoring.md#monitoring-cluster) the **Expansion progress** chart on the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab of the cluster management page or look up the `gp_expand.*` [metrics](../metrics.md#managed-greenplum-expand-metrics) using [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

* If the cluster is not closed from load, you can also run SQL queries to the `gpexpand` data schema objects.

    {% include [gpexpand-schema-availability](../../_includes/mdb/mgp/expand/gpexpand-schema-availability.md) %}

    To track the progress of the data redistribution process using SQL queries:

    1. [Connect](connect.md) to the `postgres` database as a user with the `mdb_admin` [role](../concepts/cluster-users.md#mdb_admin).
    1. Run a query to get the current status of the process:

        {% include [sql-redistribution-status](../../_includes/mdb/mgp/expand/sql-redistribution-status.md) %}

    The query result will contain [various information]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-system_catalogs-gp_expansion_tables.html) about the progress of the data redistribution process. The `status` column will indicate the current processing status of specific tables:

    * `NOT STARTED`: Table data redistribution is scheduled, the table is in the redistribution queue.

        If the cluster is not [closed from load](../concepts/expand.md#setting-close-cluster), [you can influence the table priority](#table-priority) to change its position in the queue if needed.

    * `IN PROGRESS`: Table data redistribution is in progress.
    * `COMPLETED`: Table data redistribution is completed.
    * `NO LONGER EXISTS`: Table no longer exists.

## Additional actions {#additional-actions}

### Changing table redistribution priority {#table-priority}

During the [cluster expansion preparation](../concepts/expand.md#preparation) phase, each table is assigned a rank that affects its redistribution queue priority. The higher its rank, the higher the table's queue priority and, therefore, the faster its data redistribution will be completed.

If you need to, you can change the rank for one or more tables provided the cluster is [not closed from load](../concepts/expand.md#setting-close-cluster). To do this, you must modify the table in the `gpexpand` data schema.

{% include [gpexpand-schema-availability](../../_includes/mdb/mgp/expand/gpexpand-schema-availability.md) %}

To change the rank of redistributed tables:

1. [Connect](connect.md) to the `postgres` database as a user with the `mdb_admin` [role](../concepts/cluster-users.md#mdb_admin).

1. Run a query to get the current status of the data redistribution process:

    {% include [sql-redistribution-status](../../_includes/mdb/mgp/expand/sql-redistribution-status.md) %}

    This will include full table names (`fq_name`) and their ranks (`rank`).

1. Change the rank for one or more tables:

    ```sql
    UPDATE gpexpand.status_detail
    SET rank=<required_rank>
    WHERE fq_name IN (<list_of_full_table_names>);
    ```

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-expand-expand-redistribute.html#ranking-tables-for-redistribution).

### Running data redistribution manually {#start-redistribute}

If [background data redistribution](../concepts/expand.md#setting-delay-redistribution) was not used during cluster expansion and the [data redistribution process timeout](../concepts/expand.md#setting-duration) setting was not long enough, the process may end before data redistribution is over for all tables.

This will leave some of the data distributed unevenly. As a result, the `Unknown error: Partially Distributed Data` error will occur in [cluster logs](cluster-logs.md). To fix the error, run data redistribution manually:

1. Learn the total number of segments in the cluster:

    1. [Get detailed information about a cluster](cluster-list.md#get-cluster).
    1. Multiply the number of segments per host by the number of segment hosts.

1. [Connect](connect.md) to the database as a user with the `mdb_admin` [role](../concepts/cluster-users.md#mdb_admin).

1. Find tables with unevenly distributed data:

    ```sql
    SELECT *
        FROM
            (SELECT oid, relname FROM pg_class) pgc
            JOIN
            (SELECT localoid AS oid, numsegments FROM gp_distribution_policy) gpdp
            USING (oid)
        WHERE numsegments != <total_number_of_segments>;
    ```

    A list of tables will be displayed stating the following for each table:
    * `oid`: Table ID.
    * `relname`: Table name.
    * `numsegment`: Number of segments storing the data.

    For more information, see the {{ GP }} documentation on the [gp_distribution_policy]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-system_catalogs-gp_distribution_policy.html) table.

1. Run data redistribution using the information you got earlier.

    To redistribute data of an individual table, run the following request:

    * For an ordinary table:

        ```sql
        ALTER TABLE ONLY <table_name> EXPAND TABLE;
        ```

    * For a partitioned table:

        ```sql
        ALTER TABLE <table_name>
        SET WITH (REORGANIZE=true) <distribution_policy>;
        ```

        To learn the {{ GP }} distribution policy value for an individual table partition, run the following query:

        ```sql
        SELECT pg_get_table_distributedby(<partition_OID>) AS distribution_policy;
        ```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
