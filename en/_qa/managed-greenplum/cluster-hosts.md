# {{ mgp-short-name }} clusters and hosts

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which replication can be configured.

#### How many DB hosts can a cluster contain? {#how-many-hosts}

A {{ mgp-short-name }} cluster includes a minimum of 4 hosts:

* 2 master hosts.
* 2 segment hosts.

You can increase the number of segment hosts up to 32.

For more information, see [{#T}](../../managed-greenplum/concepts/limits.md).

#### How many clusters can you create in a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-greenplum/concepts/limits.md).

#### How do I maintain database clusters? {#service-window}

Maintenance in {{ mgp-short-name }} implies:

* Automatic installation of DBMS updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mgp-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-greenplum/concepts/maintenance.md).


#### How is the cost of usage calculated for a database host? {#db-cost}

In {{ mgp-short-name }}, the usage cost is calculated based on the following parameters:

* Selected host class.
* Size of the storage reserved for the database host.
* Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-greenplum/pricing/index.md).
* Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in [{#T}](../../managed-greenplum/pricing/index.md).


#### Why is a cluster working slowly even though it still has free computing resources? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../../managed-greenplum/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-greenplum/operations/cluster-backups.md#restore) from a backup.
