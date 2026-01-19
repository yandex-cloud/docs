---
title: Storage in {{ mrd-full-name }}
description: In this article, you will learn about disk types in {{ mrd-name }} and discover how to select the right disk type when creating a cluster.
---

# {{ mrd-name }} storage



{{ mrd-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mvk/storage-type.md) %}

## Selecting disk type when creating a cluster {#storage-type-selection}

The number of hosts you can create together with a {{ VLK }} cluster depends on the disk type you select and whether you enabled [sharding](./sharding.md):

| Disk type                                                             | Non-sharded cluster  | Sharded cluster    |
| ------------------------------------------------------------------------- | --------------------------------- | ----------------------------------|
| Network SSDs (`network-ssd`), ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)                           | 1 host or more                         | 1 host or more (1 shard × 1 host)     |
| Local SSDs (`local-ssd`)                           | 3 hosts or more                        | 2 hosts or more (1 shard × 2 hosts)    |
| Non-replicated SSDs (`network-ssd-nonreplicated`)     | 3 hosts or more                        | 3 hosts or more (1 shard × 3 hosts)    |

Sharded clusters with the **local-ssd** disk type and only one host per shard are not considered fault-tolerant. You cannot create such a cluster.

For more information about limits on the number of hosts per cluster or shard, see [Quotas and limits](./limits.md).


## Disk space management {#manage-storage-space}

When the storage is 100% full, cluster hosts automatically switch to read-only mode. In this mode, data write requests fail. To release the cluster from read-only mode, [increase the storage size](../operations/update.md#change-disk-size) or contact [support]({{ link-console-support }}).

### Monitoring the transition to read-only mode {#read-only-monitor}

To monitor the cluster storage utilization percentage, set up alerts in {{ monitoring-full-name }}:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

  1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**: Set the following metric parameters:

      * Cloud.
      * Folder.
      * **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
      * `disk.free_bytes` label.
      * {{ mrd-short-name }} cluster of interest. You can get the cluster name and ID with the [list of clusters in the folder](../operations/cluster-list.md#list-clusters).

  1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Set the condition for free disk space usage to trigger the alert:

      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (minimum metric value for the period).
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `90` (90 % of storage size).
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `95` (95 % of storage size).
      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Preferred metric update period.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**: Preferred time shift backward, in seconds. It allows to keep the alert from triggering when multiple metrics are specified and collected at different intervals. To learn more about the calculation delay, see this [{{ monitoring-full-name }} guide](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

  1. **Notifications**: Add the previously created notification channel.

### Automatic increase of storage size {#auto-rescale}

Automatic increase of storage size prevents situations where free disk space has been used up and hosts have switched to read-only mode. The storage size increases upon reaching the specified threshold percentage of the total capacity. There are two thresholds:

* Scheduled increase threshold: When reached, the storage size increases during the next [maintenance window](maintenance.md#maintenance-window). If this threshold is set, [configure](../operations/update.md#change-additional-settings) the maintenance schedule.
* Immediate increase threshold: When reached, the storage size increases immediately.

You can use either one or both thresholds. If you set both, make sure the immediate increase threshold is higher than the scheduled one.

{% include [storage-resize-steps](../../_includes/mdb/mvk/storage-resize-steps.md) %}

You can configure automatic increase of storage size when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md#disk-size-autoscale).


{% include [warn-storage-resize](../../_includes/mdb/mvk/warn-storage-resize.md) %}



## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/valkey-as-php-sessions-storage.md)
* [{#T}](../tutorials/data-migration.md)
