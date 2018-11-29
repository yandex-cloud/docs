# Pricing policy for Yandex [!KEYREF mdb-short-name]


## What goes into the cost of [!KEYREF mdb-short-name] use {#rules}

The cost of [!KEYREF mdb-name] usage is based on:

   - The DBMS.
   - Storage (disk space) type and size.
   - [The DB class](concepts/instance-types.md) selected for the cluster.
   - The number of database hosts in clusters (including ZooKeeper hosts for [!KEYREF CH] clusters).
   - Settings and number of backups.
   - The amount of outgoing traffic.

[!INCLUDE [pricing-intro](../_includes/pricing-intro.md)]

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

> [!IMPORTANT]
> 
> For each [!KEYREF CH] cluster with 2 or more hosts, [!KEYREF CH] automatically creates 3 ZooKeeper hosts.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). The time when the DBMS host or ZooKeeper cannot perform its main functions is not charged.

### Disk space use {#rules-storage}

The following is charged:

- Storage allocated for DB clusters.
  - NVMe-based storage can only be ordered for clusters with more than three hosts (for [!KEYREF CH] — more than two), with an increment of 100 GB.
- Space used by DB backups in excess of the storage specified for the cluster.
  - Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.
  - During an automatic backup, [!KEYREF mdb-short-name] does not create a new copy but saves changes in the DB as compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.
  - The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).


## Prices {#prices}

### [!KEYREF CH] and ZooKeeper {#prices-clickhouse}

You can choose the host class for the [!KEYREF CH] hosts and ZooKeeper hosts (as appropriate for the expected replication load).

For example, let's say you created a [!KEYREF CH] cluster with 3 hosts using the `s1.micro` host class, and did not specify the class for the ZooKeeper hosts. [!KEYREF mdb-short-name] automatically creates 3 ZooKeeper hosts using the `s1.nano` class.

The hourly price will be calculated using the rates below (including VAT): `3 × ₽5.42 + 3 × ₽1.72 = ₽21.42`.

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| **[!KEYREF CH]]** |  |
| s1.nano | 2.30 ₽ | 2.71 ₽ |
| s1.micro | 4.59 ₽ | 5.42 ₽ |
| s1.small | 9.18 ₽ | 10.83 ₽ |
| s1.medium | 18.36 ₽ | 21.66 ₽ |
| s1.large | 36.71 ₽ | 43.32 ₽ |
| s1.xlarge | 73.42 ₽ | 86.63 ₽ |
| **ZooKeeper** |  |
| s1.nano | 1.46 ₽ | 1.72 ₽ |
| s1.micro | 2.85 ₽ | 3.36 ₽ |
| s1.small | 5.63 ₽ | 6.64 ₽ |
| s1.medium | 11.19 ₽ | 13.20 ₽ |
| s1.large | 22.32 ₽ | 26.34 ₽ |
| s1.xlarge | 44.57 ₽ | 52.59 ₽ |

### [!KEYREF PG] {#prices-postgresql}

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| s1.nano | 2.16 ₽ | 2.55 ₽ |
| s1.micro | 4.31 ₽ | 5.09 ₽ |
| s1.small | 8.62 ₽ | 10.17 ₽ |
| s1.medium | 17.25 ₽ | 20.35 ₽ |
| s1.large | 34.48 ₽ | 40.69 ₽ |
| s1.xlarge | 68.97 ₽ | 81.39 ₽ |

### [!KEYREF MG] {#prices-mongodb}

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| s1.nano | 2.50 ₽ | 2.95 ₽ |
| s1.micro | 5.01 ₽ | 5.91 ₽ |
| s1.small | 10.01 ₽ | 11.81 ₽ |
| s1.medium | 20.03 ₽ | 23.63 ₽ |
| s1.large | 40.04 ₽ | 47.25 ₽ |
| s1.xlarge | 80.09 ₽ | 94.51 ₽ |

### Storage and backups {#prices-storage-old}

| Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, with VAT |
| ----- | ----- | ----- |
| NVMe | 6.78 ₽ | 8.00 ₽ |
| Fast networked storage | 6.78 ₽ | 8.00 ₽ |
| Backups beyond the storage size | 2.12 ₽ | 2.50 ₽ |

### Outgoing traffic {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing-egress-traffic.md)]

