# Using hybrid storage in {{ mch-name }}


Hybrid storage enables you to store frequently used data on the {{ mch-name }} cluster’s network drives while keeping rarely used data in {{ objstorage-full-name }}. Your hybrid storage will automatically create a bucket and connect it to {{ CH }}. Automatically moving data between these storage tiers is only supported for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables. For more information, see [{#T}](../../managed-clickhouse/concepts/storage.md).

To use hybrid storage:

1. [Create a table](#create-table).
1. [Populate the table with data](#fill-table-with-data).
1. [Check data placement within your cluster](#check-table-tiering).
1. [Run a test query](#submit-test-query).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mch-name }} cluster fee, which covers the use of computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

### Set up the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md):

        
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}**: Standard (`network-hdd`), fast (`network-ssd`), or non-replicated (`network-ssd-nonreplicated`) network disks.


        * **{{ ui-key.yacloud.mdb.forms.label_disk-size }}**: At least 15 GB.
        * **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}**: Disabled.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `tutorial`.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}**: Enabled.

    1. [Configure access permissions](../../managed-clickhouse/operations/cluster-users.md#update-settings) to allow read and write queries to your database.

- Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [clickhouse-hybrid-storage.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-hybrid-storage/blob/main/clickhouse-hybrid-storage.tf) configuration file to your current working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Default security group](../../vpc/concepts/security-groups.md) and rules enabling connections to the cluster from the internet.
        * {{ mch-name }} cluster with hybrid storage enabled.

    1. In the `clickhouse-hybrid-storage.tf` file, specify the username and password you will use to access the {{ mch-name }} cluster.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Set up the command line tools {#set-instruments}

1. Install `curl` and `unxz`:

    ```bash
    apt-get update && apt-get install curl xz-utils
    ```

1. [Set up the clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) and use it to connect to the database.

### Optionally, explore the test dataset {#explore-dataset}

To demonstrate how the hybrid storage works, we will use anonymized hit data (`hits_v1`) from Yandex Metrica. This [dataset]({{ ch.docs }}/getting-started/example-datasets/metrica/) contains nearly 9 million hits recorded between March 17, 2014, to March 23, 2014.

When creating the `tutorial.hits_v1` table, we will [configure it](#create-table) to place all recent data (starting from March 21, 2014) in the network storage, while moving older data (from March 17, 2014 to March 20, 2014) to the object storage.

## Create a table {#create-table}

Create the `tutorial.hits_v1` table configured for hybrid storage by running the following SQL query. Replace the `<schema>` placeholder with a table schema from [this {{ CH }} guide]({{ ch.docs }}/getting-started/tutorial/#create-tables):

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

This table will use the `default` [storage policy](../../managed-clickhouse/concepts/storage.md#storage-policies).

{% endnote %}

{#ttl}

The `TTL ...` expression defines the policy for managing aging data:
1. TTL sets the lifetime of a table row. In our example, it is the number of days from the current date to March 20, 2014. 
1. The system manages table data based on the `EventDate` value:
   * Records where the elapsed time, in days, since `EventDate` is less than the TTL value are retained on the network disk storage.
   * Records where the elapsed time since `EventDate` meets or exceeds the TTL value are moved to the object storage, as per the `TO DISK 'object_storage'` policy.

While specifying TTL for hybrid storage is optional, doing so gives you explicit control over what data is moved to {{ objstorage-name }}. Without a defined TTL, data is only moved to the object storage when you run out of space in your network disk storage. For more information, see [{#T}](../../managed-clickhouse/concepts/storage.md).

{% note info %}

The TTL expression in our example is complex because the test dataset we use requires splitting historical, static data across various storage tiers. For the majority of frequently updated tables, you can use a simple TTL expression, such as `EventDate + INTERVAL 5 DAY`, which moves data to the object storage after a five-day period.

{% endnote %}

Data is moved between the network disk storage and object storage in [parts]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes), rather than per row. For optimal performance, align your TTL expression with your [partitioning key]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) to ensure that all rows within a part share the same expiration time. This prevents situations where a data part contains a mix of rows destined for different storage tiers, which can block expired data from moving to the object storage. At a minimum, the TTL expression should use the same columns as the partitioning key, e.g., `EventDate` in the example above.

For more details on configuring TTL, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-ttl).

## Populate the table with data {#fill-table-with-data}

1. Disconnect from the database.
1. Download the test dataset:

   
   ```bash
   curl https://{{ s3-storage-host }}/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```


   The downloaded dataset size is about 10 GB.

1. Load this dataset into {{ CH }} using `clickhouse-client`:

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

   You can get the host FQDN with the [list of hosts in the cluster](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Wait for the operation to complete, as importing the data may take some time.

For more information, see [this {{ CH }} guide]({{ ch.docs }}/getting-started/tutorial/#import-data).

## Check data placement within a cluster {#check-table-tiering}

1. [Connect to the database](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client).
1. Check the location of the table rows:

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

   Table partitions with `EventDate` older than the [TTL](#ttl) allows should reside on the `object_storage` disk. All other partitions should reside on the `default` disk:

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

1. Check the number of rows stored on each storage tier:

   ```sql
   SELECT
    sum(rows),
    disk_name
   FROM system.parts
   WHERE active AND (database = 'tutorial') AND (table = 'hits_v1')
   GROUP BY disk_name
   ```
   
   The result will show the distribution of table rows across the storage tiers:
   
   ```text
   ┌─sum(rows)─┬─disk_name──────┐
   │   2711246 │ default        │
   │   6162652 │ object_storage │
   └───────────┴────────────────┘
   ```
   
As you can see, the SQL results confirm the successful distribution of data across the hybrid storage tiers.

## Run a test query {#submit-test-query}

Run a test query against the `tutorial.hits_v1` table, accessing data from multiple storage tiers simultaneously:

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

As the SQL result shows, the user interacts with a single logical table. {{ CH }} successfully handles the complexity of querying data across different storage tiers.

## Monitor the volume of data in {{ objstorage-name }} (optional step) {#metrics}

To monitor the amount of space [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table parts occupy in {{ objstorage-name }}, use the `ch_s3_disk_parts_size` metric in {{ monitoring-full-name }}.

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Navigate to the **Metric Explorer** section.
1. Run this query:

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
