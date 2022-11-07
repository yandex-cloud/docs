# Monitoring and logs

#### What metrics and processes can be tracked using monitoring? {#monitoring-metrics}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
- The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ PG }}, you can track:
- Average query execution time
- Number of queries per second
- Number of errors in logs.

Monitoring can be performed with a minimum granularity of 5 seconds.

#### How is log storage charged? {#logging-pricing}

Logs of any level are written to a disk's system partition with 20 GB allocated, so you are not charged for them separately. The size of the logs created only affects log rotation frequency.

#### How do I track the amount of free storage space on ZooKeeper hosts? {#zookeeper-storage}

Follow the instructions in [{#T}](../../managed-clickhouse/operations/monitoring.md) to track the host state or set up alerts.
