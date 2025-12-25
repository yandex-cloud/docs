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

{{ yandex-cloud }} offers you two ways to work with databases:
* With {{ mpg-short-name }}, you can use template databases, with no administrative effort required.
* Alternatively, with {{ compute-full-name }} virtual machines, you can create and customize your own databases. This approach enables you to use any database management system, access databases via SSH, and more.

#### What is a database host and what is a database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ consists of one or more database hosts with configurable replication between them.

#### How do I get started with {{ mpg-short-name }}? {#quickstart}

{{ mpg-short-name }} is available to all registered {{ yandex-cloud }} users.

Before you create a database cluster in {{ mpg-short-name }}, first, decide on its key specifications:
* [Host class](../../managed-postgresql/concepts/instance-types.md) will determine your computing power: vCPUs, RAM, and more.
* Storage size (fully provisioned once you create the cluster).
* Network for your cluster.
* Number of hosts in your cluster and their availability zones.

Learn more in [{#T}](../../managed-postgresql/quickstart.md).

#### How many database hosts can be in a cluster? {#how-many-hosts}


The minimum number of hosts depends on the selected [storage](../../managed-postgresql/concepts/storage.md) type:

* A minimum of three hosts is required for the following disk types:

   * Local SSDs (`local-ssd`)
   * Non-replicated SSDs (`network-ssd-nonreplicated`)

* A single host is sufficient for the following disk types:

   * Network HDDs (`network-hdd`)
   * Network SSDs (`network-ssd`)
   * Ultra-fast network SSDs with triple replication (`network-ssd-io-m3`)


The maximum number of hosts in a cluster is subject to your quota limits.

For more information, see [{#T}](../../managed-postgresql/concepts/limits.md).

#### How to get access to a running host? {#db-access}

You can connect to {{ mpg-short-name }} databases using standard DBMS connection methods.

For details on connecting to clusters, see [this article](../../managed-postgresql/operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

To learn about MDB quotas and limits, see [{#T}](../../managed-postgresql/concepts/limits.md).

#### How are database clusters maintained? {#service-window}

Maintenance in {{ mpg-short-name }} includes:

* Automatic DBMS updates and patches for all hosts, even in stopped clusters.
* Scaling computing resources and storage capacity of cluster hosts.
* Other {{ mpg-short-name }} maintenance tasks.

Learn more in [{#T}](../../managed-postgresql/concepts/maintenance.md).

#### Which {{ PG }} version does {{ mpg-short-name }} use? {#dbms-version}

{{ mpg-short-name }} supports {{ PG }} versions 13-17, and {{ PG }} versions 13-16 for use with 1C.


#### What happens when a new DBMS version is released? {#new-version}

We update the database software with each new minor release. In advance of the planned updates, we notify the owners of the affected database clusters about the maintenance schedule and any expected downtimes.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

{{ mpg-short-name }} will automatically email you one month after your cluster’s DBMS version becomes deprecated.

Starting from that moment, you can no longer create new database hosts using this DBMS version. Database clusters are automatically updated to the next supported version 7 days after notification for minor releases and 1 month after notification for major releases. Deprecated major versions will be updated even with automatic updates turned off.

#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mpg-short-name }}, the usage cost is calculated based on the following parameters:

* Selected host class.
* Reserved storage capacity for the database host.
* Size of the database cluster backups. You get free backup storage equal to your total database storage. Additional backup storage is charged based on our [pricing policy](../../managed-postgresql/pricing.md).
* Database host uptime in hours. Partial hours are rounded up to the next hour. The hourly rates for each host class are listed in [{#T}](../../managed-postgresql/pricing.md).

#### How can I change the compute and storage capacity for a database cluster? {#resources-change}

You can scale your computing resources and storage size directly in the management console by selecting a different host class for your cluster.

The cluster settings will update within 30 minutes. This window may also be used for other maintenance tasks, such as installing updates.

#### Can I configure automatic storage expansion for a cluster? {#storage-autoscale}

Yes, you can enable automatic storage scaling when [creating](../../managed-postgresql/operations/cluster-create.md) or [updating](../../managed-postgresql/operations/storage-space.md#disk-size-autoscale) your cluster.

#### Are database host backups enabled by default? {#default-backup}

Yes, backups are enabled by default. The {{ PG }} backup policies include full daily backups and continuous transaction log archiving. This enables point-in-time recovery, allowing you to restore your cluster to any moment within the backup retention period, with the exception of the last 30 seconds.

By default, backups are retained for 7 days.

#### When does the backup run? Does a database cluster remain online during backups? {#backup-window}

The backup window, the scheduled time for the database cluster’s full daily backup, is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Is encryption enabled for {{ PG }} database cluster connections? {#encryption}

Connections between your database cluster and application are always encrypted with SSL. You cannot disable encryption for cluster connections.

#### What is a read-only replica in {{ PG }}? {#read-only-instance}

A read-only replica is a {{ PG }} database cluster host available only for reads that synchronizes its data with the master host. This applies only to clusters with more than one host. You can use a read-only replica to reduce the load on the master host experiencing high read traffic to its database.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor the following metrics:
* Absolute CPU, memory, network, and disk utilization.
* Total database cluster size and remaining free storage space.

For database hosts, you can track metrics specific to their DBMS type. For example, for {{ PG }}, you can monitor the following metrics:
* Average query execution time.
* Queries per second.
* Error count in logs, etc.

Monitoring is available with a minimum granularity of 5 seconds.

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

* To run `VACUUM FULL`, the user must have the [`mdb_admin`](../../managed-postgresql/concepts/roles.md#mdb-admin) role. The VACUUM FULL operation does not affect system tables.
* In {{ PG }} version 14, the `INDEX_CLEANUP` parameter has been enhanced and now defaults to `AUTO`. This means the `VACUUM` command will skip index cleanup if it deems it unnecessary. For backward compatibility with older {{ PG }} versions, set `INDEX_CLEANUP` to `ON`.

#### Why is my cluster slow even though the computational resources are not being fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth and reduce the risk of throttling, increase the storage size when [updating your cluster](../../managed-postgresql/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-postgresql/operations/cluster-backups.md#restore) from a backup.

