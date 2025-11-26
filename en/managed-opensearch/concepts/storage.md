---
title: Storage in {{ mos-full-name }}
description: In this article, you will learn about disk types in {{ mos-name }} and discover how to select the right type of storage when creating a cluster.
---

# {{ mos-name }} storage



{{ mos-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

{% include [storage-type](../../_includes/mdb/mos/storage-type.md) %}

## Selecting storage type when creating a cluster {#storage-type-selection}

The number of hosts with the `DATA` role you can create together with an {{ OS }} cluster depends on the selected storage type:

* You can create a cluster only with three or more hosts when using the following disk types:

    * Local SSDs (`local-ssd`)
    * Non-replicated SSDs (`network-ssd-nonreplicated`)
    
   This cluster will be fault-tolerant.

   Local SSD storage has an effect on how much a cluster will cost: you pay for it even if it is stopped. For more information, refer to the [pricing policy](../pricing.md).

* You can add any number of hosts within the current quota when using the following disk types:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)
   * Ultra high-speed network SSDs with triple replication (`network-ssd-io-m3`)

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).

To improve fault tolerance, you can set up [index replication](scalability-and-resilience.md#replication) (for multi-host cluster configurations only).


## Disk space management {#manage-storage-space}

When the storage is 95% full, cluster hosts automatically enter read-only mode. In this mode, data write requests fail. To release hosts from read-only mode, [increase](../operations/host-groups.md#update-host-group) the storage size or contact [support]({{ link-console-support }}).

### Monitoring the transition to read-only mode {#read-only-monitor}

To monitor the cluster storage usage, set up alerts in {{ monitoring-full-name }}:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

   1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**: Set the following metric parameters:

      * Cloud.
      * Folder.
      * **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
      * `disk.free_bytes` label.
      * {{ mos-name }} cluster of interest. You can get the cluster name and ID with the [list of clusters in the folder](../operations/cluster-list.md#list-clusters).

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

{% include [storage-resize-steps](../../_includes/mdb/mos/storage-resize-steps.md) %}

You can configure automatic storage increase when [creating a cluster](../operations/cluster-create.md), or when [creating](../operations/host-groups.md#add-host-group) or [modifying](../operations/host-groups.md#update-host-group) a host group.


{% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}



## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}

