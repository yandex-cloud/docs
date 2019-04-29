---
editable: false
---
# Pricing policy for [!KEYREF MG]

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

## What goes into the cost of using [!KEYREF mmg-short-name] {#rules}

The cost of [!KEYREF mmg-name] usage is based on:

* Storage type and size (disk space).

* [The DB host class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Settings and number of backups.

* The amount of outgoing traffic.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the host [!KEYREF MG] is not performing its main functions.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (NVMe) can only be ordered for clusters with more than 3 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.

    * During an automatic backup, [!KEYREF mmg-short-name] does not create a new copy but saves changes in the DB as compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Prices {#prices}

### Hosts {#prices-hosts}

---

**[!TAB Prices in USD]**

| Host class | Rate for 1 hour, without VAT
| ----- | ----- 
| **Intel Broadwell** | 
[!KEYREF b1.nano]| $0.013807
[!KEYREF b1.micro] | $0.020256
[!KEYREF b1.medium] | $0.037820
[!KEYREF s1.nano]| $0.038461
[!KEYREF s1.micro] | $0.077053
[!KEYREF s1.small] | $0.153976
[!KEYREF s1.medium] | $0.308083
[!KEYREF s1.large] | $0.616035
[!KEYREF s1.xlarge] | $1.232203
**Intel Cascade Lake** | 
[!KEYREF b2.nano]| $0.013807
[!KEYREF b2.micro] | $0.020256
[!KEYREF b2.medium] | $0.037820
[!KEYREF s2.micro] | $0.077053
[!KEYREF s2.small] | $0.153976
[!KEYREF s2.medium] | $0.308083
[!KEYREF s2.large] | $0.464661
[!KEYREF s2.xlarge] | $0.616035
[!KEYREF s2.2xlarge] | $0.929338
[!KEYREF s2.3xlarge] | $1.232203
[!KEYREF s2.4xlarge]| $1.548892
[!KEYREF s2.5xlarge]| $1.858661

**[!TAB Prices in roubles]**

| Host class | Rate for 1 hour, with VAT |
| ----- | -----
| **Intel Broadwell** |  |
[!KEYREF b1.nano]| ₽1.0770
[!KEYREF b1.micro] | ₽1.5800
[!KEYREF b1.medium] | ₽2.9500
[!KEYREF s1.nano] | ₽3.0000 | 
[!KEYREF s1.micro] | ₽6.0102 | 
[!KEYREF s1.small] | ₽12.0102 | 
[!KEYREF s1.medium] | ₽24.0305 | 
[!KEYREF s1.large] | ₽48.0508 | 
[!KEYREF s1.xlarge] | ₽96.1119 
**Intel Cascade Lake** | | 
[!KEYREF b2.nano]| ₽1.0770
[!KEYREF b2.small] | ₽1.5800
[!KEYREF b2.medium] | ₽2.9500
[!KEYREF s2.micro] | ₽6.0102
[!KEYREF s2.small] | ₽12.0102
[!KEYREF s2.medium] | ₽24.0305
[!KEYREF s2.large] | ₽36.2436
[!KEYREF s2.xlarge] | ₽48.0508
[!KEYREF s2.2xlarge] | ₽72.4884
[!KEYREF s2.3xlarge] | ₽96.1119
[!KEYREF s2.4xlarge]| ₽120.8136
[!KEYREF s2.5xlarge]| ₽144.9756

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

