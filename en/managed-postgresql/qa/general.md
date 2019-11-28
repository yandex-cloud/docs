# General questions

#### What's {{ mpg-short-name }}? {#what-is}

{{ mpg-short-name }} is a service that helps you create, operate, and scale {{ PG }} databases in a cloud infrastructure.

With {{ mpg-short-name }}, you can:

- Create a database with the required performance characteristics.
- Scale processing power and storage dedicated for your databases as needed.
- Get database logs.

{{ mpg-short-name }} takes on time-consuming {{ PG }} infrastructure administration tasks:

- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps the database software updated.

You interact with database clusters in {{ mpg-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app's requirements.

#### What part of database management and maintenance is {{ mpg-short-name }} responsible for? {#services}

When creating clusters, {{ mpg-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mpg-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mpg-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks should I use {{ mpg-short-name }} for and for which VMs with databases? {#mdb-advantage}

Yandex.Cloud offers two ways to work with databases:

- {{ mpg-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines let you create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.

#### What is a database host and database cluster? {#what-is-cluster}

_A database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

_A database cluster_ is one or more database hosts between which replication can be configured.

#### How do I get started with {{ mpg-short-name }}? {#quickstart}

{{ mpg-short-name }} is available to all registered Yandex.Cloud users.

To create a database cluster in {{ mpg-short-name }}, you must define its characteristics:

- [Host class](../concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
- Storage size (reserved in full when you create the cluster).
- The network your cluster will be connected to.
- The number of hosts for the cluster and the availability zone for each host.

For detailed instructions, see [{#T}](../quickstart.md).

#### How many DB hosts can a cluster contain? {#how-many-hosts}

For a network-based storage (NBS), the number of hosts in a cluster is limited only by the requested computing resources and the size of the storage for the cluster.

For local SSD storage, the number of hosts is limited during cluster creation: for {{ PG }} clusters, at least three hosts must be created.

#### How can I access a running DB host? {#db-access}

You can connect to {{ mpg-short-name }} databases using standard DBMS methods.

[More about how to connect to clusters](../operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../concepts/limits.md).

#### How do I maintain database clusters? {#service-window}

Maintenance in {{ mpg-short-name }} implies:

- Automatic installation of DBMS updates and fixes for your database hosts.
- Changes to the host class and storage size.
- Other {{ mpg-short-name }} maintenance activities.

#### Which version of {{ PG }} does {{ mpg-short-name }} use? {#dbms-version}

{{ mpg-short-name }} supports {{ PG }} 10, 11, and 12, as well as PostgreSQL 10 for 1C.

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. The owners of the affected DB clusters receive an advance notice of expected work timing and DB availability.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mpg-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Seven days within such notification for minor versions and one month for major versions, the database clusters are automatically upgraded to the next supported version. Deprecated major versions are upgraded even if you have disabled their automatic updates.

#### How is the cost of usage calculated for a database host? {#db-cost}

In {{ mpg-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Storage of backups in excess of this size is charged at special [rates](../pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in [{#T}](../pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change the computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.

#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ PG }}, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When is backup performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 a.m. to 05:00 a.m. (UTC+3).

Clusters remain fully accessible during the backup window.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
- The amount of data in the DB cluster and the remaining free space in the data storage.

For any DB hosts, you can track metrics specific to the type of the corresponding DBMS. For example, for {{ PG }}, you can track:

- Average query execution time
- Number of queries per second
- Number of errors in logs, etc.

Monitoring can be performed with a minimum granularity of 5 seconds.

{% include [qa-fz-152.md](../../_includes/qa-fz-152.md) %}

