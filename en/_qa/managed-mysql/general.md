#### What is {{ mmy-short-name }}? {#what-is}

{{ mmy-short-name }} is a solution that helps you create, operate, and scale {{ MY }} databases in the cloud.

With {{ mmy-short-name }}, you can:
- Create a database with performance tailored to your needs.
- Scale computing power and dedicated storage capacity for your databases as needed.
- Get database logs.

{{ mmy-short-name }} handles the heavy lifting of {{ MY }} infrastructure management:
- Monitors resource usage.
- Performs automated database backups.
- Ensures fault tolerance through automatic failover to standby replicas.
- Keeps your database software up-to-date.

You can work with a {{ mmy-short-name }} database cluster the same way as with your regular local database. This allows you to manage internal database settings to meet your app requirements.


#### What is the role of {{ mmy-short-name }} in database management and maintenance? {#services}

When you create clusters, {{ mmy-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mmy-short-name }} automatically creates backups as well as applies DBMS patches and updates.

Furthermore, {{ mmy-short-name }} ensures data replication across database hosts, both within and across [availability zones](../../overview/concepts/geo-scope.md), with automatic failover to a standby replica during an incident.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mmy-short-name }} or VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- With {{ mmy-short-name }}, you can use template databases, with no administrative effort required.
- Alternatively, with {{ compute-full-name }} virtual machines, you can create and customize your own databases. This approach allows you to use any database management system, connect to databases over SSH, and many more.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ is one or more database hosts with configurable replication between them.


#### How do I get started with {{ mmy-short-name }}? {#quickstart}

{{ mmy-short-name }} is available to all registered {{ yandex-cloud }} users.

Before creating a database cluster in {{ mmy-short-name }}, you need to decide on its configuration:

- [Host class](../../managed-mysql/concepts/instance-types.md) that will determine your computing power, i.e., vCPUs, RAM, etc.
- Storage size (fully reserved when creating the cluster).
- Network for your cluster.
- Number of hosts in your cluster and availability zone for each host.

For more information, see [Getting started](../../managed-mysql/quickstart.md).

#### How many database hosts can a cluster contain? {#how-many-hosts}


The minimum number of hosts depends on the selected [storage](../../managed-mysql/concepts/storage.md) type:

* A minimum of three hosts is required for the following disk types:

   * Local SSDs (`local-ssd`)
   * Non-replicated SSDs (`network-ssd-nonreplicated`)

* At least one host for the following disk types:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)
   * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)


The maximum number of hosts per cluster cannot exceed the set limits.

For more information, see [Quotas and limits](../../managed-mysql/concepts/limits.md).

#### How can I access a running database host? {#db-access}

You can connect to {{ mmy-short-name }} databases using native DBMS connection methods.

Learn more about connecting to clusters in [this guide](../../managed-mysql/operations/connect/index.md).


#### How many clusters can I create within a single cloud? {#db-limit}

To learn more about technical and organizational limitations of MDB, see [Quotas and limits](../../managed-mysql/concepts/limits.md).


#### How are database clusters maintained? {#service-window}

Maintenance in {{ mmy-short-name }} includes:

- Automatic installation of database management system updates and patches for hosts in both running and stopped clusters.
- Changes in the host class and storage size.
- Other {{ mmy-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-mysql/concepts/maintenance.md).

#### Which {{ MY }} version does {{ mmy-short-name }} use? {#dbms-version}

{{ mmy-short-name }} supports {{ MY }} 5.7 and {{ MY }} 8.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated whenever new minor versions are released. Owners of affected database clusters get advance notice of upcoming maintenance and database availability.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after a DBMS version becomes deprecated, {{ mmy-short-name }} automatically sends email notifications to the owners of database clusters created with that version.

For clusters with a deprecated DBMS version, there is no option to create new hosts or restore from backups. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions will be upgraded even if you disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mmy-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Reserved storage capacity for the database host.
- Size of database cluster backups. You are not charged for storing backups up to your storage size. Backup storage exceeding this limit is charged according to our [pricing policy](../../managed-mysql/pricing.md).
- Database host uptime in hours. Partial hours are rounded to the nearest whole hour. The hourly cost for each host class is provided in our [pricing policy](../../managed-mysql/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can scale your computing resources and storage size directly in the management console by selecting a different host class for your cluster.

The cluster settings will update within 30 minutes. This window may also be used for other maintenance tasks, such as installing updates.


#### Are database host backups enabled by default? {#default-backup}

Yes, backups are enabled by default. The {{ MY }} backup policies provide full daily backups and continuous transaction log archiving. This enables you to restore your cluster to any point in time within the backup retention period, except for the last 30 seconds.

By default, backups are retained for seven days.

#### When does a backup run? Can I access my database cluster during backup? {#backup-window}

The backup window, i.e., the scheduled time for the full daily backup of a database cluster, is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible throughout the backup window.

#### Can I change the retention period for automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../managed-mysql/operations/cluster-create.md) or [updating](../../managed-mysql/operations/update.md#change-additional-settings) a cluster.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:

- CPU, memory, network, and disk utilization, in absolute terms.
- Memory, network, and disk utilization as a percentage of the set limits for the cluster’s host class.
- Total cluster data size and available storage space remaining.

For all database hosts, you can monitor metrics specific to their DBMS type. For example, for {{ MY }}, you can monitor:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs, and more.

You can monitor metrics with a minimum granularity of five seconds.

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
