#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ is one or more database hosts that allow configuring replication between them.

#### How many database hosts can be in a cluster? {#how-many-hosts}

A {{ GP }} cluster includes a minimum of four hosts:

* two master hosts
* two segment hosts

You can increase the number of segment hosts up to 32.

For more information, see [Quotas and limits](../../managed-greenplum/concepts/limits.md).

#### How many clusters can you create in a single cloud? {#db-limit}

To learn more about MDB technical and organizational limitations, see [Quotas and limits](../../managed-greenplum/concepts/limits.md).

#### How are database clusters maintained? {#service-window}

In {{ mgp-short-name }}, maintenance implies:

* Automatic installation of DBMS updates and fixes for your database hosts.
* Changes in the host class and storage size.
* Other {{ mgp-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-greenplum/concepts/maintenance.md).


#### How do you calculate the usage cost for a database host? {#db-cost}

In {{ mgp-short-name }}, the usage cost is calculated based on the following variables:

* Selected host class.
* Reserved storage capacity for the database host.
* Size of database cluster backups. You do not pay for backups as long as their size does not exceed the storage capacity. Additional backup storage is charged according to our [pricing policy](../../managed-greenplum/pricing/index.md).
* Database host uptime in hours. Partial hours are rounded to the nearest whole hour. For the hourly rates of each host class, see our [pricing policy](../../managed-greenplum/pricing/index.md).


#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when [updating your cluster](../../managed-greenplum/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-greenplum/operations/cluster-backups.md#restore) from a backup.

#### Why do I get a minimum memory error for {{ GP }} processes? {#memory-limit}

When creating, modifying, or restoring a cluster, you may get this error:

```text
Per process memory must be more then '20971520' bytes on segment host, got '<calculated_memory_size>'
```

This error occurs if the memory size for each {{ GP }} process is less than 20 MB and the number of connections equals the [max_connections](../../managed-greenplum/concepts/settings-list.md#setting-max-connections) value. The minimum memory per cluster process is calculated using the following formula:

```text
<host_segment_RAM> ÷ (<max_connections> x <number_of_segments_per_host>)
```

To fix the error, do one of the following:

* Reduce the `max_connections` value.
* Increase the memory size by changing the [segment host class](../../managed-greenplum/concepts/instance-types.md).
