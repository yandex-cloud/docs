#### What is {{ mgp-short-name }}? {#what-is}

{{ mgp-short-name }} is a service that helps you create, operate, and scale {{ GP }} databases in a cloud infrastructure.

With {{ mgp-short-name }}, you can:

* Create a database with the required performance characteristics.
* Scale processing power and storage dedicated for your databases as needed.
* Get database logs.

{{ mgp-short-name }} takes on time-consuming {{ GP }} infrastructure administration tasks:

* Monitors resource usage.
* Automatically creates DB backups.
* Provides fault tolerance through automatic failover to backup replicas.
* Keeps database software updated.

You interact with database clusters in {{ mgp-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app requirements.

#### What part of database management and maintenance is {{ mgp-short-name }} responsible for? {#services}

When you create clusters, {{ mgp-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mgp-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mgp-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks are best addressed using {{ mgp-short-name }}, and which using VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

* {{ mgp-short-name }} allows you to operate template databases with no need to worry about administration.
* {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.

#### How do I get started with {{ mgp-short-name }}? {#quickstart}

{{ mgp-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mgp-short-name }}, you need to define its parameters:

* [Host class](../../managed-greenplum/concepts/instance-types.md) (performance characteristics, such as CPUs, RAM, etc.).
* Storage size (reserved to the full extent when you create a cluster).
* Network your cluster will be connected to.
* Number of hosts for a cluster and the cluster availability zone.

For a detailed guide, see [Creating a cluster](../../managed-greenplum/operations/cluster-create.md).

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. Owners of the affected DB clusters are notified of expected work times and DB availability in advance.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mgp-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
