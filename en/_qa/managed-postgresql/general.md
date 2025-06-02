#### What is {{ mpg-short-name }}? {#what-is}

{{ mpg-short-name }} is a service that helps you create, operate, and scale {{ PG }} databases in a cloud infrastructure.

With {{ mpg-short-name }}, you can:
* Create a database with the required performance characteristics.
* Scale processing power and storage dedicated for your databases as needed.
* Get database logs.

{{ mpg-short-name }} takes on time-consuming {{ PG }} infrastructure administration tasks:
* Monitors resource usage.
* Automatically creates DB backups.
* Provides fault tolerance through automatic failover to backup replicas.
* Keeps database software updated.

You interact with database clusters in {{ mpg-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app requirements.

#### What part of database management and maintenance is {{ mpg-short-name }} responsible for? {#services}

When you create clusters, {{ mpg-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mpg-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mpg-short-name }} also allows you to replicate data between database hosts (both within and across [availability zones](../../overview/concepts/geo-scope.md)) and automatically routes the load to a backup replica in the event of a failure.

#### Which tasks are best addressed using {{ mpg-short-name }}, and which using VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:
* {{ mpg-short-name }} allows you to operate template databases with no need to worry about administration.
* {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, etc.

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which you can configure replication.

#### How do I get started with {{ mpg-short-name }}? {#quickstart}

{{ mpg-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mpg-short-name }}, you need to define its parameters:
* [Host class](../../managed-postgresql/concepts/instance-types.md) (performance characteristics, such as CPUs, RAM, etc.).
* Storage size (reserved to the full extent when you create a cluster).
* Network your cluster will be connected to.
* Number of hosts for the cluster and the availability zone for each host.

For detailed instructions, see [{#T}](../../managed-postgresql/quickstart.md).

#### How many database hosts can there be in one cluster? {#how-many-hosts}


The minimum number of hosts depends on the selected type of [storage](../../managed-postgresql/concepts/storage.md):

* A minimum of three hosts for these disks:

   * Local SSDs (`local-ssd`)
   * Non-replicated SSDs (`network-ssd-nonreplicated`)

* A minimum of one host for these disks:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)
   * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)


The maximum number of hosts per cluster is subject to the limits in place.

For more information, see [{#T}](../../managed-postgresql/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mpg-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-postgresql/operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-postgresql/concepts/limits.md).

#### How are DB clusters maintained? {#service-window}

In {{ mpg-short-name }}, maintenance implies:

* Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other {{ mpg-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-postgresql/concepts/maintenance.md).

#### Which {{ PG }} version does {{ mpg-short-name }} use? {#dbms-version}

{{ mpg-short-name }} supports {{ PG }} 13, 14, 15, 16, and 17, as well as {{ PG }} 13, 14, 15, and 16 for 1C.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. Owners of the affected DB clusters are notified of expected work times and DB availability in advance.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mpg-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.

#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mpg-short-name }}, the usage cost is calculated based on the following parameters:

* Selected host class.
* Size of the storage reserved for the database host.
* Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-postgresql/pricing.md).
* Number of hours of database host operation. Partial hours are rounded to an integer value. To find out the cost per hour of operation for each host class, see [{#T}](../../managed-postgresql/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.

#### Can I configure auto increase of cluster storage size? {#storage-autoscale}

Yes, you can set up automatic increase of the storage size when [creating](../../managed-postgresql/operations/cluster-create.md) or [updating](../../managed-postgresql/operations/storage-space.md#disk-size-autoscale) a cluster.

#### Is database host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ PG }}, a full backup takes place once a day and saves all DB cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups performed? Is a database cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Are {{ PG }} DB cluster connections encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in {{ PG }}? {#read-only-instance}

A read-only replica is a {{ PG }} DB cluster host available only for reads. Its data is synced with the master host (applies only if the cluster has more than 1 host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:
* CPU, memory, network, or disk usage, in absolute terms.
* Amount of data in the DB cluster and the remaining free space in the data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ PG }}, you can track:
* Average query execution time.
* Number of queries per second.
* Number of errors in logs, etc.

Monitoring can be performed with a minimum granularity of 5 seconds.

{% include [logs](../logs.md) %}

#### What limitations are imposed on {{ PG }} database clusters? {#instance-limitations}

For more information about {{ mpg-short-name }} limitations, see [{#T}](../../managed-postgresql/concepts/limits.md). Characteristics of clusters that can be created using {{ mpg-short-name }} are given in [{#T}](../../managed-postgresql/concepts/instance-types.md).

#### What {{ PG }} extensions are supported in {{ mpg-short-name }}? {#pg-extension}

The list of supported {{ PG }} extensions is provided in [{#T}](../../managed-postgresql/operations/extensions/cluster-extensions.md).

#### Which data center stores {{ PG }} cluster backups? {#data-center}

Cluster backups are stored and available in all three data centers.

{% include [fz-152.md](../../_qa/fz-152.md) %}

#### Can I get superuser privileges in {{ PG }}? {#superuser}

No, you cannot. Superuser privileges are not available to {{ mpg-name }} users. The highest privileges for working with clusters are granted to users with the [mdb_admin](../../managed-postgresql/concepts/roles.md#mdb-admin) and [mdb_superuser](../../managed-postgresql/concepts/roles.md#mdb-superuser) roles.

#### Can I copy data from a {{ mpg-name }} table to a local file? Can I populate a table with data from a local file? {#copy-write-data}

Yes, you can both copy data from a table to a local file and populate a table with data from a local file. For more information, see [{#T}](../../managed-postgresql/operations/copy-write-data.md).

#### Are there any special aspects or restrictions on the use of a garbage collector in {{ mpg-name }} clusters? {#vacuum}

{{ mpg-name }} clusters support all parameters of the [VACUUM command](https://www.postgresql.org/docs/current/sql-vacuum.html). However, you should consider the following specifics when using them:

* To run `VACUUM FULL`, the user must have the [`mdb_admin`](../../managed-postgresql/concepts/roles#mdb-admin) role. The VACUUM FULL command does not affect system views.
* In {{ PG }} version 14, the `INDEX_CLEANUP` parameter functionality has been enhanced: it now has the `AUTO` value by default. This means the `VACUUM` command skips index cleaning if it considers it unnecessary. To ensure backward compatibility with the previous {{ PG }} versions, set `INDEX_CLEANUP` to `ON`.

#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../../managed-postgresql/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-postgresql/operations/cluster-backups.md#restore) from a backup.
