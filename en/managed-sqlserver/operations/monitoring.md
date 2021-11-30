# Monitoring the state of a cluster and hosts

You can track the status of a {{ mms-name }} cluster and its individual hosts using:

* Monitoring tools in the management console on the cluster page.
* In [{{ monitoring-full-name }}](../../monitoring/).

They provide diagnostic information in the form of charts that are updated every {{ graph-update }}.

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mms-name }} cluster status:

1. Go to the folder page and select **{{ mms-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

The following charts open on the page:

* **Is alive [bool]**: Shows cluster availability as the sum of its hosts' states.

    Each **Alive** host increases the overall availability by 1.

* **Active Transactions [count]**: The number of active transactions in the cluster.

* **Transactions/sec on primary**: The average number of transactions executed on the primary replica per second.

* **Disk capacity on primary, [bytes]**: Disk capacity on the primary replica (in bytes):
    * **Used Space**: Used disk space.
    * **Available Space**: Free disk space.

* **Is Primary [bool]**: Shows which host is the primary replica and for how long.

* **Lazy Writes/sec on primary**: The physical write speed on the primary replica. {{ MS }} splits data writes to make storage usage more efficient:

    * _Logical writes_: Updating data in RAM.
    * _Physical writes_: Writing modified pages from RAM to storage.

    For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/relational-databases/writing-pages).

* **User connections**: The number of cluster connections.

    Some connections will always be active. They are used by the cluster itself and {{ yandex-cloud }} services that are responsible for monitoring its state.

* **Page Life Expectancy [sec]**: Shows how long (in seconds) pages stay in memory before they're written to storage.

    The larger its value, the more efficiently the buffer is used and the less often the cluster has to access storage to fetch the necessary data.

* **CPU**: The percentage of CPU operating modes in time:
    * **percent_user_time**: User mode.
    * **percent_processor_time**: The total processor time under load (when it is not idle).
    * **percent_privileged_time**: Kernel mode.
    * **percent_interrupt_time**: Handling interrupts.
    * **percent_idle_time**: Standby mode.

* **Batch Requests/sec**: The number of batch operations performed on each host per second.

    For more information about batch operations, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/odbc/reference/develop-app/batches-of-sql-statements).

* **Memory Grants Pending on primary**: The number of queries waiting for a memory grant.

    For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/relational-databases/memory-management-architecture-guide).

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mms-name }} hosts:

1. Go to the folder page and select **{{ mms-name }}**.
1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
1. Select the host from the drop-down list.

This page displays the following charts:

* **Active Transactions**: The number of active transactions per database.

* **SQL Errors [count]**: The number of SQL query handling errors:

    * **User_Errors**: User errors.
    * **Kill_Connection_Errors**: Fatal errors that killed the connection.
    * **Info_Errors**: The number of information events related to errors.
    * **DB_Offline_Errors**: Errors due to DB unavailability.
    * **Total**: The total number of errors on the host.

* **Page Life Expectancy**: Shows how long (in seconds) pages stay in memory before they're flushed to storage.

    The larger its value, the more efficiently the buffer is used and the less often the cluster has to access storage to read and write the necessary data.

* **Packets send/received**: The number of processed network packets:

    * **packets_received_discarded**: The number of discarded packets.

        Packets may be discarded for the following reasons:

        * Transfer errors.
        * Formatting errors.
        * Insufficient storage space.

        Although some packets are always discarded, an increase in this metric value may indicate cluster operation issues.

    * **packets_outbound_errors**: The number of errors when sending packets.
    * **packets_received_errors**: The number of errors when receiving packets.
    * **packets_received_persec**: The average number of packets sent per second.
    * **packets_sent_persec**: The average number of packets received per second.

* **Bytes send/received**: The average number of bytes per second:
    * **bytes_received_persec**: Bytes received from the network.
    * **bytes_sent_persec**: Bytes sent to the network.

* **User connections**: The average number of cluster connections.

    Some connections will always be active. They are used by the cluster itself and {{ yandex-cloud }} services that are responsible for monitoring its state.

* **Disk read/write time**: The average amount of time it takes to write data to or read it from storage (in milliseconds).

* **Space used/available**: How much of the host's space is used and available (in bytes).

* **Disk Bytes**: The average size of data written to and read from the storage (in bytes).

* **CPU (processor time)**: vCPU usage (%):
    * **Interrupt Time**: Handling interrupts.
    * **User Time**: Operation in user mode.
    * **Privileged Time**: Operation in kernel mode.

* **Memory Grants Pending**: The number of queries waiting for a memory grant on the host.

* **Disk Latency**: The delay in storage response (ms):
    * **avg._disk_sec/transfer**: The average time it takes to perform I/O operations.
    * **avg._disk_sec/write**: The average data write time.
    * **avg._disk_sec/read**: The average data read time.
