---
editable: false
---
# Pricing for [!KEYREF mch-short-name]

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

**[!TAB Per host per month]**

| Host class | Cost per month, without VAT | Cost per month, with VAT |
| ----- | ----- | ----- | ----- |
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | ₽423 | ₽508 |
| [!KEYREF b1.micro] | ₽715 | ₽858 |
| [!KEYREF b1.medium] | ₽1 318 | ₽1 581 |
| [!KEYREF s1.nano] | ₽1 654 | ₽1 984 |
| [!KEYREF s1.micro] | ₽3 307 | ₽3 969 |
| [!KEYREF s1.small] | ₽6 608 | ₽7 930 |
| [!KEYREF s1.medium] | ₽13 216 | ₽15 860 |
| [!KEYREF s1.large] | ₽26 432 | ₽31 719 |
| [!KEYREF s1.xlarge] | ₽52 859 | ₽63 431 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano] | ₽423 | ₽508 |
| [!KEYREF b2.micro] | ₽715 | ₽858 |
| [!KEYREF b2.medium] | ₽1 318 | ₽1 581 |
| [!KEYREF s2.micro] | ₽3 048 | ₽3 658 |
| [!KEYREF s2.small] | ₽6 097 | ₽7 316 |
| [!KEYREF s2.medium] | ₽12 194 | ₽14 633 |
| [!KEYREF s2.large] | ₽18 290 | ₽21 948 |
| [!KEYREF s2.xlarge] | ₽24 387 | ₽29 265 |
| [!KEYREF s2.2xlarge] | ₽36 580 | ₽43 896 |
| [!KEYREF s2.3xlarge] | ₽48 774 | ₽58 529 |
| [!KEYREF s2.4xlarge] | ₽60 968 | ₽73 162 |
| [!KEYREF s2.5xlarge] | ₽73 161 | ₽87 794 |

**[!TAB Per hour per host]**

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | ₽0.5880 | ₽0.7056 |
| [!KEYREF b1.micro] | ₽0.9930 | ₽1.1916 |
| [!KEYREF b1.medium] | ₽1.8300 | ₽2.1960 |
| [!KEYREF s1.nano] | ₽2.2966 | ₽2.7559 |
| [!KEYREF s1.micro] | ₽4.5932 | ₽5.5119 |
| [!KEYREF s1.small] | ₽9.1780 | ₽11.0136 |
| [!KEYREF s1.medium] | ₽18.3559 | ₽22.0271 |
| [!KEYREF s1.large] | ₽36.7119 | ₽44.0542 |
| [!KEYREF s1.xlarge] | ₽73.4153 | ₽88.0983 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano] | ₽0.5880 | ₽0.7056 |
| [!KEYREF b2.micro] | ₽0.9930 | ₽1.1916 |
| [!KEYREF b2.medium] | ₽1.8300 | ₽2.1960 |
| [!KEYREF s2.micro] | ₽4.2340 | ₽5.0808 |
| [!KEYREF s2.small] | ₽8.4680 | ₽10.1616 |
| [!KEYREF s2.medium] | ₽16.9360 | ₽20.3232 |
| [!KEYREF s2.large] | ₽25.4030 | ₽30.4836 |
| [!KEYREF s2.xlarge] | ₽33.8710 | ₽40.6452 |
| [!KEYREF s2.2xlarge] | ₽50.8060 | ₽60.9672 |
| [!KEYREF s2.3xlarge] | ₽67.7420 | ₽81.2904 |
| [!KEYREF s2.4xlarge] | ₽84.6780 | ₽101.6136 |
| [!KEYREF s2.5xlarge] | ₽101.6130 | ₽121.9356 |

---

### ZooKeeper hosts {#prices-zookeeper}

---

**[!TAB Per host per month]**

| Host class | Cost per month, without VAT | Cost per month, with VAT |
| ----- | ----- | ----- | ----- |
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | ₽420 | ₽505 |
| [!KEYREF b1.micro] | ₽665 | ₽798 |
| [!KEYREF b1.medium] | ₽1 074 | ₽1 289 |
| [!KEYREF s1.nano] | ₽1 050 | ₽1 259 |
| [!KEYREF s1.micro] | ₽2 050 | ₽2 460 |
| [!KEYREF s1.small] | ₽4 052 | ₽4 862 |
| [!KEYREF s1.medium] | ₽8 054 | ₽9 665 |
| [!KEYREF s1.large] | ₽16 072 | ₽19 286 |
| [!KEYREF s1.xlarge] | ₽32 089 | ₽38 507 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano] | ₽420 | ₽505 |
| [!KEYREF b2.micro] | ₽665 | ₽798 |
| [!KEYREF b2.medium] | ₽1 074 | ₽1 289 |
| [!KEYREF s2.micro] | ₽1 909 | ₽2 290 |
| [!KEYREF s2.small] | ₽3 756 | ₽4 507 |
| [!KEYREF s2.medium] | ₽7 451 | ₽8 942 |
| [!KEYREF s2.large] | ₽11 146 | ₽13 376 |
| [!KEYREF s2.xlarge] | ₽14 841 | ₽17 810 |
| [!KEYREF s2.2xlarge] | ₽22 231 | ₽26 678 |
| [!KEYREF s2.3xlarge] | ₽29 622 | ₽35 546 |
| [!KEYREF s2.4xlarge] | ₽37 012 | ₽44 414 |
| [!KEYREF s2.5xlarge] | ₽44 402 | ₽53 282 |

**[!TAB Per hour per host]**

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| **Intel Broadwell** |  |
[!KEYREF b1.nano]| ₽0.5840 | ₽0.7008
[!KEYREF b1.micro] | ₽0.9240 | ₽1.1088
[!KEYREF b1.medium] | ₽1.4920 | ₽1.7904
[!KEYREF s1.nano] | ₽1.4577 | ₽1.7492 | 
[!KEYREF s1.micro] | ₽2.8474 | ₽3.4169 | 
[!KEYREF s1.small] | ₽5.6271 | ₽6.7525 | 
[!KEYREF s1.medium] | ₽11.1864 | ₽13.4237 | 
[!KEYREF s1.large] | ₽22.3220 | ₽26.7864 | 
[!KEYREF s1.xlarge] | ₽44.5678 | ₽53.4814 | 
**Intel Cascade Lake** | | 
[!KEYREF b2.nano]| ₽0.5840 | ₽0.7008
[!KEYREF b2.micro] | ₽0.9240 | ₽1.1088
[!KEYREF b2.medium] | ₽1.4920 | ₽1.7904
[!KEYREF s2.micro] | ₽2.6510 | ₽3.1812
[!KEYREF s2.small] | ₽5.2170 | ₽6.2604
[!KEYREF s2.medium] | ₽10.3490 | ₽12.4188
[!KEYREF s2.large] | ₽15.4810 | ₽18.5772
[!KEYREF s2.xlarge] | ₽20.6130 | ₽24.7356
[!KEYREF s2.2xlarge] | ₽30.8770 | ₽37.0524
[!KEYREF s2.3xlarge] | ₽41.1410 | ₽49.3692
[!KEYREF s2.4xlarge]| ₽51.4050 | ₽61.6860
[!KEYREF s2.5xlarge]| ₽61.6690 | ₽74.0028

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

