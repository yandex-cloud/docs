# Disk types in {{ mgp-name }}


{{ mgp-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

{% include [storage-type](../../_includes/mdb/mgp/storage-type.md) %}

In a {{ mgp-name }} cluster, the type of disks for master hosts and segment hosts may differ.

{% include [ice-lake-local-ssd-note](../../_includes/ice-lake-local-ssd-note.md) %}

## Specifics of local SSD storage {#local-storage-features}

Local SSDs do not provide fault-tolerant storage and impact the cost of the entire cluster: a cluster with this type of storage is charged even if not running. You can find more information in the [pricing policy](../pricing).


## Managing disk space {#manage-storage-space}

If any host storage is more than 95% full, the cluster will switch to read-only mode automatically, while all DBs get `DEFAULT_TRANSACTION_READ_ONLY` set to `TRUE` through the `ALTER DATABASE` query.

In this mode, the `INSERT`, `DELETE`, or `UPDATE` queries result in an error.


### Monitoring the switch to read-only mode {#read-only-monitor}

To monitor storage usage on cluster hosts, configure alerts in {{ monitoring-full-name }}:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Select **{{ mgp-name }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

   1. **{{ ui-key.yacloud.common.metric }}**: Set the following metric parameters:

      * Cloud
      * Folder
      * **{{ mgp-name }}** service
      * {{ mgp-name }} cluster ID

         You can get the cluster ID [with a list of clusters in a folder](../operations/cluster-list.md#list-clusters).

      * `disk.free_bytes` label

   1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: Set the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for the percentage of free disk space to trigger the alert:

      * 95% of the storage size for `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`.
      * 90% of the storage size for `{{ ui-key.yacloud_monitoring.alert.status_warn }}`.

   1. **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}**:

      * **{{ ui-key.yacloud_monitoring.service.field.function }}**: `{{ ui-key.yacloud_monitoring.alert.title_aggregation-min }}` (a minimum metric value for the period).
      * **{{ ui-key.yacloud_monitoring.alert-template.field.evaluation-window }}**: Required period to update a metric value.

   1. Add the previously created notification channel.


### Recovering a cluster from read-only mode {#read-only-solutions}

If the cluster switched to read-only mode:

* [Increase the storage capacity](../operations/update.md#change-disk-size) so that it exceeds the threshold value. {{ yandex-cloud }} will then disable read-only mode automatically.

* Disable read-only mode manually and free up storage space by deleting some data.

   {% note alert %}

   When doing so, make sure the amount of free disk space never reaches zero. Otherwise, since the fail-safe is disabled, {{ GP }} will crash and the cluster will stop working.

   {% endnote %}

To disable read-only mode manually, contact [technical support]({{ link-console-support }}) or follow the steps below:

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

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
