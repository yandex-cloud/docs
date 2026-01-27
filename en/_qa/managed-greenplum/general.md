#### What is {{ mgp-short-name }}? {#what-is}

{{ mgp-short-name }} is a solution that helps you create, operate, and scale {{ GP }} databases in the cloud.

With {{ mgp-short-name }}, you can:

* Create a database with the performance specs tailored to your needs.
* Scale computing power and dedicated storage capacity for your databases as needed.
* Get database logs.

{{ mgp-short-name }} takes over time-consuming administrative tasks in {{ GP }}:

* Monitors resource usage.
* Automatically creates DB backups.
* Provides fault tolerance through automatic failover to backup replicas.
* Keeps database software updated.

You work with a {{ mgp-short-name }} database cluster just like with your regular local database. This allows you to manage internal database settings to meet your app requirements.

#### What is {{ mgp-short-name }}'s share of database management and maintenance work? {#services}

When you create clusters, {{ mgp-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mgp-short-name }} automatically creates backups as well as applies fixes and updates.

{{ mgp-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of failure.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mgp-short-name }} or VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

* With {{ mgp-short-name }}, you can use template databases, with no administrative effort required.
* {{ compute-full-name }} VM: Enables you to create and configure your own databases. This approach allows you to use any database management systems, access databases over SSH, and so on.

#### How do I get started with {{ mgp-short-name }}? {#quickstart}

{{ mgp-short-name }} is available to all registered {{ yandex-cloud }} users.

To create a database cluster in {{ mgp-short-name }}, you need to define its settings:

* [Host class](../../managed-greenplum/concepts/instance-types.md) (performance specs, such as CPUs, RAM, etc.).
* Storage size (fully reserved when creating a cluster).
* Network your cluster will be connected to.
* Number of hosts for a cluster and the cluster's availability zone.

For a detailed guide, see [Creating a cluster](../../managed-greenplum/operations/cluster-create.md).

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated whenever new minor versions are released. Owners of affected database clusters get advance notice of upcoming maintenance and database availability.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after a DBMS version becomes deprecated, {{ mgp-short-name }} automatically sends email notifications to the owners of database clusters created with that version.

For clusters with a deprecated DBMS version, there is no option to create new hosts or restore from backups. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions will be upgraded even if you have disabled automatic updates.

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
