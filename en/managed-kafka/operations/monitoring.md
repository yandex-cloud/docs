---
title: Monitoring the state of an {{ KF }} cluster and its hosts
description: In this guide, you will learn how to monitor the state of of {{ KF }} clusters and their hosts.
---

# Monitoring the state of an {{ KF }} cluster and its hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#monitoring-cluster}

To view detailed information on the state of a {{ mkf-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.
  
  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  The page displays the following charts:

  * **Alive brokers**: Number of functional brokers for each host with the `KAFKA` role.
  * **Offline partitions**: Displays the values of the settings below:
      * `OfflineReplicaCount`: Number of partitions with no leader broker. These partitions do not support message writes or reads.
      * `Underreplicated partitions`: Number of partitions with in-sync replica (ISR) count below the replication factor.
      * `Under min ISR partitions`: Number of partitions with ISR count below the minimum value specified in the [settings](../concepts/settings-list.md).
  * **Errors**: Number of failed requests by error type.
  * **Free space**: Free disk space for each host with the `KAFKA` role, in bytes.
  * **Messages in**: Message write rate, in messages per second.
  * **Bytes In/Out**: Message write and read rate for each host with the `KAFKA` role, in bytes per second.
  * **Top 5 topics by size**: Amount of data for each of the five largest topics, in bytes.
  * **Replicated bytes**: Replication data streaming rate for each host with the `KAFKA` role, in bytes per second.
  * **Partitions**: Total number of partition replicas.
  * **Replication lag [messages]**: Greatest replication lag for each host with the `KAFKA` role, in messages.
  * **Request time (0.95 quantile)**: Request processing time at the 95th percentile by request type.
  * **Requests**: Request rate by type, in requests per second.

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information on the state of individual {{ mkf-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the name of your cluster and select **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
  1. Select the host from the drop-down list.

  This page displays the charts showing workloads of individual cluster hosts:

  * **CPU usage**: Processor core workload. As the workload goes up, the `Idle` value goes down.
  * **Memory usage**: Amount of RAM used, in bytes. At high workloads, the `Free` value goes down, while the other values go up.
  * **Disk read/write bytes**: Speed of disk operations, in bytes per second.
  * **Disk IOPS**: Number of disk operations per second.
  * **Network bytes**: Speed of network data exchange, in bytes per second.
  * **Network packets**: Number of network packets exchanged per second.
  * **Free space**: Free disk space, in bytes.

{% endlist %}


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure state indicator alerts for a [cluster](#monitoring-cluster) and [hosts](#monitoring-hosts):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster for which you want to set up alerts.
  1. [Go to](../../console/operations/select-service.md#select-service) ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select **{{ mkf-name }} — Cluster Overview**.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.label_warning }}` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

The recommended thresholds for some metrics are as follows:

| Metric                            | Internal metric name                                             | `{{ ui-key.yacloud_monitoring.alert.label_alarm }}`                    | `{{ ui-key.yacloud_monitoring.alert.label_warning }}`                  |
|------------------------------------|---------------------------------------------------------|----------------------------|----------------------------|
| Number of healthy hosts  | `kafka_is_alive`                                        | `<number_of_hosts> - 2`  | `<number_of_hosts> - 1`  |
| Partition replication state      | `kafka_server_ReplicaManager_UnderReplicatedPartitions` | —                          | `More than 0`                 |
| Number of lagging replicas             | `kafka_server_ReplicaManager_UnderMinIsrPartitionCount` | `More than 0`                 | —                          |
| Storage space used    | `disk.used_bytes`                                       | 90% of the storage size | 80% of the storage size |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.label_warning }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.label_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.label_warning }}`: `85,899,345,920` bytes (80%)

You can view the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-kafka-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster state and status:

1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

