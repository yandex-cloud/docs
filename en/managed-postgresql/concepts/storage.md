# Storage in {{ mpg-name }}


{{ mpg-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/mpg/storage-type.md) %}


## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created along with a {{ PG }} cluster depends on the selected disk type:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts.

   Such a cluster will be fault-tolerant.

   Local SSD storage impacts the cost of a cluster: you are charged for it even if it is not running. You can find more information in the [pricing policy](../pricing.md).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [{#T}](./limits.md).



## Managing disk space {#manage-storage-space}

When the storage is more than 97% full, the host automatically switches to read-only mode, while all DBs get `DEFAULT_TRANSACTION_READ_ONLY` set to `TRUE` through the `ALTER DATABASE` query.

In this mode, the `INSERT`, `DELETE`, or `UPDATE` queries result in an error.


### Monitoring the switch to read-only mode {#read-only-monitor}

To monitor storage usage on cluster hosts, configure alerts in {{ monitoring-full-name }}:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Select **{{ ui-key.yacloud_monitoring.services.label_postgresql }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md
   ).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

   1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**: Set the following metric parameters:

      * Cloud
      * Folder
      * **{{ ui-key.yacloud_monitoring.services.label_postgresql }}** service
      * {{ mpg-name }} cluster ID

         You can get the cluster ID [with a list of clusters in a folder](../operations/cluster-list.md#list-clusters).

      * `disk.free_bytes` label

   1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Set the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for the percentage of free disk space to trigger the alert:

      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (a minimum metric value for the period)
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `90` (90% of storage size)
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `95` (95% of storage size)
      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Required period to update a metric value

   1. Add the previously created notification channel.


### Recovering a cluster from read-only mode {#read-only-solutions}

If the cluster switched to read-only mode:

* [Increase the storage capacity](../operations/update.md#change-disk-size) so that it exceeds the threshold value. {{ yandex-cloud }} will then disable read-only mode automatically.

* Disable read-only mode manually and free up storage space by deleting some data.

   {% note alert %}

   When doing so, make sure the amount of free disk space never reaches zero. Otherwise, since the fail-safe is disabled, {{ PG }} will crash and the cluster will stop working.

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

### Automatic increase of storage size {#auto-rescale}

The storage size auto increase feature allows avoiding its overflow and switch of hosts to read-only mode.

Storage size is increased upon reaching a preset threshold that is specified as a percentage of the total storage size. Two thresholds are used:

* First threshold on reaching which storage size will be increased during the next maintenance window.
* Second threshold on reaching which the process of increasing storage size will start immediately.

If both thresholds are set, make sure the second one is higher than the first one.

While increasing storage size, host clusters will be unavailable.

Storage size will be increased to the value set in the respective setting. After the threshold is reached for the first time, the feature will be disabled: if the threshold values are exceeded again, storage size will not be increased. To reactivate the feature, set a new storage size value after the threshold is reached.

You can set up automatic increase of storage size:

* [When creating a cluster](../operations/cluster-create.md).
* [When updating a cluster](../operations/update.md#disk-size-autoscale).

{% include [storage-resize-maintenance](../../_includes/mdb/mpg/storage-resize-maintenance.md) %}
