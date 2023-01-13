# Expanding a cluster

You can add segment hosts to a {{ mgp-name }} cluster. Data is redistributed between existing and added segments. You cannot add fewer than two hosts.

The `gp_expand` utility is used to expand a cluster. For more information about the utility and its modes of operation, see the [{{ GP }} documentation](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-admin_guide-expand-expand-planning.html#planning-table-redistribution).

There are two data redistribution types:

* Automatic: After a cluster update, a part of the data is automatically transferred during the timeout specified in the expansion settings to the new segments for each table in sequence. The table is not available for read and write operations during the transfer. Once the timeout expires, data redistribution stops.
* Manual: Performed by a user directly after adding new segments. To do this, specify a timeout of `0` in the expansion settings.

## Add segment hosts {#add-hosts}

{% list tabs %}

{% if audience == "draft" %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Select a cluster and click the ![hosts-edit](../../_assets/../../_assets/mdb/hosts.svg) **Hosts** tab.
   1. Click **Expand cluster** in the top-right corner.
   1. Specify cluster expansion settings:

      * **New segment hosts**: Specify at least two segment hosts.
      * **Distribution timeout**: Specify a data distribution timeout for the new segments. For `0` (default), the timeout will be selected automatically based on cluster configuration and the amount of data.
   1. Click **Save**.

{% endif %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add segment hosts to a {{ GP }} cluster:

   1. View the description of the CLI cluster expand command:

      ```bash
      {{ yc-mdb-gp }} cluster expand --help
      ```

   1. Specify the cluster host segment settings in the cluster expand command:

      ```bash
      {{ yc-mdb-gp }} cluster expand <cluster name> \
         --segment-host-count <number of host segments to add> \
         --add-segments-per-host-count <number of segments per host to add> \
         --duration-seconds <data re-distribution timeout, seconds>
      ```

      The default for the `--duration-seconds` parameter is `7200` (2 hours).

- API

   Use the [expand](../../api-ref/Cluster/expand.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter.
   * Number of segment hosts to add in `segmentHostCount`.
   * Number of segments per host to add in `addSegmentsPerHostCount`.
   * The data redistribution timeout (in seconds) in the `duration` parameter. The minimum and default value is `0` (do not redistribute data).

   You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

{% endlist %}

{% note warning %}

The minimum (`0`) value or a short (under 2 hours) re-distribution timeout may impact cluster performance. If this happens, restart re-distribution manually (see [Example](#redistribute-by-hand)).

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

You can find the tables that were fully redistributed using the statement:

```sql
SELECT * FROM gp_toolkit.gp_skew_coefficients ORDER BY skccoeff DESC;
```

## Example of manual data redistribution {#redistribute-by-hand}

If a timeout of `0` is specified for a {{ GP }} cluster expansion, or if some of the data is not re-distributed to the new segments based on monitoring data, you will need to re-distribute manually:

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

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
