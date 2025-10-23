#### What is {{ mmg-short-name }}? {#what-is}

{{ mmg-short-name }} is a solution that helps you create, operate, and scale {{ SD }} databases in the cloud.

With {{ mmg-short-name }}, you can:
- Create a database with the required performance characteristics.
- Scale processing power and storage dedicated for your databases.
- Get database logs.

{{ mmg-short-name }} takes over time-consuming {{ SD }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You work with a {{ mmg-short-name }} database cluster as if it were a regular database in your local infrastructure This allows you to manage internal database settings to meet your app requirements.


#### What is {{ mmg-short-name }}'s share of database management and maintenance work? {#services}

When you create clusters, {{ mmg-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mmg-short-name }} automatically creates backups and applies fixes and updates.

{{ mmg-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mmg-short-name }} or VMs running databases?

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mmg-short-name }}: Enables you to operate template databases without needing to manage their administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud with dedicated computing resources and reserved storage capacity.

A _database cluster_ is one or more database hosts with the option to configure replication.


#### How do I get started with {{ mmg-short-name }}? {#quickstart}

{{ mmg-short-name }} is available to all registered {{ yandex-cloud }} users.

To create a database cluster in {{ mmg-short-name }}, you need to define its settings:

- [Host class](../../storedoc/concepts/instance-types.md) (performance parameters, such as CPUs, RAM, etc.).
- [Disk type](../../storedoc/concepts/storage.md) and size (reserved in full when creating a cluster).
- Network your cluster will be connected to.
- Number of hosts for the cluster and the availability zone for each of them.

For detailed instructions, see [{#T}](../../storedoc/quickstart.md).


#### How many database hosts does a cluster support? {#how-many-hosts}

The minimum number of hosts per cluster depends on the following:
* Selected [platform and host class](../../storedoc/concepts/instance-types.md).
* Selected [disk type](../../storedoc/concepts/storage.md).

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [Quotas and limits](../../storedoc/concepts/limits.md).


#### How can I access a running DB host? {#db-access}

You can connect to {{ mmg-short-name }} databases using standard DBMS methods.

Learn more about connecting to clusters [here](../../storedoc/operations/connect/index.md).


#### How many clusters can I create within a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../storedoc/concepts/limits.md).


#### How are DB clusters maintained? {#service-window}

In {{ mmg-short-name }}, maintenance implies:

- Automatic installation of DBMS updates and fixes for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mmg-short-name }} maintenance activities.

For more information, see [Maintenance](../../storedoc/concepts/maintenance.md).

#### Which {{ SD }} version does {{ mmg-short-name }} use? {#dbms-version}

{{ mmg-short-name }} supports {{ SD }} versions {{ versions.console.str }}.


#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is updated after a short testing period. Owners of the affected DB clusters are notified of expected work times and DB availability in advance.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mmg-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mmg-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged based on the [pricing policy](../../storedoc/pricing.md).
- Database host uptime in hours. Partial hours are rounded up to the nearest whole hour. You can find the cost per hour for each host class in the [Pricing policy](../../storedoc/pricing.md) section.

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size from the [management console]({{ link-console-main }}). All you need to do is choose a different host class for the required cluster.

The cluster settings update within 30 minutes. This period may also include other cluster maintenance activities, such as installing updates.


#### Is database host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ SD }}, a full backup is performed once a day with the possibility to restore it to any saved backup.

By default, backups are stored for seven days.

#### When are backups created? Is a database cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Can I change the retention period for automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../storedoc/operations/cluster-create.md) or [modifying](../../storedoc/operations/update.md#change-additional-settings) a cluster.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, and disk usage as a percentage of the set limits for the relevant cluster host class.
- Amount of data in a DB cluster and the remaining free space in your data storage.

For DB hosts, you can monitor metrics specific to their type of DBMS. For example, for {{ SD }}, you can track:
- Number of queries per second.
- Disk space used.
- Number of connections, etc.

Monitoring can be performed with a minimum granularity of five seconds.

#### How do I set up an alert that triggers as soon as a certain percentage of disk space has been used up? {#disk-space-percentage}

[Create an alert](../../storedoc/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mmg-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 70% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `75161927680` bytes (70%)
