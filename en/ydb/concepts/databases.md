# Terms and definitions

## Database {#database}

{% if audience == "internal" %}

*A database* (DB) is a dedicated isolated part of the {{ ydb-short-name }} service resources. The {{ ydb-short-name }} service provides database scalability and fault-tolerance, as well as automatic replication within the cluster. Databases are isolated from each other at the process level and do not share memory. To ensure data security, a query can only access data within a single database.

{{ ydb-short-name }} provides all the benefits of a distributed scalable cluster along with traditional database functions that users are familiar with.

{% else if audience == "external" %}

*A database* (DB) is a dedicated isolated part of the {{ ydb-short-name }} service resources. The {{ ydb-short-name }} service provides database scalability and fault-tolerance, as well as automatic data replication.

{% endif %}

{% if audience == "internal" %}

## Cluster {#cluster}

You can host databases in single data center clusters located in the VLA (Vladimir, Russia), MYT (Mytischi, Russia), MAN (Mäntsälä, Finland), and SAS (Sasovo, Russia) data centers. You can also use geographically distributed clusters that span three data centers: VLA-SAS-MAN and VLA-SAS-MYT. If quick write query execution is key for your project (low-latency for transactions), choose single data center clusters. If your projects have higher reliability requirements (data survivability if a data center goes offline), use geographically distributed clusters. One database is fully hosted in one cluster. A single cluster can host multiple databases.

{% note important %}

For the current {{ ydb-short-name }} installation, *ydb-ru* clusters are available in VLA-SAS-MYT data centers.

{% endnote %}

{% endif %}

## Regions and availability zones {#regions-az}

The {{ ydb-short-name }} database is regional and located in the `ru-central` region. The `ru-central` region has three availability zones. For more information about regions and availability zones, see [{#T}](../../overview/concepts/geo-scope.md).

## Directory {#directory}

To easily organize databases, {{ ydb-short-name }} lets you create directories the same as in the file system.

{% if audience == "internal" %}

## Domain {#domain}

*A domain* is the first-level directory where all cluster resources are located. There can only be one domain per cluster.

## Account {#account}

*An account* is a second-level directory that you can create to organize database storage in YDB clusters. Databases are hosted inside the account's directory tree.

## Hierarchy of cluster elements {#hierarchy}

To host databases in {{ ydb-short-name }}, use the following directory structure: ```/domain/account/directory/database```.
At the top hierarchy level, the cluster contains a single domain that hosts one or more accounts, while accounts host one or more directories that host databases.

{% endif %}

## Computing resources {#compute-units}

{{ ydb-short-name }} provides computing resources for databases. Computing resources are combinations of CPUs and RAM that you can use to configure your database. If the number of queries served per unit of time (bandwidth) is limited by the current computing resources, you can increase bandwidth by allocating more computing resources. {{ ydb-short-name }} lets you change the amount of computing resources.

{% if audience == "internal" %}

In geographically distributed clusters, you can choose a policy for distributing computing resources across data centers. This lets you find the right balance between minimum execution time and minimum downtime if a data center goes offline.

{% endif %}

## Storage groups {#storage-groups}

Storage groups are used for storing data in {{ ydb-short-name }}. Each group is a redundant array of independent disks that are networked in a single logical unit. Storage groups increase fault tolerance through redundancy and improve performance.

{% if audience == "internal" %}

Each storage group corresponds to a specific storage schema that affects the number of disks used, the failure model, and the redundancy factor. The ``block4-2`` schema is commonly used for single data center clusters, where the storage group is located on 8 disks in 8 racks, can withstand the failure of any two disks, and ensures a redundancy factor of 1.5. In multiple data center clusters, we use the ``mirror3dc`` schema, where storage groups are made up of 9 disks, 3 in each of the three data centers, which can survive the failure of a data center or disk, and ensures a redundancy factor of 3.

{% endif %}

Storage groups can consist of any of the following types of storage devices:

* SATA HDDs for the cost-effective storage of large volumes (petabytes) of cold data.
* SATA SSDs for high-performance OLTP applications.

{{ ydb-short-name }} lets you allocate additional storage groups as your data grows. You can use storage groups with different storage schemas and different types of media within the same database.

