---
title: "Monitoring the state of a PostgreSQL cluster and hosts"
description: "You can monitor the health of a Managed Service for PostgreSQL cluster and its individual hosts using the monitoring tools in the management console. These tools provide diagnostic information in the form of graphs."
---
# Monitoring the state of a cluster and hosts

Using monitoring tools in the management console, you can track the status of a{{ mpg-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

{% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

You can also configure [{{ monitoring-full-name }} service alerts](#monitoring-integration) to monitor a cluster's status automatically. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If a specified threshold is exceeded, you will receive an alert.

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mpg-name }} cluster status:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

The following charts open on the page:

* **Average transaction/statement time**: Average transaction processing and operator execution time.
* **CPU usage**: Usage of processor cores.
* **Disk read/write bytes**: Disk read and write speed (bytes per second).
* **Disk read/write IOPS**: Disk read and write activity (ops per second).
* **Disk usage by DB**: Disk usage by database (bytes).
* **Disk usage on primary**: Disk usage on a master host (bytes).
* **Is Primary**: Shows which host is the master and for how long.
* **Log errors**: Number of logged errors per second.
* **Network received/sent bytes**: Network data transfer speed (bytes per second).
* **Packets received/sent**: Network packet transmission activity (packets per second).
* **Pooler is alive**: Pooler health for each host either as a master or as a replica.
* **PostgreSQL Alive**: PostgreSQL health for each host either as a master or as a replica.
* **Replication lag**: Replication delay.
* **Session CPU usage cores**: Number of utilized processor cores by session type.
* **Sessions per wait event**: Number of waiting sessions by wait type.
* **Sessions read bytes**: Amount of data read by session type (bytes).
* **Sessions write bytes**: Amount of data written by session type (bytes).
* **Statement quantiles**: Operator execution time by percentile.
* **TCP connections**: Number of TCP connections per second.
* **Total pooler connections**: Number of pooler connections, both client and server.
* **Total size of temporary files**: Total temporary file size (bytes).
* **Total size of WAL files**: Total [WAL file](../concepts/backup.md) size (bytes).
* **Transaction quantiles**: Transaction processing time by percentile.
* **Transactions/statements per second**: Number of transactions and operators per second.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mpg-name }} hosts:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

* **CPU usage**: Usage of processor cores. As the load goes up, the **Idle** value goes down.
* **Disk IOPS**: The number of disk operations per second.
* **Disk read/write bytes**: The speed of disk operations (bytes per second).
* **Memory usage**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Network Bytes**: The speed of data exchange over the network (bytes per second).
* **Network Packets**: The number of packets exchanged over the network per second.

The **Disk read/write bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To set up [cluster](#monitoring-cluster) and [host](#monitoring-hosts) status metric alerts:

1. In the management console, select the folder with the cluster you wish to configure alerts for.
1. Click the ![image](../../_assets/ugly-sandwich.svg) icon and select **Monitoring**.
1. Under **Service dashboards**, select:
    - **{{ mpg-name }} — Cluster Overview** to configure cluster alerts.
    - **{{ mpg-name }} — Host Overview** to configure host alerts.
1. On the desired metrics chart, click the ![options](../../_assets/horizontal-ellipsis.svg) icon and select **Create alert**.
1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. {% if audience == "external" %}For more on the query language, [see the {{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md). {% endif %}
1. Set the `Alarm` and `Warning` notification threshold values.
1. Click **Create alert**.

To have other cluster health indicators monitored automatically:

{% if audience == "external" %}
1. [Create an alert](../../monitoring/operations/alert/create-alert.md).
{% else %}
1. Create an alert.
{% endif %}
1. Add a status metric.
1. Set the alert threshold values in the alert settings.

Recommended threshold values:

| Metric | Parameter | `Alarm` | `Warning` |
| --------------------------------------- | :--------------------------: | :-------------------------: | :-------------------------: |
| Replication delay | `postgres-replication_lag` | `60` | `5` |
| Number of healthy hosts | `postgres-is_alive` | `<number of hosts> - 2` | `<number of hosts> - 1` |
| Average query execution time | `pooler-avg_query_time` | — | `2000` |
| Storage space used | `disk.used_bytes` | 90% of storage size | 80% of storage size |

