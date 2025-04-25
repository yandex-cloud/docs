# Using hybrid storage in {{ mch-name }}


Hybrid storage allows you to store frequently used data on the network disks of the {{ mch-name }} cluster and rarely used data in {{ objstorage-full-name }}. Automatically moving data between these storage tiers is only supported for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables. To learn more, see [{#T}](../../managed-clickhouse/concepts/storage.md).

To use hybrid storage:

1. [Create a table](#create-table).
1. [Populate the table with data](#fill-table-with-data).
1. [Check data placement in a cluster](#check-table-tiering).
1. [Run a test query](#submit-test-query).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mch-name }} cluster fee: Using computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md):

        
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}**: Standard (`network-hdd`), fast (`network-ssd`), or non-replicated (`network-ssd-nonreplicated`) network disks.


        * **{{ ui-key.yacloud.mdb.forms.label_disk-size }}**: At least 15 GB.
        * **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}**: Disabled.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `tutorial`.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}**: Enabled.

    1. [Configure permissions](../../managed-clickhouse/operations/cluster-users.md#update-settings) so that you can execute read and write requests in this database.

- Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [clickhouse-hybrid-storage.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-hybrid-storage/blob/main/clickhouse-hybrid-storage.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Default security group](../../vpc/concepts/security-groups.md) and rules required to connect to the cluster from the internet.
        * {{ mch-name }} cluster with hybrid storage enabled.

    1. In the `clickhouse-hybrid-storage.tf` file, specify the username and password to access the {{ mch-name }} cluster.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Set up the command line tools {#set-instruments}

1. Install the `curl` and `unxz` tools:

    ```bash
    apt-get update && apt-get install curl xz-utils
    ```

1. [Set up clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) and use it to connect to the database.

### Optionally, explore the test dataset {#explore-dataset}

To demonstrate how hybrid storage works, we are going to use the Yandex Metrica anonymized hit data (`hits_v1`). This [dataset]({{ ch.docs }}/getting-started/example-datasets/metrica/) contains information about almost 9 million hits over the week from March 17, 2014, to March 23, 2014.

When creating the `tutorial.hits_v1` table, you are going to [configure it](#create-table) so that all more recent table data, starting from March 21, 2014, is in network storage, and older data, from March 17, 2014, to March 20, 2014, is in object storage.

## Create a table {#create-table}

Create the `tutorial.hits_v1` table that uses hybrid storage. To do this, run an SQL query by substituting `<schema>` with a table schema from the [{{ CH }} documentation]({{ ch.docs }}/getting-started/tutorial/#create-tables):

```sql
CREATE TABLE tutorial.hits_v1
(
   <schema>
)
ENGINE = MergeTree()
PARTITION BY EventDate
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
TTL EventDate + toIntervalDay(dateDiff('day', toDate('2014-03-20'), now())) TO DISK 'object_storage'
SETTINGS index_granularity = 8192
```

{% include [mch-hybrid-storage-tutorial-sample-query-full](../../_includes/mdb/mch-hs-tutorial-sample-query-full.md) %}

{% note info %}

This table uses the `default` [storage policy](../../managed-clickhouse/concepts/storage.md#storage-policies).

{% endnote %}

{#ttl}

The `TTL ...` expression sets a policy for handling expiring data:
1. TTL sets the lifetime of a table row. In our case, it is the number of days from the current date to March 20, 2014. 
1. For the table data, the system checks the `EventDate` value:
   * If the number of days from the current date to `EventDate` is less than the TTL value (i.e., the lifetime has not expired yet), this data is kept in network disk storage.
   * If the number of days from the current date to `EventDate` is greater than or equal to the TTL value (that is, the lifetime has already expired), this data will be placed in object storage under the `TO DISK 'object_storage'` policy.

You do not need to specify TTL for hybrid storage, but this allows you to explicitly manage which data will be in {{ objstorage-name }}. If you do not specify TTL, data will only be placed in object storage when you run out of space in your network disk storage. To learn more, see [{#T}](../../managed-clickhouse/concepts/storage.md).

{% note info %}

The expression for TTL in the example above is complex due to the selected test dataset. You must split fixed data collected long ago into parts for placing it at various storage levels. For most tables constantly updated with new data, you can use a simpler TTL expression, such as`EventDate + INTERVAL 5 DAY`, which moves data older than 5 days to object storage.

{% endnote %}

Data is moved between storage on network disks and object storage in [parts]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes), not line by line. Make sure to choose the TTL expression and [partitioning key]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) so that the TTL matches for all rows in the data part. Otherwise, you may have problems moving data into object storage as TTL expires if one data part contains data intended for various storage levels. At the most basic level, the TTL expression should use the same columns as in the partitioning key, like in the example above featuring the `EventDate` column.

For more information on setting up TTL, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-ttl).

## Populate the table with data {#fill-table-with-data}

1. Disconnect from the database.
1. Download the test dataset:

   
   ```bash
   curl https://{{ s3-storage-host }}/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```


   The downloaded dataset is about 10 GB large.

1. Insert data from this dataset into {{ CH }} using `clickhouse-client`:

   ```bash
   clickhouse-client \
       --host <{{ CH }}_host_FQDN> \
       --secure \
       --user <username> \
       --database tutorial \
       --port 9440 \
       --ask-password \
       --query "INSERT INTO tutorial.hits_v1 FORMAT TSV" \
       --max_insert_block_size=100000 < hits_v1.tsv
   ```

   You can get the host FQDN with a [list of hosts in the cluster](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Wait for the operation to complete, as data insertion may take some time.

For more information, see the [{{ CH }} documentation]({{ ch.docs }}/getting-started/tutorial/#import-data).

## Check data placement in a cluster {#check-table-tiering}

1. [Connect to the database](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client).
1. Check where the table rows are placed:

   ```sql
   SELECT
       table,
       partition,
       name,
       rows,
       disk_name
   FROM system.parts
   WHERE active AND (table = 'hits_v1') AND (database = 'tutorial')
   ```

   Table partitions for which the `EventDate` value is outside the [given TTL](#ttl) should reside on the disk named `object_storage`, i.e., in object storage. All other partitions should reside on the `default` disk:

   ```text
   ┌─table───┬─partition──┬─name───────────────┬───rows─┬─disk_name──────┐
   │ hits_v1 │ 2014-03-17 │ 20140317_6_80_2    │ 571657 │ object_storage │
   │ hits_v1 │ 2014-03-17 │ 20140317_86_125_1  │ 287545 │ object_storage │
   │ ...                                                                 │
   │ hits_v1 │ 2014-03-20 │ 20140320_109_145_1 │ 250484 │ object_storage │
   │ hits_v1 │ 2014-03-20 │ 20140320_149_200_1 │ 420081 │ object_storage │
   │ hits_v1 │ 2014-03-21 │ 20140321_3_57_1    │ 612616 │ default        │
   │ hits_v1 │ 2014-03-21 │ 20140321_65_65_0   │  53382 │ default        │
   │ ...                                                                 │
   │ hits_v1 │ 2014-03-23 │ 20140323_191_191_0 │  11145 │ default        │
   │ hits_v1 │ 2014-03-23 │ 20140323_197_197_0 │  98910 │ default        │
   └─────────┴────────────┴────────────────────┴────────┴────────────────┘
   ```

1. Check the number of rows at each of the storage levels:

   ```sql
   SELECT
    sum(rows),
    disk_name
   FROM system.parts
   WHERE active AND (database = 'tutorial') AND (table = 'hits_v1')
   GROUP BY disk_name
   ```
   
   As a result, you will see the distribution of table rows for the storage levels:
   
   ```text
   ┌─sum(rows)─┬─disk_name──────┐
   │   2711246 │ default        │
   │   6162652 │ object_storage │
   └───────────┴────────────────┘
   ```
   
As you can see from the SQL command results, the data in the table was successfully distributed in hybrid storage between different storage levels.

## Run a test query {#submit-test-query}

Run a test query to the `tutorial.hits_v1` table that engages with data at multiple storage levels at once:

```sql
SELECT
    URLDomain AS Domain,
    AVG(SendTiming) AS AvgSendTiming
FROM tutorial.hits_v1
WHERE (EventDate >= '2014-03-19') AND (EventDate <= '2014-03-22')
GROUP BY Domain
ORDER BY AvgSendTiming DESC
LIMIT 10
```

Result:

```text
┌─Domain──────────────────────────────┬──────AvgSendTiming─┐
│ realty.ru.msn.com.travel            │ 101166.85714285714 │
│ podbor.ru.msn.com.uazbukatusprosima │  76429.16666666667 │
│ club.metalia-woman                  │ 64872.333333333336 │
│ avito.rusfootki                     │              51099 │
│ papas.drimmirkvart                  │ 50325.642857142855 │
│ apps.oyunuoyna.com.uazbukadelight   │ 32761.666666666668 │
│ voyeurhit                           │          31501.625 │
│ yandex.ru.com.travesti.net          │            31427.5 │
│ sozcu.com.ua.alm.slands             │              29439 │
│ hasters.ru                          │ 18365.666666666668 │
└─────────────────────────────────────┴────────────────────┘
```

As you can see from the SQL request result, the user sees the table as a single entity: {{ CH }} successfully queries this table regardless of where the data is actually located in it.

## Optionally, monitor the amount of space data in {{ objstorage-name }} takes up {#metrics}

To monitor the amount of space [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table chunks in {{ objstorage-name }} take up, use the `ch_s3_disk_parts_size` metric in {{ monitoring-full-name }}:

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Navigate to **Metric Explorer**.
1. Run this request:

    ```text
    "ch_s3_disk_parts_size"{service="managed-clickhouse", resource_type="cluster", node="by_host", resource_id="<cluster_ID>", subcluster_name="clickhouse_subcluster"}
    ```

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
