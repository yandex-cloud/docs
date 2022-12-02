# Cluster extension

You can add segment hosts to a {{ mgp-name }} cluster. Data is redistributed between existing and added segments. The number of segments to be added must be at least two.

There are two data redistribution types:

* Automatic: After the cluster is updated, a part of the data is transferred to the new segments sequentially for each table. The table is not available for read and write operations during the transfer.
* Manual: Executed after adding new segments during the timeout specified in the settings. Once the timeout is over, it stops.

## Add segment hosts {#add-hosts}

{% list tabs %}

{% if audience == "draft" %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Select the cluster and click **Edit** at the top of the page.
   1. Select the **Segment** tab and change the **Host count** setting.

      You can add a minimum of two segment hosts.

   1. Select the data distribution mode for new segments in the **Data distribution** setting:
      * **Automatic**: The timeout value will be automatically selected based on the cluster configuration and data volume.
      * **Manual**: Specify the data redistribution timeout (in seconds). The minimum value is `0` (do not redistribute data).

{% endif %}

- API

   Use the [expand](../../api-ref/Cluster/expand.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter.
   * The number of added segment hosts in the `segment_host_count` parameter.
   * The number of segments per host in the `add_segments_per_host_count` parameter.
   * The data redistribution timeout (in seconds) in the `duration` parameter. The minimum and default value is `0` (do not redistribute data).

   You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

{% endlist %}

{% note warning %}

The minimum or a low redistribution timeout value can reduce cluster performance. In this case, restart redistribution manually (see the [Example](#redistribute-by-hand)).

{% endnote %}

## Data redistribution monitoring {#redistribute-monitoring}

To monitor data redistribution to the new segments, connect to the `postgres` database and execute the following statement on behalf of the user with the `mdb_admin` role:

```sql
SELECT dbname, fq_name, status, expansion_started, source_bytes FROM gpexpand.status_detail;
```

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

## Example of manual data redistribution {#redistribute-by-hand}

If a redistribution timeout is explicitly specified during {{ GP }} cluster expansion, execute it manually.

* For ordinary tables, execute the statement:

   ```sql
   ALTER TABLE ONLY <table_name> EXPAND TABLE;
   ```

* For partitioned tables, execute the statement:

   ```sql
   ALTER TABLE <table_name> SET WITH (REORGANIZE=true) <distribution_policy>;
   ```

   Where `<distribution_policy>` is a string denoting the {{ GP }} distribution policy for a partition of the selected table. You can obtain it by calling the built-in {{ GP }} function:

   ```sql
   SELECT pg_get_table_distributedby(<partition OID>) AS distribution_policy;
   ```

You can find the tables that were fully redistributed using the statement:

```sql
SELECT * FROM gp_toolkit.gp_skew_coefficients ORDER BY skccoeff DESC;
```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}