# Storage in {{ mpg-name }}

{{ mpg-name }} lets you use network and local storage for database clusters. Network storage is based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local storage is organized on disks that are physically located in the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/storage-type-nrd.md) %}

## Local storage features {#local-storage-features}

Local storage doesn't provide fault tolerance for data storage and affects the overall pricing for the cluster:

* Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mpg-name }} cluster using local storage, a 3-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with local storage even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Non-replicated network storage features {#network-nrd-storage-features}

{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Managing disk space {#manage-storage-space}

When the storage is more than 97% full, the host automatically switches to read-only mode. At the same time, the `DEFAULT_TRANSACTION_READ_ONLY = TRUE` setting is set for all the DBs via the `ALTER DATABASE` query.

In this mode, the data `INSERT`, `DELETE`, or `UPDATE` queries result in an error.

### Monitoring the switch to read-only mode {#read-only-monitor}

To monitor storage usage on cluster hosts, configure alerts in {{ monitoring-full-name }}:

1. Go to the folder page and select **{{ monitoring-name }}**.

1. Select **{{ mpg-name }}**.

1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).

1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following parameters:

    1. **Metric**: Set the metric parameters:

        * Cloud

        * Folder

        * **{{ mpg-name }}** service

        * {{ mpg-name }} cluster ID

            You can find out the [ cluster ID in a list of clusters in the ](../operations/cluster-list.md#list-clusters) folder.

        * `disk.free_bytes` label

    1. **Trigger condition**: Set the `Less than or equal to` condition for the size of free disk space to trigger the alert:
        * 95% of the storage size for `Alarm`.
        * 90% of the storage size for `Warning`.

    1. **Additional settings**:
        * **Aggregation function**: `Minimum` (a metric's minimum value for the period).
        * **Calculation window**: Desired period of a metric value's update.

    1. Add the previously created notification channel.

### Disabling cluster's read-only mode {#read-only-solutions}

If the cluster switched to read-only mode:

* [Increase storage capacity](../operations/update.md#change-disk-size) to go above the threshold value. After that {{ yandex-cloud }} disables read-only mode automatically.

* Manually disable read-only mode and free up storage space by deleting some of the data.

    {% note alert %}

    Make sure the amount of free disk space never reaches zero during this time. Since the fail-safe is disabled, {{ PG }} will crash and the cluster will be disabled.

    {% endnote %}

To manually disable read-only mode, contact [technical support]({{ link-console-support }}) or follow the instructions:

1. [Connect to the database](../operations/connect.md) however is convenient.

1. Open the transaction and run the following command inside it:

   ```sql
   SET LOCAL transaction_read_only TO off;
   ```

1. As part of the same transaction, delete unnecessary data using the `DROP` or `TRUNCATE` operators. Don't use the `DELETE` operator: it marks rows as deleted, but does not physically delete them from the database.

1. Commit the transaction and restart all connections to the database.

> For example, if your database contains the unnecessary table `ExcessDataTable1`, delete it with a transaction:
>
>```sql
>BEGIN;
>SET LOCAL transaction_read_only TO off;
>DROP TABLE ExcessDataTable1;
>COMMIT;
>```
