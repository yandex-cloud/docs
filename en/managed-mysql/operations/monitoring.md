---
title: "Monitoring the state of a MySQL cluster and hosts"
description: "You can monitor the health of a Managed Service for MySQL cluster and its individual hosts using the monitoring tools in the management console. These tools provide diagnostic information in the form of graphs."
---

# Monitoring the state of a cluster and hosts

Using monitoring tools in the management console, you can track the status of a{{ mmy-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

## Cluster status monitoring {#monitoring-cluster}

To view detailed information about the {{ mmy-name }} cluster status:

1. Go to the folder page and select **{{ mmy-name }}**.
1. Click on the name of a cluster and open the **Monitoring** tab.

The following charts open on the page:

- **Threads**: The number of threads started by the `mysqld` daemon.

    - **Threads connected**: The number of opened threads.

        If the chart is close to the maximum value, it may mean that open connections can't be closed.

        The maximum value is set by the `max_connections` parameter specified in [{{ MY }} additional settings](update.md#change-mysql-config).

    - **Threads running**: The number of active threads.

        As the load on the cluster increases, this value rapidly grows.

    - **Threads cached**: The number of cached threads.

       During normal cluster operation, the `mysqld` process caches most of the connections.

- **Is Alive**: Shows the cluster availability as the sum of states of its hosts.

    Each **Alive** host increases the overall availability by 1. When one of the hosts fails, the overall availability is reduced by 1.
To increase the availability of a cluster, you can [add hosts](hosts.md#add).

- **Queries**: The average number of requests sent to the cluster (per second).

- **Slow Queries**: The number of SQL queries running longer than specified in the [long_query_time](update.md#change-mysql-config) `parameter`.

- **Is Primary**: Shows which host is the master and for how long.

- **Disk usage on master, [bytes]**: Shows how space is used on the current master host. The chart displays (in bytes):

    - **Free**: The amount of free space in the storage.

    - **Used binlogs** and **Used relaylogs**: The volume used by {{ MY }} service logs. To learn more about [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html), see the documentation for {{ MY }}.

    - **Used**: The volume used by data.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mmy-name }} hosts:

1. Go to the folder page and select **{{mmy-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Go to the **Monitoring** page.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

- **CPU**: The loading of processor cores. As the load goes up, the **Idle** value goes down.

- **Memory**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down and the values of the **Used** and other parameters go up.

- **Disk Bytes**: The average size of data written to and read from the storage (in bytes).

- **Disk IOPS**: The average number of I/O operations in the storage.

- **Network Bytes**: The average size of data sent to and received from the network (in bytes).

- **Network Packets**: The average number of packets sent to and received from the network.

The **Read** and **Write** characteristics on the **Disk Bytes** and **Disk IOPS** charts grow with the active reading from the database and the writing to it, respectively.

For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.