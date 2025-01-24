#### What is {{ mmy-short-name }}? {#what-is}

{{ mmy-short-name }} is a service that helps you create, operate, and scale {{ MY }} databases in a cloud infrastructure.

With {{ mmy-short-name }}, you can:
- Create a database with the required performance characteristics.
- Scale processing power and storage dedicated for your databases as needed.
- Get database logs.

{{ mmy-short-name }} takes on time-consuming {{ MY }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You interact with database clusters in {{ mmy-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app requirements.


#### What part of database management and maintenance is {{ mmy-short-name }} responsible for? {#services}

When you create clusters, {{ mmy-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mmy-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mmy-short-name }} also allows you to replicate data between database hosts (both within and across [availability zones](../../overview/concepts/geo-scope.md)) and automatically routes the load to a backup replica in the event of a failure.

#### Which tasks are best addressed using {{ mmy-short-name }}, and which using VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mmy-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, etc.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which you can configure replication.


#### How do I get started with {{ mmy-short-name }}? {#quickstart}

{{ mmy-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mmy-short-name }}, you need to define its parameters:

- [Host class](../../managed-mysql/concepts/instance-types.md) (performance characteristics, such as CPUs, RAM, etc.).
- Storage size (reserved to the full extent when you create a cluster).
- Network your cluster will be connected to.
- Number of hosts for the cluster and the availability zone for each host.

For more information, see [Getting started](../../managed-mysql/quickstart.md).

#### How many database hosts can there be in one cluster? {#how-many-hosts}

The minimum number of hosts depends on the selected type of [storage](../../managed-mysql/concepts/storage.md):

* A minimum of three hosts for these disks:

   * Local SSDs (`local-ssd`)
   * Non-replicated SSDs (`network-ssd-nonreplicated`)

* At least one host for the following:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)   * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)



The maximum number of hosts per cluster is subject to the limits in place.

For more information, see [Quotas and limits](../../managed-mysql/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mmy-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-mysql/operations/connect.md).


#### How many clusters can I create within a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../managed-mysql/concepts/limits.md).


#### How are DB clusters maintained? {#service-window}

In {{ mmy-short-name }}, maintenance implies:

- Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mmy-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-mysql/concepts/maintenance.md).

#### Which {{ MY }} version does {{ mmy-short-name }} use? {#dbms-version}

{{ mmy-short-name }} supports {{ MY }} 5.7 and {{ MY }} 8.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. Owners of the affected DB clusters are notified of expected work times and DB availability in advance.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mmy-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mmy-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-mysql/pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. You can find the cost per hour for each host class in the [Pricing policy](../../managed-mysql/pricing.md) section.

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.


#### Is database host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ MY }}, a full backup takes place once a day and saves all DB cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups performed? Is a database cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Can I change the retention period of automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../managed-mysql/operations/cluster-create.md) or [modifying](../../managed-mysql/operations/update.md#change-additional-settings) a cluster.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster host class.
- Amount of data in the DB cluster and the remaining free space in the data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ MY }}, you can track:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs, etc.

Monitoring can be performed with a minimum granularity of 5 seconds.



{% include [fz-152.md](../../_qa/fz-152.md) %}


{% include [logs](../logs.md) %}
