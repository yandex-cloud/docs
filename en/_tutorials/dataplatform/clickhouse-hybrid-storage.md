# Using hybrid storage

Hybrid storage allows you to store frequently used data on the network disks of the {{ mch-name }} cluster and rarely used data in {{ objstorage-full-name }}. Automatic data transfer between these storage levels is only supported for the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table family. For more information, see [{#T}](../../managed-clickhouse/concepts/storage.md).

To use hybrid storage:

1. [Create a table](#create-table).
1. [Populate the table with data](#fill-table-with-data).
1. [Check the placement of data in a cluster](#check-table-tiering).
1. [Run a test query](#submit-test-query).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md):
      * **Storage type**: Standard (`network-hdd`), fast (`network-ssd`), or non-replicated (`network-ssd-nonreplicated`) network disks.
      * **DB name**: `tutorial`.
      * **Hybrid storage**: `Enabled`.

   1. [Configure permissions](../../managed-clickhouse/operations/cluster-users.md#update-settings) so that you can execute read and write requests in this database.

- Using {{ TF }}

   {% if audience != "internal" %}

   1. If you don't have {{ TF }}, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md).

   {% endif %}

   1. Clone the repository containing examples:

      ```bash
      git clone https://github.com/yandex-cloud/examples/
      ```

   1. From the `examples/tutorials/terraform/` directory, copy `clickhouse-hybrid-storage.tf` to the folder where the provider configuration file is located.

      This file describes:

      * Network.
      * Subnet.
      * Default security group and rules required to connect to the cluster from the internet.
      * {{ mch-name }} cluster with hybrid storage enabled.

   1. In `clickhouse-hybrid-storage.tf`, specify the username and password to use to access the {{ mch-name }} cluster.

   1. In the terminal window, change to the directory containing the infrastructure plan.

   1. To verify that the config files are correct, run the command below:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the infrastructure required to run instructions from this tutorial:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Configure clickhouse-client {#deploy-clickhouse-client}

[Configure the clickhouse client](../../managed-clickhouse/operations/connect.md) to connect to the database.

### Explore the test dataset (optional) {#explore-dataset}

To demonstrate how hybrid storage works, Yandex.Metrica anonymized hit data (`hits_v1`) is used. This [dataset]({{ ch.docs }}/getting-started/example-datasets/metrica/) contains information about almost 9 million hits for the week from March 17 through March 23, 2014.

The `tutorial.hits_v1` table will be configured [when you create](#create-table) it so that all the <q>fresh data</q> in the table starting from March 21, 2014 is in network storage, and older data (from March 17, 2014 to March 20, 2014) is in object storage.

## Create a table {#create-table}

Create the `tutorial.hits_v1` table that uses hybrid storage. To do this, run the SQL query below replacing `<schema>` with the table schema from the [{{ CH }} documentation]({{ ch.docs }}/getting-started/tutorial/#create-tables):

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

The `TTL ...` expression defines a policy for operating with expiring data:
1. TTL sets the lifetime of a table row (in this case, the number of days from the current date to March 20, 2014).
1. For data in the table, the value `EventDate` is checked:
   * If the number of days from the current date to `EventDate` is less than the TTL value (that is, the lifetime has not expired yet), this data is kept in storage on network drives.
   * If the number of days from the current date to `EventDate` is greater than or equal to the TTL value (that is, the lifetime has already expired), this data is placed in the object storage according to the `TO DISK 'object_storage'` policy.

You don't need to specify TTL for hybrid storage, but this allows you to explicitly control which data will be in {{ objstorage-name }}. If you don't specify TTL, data is placed in object storage only when storage on network disks runs out of space. For more information, see [{#T}](../../managed-clickhouse/concepts/storage.md).

{% note info %}

The expression for TTL in the example above is complex because of the selected test dataset. You must split fixed data collected long ago into parts for placement at different storage levels. For most tables that are constantly updated with new data, a more simple expression for TTL suffices. For example, `EventDate + INTERVAL 5 DAY`: data older than 5 days is moved to the object storage.

{% endnote %}

Data is not moved from network disk to object storage row by row but rather in [chunks]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes) Try and select TTL expressions and [partitioning keys]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) to have the same TTL for all rows in a data chunk. Otherwise, you may have problems moving data into object storage when TTL expires if one chunk contains data intended for different storage levels. At the most basic level, the expression for TTL should use the same columns as in the partitioning key, like in the example above, where the `EventDate` column is used.

For more information about setting up TTL, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-ttl).

## Completing a table with data {#fill-table-with-data}

1. Download the test dataset:

   ```bash
   curl https://clickhouse-datasets.{{ s3-objstorage-host }}/hits/tsv/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```

1. Insert data from this dataset into {{ CH }} using `clickhouse-client`:

   ```bash
   clickhouse-client \
       --host <{{ CH }} host FQDN> \
       --secure \
       --user <username> \
       --database tutorial \
       --port 9440 \
       --ask-password \
       --query "INSERT INTO tutorial.hits_v1 FORMAT TSV" \
       --max_insert_block_size=100000 < hits_v1.tsv
   ```

   You can obtain the host FQDN with a [list of hosts in the cluster](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Wait for the operation to complete because the insertion of data may take some time.

For more information, see the [{{ CH }} documentation]({{ ch.docs }}/getting-started/tutorial/#import-data).

## Checking the placement of data in a cluster {#check-table-tiering}

1. Find out where the table rows are placed:

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

   Table partitions for which the `EventDate` value is outside the [given TTL](#ttl) should be on the disk named `object_storage`, that is, in object storage. All other partitions should be on the `default` disk:

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

   As a result, you'll see the distribution of table rows for the storage levels:

   ```text
   ┌─sum(rows)─┬─disk_name──────┐
   │   2711246 │ default        │
   │   6162652 │ object_storage │
   └───────────┴────────────────┘
   ```

As you can see from the SQL command results, the data in the table was successfully distributed in hybrid storage between different storage levels.

## Running a test query {#submit-test-query}

Run a test query to the `tutorial.hits_v1` table that addresses data on multiple storage levels at once:

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

Query result:

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

As you can see from the SQL request result, from the user's point of view, the table is a single entity: {{ CH }} successfully queries this table regardless of where the data is actually located in it.

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   If you no longer need these resources, delete the [{{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).

- Using {{ TF }}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete `clickhouse-hybrid-storage.tf`.
   1. Run the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in `clickhouse-hybrid-storage.tf`.

{% endlist %}
