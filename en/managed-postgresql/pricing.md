---
editable: false
---
# Pricing for Managed Service for PostgreSQL

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using Managed Service for PostgreSQL {#rules}

The cost of Managed Service for PostgreSQL usage is based on:

* Storage type and size (disk space).

* [The DB class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Settings and number of backups.

* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. Exact class characteristics are given in [#T](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the PostgreSQL host is not performing its main functions.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (NVMe) can only be ordered for clusters with more than 3 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, Managed Service for PostgreSQL doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Hosts {prices-hosts}

{% list tabs %}

- Per host per month

  | Host class | Cost per month, with VAT |
  | ----- | ----- |
  | **Intel Broadwell** |
  | b1.nano (2 vCPU × 5%, 2 GB) | 508 ₽ |
  | b1.micro (2 vCPU × 20%, 2 GB) | 858 ₽ |
  | b1.medium (2 vCPU × 50%, 4 GB) | 1581 ₽ |
  | m1.micro (2 vCPU, 16 GB) | 5205 ₽ |
  | m1.small (4 vCPU, 32 GB) | 10,409 ₽ |
  | m1.medium (6 vCPU, 48 GB) | 15,612 ₽ |
  | m1.large (8 vCPU, 64 GB) | 20,817 ₽ |
  | m1.xlarge (12 vCPU, 96 GB) | 31,225 ₽ |
  | m1.2xlarge (16 vCPU, 128 GB) | 41,634 ₽ |
  | m1.3xlarge (24 vCPU, 192 GB) | 62,450 ₽ |
  | m1.4xlarge (32 vCPU, 256 GB) | 83,266 ₽ |
  | s1.nano (1 vCPU, 4 GB) | 1867 ₽ |
  | s1.micro (2 vCPU, 8 GB) | 3727 ₽ |
  | s1.small (4 vCPU, 16 GB) | 7447 ₽ |
  | s1.medium (8 vCPU, 32 GB) | 14,900 ₽ |
  | s1.large (16 vCPU, 64 GB) | 29,793 ₽ |
  | s1.xlarge (32 vCPU, 128 GB) | 59,594 ₽ |
  | **Intel Cascade Lake** |
  | b2.nano (2 vCPU × 5%, 2 GB) | 508 ₽ |
  | b2.micro (2 vCPU × 20%, 2 GB) | 858 ₽ |
  | b2.medium (2 vCPU × 50%, 4 GB) | 1581 ₽ |
  | m2.micro (2 vCPU, 16 GB) | 5205 ₽ |
  | m2.small (4 vCPU, 32 GB) | 10,409 ₽ |
  | m2.medium (6 vCPU, 48 GB) | 15,612 ₽ |
  | m2.large (8 vCPU, 64 GB) | 20,817 ₽ |
  | m2.xlarge (12 vCPU, 96 GB) | 31,225 ₽ |
  | m2.2xlarge (16 vCPU, 128 GB) | 41,634 ₽ |
  | m2.3xlarge (24 vCPU, 192 GB) | 62,450 ₽ |
  | m2.4xlarge (32 vCPU, 256 GB) | 83,266 ₽ |
  | m2.5xlarge (40 vCPU, 320 GB) | 104,083 ₽ |
  | m2.6xlarge (48 vCPU, 384 GB) | 124,900 ₽ |
  | s2.micro (2 vCPU, 8 GB) | 3436 ₽ |
  | s2.small (4 vCPU, 16 GB) | 6873 ₽ |
  | s2.medium (8 vCPU, 32 GB) | 13,745 ₽ |
  | s2.large (12 vCPU, 48 GB) | 20,618 ₽ |
  | s2.xlarge (16 vCPU, 64 GB) | 27,491 ₽ |
  | s2.2xlarge (24 vCPU, 96 GB) | 41,237 ₽ |
  | s2.3xlarge (32 vCPU, 128 GB) | 54,982 ₽ |
  | s2.4xlarge (40 vCPU, 160 GB) | 68,728 ₽ |
  | s2.5xlarge (48 vCPU, 192 GB) | 82,473 ₽ |

- Per host per hour

  | Host class | Cost of 1 hour, with VAT |
  | ----- | ----- |
  | **Intel Broadwell** |
  | b1.nano (2 vCPU × 5%, 2 GB) | 0.7056 ₽ |
  | b1.micro (2 vCPU × 20%, 2 GB) | 1.1916 ₽ |
  | b1.medium (2 vCPU × 50%, 4 GB) | 2.1960 ₽ |
  | m1.micro (2 vCPU, 16 GB) | 7.2288 ₽ |
  | m1.small (4 vCPU, 32 GB) | 14.4564 ₽ |
  | m1.medium (6 vCPU, 48 GB) | 21.6840 ₽ |
  | m1.large (8 vCPU, 64 GB) | 28.9128 ₽ |
  | m1.xlarge (12 vCPU, 96 GB) | 43.3680 ₽ |
  | m1.2xlarge (16 vCPU, 128 GB) | 57.8244 ₽ |
  | m1.3xlarge (24 vCPU, 192 GB) | 86.7360 ₽ |
  | m1.4xlarge (32 vCPU, 256 GB) | 115.6476 ₽ |
  | s1.nano (1 vCPU, 4 GB) | 2.5932 ₽ |
  | s1.micro (2 vCPU, 8 GB) | 5.1763 ₽ |
  | s1.small (4 vCPU, 16 GB) | 10.3424 ₽ |
  | s1.medium (8 vCPU, 32 GB) | 20.6949 ₽ |
  | s1.large (16 vCPU, 64 GB) | 41.3797 ₽ |
  | s1.xlarge (32 vCPU, 128 GB) | 82.7695 ₽ |
  | **Intel Cascade Lake** |
  | b2.nano (2 vCPU × 5%, 2 GB) | 0.7056 ₽ |
  | b2.micro (2 vCPU × 20%, 2 GB) | 1.1916 ₽ |
  | b2.medium (2 vCPU × 50%, 4 GB) | 2.1960 ₽ |
  | m2.micro (2 vCPU, 16 GB) | 7.2288 ₽ |
  | m2.small (4 vCPU, 32 GB) | 14.4564 ₽ |
  | m2.medium (6 vCPU, 48 GB) | 21.6840 ₽ |
  | m2.large (8 vCPU, 64 GB) | 28.9128 ₽ |
  | m2.xlarge (12 vCPU, 96 GB) | 43.3680 ₽ |
  | m2.2xlarge (16 vCPU, 128 GB) | 57.8244 ₽ |
  | m2.3xlarge (24 vCPU, 192 GB) | 86.7360 ₽ |
  | m2.4xlarge (32 vCPU, 256 GB) | 115.6476 ₽ |
  | m2.5xlarge (40 vCPU, 320 GB) | 144.5592 ₽ |
  | m2.6xlarge (48 vCPU, 384 GB) | 173.4720 ₽ |
  | s2.micro (2 vCPU, 8 GB) | 4.7724 ₽ |
  | s2.small (4 vCPU, 16 GB) | 9.5460 ₽ |
  | s2.medium (8 vCPU, 32 GB) | 19.0908 ₽ |
  | s2.large (12 vCPU, 48 GB) | 28.6356 ₽ |
  | s2.xlarge (16 vCPU, 64 GB) | 38.1816 ₽ |
  | s2.2xlarge (24 vCPU, 96 GB) | 57.2736 ₽ |
  | s2.3xlarge (32 vCPU, 128 GB) | 76.3644 ₽ |
  | s2.4xlarge (40 vCPU, 160 GB) | 95.4552 ₽ |
  | s2.5xlarge (48 vCPU, 192 GB) | 114.5460 ₽ |

{% endlist %}

### Storage and backups {#prices-storage}

| Service | Cost of 1 GB per month, with VAT |
| ----- | ----- |
| Standard network storage | 2.2881 ₽ |
| Fast network storage | 8.1356 ₽ |
| NVMe | 8.1356 ₽ |
| Backups beyond the storage size | 2.5424 ₽ |

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

