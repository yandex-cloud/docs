---
title: "Terms and definitions Yandex Database. Database"
description: "A database (DB) is a dedicated isolated part of the resources of the Yandex Database service. The YDB service provides scalability, database fault tolerance and automatic data replication."
---

# Terms and definitions

{% if audience != "external" %}

This section describes databases, clusters, directories, accounts, compute units, and storage groups.

For more information about how to create and manage databases, see ["Creating and managing databases"](../getting_started/create_manage_database.md)

{% endif %}

## Database {#database}

{% if audience != "external" %}

*A database* (DB) is a dedicated isolated part of the {{ ydb-short-name }} service resources. The {{ ydb-short-name }} service provides database scalability, fault-tolerance, and automatic replication within the cluster. Databases are isolated from each other at the process level and do not share memory. To ensure data security, a query can only access data within a single database.

{{ ydb-short-name }} provides all the benefits of a distributed scalable cluster along with the traditional database functions that users are familiar with.

{% else if audience == "external" %}

*A database* (DB) is a dedicated isolated part of the {{ ydb-short-name }} service resources. The {{ ydb-short-name }} service provides database scalability and fault-tolerance, as well as automatic data replication.

{% endif %}

{% if audience != "external" %}

## Cluster {#cluster}

You can host databases in single data center clusters located in the VLA (Vladimir, Russia), MYT (Mytischi, Russia), MAN (Mäntsälä, Finland), and SAS (Sasovo, Russia) data centers. You can also use geographically distributed clusters that span three data centers: VLA-SAS-MAN and VLA-SAS-MYT. If quick write query execution is key for your project (low-latency for transactions), choose single data center clusters. If your projects have higher reliability requirements (data survivability if a data center goes offline), use geographically distributed clusters. One database is fully hosted in one cluster. A single cluster can host multiple databases.

{% note warning %}

For the current {{ ydb-short-name }} installation, *ydb-ru* clusters are available in VLA-SAS-MYT data centers.

{% endnote %}

{% endif %}

{% if audience == "external" %}

## Regions and availability zones {#regions-az}

The {{ ydb-short-name }} database is regional and is located in the `ru-central` region. The `ru-central` region has three availability zones. For more information about regions and availability zones, see {% if deploy != "arc" %}[{#T}](../../overview/concepts/geo-scope.md){% else %}availability zones{% endif %}.

{% endif %}

## Directories {#directory}

To easily organize databases, {{ ydb-short-name }} lets you create directories like in the file system.

{% if audience == "internal" %}

## Domain {#domain}

*A domain* is the first-level directory where all cluster resources are located. There can only be one domain per cluster.

## Account {#account}

*An account* is a second-level directory that you can create to organize database storage in {{ ydb-short-name }} clusters. Databases are hosted inside the account's directory tree.

## Hierarchy of cluster elements {#hierarchy}

To host databases in {{ ydb-short-name }}, use the following directory structure: ```/domain/account/directory/database```.
At the top hierarchy level, the cluster contains a single domain that hosts one or more accounts, while accounts host one or more directories that host databases.

{% endif %}

## Compute units {#compute-units}

{% if audience != "external" %}

In {{ ydb-short-name }} clusters, compute units are represented with **slots**. A slot is a single process that handles user queries to a specific database. One slot can only serve one DB. A query to a specific database can be handled by any of the slots allocated to this database. You can see a list of DB slots on the [Info](https://ydb.yandex-team.ru/db/ydb-ru/tutorial/home/testdb/info) tab of the {{ ydb-short-name }} web interface or in the results of running the `discovery list` command in the {{ ydb-short-name }} console client.

{% note info %}

10 CPU cores and 50 GB of RAM are reserved per slot.

{% endnote %}

In geographically distributed clusters, you can choose a policy for distributing computing resources across data centers. This lets you find the right balance between minimum execution time and minimum downtime if a data center goes offline.

{% else %}

Computing resources are combinations of vCPUs and RAM. In {{ ydb-short-name }}, they're provided based on {{ compute-full-name }} VMs. You can create these VMs on any of the platforms that {{ compute-name }} supports. For a detailed description of the platforms, see {% if deploy != "arc" %}[{#T}](../../compute/concepts/vm-platforms.md){% else %}platforms{% endif %}.

Types of compute units:

| Platform | Computing resource | Number of vCPUs | Guaranteed vCPU performance | RAM, GB |
| ----- | ----- | ----- | ----- | ----- |
| **Intel Cascade Lake** | medium | 8 | 100% | 32 |
| **Intel Cascade Lake** | medium-m64 | 8 | 100% | 64 |
| **Intel Cascade Lake** | medium-m96 | 8 | 100% | 96 |

To increase database throughput, you can increase the amount of compute units.

{% endif %}

## Storage groups {#storage-groups}

A storage group is a redundant array of independent disks that are networked in a single logical unit. Storage groups increase fault tolerance through redundancy and improve performance.

In {{ ydb-short-name }}, each of the three availability zones uses three disks. This configuration ensures stability even if a zone or disk fails. It also provides a redundancy factor of 3.

{% if audience != "external" %}

Each storage group corresponds to a specific storage schema that affects the number of disks used, the failure model, and the redundancy factor. The ``block4-2`` schema is commonly used for single data center clusters, where the storage group is located on 8 disks in 8 racks, can withstand the failure of any two disks, and ensures a redundancy factor of 1.5. In multiple data center clusters, we use the ``mirror3dc`` schema, where storage groups are made up of 9 disks, 3 in each of the three data centers, which can survive the failure of a data center or disk, and ensures a redundancy factor of 3.

{% endif %}

A storage group may consist of any of the following types of storage devices:

{% if audience != "external" %}

* SATA HDDs for the cost-effective storage of large volumes (petabytes) of cold data.
* SATA SSDs for high-performance OLTP applications.
* NVMe SSDs for high-performance OLTP applications.

{% note info %}

For the current {{ ydb-short-name }} installation, only SATA SSDs are available.

{% endnote %}

{% else %}

* SSD (`network-ssd`): A fast network drive. Network block storage on an SSD. Suitable for high-performance OLTP applications.
* HDD (`network-hdd`): A standard network drive. Network block storage on an HDD. Suitable for storing large volumes (petabytes) of cold data.

{% endif %}

{{ ydb-short-name }} lets you allocate additional storage groups as your data grows.

