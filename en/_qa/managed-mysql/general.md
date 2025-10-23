#### What is {{ mmy-short-name }}? {#what-is}

{{ mmy-short-name }} is a solution that helps you create, operate, and scale {{ MY }} databases in the cloud.

With {{ mmy-short-name }}, you can:
- Create a database with the performance parameters tailored to your needs.
- Scale computing power and dedicated storage capacity for your databases as needed.
- Get database logs.

{{ mmy-short-name }} takes over time-consuming {{ MY }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You work with a {{ mmy-short-name }} database cluster as if it were a regular database in your local infrastructure This allows you to manage internal database settings to meet your app requirements.


#### What is {{ mmy-short-name }}'s share of database management and maintenance work? {#services}

When you create clusters, {{ mmy-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mmy-short-name }} automatically creates backups and applies fixes and updates.

{{ mmy-short-name }} also enables data replication between database hosts (both within and across [availability zones](../../overview/concepts/geo-scope.md)) and automatically fails over to a backup replica if a failure occurs.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mmy-short-name }} or VMs running databases?

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mmy-short-name }}: Enables you to operate template databases without needing to manage their administration.
- {{ compute-full-name }} VM: Enables you to create and configure your own databases. With this approach, you can use any database management systems, access databases via SSH, and more.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud with dedicated computing resources and reserved storage capacity.

A _database cluster_ is one or more database hosts with the option to configure replication.


#### How do I get started with {{ mmy-short-name }}? {#quickstart}

{{ mmy-short-name }} is available to all registered {{ yandex-cloud }} users.

To create a database cluster in {{ mmy-short-name }}, you need to define its settings:

- [Host class](../../managed-mysql/concepts/instance-types.md) (performance parameters, such as CPUs, RAM, etc.).
- Storage size (fully reserved when creating the cluster).
- Network your cluster will be connected to.
- Number of hosts for your cluster and availability zone for each host.

For more information, see [Getting started](../../managed-mysql/quickstart.md).

#### How many database hosts does a cluster support? {#how-many-hosts}


The minimum number of hosts depends on the selected type of [storage](../../managed-mysql/concepts/storage.md):

* A minimum of three hosts for these disks:

   * Local SSDs (`local-ssd`)
   * Non-replicated SSDs (`network-ssd-nonreplicated`)

* A minimum of one host for these disks:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)
   * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)


The maximum number of hosts per cluster cannot exceed the set limits.

For more information, see [Quotas and limits](../../managed-mysql/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mmy-short-name }} databases using standard DBMS methods.

Learn more about connecting to clusters [here](../../managed-mysql/operations/connect.md).


#### How many clusters can I create within a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../managed-mysql/concepts/limits.md).


#### How are DB clusters maintained? {#service-window}

In {{ mmy-short-name }}, maintenance implies:

- Automatic installation of DBMS updates and fixes for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mmy-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-mysql/concepts/maintenance.md).

#### Which {{ MY }} version does {{ mmy-short-name }} use? {#dbms-version}

{{ mmy-short-name }} supports {{ MY }} 5.7 and {{ MY }} 8.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. Owners of the affected DB clusters are notified of an expected maintenance period and DB availability in advance.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mmy-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mmy-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged based on the [pricing policy](../../managed-mysql/pricing.md).
- Database host uptime in hours. Partial hours are rounded up to the nearest whole hour. You can find the cost per hour for each host class in the [Pricing policy](../../managed-mysql/pricing.md) section.

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the relevant cluster.

The cluster settings update within 30 minutes. This period may also include other cluster maintenance activities, such as installing updates.


#### Is database host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ MY }}, a full backup takes place once a day and saves all DB cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups created? Is a database cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Can I change the retention period of automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../managed-mysql/operations/cluster-create.md) or [modifying](../../managed-mysql/operations/update.md#change-additional-settings) a cluster.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, and disk usage as a percentage of the set limits for the relevant cluster host class.
- Amount of data in a DB cluster and the remaining free space in your data storage.

For DB hosts, you can monitor metrics specific to their type of DBMS. For example, for {{ MY }}, you can monitor:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs, and more.

Monitoring can be performed with a minimum granularity of five seconds.

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
