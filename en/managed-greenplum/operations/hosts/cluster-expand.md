# Cluster extension

You can expand a {{ mgp-name }} cluster by adding segment hosts to it. You need to add at least two hosts.

When a cluster is being expanded, its data is automatically redistributed across new segments. This is done for each table in sequence during the timeout specified in the expansion settings. The table is not available for read and write operations during data redistribution.

The `gp_expand` utility is used to expand a cluster. For more information about the utility and its modes of operation, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/admin_guide-expand-expand-planning.html#planning-table-redistribution).

## Add segment hosts {#add-hosts}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Select a cluster and open the ![hosts-edit](../../_assets/../../_assets/mdb/hosts.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click **{{ ui-key.yacloud.greenplum.action_expand-open }}** in the top-right corner.
   1. Specify cluster expansion settings:

      * **{{ ui-key.yacloud.greenplum.field_expand-segment-host-count }}**: Number of segment hosts to add. The minimum value is `2`.
      * **{{ ui-key.yacloud.greenplum.field_expand-add-segments-per-host-count }}**: Number of segments being added per host. The maximum value depends on the host class.
      * **{{ ui-key.yacloud.greenplum.field_expand-duration }}**: Timeout for data redistribution across the new segments, in seconds. For `0` (recommended value), the timeout will be selected automatically based on cluster configuration and the amount of data.
   1. Click **{{ ui-key.yacloud.greenplum.action_expand-start }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add segment hosts to a {{ GP }} cluster:

   1. View the description of the CLI cluster expand command:

      ```bash
      {{ yc-mdb-gp }} cluster expand --help
      ```

   1. Specify the cluster expansion parameters in the command:

      ```bash
      {{ yc-mdb-gp }} cluster expand <cluster_name_or_ID> \
         --segment-host-count <number_of_added_segment_hosts> \
         --add-segments-per-host-count <number_of_segments_added_to_host> \
         --duration-seconds <data_redistribution_timeout_in_seconds>
      ```

      Where:

      * `--segment-host-count`: Number of segment hosts to add. The minimum (default) value is `2`.
      * `--add-segments-per-host-count`: Number of segments added per host. The maximum value depends on the host class. The default value is `0`.
      * `--duration-seconds`: Timeout for data redistribution across the new segments, in seconds. For `0` (recommended value set by default), the timeout will be selected automatically based on cluster configuration and the amount of data.

      You can get the cluster ID and name with a [list of clusters in the folder](../cluster-list.md#list-clusters).

- API

   To add segment hosts, use the [expand](../../api-ref/Cluster/expand.md) REST API method for the [Cluster](../../api-ref/Cluster/index.md) resource or the [ClusterService/Expand](../../api-ref/grpc/cluster_service.md#Expand) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.
   * Number of segment hosts to add in `segmentHostCount`.
   * Number of segments per host to add in `addSegmentsPerHostCount`.
   * The data redistribution timeout (in seconds) in the `duration` parameter. For `0` (recommended value set by default), the timeout will be selected automatically based on cluster configuration and the amount of data.

   You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

{% endlist %}

{% note warning %}

A low redistribution timeout value (less than two hours) may be insufficient to redistribute the data of all cluster tables. In this case, [restart redistribution](#start-redistribute).

{% endnote %}

## Data redistribution monitoring {#redistribute-monitoring}

To monitor data redistribution to the new segments, connect to the `postgres` database and execute the following statement on behalf of the user with the `mdb_admin` role:

```sql
SELECT dbname, fq_name, status, expansion_started, source_bytes FROM gpexpand.status_detail;
```

Result:

```text
  dbname   |               fq_name               |   status    |     expansion_started      | source_bytes
-----------+-------------------------------------+-------------+----------------------------+-------------
 diskquota | diskquota_namespace.database_list   | NOT STARTED |                            |            0
 postgres  | public.rnd_nocomp_distrnd_ao_res3   | NOT STARTED |                            |  52558742480
 postgres  | public.rnd_nocomp_distrnd_ao1       | COMPLETED   | 2022-09-06 12:44:36.71759  |     13013536
 postgres  | public.rnd_nocomp_distrnd_ao_res2   | IN PROGRESS | 2022-09-06 13:03:29.231359 |  63070490912
(4 rows)
```

The current redistribution status will be specified in the `status` column.

## Table redistribution priority {#table-priority}

To specify the tables whose data should be redistributed first of all, increase their priority. To do this, connect to the `postgres` database and run the following query as the user with the `mdb_admin` role:

```sql
UPDATE gpexpand.status_detail SET rank=1 WHERE fq_name IN (<table_list>);
```

## Starting data redistribution {#start-redistribute}

`Unknown error: Partially Distributed Data` in cluster runtime logs means that some table data was not redistributed to all new segments. This may occur if the specified redistribution timeout expired before completing redistribution of data from all tables. To fix this error:

1. Find the tables that were redistributed partially:

   ```sql
   SELECT count(*) FROM gp_distribution_policy WHERE numsegments != <segment_count>;
   ```

   Where `segment_count` is the total number of segments in all {{ GP }} cluster segment hosts.

1. Start data redistribution:

   * For ordinary tables:

      ```sql
      ALTER TABLE ONLY <table_name> EXPAND TABLE;
      ```

   * For partitioned tables:

      ```sql
      ALTER TABLE <table_name> SET WITH (REORGANIZE=true) <distribution_policy>;
      ```

      Where `distribution_policy` is the {{ GP }} distribution policy.

      To get the {{ GP }} distribution policy for the selected table's partition, call the embedded function:

      ```sql
      SELECT pg_get_table_distributedby(<partition_OID>) AS distribution_policy;
      ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
