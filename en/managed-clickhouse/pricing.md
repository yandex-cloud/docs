---
editable: false
---
# Pricing policy for [!KEYREF mch-short-name]

## What goes into the cost of using [!KEYREF mch-short-name] {#rules}

The cost of [!KEYREF mch-name] usage is based on:

* Storage (disk space) type and size.

* [The DB class](concepts/instance-types.md) selected for the cluster.

* The number of database hosts in clusters (including ZooKeeper hosts for [!KEYREF CH] clusters).

* Settings and number of backups.

* The amount of outgoing traffic.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

> [!IMPORTANT]

For each [!KEYREF CH] cluster with 2 or more hosts, [!KEYREF CH] automatically creates 3 ZooKeeper hosts.

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

### [!KEYREF CH] and ZooKeeper {#prices-clickhouse}

You can choose the host class for the [!KEYREF CH] hosts and ZooKeeper hosts (as appropriate for the expected replication load).

For example, let's say you created a [!KEYREF CH] cluster with 3 hosts using the `s1.micro` host class, and did not specify the class for the ZooKeeper hosts. [!KEYREF mch-short-name] automatically creates 3 ZooKeeper hosts using the `s1.nano` class.

The hourly price will be calculated using the rates below (including VAT): `3 × ₽5.5119 + 3 × ₽1.7492 = ₽21.78`.

## Prices {#prices}

### Hosts {prices-hosts}

Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT

**[!KEYREF CH]** |  |  |
s1.nano | ₽2.2966 | ₽2.7559 |
s1.micro | ₽4.5932 | ₽5.5119 |
s1.small | ₽9.1780 | ₽11.0136 |
s1.medium | ₽18.3559 | ₽22.0271 |
s1.large | ₽36.7119 | ₽44.0542 |
s1.xlarge | ₽73.4153 | ₽88.0983 |
**ZooKeeper** |  |  |
s1.nano | ₽1.4576 | ₽1.7492 |
s1.micro | ₽2.8475 | ₽3.4169 |
s1.small | ₽5.6271 | ₽6.7525 |
s1.medium | ₽11.1864 | ₽13.4237 |
s1.large | ₽22.3220 | ₽26.7864 |
s1.xlarge | ₽44.5678 | ₽53.4814 ₽

### Storage and backups {#prices-storage}

Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, with VAT

The standard NAS | ₽1.9068 | ₽2.2881 |
Fast network storage | ₽6.7797 | ₽8.1356 |
Fast local storage | ₽6.7797 | ₽8.1356 |
Backup over storage size | ₽2.1186 | ₽2.5424 ₽

### Outgoing traffic {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]

