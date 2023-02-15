---
title: "{{ mpg-name }}. Questions and answers"
description: "What is {{ mpg-name }}? What tasks should I use {{ mpg-name }} for and for which VMs with databases? What part of database management and maintenance is {{ mpg-name }} responsible for? Find the answers to these and other questions in this article."
---

# General questions about {{ mpg-name }}

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

You interact with database clusters in {{ mpg-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app's requirements.

#### What part of database management and maintenance is {{ mpg-short-name }} responsible for? {#services}

When creating clusters, {{ mpg-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mpg-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mpg-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks should I use {{ mpg-short-name }} for and for which VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:
* {{ mpg-short-name }} allows you to operate template databases with no need to worry about administration.
* {{ compute-full-name }} virtual machines let you create and configure your own databases. This approach allows you to use any database management systems, access databases via {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}, and so on.

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which replication can be configured.

#### How do I get started with {{ mpg-short-name }}? {#quickstart}

{{ mpg-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mpg-short-name }}, you must define its characteristics:
* [Host class](../../managed-postgresql/concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
* Storage size (reserved in full when you create the cluster).
* The network your cluster will be connected to.
* The number of hosts for the cluster and the availability zone for each host.

For detailed instructions, see [{#T}](../../managed-postgresql/quickstart.md).

#### How many DB hosts can a cluster contain? {#how-many-hosts}

The minimum number of hosts depends on the selected type of [storage](../../managed-postgresql/concepts/storage.md){% if audience != "internal" %}:
* If you use non-replicated SSD (`network-ssd-nonreplicated`) or local SSD storage (`local-ssd`), the minimum number of hosts is 3.
* If you use SSD network (`network-ssd`) or HDD network storage (`network-hdd`), you can create single-host clusters{% endif %}.

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [{#T}](../../managed-postgresql/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mpg-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-postgresql/operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-postgresql/concepts/limits.md).

#### How do I maintain database clusters? {#service-window}

Maintenance in {{ mpg-short-name }} implies:

* Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other {{ mpg-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-postgresql/concepts/maintenance.md).

#### Which version of {{ PG }} does {{ mpg-short-name }} use? {#dbms-version}

{{ mpg-short-name }} supports {{ PG }} 11, 12, 13, and 14, as well as PostgreSQL 11, 12, 13, and 14 for 1C.

#### Which {{ PG }} version and settings are best suited when creating databases for 1C? {#1c-version}

We recommend using {{ PG }} version 12-1c (current as of March 2022). This version was tested with 1C version 8.3.18: compatibility with earlier 1C versions is not guaranteed.

Please contact 1C tech support for settings optimized for cluster operation.

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mpg-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version: seven days after notification for minor versions and one month for major versions. Deprecated major versions are upgraded even if you disabled automatic updates.

#### How is the cost of usage calculated for a database host? {#db-cost}

In {{ mpg-short-name }}, the usage cost is calculated based on the following parameters:

* Selected host class.
* Size of the storage reserved for the database host.
* Size of the database cluster backups. {% if audience != "internal" %}Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-postgresql/pricing.md).{% endif %}
* Number of hours of database host operation. Partial hours are rounded to an integer value. {% if audience != "internal" %}The cost per hour of operation for each host class is given in [{#T}](../../managed-postgresql/pricing.md).{% endif %}

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.

#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ PG }}, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### Are {{ PG }} database cluster connections encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in {{ PG }}? {#read-only-instance}

A read-only replica is a host in a {{ PG }} DB cluster that can only be read. Its data is synced with the master host (applies only if the cluster has more than 1 host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:
* CPU, memory, network, or disk usage, in absolute terms.
* The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ PG }}, you can track:
* Average query execution time
* Number of queries per second
* Number of errors in logs.

Monitoring can be performed with a minimum granularity of 5 seconds.

{% include [logs](../logs.md) %}

#### What limitations are imposed on {{ PG }} database clusters? {#instance-limitations}

For more information about {{ mpg-short-name }} limits, see [{#T}](../../managed-postgresql/concepts/limits.md). Characteristics of clusters that can be created using {{ mpg-short-name }} are given in [{#T}](../../managed-postgresql/concepts/instance-types.md).

#### What {{ PG }} extensions are supported in {{ mpg-short-name }}? {#pg-extension}

The list of supported {{ PG }} extensions is provided in [{#T}](../../managed-postgresql/operations/extensions/cluster-extensions.md).

#### Which data center stores {{ PG }} cluster backups? {#data-center}

Cluster backups are stored and available in all three data centers.

{% if product == "yandex-cloud" %}

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% endif %}

