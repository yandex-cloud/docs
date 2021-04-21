# Using hybrid storage

Hybrid storage allows you to store frequently used data in the network storage of the {{ mch-name }} cluster and rarely used data in {{ objstorage-full-name }}. Automatically moving data between these storage levels is only supported for [MergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/) tables. To learn more, see [{#T}](../concepts/storage.md).

{% include [mch-hybrid-storage-preview-combined-note](../../_includes/mdb/mch-hybrid-storage-preview-combined-note.md) %}

To use hybrid storage:

1. [Create a table](#create-table).
1. [Fill the table with data](#fill-table-with-data).
1. [Check the placement of table data in the cluster](#check-table-tiering).
1. [Run the test query](#submit-test-query).

## Before you start {#before-you-begin}

1. [Create a {{ mch-name }} cluster](../operations/cluster-create.md) with network storage, hybrid storage, and the `tutorial` database.

1. [Configure permissions](../operations/cluster-users.md#update-settings) so that you can execute read and write requests in this database.

1. [Configure the clickhouse client](../operations/connect.md) to connect to the database.

1. Explore the test dataset:

   To demonstrate how hybrid storage works, Yandex.Metrica anonymized hit data (`hits_v1`) is used . This [dataset](https://clickhouse.tech/docs/en/getting-started/example-datasets/metrica/) contains information about almost 9 million hits for the week from March 17, 2014 to March 23, 2014.

   The `tutorial.hits_v1` table will be [configured when you create](#create-table) it so that all the "fresh" data in the table starting from March 21, 2014 is in the network storage, and the older data (from March 17, 2014 to March 20, 2014) is in the object storage.

## Create a table {#create-table}

Create the `tutorial.hits_v1` table that uses hybrid storage. To do this, run an SQL query by substituting ``  with a table schema from the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/getting-started/tutorial/#create-tables):

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

{#ttl}

The `TTL ...` expression defines a policy for operating with expiring data:

1. TTL sets the lifetime of a table row (in this case, the number of days from the current date to March 20, 2014).
1. For data in the table, the value `EventDate` is checked:
   - If the number of days from the current date to `EventDate` is less than the TTL value (that is, the lifetime has not expired yet), this data is kept in the network storage.
   - If the number of days from the current date to `EventDate` is greater than or equal to the TTL value (that is, the lifetime has already expired), this data is placed in the object storage according to the `TO DISK 'object_storage'` policy.

You don't need to specify TTL for hybrid storage, but this allows you to explicitly control which data will be in {{ objstorage-name }}. If you don't specify TTL, data is placed in the object storage only when the network storage runs out of space. To learn more, see [{#T}](../concepts/storage.md)

{% note info %}

The expression for TTL in the example above is complex because of the selected test dataset. It's necessary to deliberately split fixed data collected long ago into parts for placement at different storage levels. For most tables that are constantly updated with new data, a more simple expression for TTL suffices. For example, `EventDate + INTERVAL 5 DAY`: data older than 5 days is moved to the object storage.

{% endnote %}

Between the network and object storage, data is not moved line by line but in [chunks](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes). Make sure to choose the TTL expression and the [partitioning key](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/custom-partitioning-key/) so that TTL matches for all the rows in the data chunk. Otherwise, you may have problems moving data into object storage when TTL expires if one chunk contains data intended for different storage levels. At the most basic level, the expression for TTL should use the same columns as in the partitioning key, like in the example above, where the `EventDate` column is used.

To learn more about configuring TTL, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-ttl).

## Completing a table with data {#fill-table-with-data}

1. Download the test dataset:

   ```bash
   curl https://clickhouse-datasets.s3.yandex.net/hits/tsv/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```

1. Insert data from this dataset into {{ CH }} using `clickhouse-cli`:

   ```bash
   clickhouse-client --host <{{ CH }} host FQDN> --secure --user <username> --database tutorial --port 9440 --password <user's password --query "INSERT INTO tutorial.hits_v1 FORMAT TSV" --max_insert_block_size=100000  hits_v1.tsv
   ```

   The host FQDN can be obtained [with a list of hosts in the cluster](../operations/hosts.md#list-hosts).

1. Wait for the operation to complete because the insertion of data may take some time.

To learn more, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/getting-started/tutorial/#import-data).

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

   ```
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

   ```
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

Request result:

```
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

