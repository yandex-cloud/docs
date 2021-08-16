# Monitoring the state of a cluster and hosts

Using monitoring tools in the management console, you can track the status of a {{ mrd-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

## Cluster status monitoring {#monitoring-cluster}

To view detailed information about the {{ mrd-name }} cluster status:

1. Go to the folder page and select **{{ mrd-name }}**.
1. Click on the name of a cluster and open the **Monitoring** tab.

The following charts open on the page:

* **Connected Clients, [count]**: Number of open connections for each cluster host.

    If a cluster is [sharded](../concepts/sharding.md) or uses [replication](../concepts/replication.md), some of the connections will be used for exchanging data between hosts in a cluster.
    Errors occuring when connecting to a cluster may result from inactive applications keeping connections open too long. If this is the case, change the value of [Timeout](../concepts/settings-list.md#settings-timeout) in the [DBMS settings](../operations/update.md#change-redis-config).

* **Command Processed**: Average number of queries processed by each host in a cluster.

* **Is Alive**: Shows cluster availability as the sum of its hosts' states.

    Each **Alive** host increases the overall availability by 1. When one of the hosts fails, the overall availability is reduced by 1.
    To increase the availability of a cluster, [add hosts](hosts.md#add).

* **Outer memory limit**: Shows the total memory available to the hosts:
    * **memory_limit**: The amount of memory allocated to each host.
    * **used_memory_rss**: Process memory usage by {{ RD }} processes.

    When the value of **used_memory_rss** approaches the value of **memory_limit**, a {{ RD }} process may be killed by the operating system. To avoid this:
    * Change the application logic to reduce the amount of data stored in {{ RD }}.
    * Go to [{{ RD }} settings](./update.md#change-redis-config) to change the value of [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy), which sets the memory management policy when memory is in short supply.
    * [Upgrade the host to a higher class](./update.md#change-resource-preset).

* **Inner memory limit**: Shows the amount of memory available to {{ RD }} processes:
    * **maxmemory**: Maximum amount of memory available to {{ RD }}.
    * **used_memory**: Actual memory usage by a host.

    If the value of **used_memory** becomes equal to the value of **maxmemory**, {{ RD }} will apply a memory management mode set by [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) when an attempt is made to insert new records.

    {% note info %}

    The value of **maxmemory** for Redis hosts is set equal to 75% of the available memory. For a host with 8 GB RAM for example, the value of **maxmemory** is 6 GB.

    {% endnote %}

* **Is Master**: Shows which host is and how long it has been master.

    With [sharding](../concepts/sharding.md) enabled, the graph will display information on master hosts in each shard.

* **Redis-server OOM kills**: Number of {{ RD }} processes terminated because of a shortage of RAM (_OOM_ stands for out-of-memory).

    To reduce the number of terminations:
    * Change the application logic to reduce the amount of data stored in {{ RD }}.
    * Go to [DBMS settings](./update.md#change-redis-config) to change the value of [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy), which sets the RAM management policy when RAM is in short supply.
    * [Upgrade the host to a higher class](./update.md#change-resource-preset).

* **Redis Used Memory on Masters**: Memory usage on master hosts:
    * **db_hashtable_overhead**: To store all database hash tables.
    * **used_memory_scripts**: To store and run [scripts](https://redis.io/commands/script-load).
    * **mem_aof_buffer**: For the [AOF](../concepts/replication.md#setting-appendonly) buffer.
    * **mem_clients_normal**: To service external connections.
    * **mem_clients_slaves**: To service replication connections.
    * **mem_replication_backlog**: For a circular replication buffer.
    * **used_memory_startup**: For {{ RD }} processes at startup (for example, after a cluster reboot).
    * **used_memory_dataset**: For data storage.

* **Replication Lag**: Delay between master and replica.

    A non-zero value indicates long-running queries on the replica or its overload.

    For more information, see [{#T}](../concepts/replication.md).

* **DB keys**: Number of keys stored in all the cluster's databases.

* **Redis Used Memory on Replicas**: RAM usage in replicated hosts:
    * **db_hashtable_overhead**: To store all database hash tables.
    * **used_memory_scripts**: To store and run [scripts](https://redis.io/commands/script-load).
    * **mem_aof_buffer**: For the [AOF](../concepts/replication.md#setting-appendonly) buffer.
    * **mem_clients_normal**: To service external connections.
    * **mem_clients_slaves**: To service replication connections.
    * **mem_replication_backlog**: For a circular replication buffer.
    * **used_memory_startup**: For {{ RD }} processes at startup (for example, after a cluster reboot).
    * **used_memory_dataset**: For data storage.

* **Replication buffer size**: [Replication](../concepts/replication.md#replication) buffer size:
    * **repl_backlog_size**: Maximum amount of memory available for the replication buffer.
    * **repl_backlog_histlen**: Portion of the replication buffer currently in use by data.

    When the circular buffer runs out of memory, complete replication starts. This reduces cluster performance, since complete replication significantly increases RAM usage as well as CPU and network workload.

* **Evicted keys**: Number of keys deleted from memory when inserting new data.

    By default, memory management uses a **noeviction** policy: do not delete keys and return an error if there is insufficient memory to insert new data. To use a different memory management policy, change the value of [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) in [{{ RD }} settings](./update.md#change-redis-config).

* **Client recent max output buffer size**: Memory usage to handle client connections to retrieve data:
    * **soft_limit**: Soft memory usage limit.
    * **hard_limit**: Hard memory usage limit.
    * **buffer**: Current amount of data in buffer.

    If the value of **buffer** reaches the **soft_limit**, the cluster will wait a few seconds for it to decrease. If the value of **buffer** does not decrease, the connection will be closed.
    If the value of **buffer** becomes equal to the value of **hard_limit**, the connection will shut down immediately.

* **Copy-on-write allocation**: Memory usage by {{ RD }} processes for [COW (Copy-on-write)](https://en.wikipedia.org/wiki/Copy-on-write).

    The graph shows the most recent parameter values measured by {{ RD }}:
    * **module_fork_last_cow_size**: Amount of data copied during a `fork()` call using the COW mechanism.
    * **aof_last_cow_size**: Amount of data copied when creating an AOF file.
    * **rdb_last_cow_size**: Amount of data copied when creating an RDB file.

    For more information, see [{#T}](../concepts/backup.md).

* **Cache Hit Rate**: Percentage of cache hits for each host.

    Values approaching 1 indicate efficient use of the cluster as a caching server. If the percentage of cache hits is closer to 0, you may need to modify the application logic, the key lifetime, or the [RAM shortage management policy](../concepts/settings-list.md#settings-maxmemory-policy).

* **Client recent max input buffer size**: Memory usage to support client connections for data writes.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mrd-name }} hosts:

1. Go to the folder page and select **{{ mrd-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Go to the **Monitoring** page.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

* **CPU**: The loading of processor cores. As the load goes up, the **Idle** value goes down.

* **Memory**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down and the values of the **Used** and other parameters go up.

* **Disk Bytes**: The average size of data written to and read from the storage (in bytes).

* **Disk IOPS**: The average number of I/O operations in the storage.

* **Network Bytes**: The average size of data sent to and received from the network (in bytes).

* **Network Packets**: The average number of packets sent to and received from the network.

The **Disk bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

