---
title: "{{ mmy-name }}. Questions and answers"
description: "What is {{ mmy-name }}? Which tasks should I use {{ mmy-name }} for and for which are VMs with databases more appropriate? What part of database management and maintenance is {{ mmy-name }} responsible for? Find the answers to these and other questions in this article."
---

# General questions about {{ mmy-name }}

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

You interact with database clusters in {{ mmy-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app's requirements.


#### What part of database management and maintenance is {{ mmy-short-name }} responsible for? {#services}

When creating clusters, {{ mmy-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mmy-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mmy-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks should I use {{ mmy-short-name }} for and for which VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mmy-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, etc.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which replication can be configured.


#### How do I get started with {{ mmy-short-name }}? {#quickstart}

{{ mmy-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mmy-short-name }}, you must define its characteristics:

- [Host class](../../managed-mysql/concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
- Storage size (reserved in full when you create the cluster).
- The network your cluster will be connected to.
- The number of hosts for the cluster and the availability zone for each host.

For detailed instructions, see [{#T}](../../managed-mysql/quickstart.md).

#### How many DB hosts can a cluster contain? {#how-many-hosts}

The minimum number of hosts depends on the selected type of [storage](../../managed-mysql/concepts/storage.md):

- If you use non-replicated SSD (`ssd-network-nonreplicated`) or local SSD storage (`local-ssd`), the minimum number of hosts is 3.
- If you use SSD network (`network-ssd`) or HDD network storage (`network-hdd`), you can create single-host clusters.

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [{#T}](../../managed-mysql/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mmy-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-mysql/operations/connect.md).


#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-mysql/concepts/limits.md).


#### How do I maintain database clusters? {#service-window}

Maintenance in {{ mmy-short-name }} implies:

- Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mmy-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-mysql/concepts/maintenance.md).

#### Which version of {{ MY }} does {{ mmy-short-name }} use? {#dbms-version}

{{ mmy-short-name }} supports {{ MY }} 5.7 and {{ MY }} 8.


#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mmy-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version: seven days after notification for minor versions and one month for major versions. Deprecated major versions are upgraded even if you disabled automatic updates.


#### How is the cost of usage calculated for a database host? {#db-cost}

In {{ mmy-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-mysql/pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in [{#T}](../../managed-mysql/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.


#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ MY }}, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
- The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ MY }}, you can track:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs.

Monitoring can be performed with a minimum granularity of 5 seconds.



{% include [fz-152.md](../../_qa/fz-152.md) %}


{% include [logs](../logs.md) %}
