---
editable: false
---
# Pricing for [!KEYREF mpg-name]

## What goes into the cost of using [!KEYREF mpg-short-name] {#rules}

The cost of [!KEYREF mpg-name] usage is based on:

* Storage type and size (disk space).

* [The DB class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Settings and number of backups.

* The amount of outgoing traffic.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the host [!KEYREF PG] is not performing its main functions.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (NVMe) can only be ordered for clusters with more than 3 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.

    * During an automatic backup, [!KEYREF mpg-short-name] does not create a new copy but saves changes in the DB as compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Hosts {prices-hosts}

---

**[!TAB Per host per month]**

| Host class | Cost per month, without VAT | Cost per month, with VAT |
| ----- | ----- | ----- | ----- |
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | ₽423 | ₽508 |
| [!KEYREF b1.micro] | ₽715 | ₽858 |
| [!KEYREF b1.medium] | ₽1 318 | ₽1 581 |
| [!KEYREF s1.nano] | ₽1 556 | ₽1 867 |
| [!KEYREF s1.micro] | ₽3 106 | ₽3 727 |
| [!KEYREF s1.small] | ₽6 205 | ₽7 447 |
| [!KEYREF s1.medium] | ₽12 417 | ₽14 900 |
| [!KEYREF s1.large] | ₽24 828 | ₽29 793 |
| [!KEYREF s1.xlarge] | ₽49 662 | ₽59 594 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano] | ₽423 | ₽508 |
| [!KEYREF b2.micro] | ₽715 | ₽858 |
| [!KEYREF b2.medium] | ₽1 318 | ₽1 581 |
| [!KEYREF s2.micro] | ₽2 863 | ₽3 436 |
| [!KEYREF s2.small] | ₽5 728 | ₽6 873 |
| [!KEYREF s2.medium] | ₽11 454 | ₽13 745 |
| [!KEYREF s2.large] | ₽17 181 | ₽20 618 |
| [!KEYREF s2.xlarge] | ₽22 909 | ₽27 491 |
| [!KEYREF s2.2xlarge] | ₽34 364 | ₽41 237 |
| [!KEYREF s2.3xlarge] | ₽45 819 | ₽54 982 |
| [!KEYREF s2.4xlarge] | ₽57 273 | ₽68 728 |
| [!KEYREF s2.5xlarge] | ₽68 728 | ₽82 473 |

**[!TAB Per hour per host]**

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- | ----- |
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | ₽0.5880 | ₽0.7056 |
| [!KEYREF b1.micro] | ₽0.9930 | ₽1.1916 |
| [!KEYREF b1.medium] | ₽1.8300 | ₽2.1960 |
| [!KEYREF s1.nano] | ₽2.1610 | ₽2.5932 |
| [!KEYREF s1.micro] | ₽4.3136 | ₽5.1763 |
| [!KEYREF s1.small] | ₽8.6186 | ₽10.3424 |
| [!KEYREF s1.medium] | ₽17.2458 | ₽20.6949 |
| [!KEYREF s1.large] | ₽34.4831 | ₽41.3797 |
| [!KEYREF s1.xlarge] | ₽68.9746 | ₽82.7695 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano] | ₽0.5880 | ₽0.7056 |
| [!KEYREF b2.micro] | ₽0.9930 | ₽1.1916 |
| [!KEYREF b2.medium] | ₽1.8300 | ₽2.1960 |
| [!KEYREF s2.micro] | ₽3.9770 | ₽4.7724 |
| [!KEYREF s2.small] | ₽7.9550 | ₽9.5460 |
| [!KEYREF s2.medium] | ₽15.9090 | ₽19.0908 |
| [!KEYREF s2.large] | ₽23.8630 | ₽28.6356 |
| [!KEYREF s2.xlarge] | ₽31.8180 | ₽38.1816 |
| [!KEYREF s2.2xlarge] | ₽47.7280 | ₽57.2736 |
| [!KEYREF s2.3xlarge] | ₽63.6370 | ₽76.3644 |
| [!KEYREF s2.4xlarge] | ₽79.5460 | ₽95.4552 |
| [!KEYREF s2.5xlarge] | ₽95.4550 | ₽114.5460 |

---

### Storage and backups {#prices-storage}

| Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, with VAT |
| ----- | ----- | ----- |
| Standard network storage | ₽1.9068 | ₽2.2881 |
| Fast network storage | ₽6.7797 | ₽8.1356 |
| NVMe | ₽6.7797 | ₽8.1356 |
| Backups beyond the storage size | ₽2.1186 | ₽2.5424 |

### Outgoing traffic {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]

