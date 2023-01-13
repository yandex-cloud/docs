# General questions about {{ mgp-name }}

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

You interact with database clusters in {{ mgp-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app's requirements.

#### What part of database management and maintenance is {{ mgp-short-name }} responsible for? {#services}

When creating clusters, {{ mgp-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mgp-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mgp-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks should I use {{ mgp-short-name }} for and for which VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

* {{ mgp-short-name }} allows you to operate template databases with no need to worry about administration.
* {{ compute-full-name }} virtual machines let you create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, and so on.

#### How do I get started with {{ mgp-short-name }}? {#quickstart}

{{ mgp-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mgp-short-name }}, you must define its characteristics:

* [Host class](../concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
* Storage size (reserved in full when you create the cluster).
* The network your cluster will be connected to.
* The number of hosts for a cluster and the cluster availability zone.

For detailed instructions, see [{#T}](../operations/cluster-create.md).

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mgp-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version: seven days after notification for minor versions and one month for major versions. Deprecated major versions are upgraded even if you disabled automatic updates.

{% if product == "yandex-cloud" %}

{% include [qa-fz-152.md](../../_includes/qa-fz-152.md) %}

{% endif %}

{% include [logs](../../_qa/logs.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}