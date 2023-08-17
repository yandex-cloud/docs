---
title: "{{ mrd-name }}. Questions and answers"
description: "What is {{ mrd-name }}? What tasks should I use {{ mrd-name }} for and for which VMs with databases? What part of database management and maintenance is {{ mrd-name }} responsible for? Find the answers to these and other questions in this article."
---

# General questions about {{ mrd-name }}

#### What is {{ mrd-short-name }}? {#what-is}

{{ mrd-short-name }} is a service that helps you create, operate, and scale {{ RD }} databases in a cloud infrastructure.

With {{ mrd-short-name }}, you can:
- Create a database with the required performance characteristics.
- Scale your processing power and storage size allocated to your databases as needed.
- Get database logs.

{{ mrd-short-name }} takes on time-consuming {{ RD }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You interact with database clusters in {{ mrd-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app's requirements.


#### What part of database management and maintenance is {{ mrd-short-name }} responsible for? {#services}

When creating clusters, {{ mrd-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mrd-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mrd-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks should I use {{ mrd-short-name }} for and for which VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mrd-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, etc.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which replication can be configured.


#### How do I get started with {{ mrd-short-name }}? {#quickstart}

{{ mrd-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mrd-short-name }}, you must define its characteristics:

- [Host class](../concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
- [Disk type](../concepts/storage.md) and size (reserved in full when creating a cluster).
- The network your cluster will be connected to.
- The number of hosts for the cluster and the availability zone for each host.

For detailed instructions, see [{#T}](../quickstart.md).

#### How many DB hosts can a cluster contain? {#how-many-hosts}

The minimum number of hosts per cluster depends on the following:
* Selected [platform and host class](../concepts/instance-types.md).
* Selected [disk type](../concepts/storage.md).
* Whether you enabled [sharding](../concepts/sharding.md) when [creating](../operations/cluster-create.md) a cluster.

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [{#T}](../concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mrd-short-name }} databases using standard DBMS methods. However, there is one exception: {{ mrd-short-name }} hosts can only be accessed from {{ yandex-cloud }} VMs connected to the same network.


#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../concepts/limits.md).


#### How do I maintain database clusters? {#service-window}

Maintenance in {{ mrd-short-name }} implies:

- Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mrd-short-name }} maintenance activities.

For more information, see [{#T}](../concepts/maintenance.md).

#### Which version of {{ RD }} does {{ mrd-short-name }} use? {#dbms-version}

{{ mrd-short-name }} supports {{ RD }} versions {{ versions.console.str }}.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mrd-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version: seven days after notification for minor versions and one month for major versions. Deprecated major versions are upgraded even if you disabled automatic updates.


#### How is the cost of usage calculated for a database host? {#db-cost}

In {{ mrd-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at [special rates](../pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in [{#T}](../pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.


#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ RD }}, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
- The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ RD }}, you can track:
- Average query execution time
- Number of queries per second
- Number of errors in logs.

Monitoring can be performed with a minimum granularity of 5 seconds.

#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-redis/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mrd-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Here are their recommended values:

* `Alarm`: 90% of disk space.
* `Warning`: 80% of disk space.

The thresholds are only set in bytes. For example, here are the recommended values for a disk of 100 GB:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).


{% include [fz-152.md](../../_qa/fz-152.md) %}


{% include [logs](../../_qa/logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### Why is a cluster working slowly even though it still has free computing resources? {#throttling}

Perhaps, the maximum storage [IOPS and bandwidth](../../compute/concepts/storage-read-write.md) values are insufficient for processing the current number of requests. In this case, [throttling](../../compute/concepts/storage-read-write.md#throttling) is triggered and the performance of the entire cluster degrades.

The maximum IOPS and bandwidth values increase by a fixed value when the storage size increases by a certain step. The step and increment values depend on the disk type:

| Disk type | Step, GB | Max IOPS increase (read/write) | Max bandwidth increase (read/write), MB/s |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-ssd` | 32 | 1,000/1,000 | 15/15 |
| `network-ssd-nonreplicated` | 93 | 28,000/5,600 | 110/82 |

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../operations/update.md#change-disk-size).

Consider switching to a faster disk type by [restoring the cluster](../operations/cluster-backups.md#restore) from a backup.
