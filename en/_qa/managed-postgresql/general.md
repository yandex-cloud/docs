#### What is {{ mpg-short-name }}? {#what-is}

{{ mpg-short-name }} is a service that helps you create, operate, and scale {{ PG }} databases in the cloud.

With {{ mpg-short-name }}, you can:
* Create databases with performance settings tailored to your needs.
* Scale your database compute and dedicated storage capacity as needed.
* Access database performance and activity logs.

{{ mpg-short-name }} handles the heavy lifting of {{ PG }} infrastructure administration for you:
* Provides monitoring of your resource consumption.
* Automatically backs up your databases.
* Ensures fault tolerance through automatic failover to backup replicas.
* Keeps your DBMS software up to date.

You work with a {{ mpg-short-name }} database cluster just like with your local database. This allows you to fine-tune your database’s internal settings to meet your application’s specific requirements.

#### What parts of database management and maintenance does {{ mpg-short-name }} handle? {#services}

During cluster creation, {{ mpg-short-name }} allocates resources, installs the DBMS, and creates the databases.

 {{ mpg-short-name }} automatically manages backups and applies DBMS patches and updates for your deployed databases.

Furthermore, {{ mpg-short-name }} ensures data replication, both within and across [availability zones](../../overview/concepts/geo-scope.md), with automatic failover to a standby replica during a failure.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### When should I use {{ mpg-short-name }}, and when should I use VMs running databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:
* {{ mpg-short-name }}: Enables you to operate template databases without needing to manage their administration.
* {{ compute-full-name }} VM: Enables you to create and configure your own databases. With this approach, you can use any database management systems, access databases via SSH, and more.

#### What is a database host and what is a database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud with dedicated computing resources and a reserved storage capacity.

A _database cluster_ is one or more database hosts that allow configuring replication between them.

#### How do I get started with {{ mpg-short-name }}? {#quickstart}

{{ mpg-short-name }} is available to all registered {{ yandex-cloud }} users.

To create a database cluster in {{ mpg-short-name }}, you need to define its settings:
* [Host class](../../managed-postgresql/concepts/instance-types.md) (performance parameters, such as CPUs, RAM, etc.).
* Storage size (fully reserved when creating the cluster).
* Network your cluster will be connected to.
* Number of hosts for your cluster and availability zone for each host.

For detailed instructions, see [{#T}](../../managed-postgresql/quickstart.md).

#### How many database hosts can be in a cluster? {#how-many-hosts}


The minimum number of hosts depends on the selected type of [storage](../../managed-postgresql/concepts/storage.md):

* A minimum of three hosts for these disks:

   * Local SSDs (`local-ssd`)
   * Non-replicated SSDs (`network-ssd-nonreplicated`)

* A minimum of one host for these disks:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)
   * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)


The maximum number of hosts per cluster cannot exceed the set limits.

For more information, see [{#T}](../../managed-postgresql/concepts/limits.md).

#### How to get access to a running host? {#db-access}

You can connect to {{ mpg-short-name }} databases using standard DBMS methods.

Learn more about connecting to clusters [here](../../managed-postgresql/operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-postgresql/concepts/limits.md).

#### How are database clusters maintained? {#service-window}

In {{ mpg-short-name }}, maintenance implies:

* Automatic installation of DBMS updates and fixes for DB hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other {{ mpg-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-postgresql/concepts/maintenance.md).

#### Which {{ PG }} version does {{ mpg-short-name }} use? {#dbms-version}

{{ mpg-short-name }} supports {{ PG }} 13, 14, 15, 16, and 17, as well as {{ PG }} 13, 14, 15, and 16 for 1C.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. Owners of the affected DB clusters are notified of an expected maintenance period and DB availability in advance.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mpg-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.

#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mpg-short-name }}, the usage cost is calculated based on the following:

* Selected host class.
* Size of storage reserved for the database host.
* Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged based on the [pricing policy](../../managed-postgresql/pricing.md).
* Database host uptime in hours. Partial hours are rounded up to the nearest whole hour. To find out the cost per hour of operation for each host class, see [{#T}](../../managed-postgresql/pricing.md).

#### How can I change the compute and storage capacity for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the relevant cluster.

The cluster settings update within 30 minutes. This period may also include other cluster maintenance activities, such as installing updates.

#### Can I configure automatic storage expansion for a cluster? {#storage-autoscale}

Yes, you can set up automatic increase of the storage size when [creating](../../managed-postgresql/operations/cluster-create.md) or [updating](../../managed-postgresql/operations/storage-space.md#disk-size-autoscale) a cluster.

#### Are database host backups enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ PG }}, a full backup takes place once a day and saves all DB cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups created? Does a database cluster remain online during backups? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Is encryption enabled for {{ PG }} database cluster connections? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in {{ PG }}? {#read-only-instance}

A read-only replica is a {{ PG }} DB cluster host available only for reads. Its data is synced with the master host (applies only if the cluster has more than 1 host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:
* CPU, memory, network, or disk usage, in absolute terms.
* Amount of data in the DB cluster and the remaining free space in the data storage.

For DB hosts, you can monitor metrics specific to their type of DBMS. For example, for {{ PG }}, you can monitor:
* Average query execution time.
* Number of queries per second.
* Number of errors in logs, and more.

Monitoring can be performed with a minimum granularity of five seconds.

{% include [logs](../logs.md) %}

#### What restrictions are placed on {{ PG }} database clusters? {#instance-limitations}

For more information about {{ mpg-short-name }} limitations, see [{#T}](../../managed-postgresql/concepts/limits.md). Characteristics of clusters that can be created using {{ mpg-short-name }} are given in [{#T}](../../managed-postgresql/concepts/instance-types.md).

#### What {{ PG }} extensions are supported in {{ mpg-short-name }}? {#pg-extension}

The list of supported {{ PG }} extensions is provided in [{#T}](../../managed-postgresql/operations/extensions/cluster-extensions.md).


#### Can I get superuser privileges in {{ PG }}? {#superuser}

No, you cannot. Superuser privileges are not available to {{ mpg-name }} users. Cluster actions of all types are available to users with the [mdb_admin](../../managed-postgresql/concepts/roles.md#mdb-admin) role.

#### Can I copy data from a {{ mpg-name }} table to a local file? Can I populate a table with data from a local file? {#copy-write-data}

Yes, you can both copy data from a table to a local file and populate a table with data from a local file. For more information, see [{#T}](../../managed-postgresql/operations/copy-write-data.md).

#### Are there any specific features or restrictions for the garbage collector in a {{ mpg-name }} cluster? {#vacuum}

{{ mpg-name }} clusters support all parameters of the [VACUUM command](https://www.postgresql.org/docs/current/sql-vacuum.html). However, you should consider the following specifics when using them:

* To run `VACUUM FULL`, the user must have the [`mdb_admin`](../../managed-postgresql/concepts/roles#mdb-admin) role. The VACUUM FULL command does not affect system views.
* In {{ PG }} version 14, the `INDEX_CLEANUP` parameter functionality has been enhanced: it now has the `AUTO` value by default. This means the `VACUUM` command skips index cleaning if it considers it unnecessary. To ensure backward compatibility with the previous {{ PG }} versions, set `INDEX_CLEANUP` to `ON`.

#### Why is my cluster slow even though the computational resources are not being fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when [updating your cluster](../../managed-postgresql/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-postgresql/operations/cluster-backups.md#restore) from a backup.
