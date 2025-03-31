#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which you can configure replication.

#### How many database hosts can there be in one cluster? {#how-many-hosts}

A {{ mgp-short-name }} cluster includes a minimum of 4 hosts:

* 2 master hosts.
* 2 segment hosts.

You can increase the number of segment hosts up to 32.

For more information, see [Quotas and limits](../../managed-greenplum/concepts/limits.md).

#### How many clusters can you create in a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../managed-greenplum/concepts/limits.md).

#### How are DB clusters maintained? {#service-window}

In {{ mgp-short-name }}, maintenance implies:

* Automatic installation of DBMS updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mgp-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-greenplum/concepts/maintenance.md).


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mgp-short-name }}, the usage cost is calculated based on the following parameters:

* Selected host class.
* Size of the storage reserved for the database host.
* Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-greenplum/pricing/index.md).
* Number of hours of database host operation. Partial hours are rounded to an integer value. You can find the cost per hour for each host class in the [Pricing policy](../../managed-greenplum/pricing/index.md) section.


#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../../managed-greenplum/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-greenplum/operations/cluster-backups.md#restore) from a backup.

#### Why do I get the minimum memory error for {{ GP }} processes? {#memory-limit}

When creating, modifying, or restoring a cluster, you may get this error:

```text
Per process memory must be more then '20971520' bytes on segment host, got '<calculated_memory_size>'
```

This error occurs if the memory size for each {{ GP }} process is less than 20 MB and the number of connections equals the [max_connections](../../managed-greenplum/concepts/settings-list.md#setting-max-connections) value. Minimum memory per cluster process is calculated using the following formula:

```text
<host_segment_RAM> ÷ (<max_connections> x <number_of_segments_per_host>)
```

To fix the error, do one of the following:

* Reduce the `max_connections` value.
* Increase memory size by changing the [segment host class](../../managed-greenplum/concepts/instance-types.md).
