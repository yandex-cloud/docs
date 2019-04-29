---
editable: false
---
# Pricing policy for [!KEYREF mpg-name]

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

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

**[!TAB Prices in USD]**

| Host class | Rate for 1 hour, without VAT
| ----- | ----- 
| **Intel Broadwell** | 
[!KEYREF b1.nano]| $0.009046
[!KEYREF b1.micro] | $0.015276
[!KEYREF b1.medium] | $0.028153
[!KEYREF s1.nano]| $0.033246
[!KEYREF s1.micro] | $0.066362
[!KEYREF s1.small] | $0.132594
[!KEYREF s1.medium] | $0.265319
[!KEYREF s1.large] | $0.530508
[!KEYREF s1.xlarge] | $1.061147
**Intel Cascade Lake** | 
[!KEYREF b2.nano]| $0.009046
[!KEYREF b2.micro] | $0.015276
[!KEYREF b2.medium] | $0.028153
[!KEYREF s2.micro] | $0.061184
[!KEYREF s2.small] | $0.122384
[!KEYREF s2.medium] | $0.244753
[!KEYREF s2.large] | $0.367123
[!KEYREF s2.xlarge] | $0.489507
[!KEYREF s2.2xlarge] | $0.734276
[!KEYREF s2.3xlarge] | $0.979030
[!KEYREF s2.4xlarge]| $1.223784
[!KEYREF s2.5xlarge]| $1.468538

**[!TAB Prices in roubles]**

| Host class | Rate for 1 hour, with VAT |
| ----- | ----- 
| **Intel Broadwell** | 
| [!KEYREF b1.nano] | ₽0.7056 |
| [!KEYREF b1.micro] | ₽1.1916 |
| [!KEYREF b1.medium] | ₽2.1960 |
| [!KEYREF s1.nano] | ₽2.5932 |
| [!KEYREF s1.micro] | ₽5.1763 |
| [!KEYREF s1.small] | ₽10.3424 |
| [!KEYREF s1.medium] | ₽20.6949 |
| [!KEYREF s1.large] | ₽41.3797 |
| [!KEYREF s1.xlarge] | ₽82.7695 |
| **Intel Cascade Lake** | 
| [!KEYREF b2.nano] | ₽0.7056 |
| [!KEYREF b2.micro] | ₽1.1916 |
| [!KEYREF b2.medium] | ₽2.1960 |
| [!KEYREF s2.micro] | ₽4.7724 |
| [!KEYREF s2.small] | ₽9.5460 |
| [!KEYREF s2.medium] | ₽19.0908 |
| [!KEYREF s2.large] | ₽28.6356 |
| [!KEYREF s2.xlarge] | ₽38.1816 |
| [!KEYREF s2.2xlarge] | ₽57.2736 |
| [!KEYREF s2.3xlarge] | ₽76.3644 |
| [!KEYREF s2.4xlarge] | ₽95.4552 |
| [!KEYREF s2.5xlarge] | ₽114.5460 |

---

### Storage and backups {#prices-storage}

---

**[!TAB Prices in USD]**
| Service | Rate for 1 GB per month, without VAT |
| ----- | ----- 
| Standard network storage| $0.029334 |
| Fast network storage| $0.104302 |
| NVMe| $0.104302 |
| Backups beyond the storage size| $0.032594 |

**[!TAB Prices in roubles]**
| Service | Rate for 1 GB per month, with VAT |
| ----- | ----- 
| Standard network storage| ₽2.2881 |
| Fast network storage| ₽8.1356 |
| NVMe| ₽8.1356 |
| Backups beyond the storage size| ₽2.5424 |

---

### Outgoing traffic {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]

