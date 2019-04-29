---
editable: false
---
# Pricing policy for [!KEYREF mmy-name]

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

## What goes into the cost of using [!KEYREF mmy-short-name] {#rules}

The cost of [!KEYREF mmy-name] usage is based on:

* Storage type and size (disk space).

* [The DB class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Settings and number of backups.

* The amount of outgoing traffic.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the host [!KEYREF MY] is not performing its main functions.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (NVMe) can only be ordered for clusters with more than 3 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Hosts {prices-hosts}

---

**[!TAB Per host per month]**

| Host class | Rate for 1 hour, without VAT 
| ----- | ----- 
| **Intel Broadwell** | 
| [!KEYREF b1.nano] | $0.009046 |
| [!KEYREF b1.micro] | $0.015276 |
| [!KEYREF b1.medium] | $0.028153
| [!KEYREF s1.nano] | $0.034292
| [!KEYREF s1.micro] | $0.063153
| [!KEYREF s1.small] | $0.126323
| [!KEYREF s1.medium] | $0.252646
| [!KEYREF s1.large] | $0.505292
| [!KEYREF s1.xlarge] | $1.010600
| **Intel Cascade Lake** | 
| [!KEYREF b2.nano] | $0.009046
| [!KEYREF b2.micro] | $0.015276
| [!KEYREF b2.medium] | $0.028153
| [!KEYREF s2.micro] | $0.063153
| [!KEYREF s2.small] | $0.126323
| [!KEYREF s2.medium] | $0.252646
| [!KEYREF s2.large] | $0.378984
| [!KEYREF s2.xlarge] | $0.505292
| [!KEYREF s2.2xlarge] | $0.757953
| [!KEYREF s2.3xlarge] | $1.010600
| [!KEYREF s2.4xlarge] | $1.263261
| [!KEYREF s2.5xlarge] | $1.515907

**[!TAB Prices in roubles]**

| Host class | Rate for 1 hour, with VAT |
| ----- | -----
| **Intel Broadwell** | 
| [!KEYREF b1.nano] | ₽0.7056 |
| [!KEYREF b1.micro] | ₽1.1916 |
| [!KEYREF b1.medium] | ₽2.1960 |
| [!KEYREF s1.nano] | ₽2.6748 |
| [!KEYREF s1.micro] | ₽4.9260 |
| [!KEYREF s1.small] | ₽9.8532 |
| [!KEYREF s1.medium] | ₽19.7064 |
| [!KEYREF s1.large] | ₽39.4128 |
| [!KEYREF s1.xlarge] | ₽78.8268 |
| **Intel Cascade Lake** | 
| [!KEYREF b2.nano] | ₽0.7056 |
| [!KEYREF b2.micro] | ₽1.1916 |
| [!KEYREF b2.medium] | ₽2.1960 |
| [!KEYREF s2.micro] | ₽4.9260 |
| [!KEYREF s2.small] | ₽9.8532 |
| [!KEYREF s2.medium] | ₽19.7064 |
| [!KEYREF s2.large] | ₽29.5608 |
| [!KEYREF s2.xlarge] | ₽39.4128 |
| [!KEYREF s2.2xlarge] | ₽59.1204 |
| [!KEYREF s2.3xlarge] | ₽78.8268 |
| [!KEYREF s2.4xlarge] | ₽98.5344 |
| [!KEYREF s2.5xlarge] | ₽118.2408 |

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

