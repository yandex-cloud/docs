---
title: Disk types in {{ mgp-full-name }}
description: In this article, you will learn about disk types in {{ mgp-name }} and discover some features of local SSD storage.
---

# Disk types in {{ mgp-name }}



{{ mgp-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

{% include [storage-type](../../_includes/mdb/mgp/storage-type.md) %}

In a {{ GP }} cluster, the type of disks for master hosts and segment hosts may differ.

{% note info %}

When using standard **Intel Ice Lake** hosts, access to local SSD storage is provided on request. If you need one, contact [our support]({{ link-console-support }}) or your account manager.

{% endnote %}

## Specifics of local SSD storage {#local-storage-features}

Local SSDs do not provide fault-tolerant storage and impact the cost of the entire cluster: you are charged for a cluster with this type of storage even if it is stopped. You can find more information in the [pricing policy](../pricing).


## Disk space management {#manage-storage-space}

If any host storage is more than 95% full, the cluster will switch to read-only mode automatically, all DBs get the `DEFAULT_TRANSACTION_READ_ONLY = TRUE` setting through the `ALTER DATABASE` query.

In this mode, the `INSERT`, `DELETE`, or `UPDATE` queries result in an error.


### Monitoring the transition to read-only mode {#read-only-monitor}

To monitor storage usage on cluster hosts, configure alerts in {{ monitoring-full-name }}:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Select **{{ mgp-name }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following settings:

    1. **{{ ui-key.yacloud.common.metric }}**: Configure the following metric settings:

        * Cloud
        * Folder
        * **{{ mgp-name }}** service
        * {{ GP }} cluster ID

            You can get the cluster ID from the [folder’s cluster list](../operations/cluster-list.md#list-clusters).

        * `disk.free_bytes` label

    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: Define the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for disk usage percentage that will trigger the alert:

        * 95% of the storage size for `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`
        * 90% of the storage size for `{{ ui-key.yacloud_monitoring.alert.status_warn }}`

    1. **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}**:

        * **{{ ui-key.yacloud_monitoring.service.field.function }}**: `{{ ui-key.yacloud_monitoring.alert.title_aggregation-min }}` (metric’s minimum value over the period).
        * **{{ ui-key.yacloud_monitoring.alert-template.field.evaluation-window-key-value }}**: Preferred metric update period.

    1. Add the notification channel you created earlier.


### Recovering a cluster from read-only mode {#read-only-solutions}

If the cluster switched to read-only mode:

* [Increase the storage capacity](../operations/update.md#change-disk-size) to exceed the threshold value. {{ yandex-cloud }} will then disable read-only mode automatically.

* Disable read-only mode manually and free up storage space by deleting some data.

    {% note alert %}

    When doing so, make sure the amount of free disk space never reaches zero. Otherwise, with the fail-safe mechanism disabled, {{ GP }} will crash, rendering the cluster inoperable.

    {% endnote %}

To disable read-only mode manually, contact [support]({{ link-console-support }}) or follow the steps below:

1. [Connect to the database](../operations/connect.md) using any method of your choice.

1. Start a transaction and run the following statement within it:

   ```sql
   SET LOCAL transaction_read_only TO off;
   ```

1. In the same transaction, clean up the data you no longer need using the `DROP` or `TRUNCATE` statements. Avoid the `DELETE` statement because it marks rows as deleted without physically purging them from the database.

1. Commit the transaction and restart all database connections.

> For example, to remove the `ExcessDataTable1` table you no longer need, use the following transaction:
>
> ```sql
> BEGIN;
> SET LOCAL transaction_read_only TO off;
> DROP TABLE ExcessDataTable1;
> COMMIT;
> ```

## Use cases {#examples}

* [{#T}](../tutorials/object-storage-to-greenplum.md)
* [{#T}](../tutorials/yezzey.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
