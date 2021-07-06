---
title: "Terms and definitions Yandex Database. Database"
description: "A database (DB) is a dedicated isolated part of the resources of the Yandex Database service. The YDB service provides scalability, database fault tolerance and automatic data replication."
---

# Terms and definitions

## Database {#database}

*A database* (DB) is a dedicated isolated part of the {{ ydb-short-name }} service resources. The {{ ydb-short-name }} service provides database scalability and fault-tolerance, as well as automatic data replication.

## Regions and availability zones {#regions-az}

The {{ ydb-short-name }} database is regional and is located in the `ru-central` region. The `ru-central` region has three availability zones. For more information about regions and availability zones, see [{#T}](../../overview/concepts/geo-scope.md).

## Directories {#directory}

To easily organize databases, {{ ydb-short-name }} lets you create directories like in the file system.

## Computing resources {#compute-units}

Computing resources are combinations of vCPUs and RAM. In {{ ydb-short-name }}, they're provided based on {{ compute-full-name }} VMs. You can create these VMs on any of the platforms that {{ compute-name }} supports. For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

Types of computing resources:

| Platform | Computing resource | Number of vCPUs | Guaranteed vCPU performance | RAM, GB |
| ----- | ----- | ----- | ----- | ----- |
| **Intel Cascade Lake** | s2.medium | 8 | 100% | 32 |

To increase database throughput, you can increase the amount of computing resources.

## Storage groups {#storage-groups}

A storage group is a redundant array of independent disks that are networked in a single logical unit. Storage groups increase fault tolerance through redundancy and improve performance.

In {{ ydb-short-name }}, each of the three availability zones uses three disks. This configuration ensures stability even if a zone or disk fails. It also provides a redundancy factor of 3.

A storage group may consist of any of the following types of storage devices:

* SSD (`network-ssd`): A fast network drive. Network block storage on an SSD. Suitable for high-performance OLTP applications.
* HDD (`network-hdd`): A standard network drive. Network block storage on an HDD. Suitable for storing large volumes (petabytes) of cold data.

{{ ydb-short-name }} lets you allocate additional storage groups as your data grows.

