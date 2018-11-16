# Yandex MDB pricing policy

The cost of Yandex Managed Databases usage is based on:

   - The DBMS.
   - Storage (disk space) type and size.
   - [The DB class](concepts/instance-types.md) selected for the cluster.
   - How many DB hosts are in the clusters.
   - Settings and number of backups.
   - The amount of outgoing traffic.

[!INCLUDE [pricing-intro](../_includes/pricing-intro.md)]

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

## Using hosts with different DB types {#host-uptime}

The cost is charged for each hour of the host's operation with the corresponding DB class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is equal to the cost of 2 hours of operation). The time when the DBMS on the host is unavailable is not charged.

| DB class | Cost of 1 hour, without VAT | Cost of 1 hour, incl. VAT |
| ----- | ----- | ----- |
| **ClickHouse** |  |
| s1.nano | 3.81 ₽ | 4.50 ₽ |
| s1.micro | 6.11 ₽ | 7.21 ₽ |
| s1.small | 10.70 ₽ | 12.63 ₽ |
| s1.medium | 19.87 ₽ | 23.45 ₽ |
| s1.large | 38.23 ₽ | 45.11 ₽ |
| s1.xlarge | 74.94 ₽ | 88.43 ₽ |
| **PostgreSQL** |  |
| s1.nano | 2.16 ₽ | 2.55 ₽ |
| s1.micro | 4.31 ₽ | 5.09 ₽ |
| s1.small | 8.62 ₽ | 10.17 ₽ |
| s1.medium | 17.25 ₽ | 20.35 ₽ |
| s1.large | 34.48 ₽ | 40.69 ₽ |
| s1.xlarge | 68.97 ₽ | 81.39 ₽ |
| **MongoDB** |  |
| s1.nano | 2.50 ₽ | 2.95 ₽ |
| s1.micro | 5.01 ₽ | 5.91 ₽ |
| s1.small | 10.01 ₽ | 11.81 ₽ |
| s1.medium | 20.03 ₽ | 23.63 ₽ |
| s1.large | 40.04 ₽ | 47.25 ₽ |
| s1.xlarge | 80.09 ₽ | 94.51 ₽ |

## Storage and backups {#storage}

The following is charged:

- Storage allocated for DB clusters.
  - NVMe-based storage can only be ordered for clusters with more than three hosts (for [!KEYREF CH] — more than two), with an increment of 100 GB.
- Space used by DB backups in excess of the storage specified for the cluster.
  - Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.
  - During an automatic backup, [!KEYREF mdb-short-name] does not create a new copy but saves changes in the DB as compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.
  - The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

| Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, incl. VAT |
| ----- | ----- | ----- |
| NVMe | 6.78 ₽ | 8.00 ₽ |
| Fast networked storage | 6.78 ₽ | 8.00 ₽ |
| Backups beyond the storage size | 2.12 ₽ | 2.50 ₽ |

[!INCLUDE [pricing-egress-traffic](../_includes/pricing-egress-traffic.md)]

