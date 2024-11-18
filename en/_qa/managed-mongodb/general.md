#### What is {{ mmg-short-name }}? {#what-is}

{{ mmg-short-name }} is a service that helps you create, operate, and scale {{ MG }} databases in a cloud infrastructure.

With {{ mmg-short-name }}, you can:
- Create a database with the required performance characteristics.
- Scale processing power and storage dedicated for your databases.
- Get database logs.

{{ mmg-short-name }} takes on time-consuming {{ MG }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You interact with database clusters in {{ mmg-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app requirements.


#### What part of database management and maintenance is {{ mmg-short-name }} responsible for? {#services}

When you create clusters, {{ mmg-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mmg-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mmg-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks are best addressed using {{ mmg-short-name }}, and which using VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mmg-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which replication can be configured.


#### How do I get started with {{ mmg-short-name }}? {#quickstart}

{{ mmg-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mmg-short-name }}, you need to define its parameters:

- [Host class](../../managed-mongodb/concepts/instance-types.md) (performance characteristics, such as CPUs, RAM, etc.).
- [Disk type](../../managed-mongodb/concepts/storage.md) and size (reserved in full when creating a cluster).
- Network your cluster will be connected to.
- Number of hosts for the cluster and the availability zone for each of them.

For detailed instructions, see [{#T}](../../managed-mongodb/quickstart.md).


#### How many database hosts can there be in one cluster? {#how-many-hosts}

The minimum number of hosts per cluster depends on the following:
* Selected [platform and host class](../../managed-mongodb/concepts/instance-types.md).
* Selected [disk type](../../managed-mongodb/concepts/storage.md).

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [Quotas and limits](../../managed-mongodb/concepts/limits.md).


#### How can I access a running DB host? {#db-access}

You can connect to {{ mmg-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-mongodb/operations/connect/index.md).


#### How many clusters can I create within a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../managed-mongodb/concepts/limits.md).


#### How are DB clusters maintained? {#service-window}

In {{ mmg-short-name }}, maintenance implies:

- Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mmg-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-mongodb/concepts/maintenance.md).

#### Which {{ MG }} version does {{ mmg-short-name }} use? {#dbms-version}

{{ mmg-short-name }} supports {{ MG }} versions 5.0 and 6.0 Community Edition.


#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is updated after a short testing period. Owners of the affected DB clusters are notified of expected work times and DB availability in advance.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mmg-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-mongodb/pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. You can find the cost per hour data for each host class in the [Pricing policy](../../managed-mongodb/pricing.md) section.

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size from the [management console]({{ link-console-main }}). All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.


#### Is database host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ MG }}, a full backup is performed once a day with the possibility to restore it to any saved backup.

By default, backups are stored for seven days.

#### When are backups performed? Is a database cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Can I change the retention period of automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../managed-mongodb/operations/cluster-create.md) or [modifying](../../managed-mongodb/operations/update.md#change-additional-settings) a cluster.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster host class.
- Amount of data in the DB cluster and the remaining free space in the data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ MG }}, you can track:
- Number of queries per second.
- Amount of disk space used.
- Number of connections, and so on.

Monitoring can be performed with a minimum granularity of five seconds.

#### How do I set up an alert that triggers as soon as a certain percentage of disk space has been used up? {#disk-space-percentage}

[Create an alert](../../managed-mongodb/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mmg-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 70% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `75161927680` bytes (70%)
