# General questions

#### What is Managed Service for MongoDB? {#what-is}

Managed Service for MongoDB is a service that helps you create, operate, and scale MongoDB databases in the cloud infrastructure.

With Managed Service for MongoDB, you can:

- Create a database with the required performance characteristics.
- Scale processing power and storage dedicated for your databases as needed.
- Get database logs.

Managed Service for MongoDB takes on labor-intensive Managed Service for MongoDB infrastructure administration tasks:

- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps the database software updated.

You interact with a database cluster in Managed Service for MongoDB in the same way as with a regular database in your local infrastructure. This allows you to manage internal database settings to meet your app's requirements.

#### What part of DB management and maintenance is Managed Service for MongoDB responsible for? {#services}

When creating clusters, Managed Service for MongoDB allocates resources, installs the DBMS, and creates databases.

For the created and running databases, Managed Service for MongoDB automatically creates backups and applies fixes and updates to the DBMS.

Managed Service for MongoDB also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### For which tasks should I use Managed Service for MongoDB and for which VMs with databases? {#mdb-advantage}

Yandex.Cloud offers two ways to work with databases:

- Managed Service for MongoDB allows you to operate template databases with no need to worry about administration.
- With Yandex Compute Cloud VMs, you can create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.

#### What is a database host and database cluster? {#what-is-cluster}

_A database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

_A database cluster_ is one or more database hosts between which replication can be configured.

#### How do I get started with Managed Service for MongoDB? {#quickstart}

Managed Service for MongoDB is available to all registered Yandex.Cloud users.

To create a database cluster in Managed Service for MongoDB, decide what the characteristics will be:

- [Host class](../concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
- Storage size (reserved in full when you create the cluster).
- The network your cluster will be connected to.
- The number of hosts for the cluster and the availability zone for each host.

For detailed instructions, see the section [#T](../quickstart.md).

#### How many DB hosts can a cluster contain? {#how-many-hosts}

For a network-based storage (NBS), the number of hosts in a cluster is limited only by the requested computing resources and the size of the storage for the cluster.

For NVMe SSD storage, the number of hosts is limited during cluster creation: for MongoDB-clusters, at least three hosts must be created.

#### How can I access a running DB host? {#db-access}

You can connect to Managed Service for MongoDB databases using standard DBMS methods.

[More about how to connect to clusters](../operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

For MDB technical and organizational limitations, see the section [#T](../concepts/limits.md).

#### How do I maintain database clusters? {#service-window}

Maintenance in Managed Service for MongoDB implies:

- Automatic installation of DBMS updates and fixes for your database hosts.
- Changes to the host class and storage size.
- Other Managed Service for MongoDB maintenance activities.

#### Which MongoDB version does Managed Service for MongoDB use? {#dbms-version}

Managed Service for MongoDB supports MongoDB 3.6 and 4.0.

#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is updated after a short testing period. The owners of the affected DB clusters receive an advance notice of expected work timing and DB availability.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, Managed Service for MongoDB automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Seven days within such notification for minor versions and one month for major versions, the database clusters are automatically upgraded to the next supported version. Deprecated major versions are upgraded even if you have disabled their automatic updates.

#### How is the cost of usage calculated for a database host? {#db-cost}

In Managed Service for MongoDB, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Storage of backups in excess of this size is charged at special [rates](../pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in the section [#T](../pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change the computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.

#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For MongoDB, a full backup is performed once a day with the possibility to restore it to any saved backup.

By default, backups are stored for seven days.

#### When is backup performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 a.m. to 05:00 a.m. (UTC+3).

Clusters remain fully accessible during the backup window.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
- The amount of data in the DB cluster and the remaining free space in the data storage.

For any DB hosts, you can track metrics specific to the type of the corresponding DBMS. For example, for MongoDB, you can track:

- Average query execution time
- Number of queries per second
- Number of errors in logs, etc.

Monitoring can be performed with a minimum granularity of 5 seconds.

