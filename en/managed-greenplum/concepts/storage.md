# Disk types in {{ mgp-name }}

{% if audience != "internal" %}

{{ mgp-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

{% include [storage-type](../../_includes/mdb/mgp/storage-type.md) %}

In a {{ mgp-name }} cluster, the type of disks for master hosts and segment hosts may differ.

{% include [ice-lake-local-ssd-note](../../_includes/ice-lake-local-ssd-note.md) %}

## Specifics of local SSD storage {#local-storage-features}

Local SSDs do not provide fault-tolerant storage and impact the cost of the entire cluster: a cluster with this type of storage is charged even if it is not running. Read more in the [pricing policy](../pricing).

{% else %}

{{ mgp-name }} lets you use local storage for database clusters. Local disks are physically located in the database host servers.

When creating a cluster, you can select the following disk types for data storage:

* Local SSD storage (`local-ssd`): The fastest disks. This storage capacity is between 10 and 2048 GB.
* Standard local disks (`local-hdd`): A slower but large storage option. Available only for hosts powered by Ice Lake or Cascade Lake processors with at least eight vCPUs.

{% endif %}

## Managing disk space {#manage-storage-space}

When the storage of any host is more than 95% full, the cluster automatically switches to read-only mode. At the same time, the `DEFAULT_TRANSACTION_READ_ONLY = TRUE` setting is set for all the DBs via the `ALTER DATABASE` query.

In this mode, the data `INSERT`, `DELETE`, or `UPDATE` queries result in an error.

{% if audience == "external" %}

### Monitoring the switch to read-only mode {#read-only-monitor}

To monitor storage usage on cluster hosts, configure alerts in {{ monitoring-full-name }}:

1. Go to the folder page and select **{{ monitoring-name }}**.
1. Select **{{ mgp-name }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

   1. **Metric**: Set the metric parameters:

      * Cloud.
      * Folder.
      * **{{ mgp-name }}** service
      * {{ mgp-name }} cluster ID.

         You can get the cluster ID [with a list of clusters in a folder](../operations/cluster-list.md#list-clusters).

      * `disk.free_bytes` label.

   1. **Trigger condition**: Set the `Less than or equal to` condition for the percentage of free disk space to trigger the alert:

      * 95% of the storage size for `Alarm`.
      * 90% of the storage size for `Warning`.

   1. **Additional settings**:

      * **Aggregation function**: `Minimum` (a metric's minimum value for the period).
      * **Calculation window**: Desired period to update a metric's value.

   1. Add the previously created notification channel.

{% endif %}

### Disabling a cluster in read-only mode {#read-only-solutions}

If the cluster switched to read-only mode:

* [Increase the storage capacity](../operations/update.md#change-disk-size) to go above the threshold value. After that, {{ yandex-cloud }} disables read-only mode automatically.

* Manually disable read-only mode and free up storage space by deleting some of the data.

   {% note alert %}

   Make sure the amount of free disk space never reaches zero during this time. Since the fail-safe is disabled, {{ GP }} will crash and the cluster will be disabled.

   {% endnote %}

To disable read-only mode manually, contact [technical support]({{ link-console-support }}) or follow the instructions below:

1. [Connect to the database](../operations/connect.md) however is convenient.

1. Open the transaction and run the following command inside it:

   ```sql
   SET LOCAL transaction_read_only TO off;
   ```

1. As part of the same transaction, delete unnecessary data using the `DROP` or `TRUNCATE` operators. Don't use the `DELETE` operator: it marks rows as deleted, but does not physically delete them from the database.

1. Commit the transaction and restart all connections to the database.

> For example, if your database contains the unnecessary table `ExcessDataTable1`, delete it with a transaction:
>
> ```sql
> BEGIN;
> SET LOCAL transaction_read_only TO off;
> DROP TABLE ExcessDataTable1;
> COMMIT;
> ```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
