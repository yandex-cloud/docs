# General questions

## What is {{ mgp-short-name }}? {#what-is}

## What part of database management and maintenance is {{ mgp-short-name }} responsible for? {#services}

When creating clusters, {{ mgp-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mgp-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mgp-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

## When should I use {{ mgp-short-name }} and when should I use VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

* {{ mgp-short-name }} allows you to operate template databases with no need to worry about administration.
* {{ compute-full-name }} virtual machines let you create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.

## What is a database host and database cluster? {#what-is-cluster}

_A database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

_A database cluster_ is one or more database hosts between which replication can be configured.

## How do I get started with {{ mgp-short-name }}? {#quickstart}

{{ mgp-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mgp-short-name }}, you must define its characteristics:

* [Host class](../../managed-greenplum/concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
* Storage size (reserved in full when you create the cluster).
* The network your cluster will be connected to.
* Number of hosts for the cluster and the availability zone. You can select the availability zone for each host.

For detailed instructions, see [{#T}](../../managed-greenplum/quickstart.md).

## How many DB hosts can a cluster contain? {#how-many-hosts}

The minimum number of hosts depends on the selected type of [storage](../../managed-greenplum/concepts/storage.md):

* When using non-replicated (`ssd-network-nonreplicated`) or local SSD storage (`local-ssd`), the minimum number of hosts is 3.
* when using network HDD (`network-hdd`) or network SSD storage (`network-ssd`), you can create a cluster containing a single host.

The maximum number of hosts in a cluster is limited by the selected {{ MS }} edition, the requested computing resources, and the size of the storage for the cluster.

For more information, see [{#T}](../../managed-greenplum/concepts/limits.md).

## How can I access a running DB host? {#db-access}

You can connect to {{ mgp-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-greenplum/operations/cluster-connect.md).

## How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-greenplum/concepts/limits.md).

## How do I maintain database clusters? {#service-window}

Maintenance in {{ mgp-short-name }} implies:

* Automatic installation of DBMS updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mgp-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-greenplum/concepts/maintenance.md).

## What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.

## What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mgp-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version: seven days after notification for minor versions and one month for major versions. Deprecated major versions are upgraded even if you disabled automatic updates.

## How is the cost of usage calculated for a database host? {#db-cost}

In {{ mgp-short-name }}, the usage cost is calculated based on the following parameters:

* Selected host class.
* Size of the storage reserved for the database host.
* Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at special [rates](../../managed-greenplum/pricing.md).
* Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in [{#T}](../../managed-greenplum/pricing.md).

## How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.

## Is DB host backup enabled by default? {#default-backup}

**TODO: Clarify and correct if necessary**

Yes, backup is enabled by default. For {{ GP }}, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

## When are backups performed? Is a DB cluster available during backup? {#backup-window}

**TODO: Clarify and correct if necessary**

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

## What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

* CPU, memory, network, or disk usage, in absolute terms.
* Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
* The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ MS }}, you can track:

* Average query execution time
* Number of queries per second
* Number of errors in logs, etc.

Monitoring can be performed with a minimum granularity of 5 seconds.

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
