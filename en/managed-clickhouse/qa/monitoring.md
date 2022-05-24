# Monitoring and logs

#### What metrics and processes can be tracked using monitoring? {#monitoring-metrics}

For all DBMS types, you can track:

* CPU, memory, network, or disk usage, in absolute terms.
* Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
* The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ PG }}, you can track:

* Average query execution time.
* Number of queries per second.
* Number of errors in logs.

Monitoring can be performed with a minimum granularity of 5 seconds.

#### How is log storage charged? {#logging-pricing}

Logs of any level are written to a system disk partition for which 20 GB is allocated, so they are not charged separately. The size of created logs only affects the frequency of their rotation.

#### How do I monitor the free storage space of {{ ZK }} hosts? {#zookeeper-storage}

Follow the instructions in [{#T}](../operations/monitoring.md) to monitor the state of hosts and set up alerts.
