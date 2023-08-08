# Storage in {{ mpg-name }}


{{ mpg-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/mpg/storage-type.md) %}


## Specifics of local SSD storage {#local-storage-features}

The number of hosts that can be created along with a {{ PG }} cluster depends on the selected disk type:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts.

   This cluster will be fault-tolerant.

   Local SSD storage impacts the cost of a cluster: it is charged even if it is not running. You can find more information in the [pricing policy](../pricing.md).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [{#T}](./limits.md).



## Managing disk space {#manage-storage-space}

When the storage is more than 97% full, the host automatically switches to read-only mode, while all DBs get `DEFAULT_TRANSACTION_READ_ONLY` set to `TRUE` through the `ALTER DATABASE` query.

In this mode, the data `INSERT`, `DELETE`, or `UPDATE` queries result in an error.


### Monitoring the switch to read-only mode {#read-only-monitor}

To monitor storage usage on cluster hosts, configure alerts in {{ monitoring-full-name }}:

1. Go to the folder page and select **{{ monitoring-name }}**.
1. Select **{{ mpg-name }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md
   ).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

   1. **Metric**: Set the following metric parameters:

      * Cloud
      * Folder
      * **{{ mpg-name }}** service
      * {{ mpg-name }} cluster ID

         You can get the cluster ID [with a list of clusters in a folder](../operations/cluster-list.md#list-clusters).

      * `disk.free_bytes` label

   1. **Trigger condition**: Set the `Less than or equal to` condition for the percentage of free disk space to trigger the alert:

      * 95% of the storage size for `Alarm`.
      * 90% of the storage size for `Warning`.

   1. **Additional settings**:

      * **Aggregation function**: `Minimum` (a minimum metric value for the period).
      * **Calculation window**: Desired period to update a metric value.

   1. Add the previously created notification channel.


### Recovering a cluster from read-only mode {#read-only-solutions}

If the cluster switched to read-only mode:

* [Increase the storage capacity](../operations/update.md#change-disk-size) so that it exceeds the threshold value. {{ yandex-cloud }} will then disable read-only mode automatically.

* Disable read-only mode manually and free up storage space by deleting some of the data.

   {% note alert %}

   When doing so, make sure the amount of free disk space never reaches zero. Since the fail-safe is disabled, {{ PG }} will crash and the cluster will stop working.

   {% endnote %}

To disable read-only mode manually, contact [technical support]({{ link-console-support }}) or follow the instructions below:

1. [Connect to the database](../operations/connect.md) in any appropriate way.

1. Open a transaction and run the following command inside it:

   ```sql
   SET LOCAL transaction_read_only TO off;
   ```

1. As part of the same transaction, delete the data you do not need using the `DROP` or `TRUNCATE` operators. Do not use the `DELETE` operator, as it marks rows as deleted but does not physically delete them from the database.

1. Commit the transaction and restart all connections to the database.

> For example, if your database contains a table called `ExcessDataTable1` that you no longer need, delete it with the following transaction:
>
> ```sql
> BEGIN;
> SET LOCAL transaction_read_only TO off;
> DROP TABLE ExcessDataTable1;
> COMMIT;
> ```
