---
title: Storage in {{ mrd-full-name }}
description: In this article, you will learn about disk types in {{ mrd-name }} and discover how to select the right disk type when creating a cluster.
---

# Storage in {{ mrd-name }}



{{ mrd-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, i.e., virtual drives in the {{ yandex-cloud }} infrastructure. Local drives are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mvk/storage-type.md) %}

## Selecting disk type when creating a cluster {#storage-type-selection}

The number of hosts you can create together with a {{ VLK }} cluster depends on the disk type you select and whether you enabled [sharding](./sharding.md):

| Disk type                                                             | Non-sharded cluster  | Sharded cluster    |
| ------------------------------------------------------------------------- | --------------------------------- | ----------------------------------|
| Network SSDs (`network-ssd`), ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)                           | 1 host or more                         | 1 host or more (1 shard × 1 host)     |
| Local SSDs (`local-ssd`)                           | 3 hosts or more                        | 2 hosts or more (1 shard × 2 hosts)    |
| Non-replicated SSDs (`network-ssd-nonreplicated`)     | 3 hosts or more                        | 3 hosts or more (1 shard × 3 hosts)    |

Learn about the limits on the number of hosts per cluster or shard in [Quotas and limits](./limits.md).


## Managing disk space {#manage-storage-space}

When the storage is 100% full, cluster hosts automatically switch to read-only mode. In this mode, data write requests fail. To release the cluster from read-only mode, [increase the storage size](../operations/update.md#change-disk-size) or contact [support]({{ link-console-support }}).

### Monitoring the transition to read-only mode {#read-only-monitor}

To monitor the cluster storage utilization percentage, set up alerts in {{ monitoring-full-name }}:

1. In the [management console]({{ link-console-main }}), select the folder.
1. [Navigate]({{ link-monitoring }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

   * Metric expression: `disk.used_bytes / disk.total_bytes * 100`.

   * **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Set alert trigger conditions:

      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}` (maximum metric value over the period).
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `90` (90 % of storage size).
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `95` (95 % of storage size).
      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Metric value calculation period.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**: Preferred time shift backward, in seconds. Allows to exclude incorrectly triggered alerts with several metrics collected at different time intervals. To learn more about the calculation delay, see [this {{ monitoring-full-name }} guide](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

   * **Notifications**: Add the notification channel you created earlier.

### Automatic storage expansion {#auto-rescale}

Automatic increase of storage size prevents situations where free disk space has been used up and hosts have switched to read-only mode. The storage size increases upon reaching the specified threshold percentage of the total capacity. There are two thresholds:

* Scheduled expansion threshold: When reached, the storage expands during the next [maintenance window](maintenance.md#maintenance-window). If this threshold is set, [configure](../operations/update.md#change-additional-settings) the maintenance schedule.
* Immediate expansion threshold: When reached, the storage size increases immediately.

You can use either one or both thresholds. If you set both, make sure the immediate increase threshold is higher than the scheduled one.

{% include [storage-resize-steps](../../_includes/mdb/mvk/storage-resize-steps.md) %}

You can configure automatic storage expansion when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md#disk-size-autoscale).


{% include [warn-storage-resize](../../_includes/mdb/mvk/warn-storage-resize.md) %}



## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}


## Data tiering {#data-tiering}

{{ VLK }} stores all data in RAM. This ensures high performance but requires a large amount of RAM, which is much more expensive than disk storage.

With data tiering, unused data can be moved from memory to disk.  This way you have your data both in RAM and on disk.

Data is managed using the key eviction policy configured in the [Maxmemory policy](settings-list.md#settings-maxmemory-policy) setting. In {{ VLK }}, when this policy is enabled, evicted data is deleted. With data tiering, evicted data is moved to disk instead of being deleted, which is known as cooling.

When processing a request, {{ VLK }} first looks for data in RAM. If there is no data there, it checks the disk storage.

If the disk runs out of free space, the keys get deleted the same way as with regular eviction.

{% note warning %}

With the `noeviction` policy enabled, data will be moved to disk after `maxmemory` is reached but will not be deleted from the disk when it becomes full.

{% endnote %}

Data tiering saves RAM by moving rarely used data to disk. This can be useful when the total amount of data is much larger than the amount of frequently used data.

For example, a database may contain 300 GB of data, while only 20% of it is actively used, i.e., 60 GB. Without data tiering, all data must be reside in RAM. With data tearing, 240 GB of rarely used data can be moved to disk with only frequently used data remaining in RAM. This allows using about 60–70 GB of RAM instead of more than 300 GB, with minimal impact on response time.

Unlike hybrid storage, this approach does not use S3 object storage: data is moved directly from memory to disk.

Learn more about [configuring data tiering](../operations/tiered-storage.md).

## Use cases {#examples}

* [{#T}](../tutorials/valkey-as-php-sessions-storage.md)
* [{#T}](../tutorials/data-migration.md)