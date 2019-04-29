---
editable: false
---
# Pricing policy for [!KEYREF mch-short-name]

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

## What goes into the cost of using [!KEYREF mch-short-name] {#rules}

The cost of [!KEYREF mch-name] usage is based on:

* Storage type and size (disk space).

* [The DB class](concepts/instance-types.md) selected for the cluster.

* The number of database hosts in clusters (including ZooKeeper hosts for [!KEYREF CH] clusters).

* Settings and number of backups.

* The amount of outgoing traffic.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

> [!IMPORTANT]
>
> For each [!KEYREF CH] cluster with 2 or more hosts, [!KEYREF CH] automatically creates 3 ZooKeeper hosts.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). The time when the DBMS host or ZooKeeper cannot perform its main functions is not charged.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (NVMe) can only be ordered for clusters with more than 2 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.

    * During an automatic backup, [!KEYREF mch-short-name] does not create a new copy but saves changes in the DB as compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

### [!KEYREF CH] and ZooKeeper {#clickhouse-zooker}

You can choose the host class for the [!KEYREF CH] hosts and ZooKeeper hosts (as appropriate for the expected replication load).

For example, let's say you created a [!KEYREF CH] cluster with 3 hosts using the `s1.micro` host class, and did not specify the class for the ZooKeeper hosts. [!KEYREF mch-short-name] automatically creates 3 ZooKeeper hosts using the `s1.nano` class.

The hourly price will be calculated using the rates below (including VAT): `3 × ₽5.5119 + 3 × ₽1.7492 = ₽21.78`.

## Pricing {#prices}

### Hosts [!KEYREF CH] {#prices-clickhouse}

---

**[!TAB Prices in USD]**

| Host class | Rate for 1 hour, without VAT 
| ----- | ----- 
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | $0.009046 |
| [!KEYREF b1.micro] | $0.015276 |
| [!KEYREF b1.medium] | $0.028153 |
| [!KEYREF s1.nano] | $0.035332 |
| [!KEYREF s1.micro] | $0.070665 |
| [!KEYREF s1.small] | $0.141200 |
| [!KEYREF s1.medium] | $0.282398 |
| [!KEYREF s1.large] | $0.564797 |
| [!KEYREF s1.xlarge] | $1.129465 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano]  |  $0.009046 |
| [!KEYREF b2.micro] | $0.015276 |
| [!KEYREF b2.medium] | $0.028153 |
| [!KEYREF s2.micro] | $0.065138 |
| [!KEYREF s2.small] | $0.130276 |
| [!KEYREF s2.medium] | $0.260553 |
| [!KEYREF s2.large] | $0.390815 |
| [!KEYREF s2.xlarge] | $0.521092 |
| [!KEYREF s2.2xlarge] | $0.781630 |
| [!KEYREF s2.3xlarge] | $1.042184 |
| [!KEYREF s2.4xlarge] | $1.302738 |
| [!KEYREF s2.5xlarge] | $1.563276 |

**[!TAB Prices in roubles]**

| Host class | Rate for 1 hour, with VAT |
| ----- | -----
| **Intel Broadwell** | 
| [!KEYREF b1.nano] | ₽0.7056 |
| [!KEYREF b1.micro] | ₽1.1916 |
| [!KEYREF b1.medium] | ₽2.1960 |
| [!KEYREF s1.nano] | ₽2.7559 |
| [!KEYREF s1.micro] | ₽5.5119 |
| [!KEYREF s1.small] | ₽11.0136 |
| [!KEYREF s1.medium] | ₽22.0271 |
| [!KEYREF s1.large] | ₽44.0542 |
| [!KEYREF s1.xlarge] | ₽88.0983 |
| **Intel Cascade Lake** | 
| [!KEYREF b2.nano] | ₽0.7056 |
| [!KEYREF b2.micro] | ₽1.1916 |
| [!KEYREF b2.medium] | ₽2.1960 |
| [!KEYREF s2.micro] | ₽5.0808 |
| [!KEYREF s2.small] | ₽10.1616 |
| [!KEYREF s2.medium] | ₽20.3232 |
| [!KEYREF s2.large] | ₽30.4836 |
| [!KEYREF s2.xlarge] | ₽40.6452 |
| [!KEYREF s2.2xlarge] | ₽60.9672 |
| [!KEYREF s2.3xlarge] | ₽81.2904 |
| [!KEYREF s2.4xlarge] | ₽101.6136 |
| [!KEYREF s2.5xlarge] | ₽121.9356 |

---

### ZooKeeper hosts {#prices-zookeeper}

---

**[!TAB Prices in USD]**

| Host class | Rate for 1 hour, without VAT 
| ----- | ----- 
| **Intel Broadwell** | 
| [!KEYREF b1.nano] | $0.008984 |
| [!KEYREF b1.micro] | $0.014215 |
| [!KEYREF b1.medium] | $0.022953 |
| [!KEYREF s1.nano] | $0.022425 |
| [!KEYREF s1.micro] | $0.043806 |
| [!KEYREF s1.small] | $0.086570 |
| [!KEYREF s1.medium] | $0.172098 |
| [!KEYREF s1.large] | $0.343415 |
| [!KEYREF s1.xlarge] | $0.685658 |
| **Intel Cascade Lake** | 
| [!KEYREF b2.nano] |  $0.008984 |
| [!KEYREF b2.micro] | $0.014215 |
| [!KEYREF b2.medium] | $0.022953 |
| [!KEYREF s2.micro] | $0.040784 |
| [!KEYREF s2.small] | $0.080261 |
| [!KEYREF s2.medium] | $0.159215 |
| [!KEYREF s2.large] | $0.238169 |
| [!KEYREF s2.xlarge] | $0.317123 |
| [!KEYREF s2.2xlarge] | $0.475030 |
| [!KEYREF s2.3xlarge] | $0.632938 |
| [!KEYREF s2.4xlarge] | $0.790846 |
| [!KEYREF s2.5xlarge] | $0.948753 |

**[!TAB Prices in roubles]**

| Host class | Rate for 1 hour, with VAT |
| ----- | ----- 
| **Intel Broadwell** | 
[!KEYREF b1.nano]| ₽0.7008
[!KEYREF b1.micro]| ₽1.1088
[!KEYREF b1.medium]| ₽1.7904
[!KEYREF s1.nano]| ₽1.7492 | 
[!KEYREF s1.micro]| ₽3.4169 | 
[!KEYREF s1.small]| ₽6.7525 | 
[!KEYREF s1.medium]| ₽13.4237 | 
[!KEYREF s1.large]| ₽26.7864 | 
[!KEYREF s1.xlarge]| ₽53.4814 | 
**Intel Cascade Lake** | 
[!KEYREF b2.nano]| ₽0.7008
[!KEYREF b2.micro]| ₽1.1088
[!KEYREF b2.medium]| ₽1.7904
[!KEYREF s2.micro]| ₽3.1812
[!KEYREF s2.small]| ₽6.2604
[!KEYREF s2.medium]| ₽12.4188
[!KEYREF s2.large]| ₽18.5772
[!KEYREF s2.xlarge]| ₽24.7356
[!KEYREF s2.2xlarge]| ₽37.0524
[!KEYREF s2.3xlarge]| ₽49.3692
[!KEYREF s2.4xlarge]| ₽61.6860
[!KEYREF s2.5xlarge]| ₽74.0028

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

