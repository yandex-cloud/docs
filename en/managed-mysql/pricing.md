---
editable: false
---
# Pricing for {{ mmy-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ mmy-short-name }} {#rules}

The cost of {{ mmy-name }} usage is based on:

* Storage type and size (disk space).

* [The DB class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Settings and number of backups.

* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. Exact class characteristics are given in [{#T}](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ MY }} host is not performing its main functions.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (SSD) can only be ordered for clusters with more than 3 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Hosts {prices-hosts}

{% list tabs %}

- Per host per month

  | Host class | Cost per month, with VAT |
  | ----- | ----- |
  | **Intel Broadwell** |
  | {{ b1-nano }} | 508 ₽ |
  | {{ b1-micro }} | 858 ₽ |
  | {{ b1-medium }} | 1581 ₽ |
  | {{ m1-micro }} | 5372 ₽ |
  | {{ m1-small }} | 10,745 ₽ |
  | {{ m1-medium }} | 16,116 ₽ |
  | {{ m1-large }} | 21,489 ₽ |
  | {{ m1-xlarge }} | 32,232 ₽ |
  | {{ m1-2xlarge }} | 42,976 ₽ |
  | {{ m1-3xlarge }} | 64,465 ₽ |
  | {{ m1-4xlarge }} | 85,952 ₽ |
  | {{ s1-nano }} | 1926 ₽ |
  | {{ s1-micro }} | 3547 ₽ |
  | {{ s1-small }} | 7094 ₽ |
  | {{ s1-medium }} | 14,189 ₽ |
  | {{ s1-large }} | 28,377 ₽ |
  | {{ s1-xlarge }} | 56,755 ₽ |
  | **Intel Cascade Lake** |
  | {{ b2-nano }} | 508 ₽ |
  | {{ b2-micro }} | 858 ₽ |
  | {{ b2-medium }} | 1581 ₽ |
  | {{ m2-micro }} | 5372 ₽ |
  | {{ m2-small }} | 10,745 ₽ |
  | {{ m2-medium }} | 16,116 ₽ |
  | {{ m2-large }} | 21,489 ₽ |
  | {{ m2-xlarge }} | 32,232 ₽ |
  | {{ m2-2xlarge }} | 42,976 ₽ |
  | {{ m2-3xlarge }} | 64,465 ₽ |
  | {{ m2-4xlarge }} | 85,952 ₽ |
  | {{ m2-5xlarge }} | 107,440 ₽ |
  | {{ m2-6xlarge }} | 128,929 ₽ |
  | {{ s2-micro }} | 3547 ₽ |
  | {{ s2-small }} | 7094 ₽ |
  | {{ s2-medium }} | 14,189 ₽ |
  | {{ s2-large }} | 21,284 ₽ |
  | {{ s2-xlarge }} | 28,377 ₽ |
  | {{ s2-2xlarge }} | 42,567 ₽ |
  | {{ s2-3xlarge }} | 56,755 ₽ |
  | {{ s2-4xlarge }} | 70,945 ₽ |
  | {{ s2-5xlarge }} | 85,133 ₽ |

- Per host per hour

  | Host class | Cost of 1 hour, with VAT |
  | ----- | ----- |
  | **Intel Broadwell** |
  | {{ b1-nano }} | 0.7056 ₽ |
  | {{ b1-micro }} | 1.1916 ₽ |
  | {{ b1-medium }} | 2.1960 ₽ |
  | {{ m1-micro }} | 7.4616 ₽ |
  | {{ m1-small }} | 14.9232 ₽ |
  | {{ m1-medium }} | 22.3836 ₽ |
  | {{ m1-large }} | 29.8452 ₽ |
  | {{ m1-xlarge }} | 44.7672 ₽ |
  | {{ m1-2xlarge }} | 59.6892 ₽ |
  | {{ m1-3xlarge }} | 89.5344 ₽ |
  | {{ m1-4xlarge }} | 119.3784 ₽ |
  | {{ s1-nano }} | 2.6748 ₽ |
  | {{ s1-micro }} | 4.9260 ₽ |
  | {{ s1-small }} | 9.8532 ₽ |
  | {{ s1-medium }} | 19.7064 ₽ |
  | {{ s1-large }} | 39.4128 ₽ |
  | {{ s1-xlarge }} | 78.8268 ₽ |
  | **Intel Cascade Lake** |
  | {{ b2-nano }} | 0.7056 ₽ |
  | {{ b2-micro }} | 1.1916 ₽ |
  | {{ b2-medium }} | 2.1960 ₽ |
  | {{ m2-micro }} | 7.4616 ₽ |
  | {{ m2-small }} | 14.9232 ₽ |
  | {{ m2-medium }} | 22.3836 ₽ |
  | {{ m2-large }} | 29.8452 ₽ |
  | {{ m2-xlarge }} | 44.7672 ₽ |
  | {{ m2-2xlarge }} | 59.6892 ₽ |
  | {{ m2-3xlarge }} | 89.5344 ₽ |
  | {{ m2-4xlarge }} | 119.3784 ₽ |
  | {{ m2-5xlarge }} | 149.2224 ₽ |
  | {{ m2-6xlarge }} | 179.0676 ₽ |
  | {{ s2-micro }} | 4.9260 ₽ |
  | {{ s2-small }} | 9.8532 ₽ |
  | {{ s2-medium }} | 19.7064 ₽ |
  | {{ s2-large }} | 29.5608 ₽ |
  | {{ s2-xlarge }} | 39.4128 ₽ |
  | {{ s2-2xlarge }} | 59.1204 ₽ |
  | {{ s2-3xlarge }} | 78.8268 ₽ |
  | {{ s2-4xlarge }} | 98.5344 ₽ |
  | {{ s2-5xlarge }} | 118.2408 ₽ |

{% endlist %}

### Storage and backups {#prices-storage}

| Service | Cost of 1 GB per month, with VAT |
| ----- | ----- |
| Standard network storage | 2.2881 ₽ |
| Fast network storage | 8.1356 ₽ |
| SSD | 8.1356 ₽ |
| Backups beyond the storage size | 2.5424 ₽ |

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

