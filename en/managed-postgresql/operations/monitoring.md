---
title: "Monitoring the state of a PostgreSQL cluster and hosts"
description: "You can monitor the health of a Managed Service for PostgreSQL cluster and its individual hosts using the monitoring tools in the management console. These tools provide diagnostic information in the form of graphs."
---

# Monitoring the state of a cluster and hosts

Using monitoring tools in the management console, you can track the status of a {{ mpg-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

Chart update rate:

* Standard hosts and hosts with an increased RAM to vCPU ratio (`memory-optimized`): {{ graph-update }}.
* Hosts with a guaranteed vCPU share under 100% (`burstable`): {{ graph-update-burstable }}.

## Cluster status monitoring {#monitoring-cluster}

To view detailed information about the {{ mpg-name }} cluster status:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click on the name of a cluster and open the **Monitoring** tab.

The following charts open on the page:

- **Statements, (count)**: The total number of running queries.

- **Average statement time, (ms)**: The average query execution time in milliseconds.

- **Transactions, (count)**: The number of transactions running on the cluster.

- **Average transaction time, (ms)**: The average transaction execution time in milliseconds.

- **PostgreSQL connections, (count)**: The number of DB connections:

    - **Active**: Active connections.

    - **Waiting**: Pending connections.

    - **Idle**: Idle server connections.

    - **Idle in transaction**: Idle connections in a transaction.

    - **Aborted**: Aborted connections.

      A large number of **Aborted** or **Idle in transaction** connections may indicate that the cluster is overloaded.

- **Pooler connections, (count)**: The number of pooler connections:
    - **Free servers**: Free server connections.
    - **Free clients**: Free client connections.
    - **Used servers**: Active server connections.
    - **Used clients**: Active client connections.

- **Sessions CPU usage, (count)**: The number of server connections using the CPU.

- **Sessions read bytes, (count)**: The amount of data read.

- **Sessions write bytes, (count)**: The amount of data written.

- **Sessions per wait events, (count)**: The number of server connections waiting for certain events.

- **Disk capacity on primary, (bytes)**: The primary node's disk capacity in bytes:

    - **Free**: Free disk space.

    - **Used**: Used disk space.

      If the memory usage chart has a saw-tooth shape, this may indicate a high load on the cluster.

- **Replication lag, (seconds)**: The number of seconds that the replica lags behind the master.

  A non-zero value indicates long-running queries on the replica or its overload. For more information, see [Replication](../concepts/replication.md).

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mpg-name }} hosts:

1. Go to the folder page and select **{{mpg-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Go to the **Monitoring** page.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

- **CPU**: The loading of processor cores. As the load goes up, the **Idle** value goes down.
- **Memory**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
- **Disk Bytes**: The average size of data written to and read from the storage (in bytes).
- **Disk IOPS**: The average number of I/O operations in the storage.
- **Network Bytes**: The average size of data sent to and received from the network (in bytes).
- **Network Packets**: The average number of packets sent to and received from the network.

The **Read** and **Write** characteristics on the **Disk Bytes** and **Disk IOPS** charts grow with the active reading from the database and the writing to it, respectively.

For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

