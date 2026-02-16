#### What is {{ mpg-short-name }}? {#what-is}

{{ mpg-short-name }} is a solution that helps you create, operate, and scale {{ PG }} databases in the cloud.

With {{ mpg-short-name }}, you can:
* Create a database with performance tailored to your needs.
* Scale computing power and dedicated storage capacity for your databases as needed.
* Get database logs.

{{ mpg-short-name }} takes over time-consuming administrative tasks in {{ PG }}:
* Monitors resource usage.
* Automatically creates DB backups.
* Provides fault tolerance through automatic failover to backup replicas.
* Keeps your DBMS software up to date.

You work with a {{ mpg-short-name }} database cluster just like with your regular local database. Thus, you can manage internal database settings to meet your application requirements.

#### What is the role of {{ mpg-short-name }} in database management and maintenance? {#services}

When you create clusters, {{ mpg-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mpg-short-name }} automatically creates backups as well as applies DBMS patches and updates.

Furthermore, {{ mpg-short-name }} ensures data replication across database hosts, both within and across [availability zones](../../overview/concepts/geo-scope.md), with automatic failover to a standby replica if a failure occurs.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mpg-short-name }} or VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:
* With {{ mpg-short-name }}, you can use template databases, with no administrative effort required.
* Alternatively, with {{ compute-full-name }} virtual machines, you can create and customize your own databases. This approach allows you to use any database management system, connect to databases over SSH, and many more.

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ consists of one or more database hosts with configurable replication between them.

#### How do I get started with {{ mpg-short-name }}? {#quickstart}

{{ mpg-short-name }} is available to all registered {{ yandex-cloud }} users.

Before creating a database cluster in {{ mpg-short-name }}, you need to decide on its configuration:
* [Host class](../../managed-postgresql/concepts/instance-types.md) that will determine your computing power, i.e., vCPUs, RAM, and more.
* Storage size (fully reserved when creating the cluster).
* Network for your cluster.
* Number of hosts in your cluster and availability zone for each host.

Learn more in [{#T}](../../managed-postgresql/quickstart.md).

#### How many database hosts can there be in a cluster? {#how-many-hosts}


The minimum number of hosts depends on the selected [storage](../../managed-postgresql/concepts/storage.md) type:

* A minimum of three hosts is required for the following disk types:

   * Local SSDs (`local-ssd`)
   * Non-replicated SSDs (`network-ssd-nonreplicated`)

* At least one host for the following disk types:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)
   * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)


The maximum number of hosts per cluster cannot exceed the set limits.

For more information, see [{#T}](../../managed-postgresql/concepts/limits.md).

#### How can I access a running database host? {#db-access}

You can connect to {{ mpg-short-name }} databases using conventional DBMS methods.

Learn more about connecting to clusters in [this guide](../../managed-postgresql/operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

To learn about MDB quotas and limits, see  [{#T}](../../managed-postgresql/concepts/limits.md).

#### How are database clusters maintained? {#service-window}

Maintenance in {{ mpg-short-name }} includes:

* Automatic installation of DBMS updates and patches for database hosts (including for stopped clusters).
* Changes in the host class and storage size.
* Other {{ mpg-short-name }} maintenance activities.

Learn more in [{#T}](../../managed-postgresql/concepts/maintenance.md).

#### Which {{ PG }} version does {{ mpg-short-name }} use? {#dbms-version}

{{ mpg-short-name }} supports {{ PG }} versions 14-17, and {{ PG }} versions 14-16 for use with 1C.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated whenever new minor versions are released. Owners of affected database clusters get advance notice of upcoming maintenance and database availability.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after a DBMS version becomes deprecated, {{ mpg-short-name }} automatically sends email notifications to the owners of database clusters created with that version.

For clusters with a deprecated DBMS version, there is no option to create new hosts or restore from backups. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions will be upgraded even if you disabled automatic updates.

#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mpg-short-name }}, the usage cost is calculated based on the following:

* Selected host class.
* Reserved storage capacity for the database host.
* Size of database cluster backups. You do not pay for backups as long as their size does not exceed the storage capacity. Additional backup storage is charged according to our [pricing policy](../../managed-postgresql/pricing.md).
* Database host uptime in hours. Partial hours are rounded to the nearest whole hour. The hourly rates for each host class are listed in [{#T}](../../managed-postgresql/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can scale your computing resources and storage size directly in the management console by selecting a different host class for your cluster.

The cluster settings will update within 30 minutes. This window may also be used for other maintenance activities, such as installing updates.

#### Can I configure automatic storage expansion for a cluster? {#storage-autoscale}

Yes, you can enable automatic storage expansion when [creating](../../managed-postgresql/operations/cluster-create.md) or [updating](../../managed-postgresql/operations/storage-space.md#disk-size-autoscale) your cluster.

#### Are database host backups enabled by default? {#default-backup}

Yes, backups are enabled by default. The {{ PG }} backup policies provide full daily backups and continuous transaction log archiving. This enables point-in-time recovery, allowing you to restore your cluster to any moment within the backup retention period, with the exception of the last 30 seconds.

By default, backups are retained for seven days.

#### When does a backup run? Is a database cluster available during backups? {#backup-window}

The backup window, the scheduled time for the database cluster’s full daily backup, is from 01:00 to 05:00 (UTC+3).

Clusters remain fully available during the backup window.

#### Is encryption enabled for {{ PG }} database cluster connections? {#encryption}

Connections between your database cluster and application are always encrypted with SSL. You cannot disable encryption for cluster connections.

#### What is a read-only replica in {{ PG }}? {#read-only-instance}

A read-only replica is a {{ PG }} database cluster host available only for reads that synchronizes its data with the master host. This applies only to clusters with more than one host. You can use a read-only replica to reduce the load on the master host experiencing high read traffic to its database.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:
* Absolute CPU, memory, network, and disk utilization.
* Amount of data in a database cluster and the remaining free space in your data storage.

For all database hosts, you can monitor metrics specific to their DBMS type. For example, for {{ PG }}, you can monitor:
* Average query execution time.
* Number of queries per second.
* Number of errors in logs, and more.

You can monitor metrics with a minimum granularity of five seconds.

{% include [logs](../logs.md) %}

#### What restrictions are placed on {{ PG }} database clusters? {#instance-limitations}

To learn about {{ mpg-short-name }} quotas and limits, see [{#T}](../../managed-postgresql/concepts/limits.md). Also refer to [{#T}](../../managed-postgresql/concepts/instance-types.md) for the specifications of clusters you can create with {{ mpg-short-name }}.

#### What {{ PG }} extensions are supported in {{ mpg-short-name }}? {#pg-extension}

See the list of supported {{ PG }} extensions in [{#T}](../../managed-postgresql/operations/extensions/cluster-extensions.md).


#### Can I get superuser privileges in {{ PG }}? {#superuser}

No, superuser privileges are not available to {{ mpg-name }} users. Cluster actions of all types are available to users with the [mdb_admin](../../managed-postgresql/concepts/roles.md#mdb-admin) role.

#### Can I copy data from a {{ mpg-name }} table to a local file? Can I populate a table with data from a local file? {#copy-write-data}

Yes, you can both copy data from a table to a local file and import data from a file into a table. For more information, see [{#T}](../../managed-postgresql/operations/copy-write-data.md).

#### Are there any specific features or restrictions for the garbage collector in a {{ mpg-name }} cluster? {#vacuum}

{{ mpg-name }} clusters support all [VACUUM command](https://www.postgresql.org/docs/current/sql-vacuum.html) options. However, please note the following when using them:

* To run `VACUUM FULL`, the user must have the [`mdb_admin`](../../managed-postgresql/concepts/roles#mdb-admin) role. The VACUUM FULL operation does not affect system tables.
* In {{ PG }} version 14, the `INDEX_CLEANUP` parameter functionality has been enhanced: it now has the `AUTO` value by default. This means the `VACUUM` command skips index cleaning if it considers it unnecessary. For backward compatibility with older {{ PG }} versions, set `INDEX_CLEANUP` to `ON`.

#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, expand the storage when [updating your cluster](../../managed-postgresql/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-postgresql/operations/cluster-backups.md#restore) from a backup.

