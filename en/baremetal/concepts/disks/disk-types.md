---
title: Disk types in {{ baremetal-full-name }} servers
description: This section explains the disk types used in {{ baremetal-full-name }} servers and how to choose the right type for you.
---

# Disk types in {{ baremetal-full-name }} servers

{{ baremetal-name }} offers three disk types: [HDD](#hdd), [SATA SSD](#ssd), and [NVMe SSD](#nvme). These types differ in their operating principle, performance, reliability, and cost.

## HDD {#hdd}

[HDD (Hard Disk Drive)](https://en.wikipedia.org/wiki/Hard_disk_drive) is a magnetic storage device with spinning platters. A mechanical read/write head physically moves across the disk surface during data access.

Due to its mechanical nature, HDDs perform well in sequential reads of large files but are slow when randomly accessing scattered data blocks. Sequential read/write speeds: 100-220 MB/s; random operations: 100 to 200 [IOPS](https://en.wikipedia.org/wiki/IOPS); latency: 5 to 10 ms.

**Optimal use cases for HDD:**

* Backup and archive storage.
* Cold storage of large volumes of data (videos, logs).
* Scenarios where performance is not as critical as low storage cost.

## SSD SATA {#ssd}

[SSD (Solid-State Drive)](https://en.wikipedia.org/wiki/Solid-state_drive) is a solid-state flash-based storage device with no moving parts. Data resides in memory chips and is instantly accessible from anywhere on the drive. Server-grade SSDs in {{ baremetal-name }} use the [SATA III](https://en.wikipedia.org/wiki/SATA#SATA_revision_3.0_(6_Gbit/s,_600_MB/s,_Serial_ATA-600)) interface, which delivers sequential read speeds of up to 560 MB/s, read IOPS of up to 97,000, write IOPS of up to 29,000, and latency around 0.1 ms.

Compared to HDDs, SSDs are about 10 times faster in random operations and 3 to 4 times faster in sequential operations. The absence of mechanical components makes them more resistant to vibrations and more durable under heavy write loads.

**Optimal use cases for SSD:**

* Databases with moderate load.
* Web and application servers.
* File servers with active data access.
* Scenarios dependent on balance between cost and performance.

## NVMe SSD {#nvme}

[NVMe (Non-Volatile Memory Express) SSD](https://en.wikipedia.org/wiki/NVM_Express) is a solid-state drive connected directly to the [PCIe](https://en.wikipedia.org/wiki/PCI_Express) bus of the CPU bypassing the SATA controller. Purpose-built for flash memory, the NVMe protocol supports thousands of parallel command queues for sequential read speeds of 3,000 to 7,000 MB/s, read IOPS exceeding 1,500,000, and the lowest latency among all disk types: 0.02 to 0.05 ms.

These drives come in `U.2` and `M.2` form factors.

**Optimal use cases for NVMe:**

* High-load databases (OLTP, OLAP).
* Real-time data processing systems.
* ML/AI workloads with intensive data exchange.
* Any scenarios where latency and IOPS are critical.

## Available disk types compared {#comparison}

| Type | HDD | SSD SATA | NVMe |
| --- | --- | --- | --- |
| Technology | Magnetic platters | Flash memory | Flash memory |
| Interface | SATA | SATA III | PCIe (U.2 / M.2) |
| Sequential read speed | 100 to 220 MB/s | Up to 560 MB/s | Up to 7,000 MB/s |
| IOPS (4K Random Read) | 100–200 | Up to 97,000 | Up to 1,500,000 |
| Latency | 5 to 10 ms | ~0.1 ms | ~0.02 to 0.05 ms |
| Cost per GB | Low | Medium | High |
| Typical applications | Archives, backups | Databases, web servers | High-load databases, ML |

## Choosing disks {#making-choice}

For each of the disk types above we have given the best-fitting scenarios. However, the same server may be used for a number of different tasks at the same time, so you might want to combine different disk types and distribute the server's role between them.

A common approach is to pair fast drives (SATA SSD or NVMe SSD) with high-capacity HDDs. In this setup, the high-speed drives enable the OS, databases, and _hot_ (i.e., frequently accessed) data, while the HDDs store the source data, backups, and archives.

In this configuration, the choice between SATA SSD and NVMe depends on performance requirements: if latency and IOPS are critical, go for NVMe; if ultra-high performance is not a must, SATA SSD is the choice.

## Merging disks into RAID arrays {#raid}

[RAID](./raid.md) arrays can further enhance data throughput, fault tolerance, and data loss protection on {{ baremetal-name }} servers.

For more details on RAID technology and how to configure RAID arrays in {{ baremetal-full-name }}, see [{#T}](./raid.md).
