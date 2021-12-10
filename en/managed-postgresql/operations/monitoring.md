---
title: "Monitoring the state of a PostgreSQL cluster and hosts"
description: "You can monitor the health of a Managed Service for PostgreSQL cluster and its individual hosts using the monitoring tools in the management console. These tools provide diagnostic information in the form of graphs."
---
# Monitoring the state of a cluster and hosts

Using monitoring tools in the management console, you can track the status of a{{ mpg-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

Chart update rate:

* Standard hosts and hosts with an increased RAM to vCPU ratio (`memory-optimized`): {{ graph-update }}.
* Hosts with a guaranteed vCPU share under 100% (`burstable`): {{ graph-update-burstable }}.

You can also configure [{{ monitoring-full-name }} service alerts](#monitoring-integration) to monitor a cluster's status automatically. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If a specified threshold is exceeded, you will receive an alert.

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mpg-name }} cluster status:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

The following charts open on the page:

- **Average statement time, (ms)**: The average query execution time in milliseconds.

- **Average transaction time, (ms)**: The average transaction execution time in milliseconds.

- **Disk capacity on primary, (bytes)**: The primary node's disk capacity in bytes:

    - **Free**: Free disk space.

    - **Used**: Used disk space.

      If the memory usage chart has a saw-tooth shape, this may indicate a high load on the cluster.

- **Pooler connections, (count)**: The number of pooler connections:
    - **Free servers**: Free server connections.
    - **Free clients**: Free client connections.
    - **Used servers**: Active server connections.
    - **Used clients**: Active client connections.
	
- **PostgreSQL connections, (count)**: The number of DB connections:

    - **Active**: Active connections.

    - **Waiting**: Pending connections.

    - **Idle**: Idle server connections.

    - **Idle in transaction**: Idle connections in a transaction.

    - **Aborted**: Aborted connections.

      A large number of **Aborted** or **Idle in transaction** connections may indicate that the cluster is overloaded.

- **Replication lag, (seconds)**: The number of seconds that the replica lags behind the master.

  A non-zero value indicates long-running queries on the replica or its overload. For more information, see [Replication](../concepts/replication.md).
  
- **Sessions CPU usage, (count)**: The number of server connections using the CPU.

- **Sessions per wait events, (count)**: The number of server connections waiting for certain events.

- **Sessions read bytes, (count)**: The amount of data read.

- **Sessions write bytes, (count)**: The amount of data written.

- **Statements, (count)**: The total number of running queries.

- **Transactions, (count)**: The number of transactions running on the cluster.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mpg-name }} hosts:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

- **CPU**: The loading of processor cores. As the load goes up, the **Idle** value goes down.
- **Disk Bytes**: The average size of data written to and read from the storage (in bytes).
- **Disk IOPS**: The average number of I/O operations in the storage.
- **Memory**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
- **Network Bytes**: The average size of data sent to and received from the network (in bytes).
- **Network Packets**: The average number of packets sent to and received from the network.

The **Disk bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To set up [cluster](#monitoring-cluster) and [host](#monitoring-hosts) status metric alerts:

1. In the Management console, select the folder with the cluster you wish to configure alerts for.
1. Click the ![image](../../_assets/ugly-sandwich.svg) icon and select **Monitoring**.
1. Under **Service dashboards**, select:
    - **{{ mpg-name }} — Cluster Overview** to configure cluster alerts.
    - **{{ mpg-name }} — Host Overview** to configure host alerts.
1. On the desired metrics chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more on the query language, [see the {{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
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
| Storage space used | `disk.used_bytes` | 95% of storage size | 80% of storage size |

