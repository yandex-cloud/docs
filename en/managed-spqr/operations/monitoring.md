---
title: '{{ SPQR }} cluster and host state monitoring'
description: You can monitor the state of a {{ SPQR }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts. You can also configure {{ monitoring-full-name }} alerts for automated cluster health monitoring.
---

# {{ SPQR }} cluster and host state monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Cluster health state monitoring {#monitoring-cluster}

To view health details for a {{ mspqr-name }} cluster:

1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.

1. Click the cluster name and open the **Monitoring** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

You will see the following charts:

* Under **Cluster**:

    * **SPQR is Alive, \[boolean\]**: Health status of [router hosts](../concepts/index.md#router).
    * **ETCD is Alive, \[boolean\]**: Health status of [coordinator hosts](../concepts/index.md#coordinator).
    * **Maximum CPU usage**: Peak processor core load.
    * **Average CPU usage**: Average processor core workload.
    * **Maximum memory usage**: Peak RAM usage (in bytes). At high loads, the value of the **Free space** metric decreases, while the others increase.

* **Sessions** → **Sessions count**: Number of active client connections to the router.

* **Connections** → **Backend connections count**: Number of active connections from the router to [shard](../concepts/index.md#shard) hosts.

* Under **Network**:

    * **Packets received/sent**: Network packet exchange rate, in packets per second.
    * **Network received/sent bytes**: Total amount of received and sent data, in bytes.

* Under **Time quantiles**:

    * **Router time quantiles, ms**: Execution time of client requests to each router at the quantiles set by the **Time Quantiles** [configuration](../concepts/settings-list.md).
    * **Shard time quantiles, ms**: Execution time of requests from the router to shard hosts at the quantiles set by the **Time Quantiles** configuration.

## Host state monitoring {#monitoring-hosts}

To view detailed information about the status of individual {{ mspqr-name }} hosts:

1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Click the cluster name and open the **Monitoring** → **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
1. Click the line of the host in the list.

This page displays workload charts for an individual cluster host:

* **CPU usage**: Processor core workload. With increased workload, the **Idle** value drops.
* **Memory usage**: Use of RAM, in bytes. At high loads, the value of the **Free space** metric decreases, while the others increase.
* **Packets received/sent**: Network packet exchange rate, in packets per second.
* **Network received/sent bytes**: Total amount of received and sent data, in bytes.
* Under **Time quantiles**:
    * **Router time quantiles, ms**: Execution time of client requests to router at the quantiles set by the **Time Quantiles** [configuration](../concepts/settings-list.md).
    * **Shard time quantiles, ms**: Execution time of requests from the router to shard hosts at the quantiles set by the **Time Quantiles** configuration.


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure automatic monitoring of key cluster health metrics:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to set up alerts.
    1. [Go to](../../console/operations/select-service.md#select-service) ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select:
        * **{{ mspqr-name }} — Cluster Overview** to configure cluster alerts.
        * **{{ mspqr-name }} — Host Overview** to set up host alerts.
    1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
    1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud.common.continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} guides](../../monitoring/concepts/querying.md).
    1. Set the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` thresholds to trigger the alert.
    1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values for selected metrics:

| Metric                                         |   Designation   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` |
|-------------------------------------------------|:---------------:|:-----------------------------------------------------------------------:|:----------------------------------------------------------------------:|
| Number of healthy router hosts      | `spqr-is-alive` |                   `<number_of_router_hosts> - 2`                    |                   `<number_of_router_hosts> - 1`                   |
| Number of healthy coordinator hosts | `etcd-is-alive` |                 `<number_of_coordinator_hosts> - 2`                 |                `<number_of_coordinator_hosts> - 1`                 |


## Cluster health and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view cluster health and status:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster health states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
