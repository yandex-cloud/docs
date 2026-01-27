#### What is {{ mmg-short-name }}? {#what-is}

{{ mmg-short-name }} is a solution that helps you create, operate, and scale {{ SD }} databases in the cloud.

With {{ mmg-short-name }}, you can:
- Create a database with the performance specs tailored to your needs.
- Scale processing power and storage dedicated for your databases.
- Get database logs.

{{ mmg-short-name }} takes over time-consuming administrative tasks in {{ SD }}:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps your DBMS software up to date.

You work with a {{ mmg-short-name }} database cluster just like with your regular local database. Thus, you can manage internal database settings to meet your application requirements.


#### What is the role of {{ mmg-short-name }} in database management and maintenance? {#services}

When you create clusters, {{ mmg-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mmg-short-name }} automatically creates backups as well as applies DBMS patches and updates.

{{ mmg-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mmg-short-name }} or VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- With {{ mmg-short-name }}, you can use template databases, with no administrative effort required.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases over SSH, and so on.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ consists of one or more database hosts with configurable replication between them.


#### How do I get started with {{ mmg-short-name }}? {#quickstart}

{{ mmg-short-name }} is available to all registered {{ yandex-cloud }} users.

Before creating a database cluster in {{ mmg-short-name }}, you need to decide on its configuration:

- [Host class](../../storedoc/concepts/instance-types.md) that will determine your computing power, i.e., vCPUs, RAM, and more.
- [Disk type](../../storedoc/concepts/storage.md) and size (reserved in full when creating a cluster).
- Network for your cluster.
- Number of hosts for the cluster and the availability zone for each of them.

Learn more in [{#T}](../../storedoc/quickstart.md).


#### How many database hosts can there be in a cluster? {#how-many-hosts}

The minimum number of hosts in a cluster depends on the following:
* Selected [platform and host class](../../storedoc/concepts/instance-types.md).
* Selected [disk type](../../storedoc/concepts/storage.md).

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [Quotas and limits](../../storedoc/concepts/limits.md).


#### How can I access a running database host? {#db-access}

You can connect to {{ mmg-short-name }} databases using conventional DBMS methods.

Learn more about connecting to clusters in [this guide](../../storedoc/operations/connect/index.md).


#### How many clusters can I create within a single cloud? {#db-limit}

To learn more about MDB technical and organizational limitations, see [Quotas and limits](../../storedoc/concepts/limits.md).


#### How are database clusters maintained? {#service-window}

Maintenance in {{ mmg-short-name }} includes:

- Automatic installation of DBMS updates and patches for database hosts (including for stopped clusters).
- Changes in the host class and storage size.
- Other {{ mmg-short-name }} maintenance activities.

For more information, see [Maintenance](../../storedoc/concepts/maintenance.md).

#### Which {{ SD }} version does {{ mmg-short-name }} use? {#dbms-version}

{{ mmg-short-name }} supports {{ SD }} versions {{ versions.console.str }}.


#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is updated after a short testing period. Owners of the affected DB clusters are notified of expected work times and DB availability in advance.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mmg-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

For clusters with a deprecated DBMS version, there is no option to create new hosts or restore from backups. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mmg-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Reserved storage capacity for the database host.
- Size of database cluster backups. You do not pay for backups as long as their size does not exceed the storage capacity. Additional backup storage is charged according to our [pricing policy](../../storedoc/pricing.md).
- Database host uptime in hours. Partial hours are rounded to the nearest whole hour. For the cost per hour of operation for each host class, see our [pricing policy](../../storedoc/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can scale your computing resources and storage size directly in the [management console]({{ link-console-main }}) by selecting a different host class for your cluster.

The cluster settings will update within 30 minutes. This window may also be used for other maintenance tasks, such as installing updates.


#### Are database host backups enabled by default? {#default-backup}

Yes, backups are enabled by default. For {{ SD }}, a full backup is performed once a day with the possibility to restore it to any saved backup.

By default, backups are stored for seven days.

#### When does a backup run? Is a database cluster available during backups? {#backup-window}

The backup window, the scheduled time for the database cluster’s full daily backup, is from 01:00 to 05:00 (UTC+3).

Clusters remain fully available during the backup window.

#### Can I change the retention period for automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../storedoc/operations/cluster-create.md) or [updating](../../storedoc/operations/update.md#change-additional-settings) a cluster.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:

- CPU, memory, network, and disk usage, in absolute terms.
- Memory, network, and disk usage as a percentage of the set limits for the relevant cluster's host class.
- Amount of data in a DB cluster and the remaining free space in your data storage.

For DB hosts, you can monitor metrics specific to their DBMS type. For example, for {{ SD }}, you can track:
- Number of queries per second.
- Disk space used.
- Number of connections, etc.

Monitoring can be performed with a minimum granularity of five seconds.

#### How do I set up an alert that triggers as soon as a certain percentage of disk space is used up? {#disk-space-percentage}

[Create an alert](../../storedoc/operations/monitoring.md#monitoring-integration) for the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mmg-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Their recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 70% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `75161927680` bytes (70%)
