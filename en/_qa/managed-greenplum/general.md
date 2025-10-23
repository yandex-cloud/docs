#### What is {{ mgp-short-name }}? {#what-is}

{{ mgp-short-name }} is a solution that helps you create, operate, and scale {{ GP }} databases in the cloud.

With {{ mgp-short-name }}, you can:

* Create a database with the performance parameters tailored to your needs.
* Scale computing power and dedicated storage capacity for your databases as needed.
* Get database logs.

{{ mgp-short-name }} takes over time-consuming {{ GP }} infrastructure administration tasks:

* Monitors resource usage.
* Automatically creates DB backups.
* Provides fault tolerance through automatic failover to backup replicas.
* Keeps database software updated.

You work with a {{ mgp-short-name }} database cluster as if it were a regular database in your local infrastructure This allows you to manage internal database settings to meet your app requirements.

#### What is {{ mgp-short-name }}'s share of database management and maintenance work? {#services}

When you create clusters, {{ mgp-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mgp-short-name }} automatically creates backups and applies fixes and updates.

{{ mgp-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mgp-short-name }} or VMs running databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

* {{ mgp-short-name }}: Enables you to operate template databases without needing to manage their administration.
* {{ compute-full-name }} VM: Enables you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.

#### How do I get started with {{ mgp-short-name }}? {#quickstart}

{{ mgp-short-name }} is available to all registered {{ yandex-cloud }} users.

To create a database cluster in {{ mgp-short-name }}, you need to define its settings:

* [Host class](../../managed-greenplum/concepts/instance-types.md) (performance characteristics, such as CPUs, RAM, etc.).
* Storage size (fully reserved when creating the cluster).
* Network your cluster will be connected to.
* Number of hosts for a cluster and the cluster availability zone.

For a detailed guide, see [Creating a cluster](../../managed-greenplum/operations/cluster-create.md).

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. Owners of the affected DB clusters are notified of an expected maintenance period and DB availability in advance.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mgp-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
