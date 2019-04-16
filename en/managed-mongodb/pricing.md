---
editable: false
---
# Pricing for [!KEYREF MG]

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

## Prices as of January 1, 2019 {#prices}

### Hosts {prices-hosts}

---

**[!TAB Per host per month]**

| Host class | Cost per month, without VAT | Cost per month, with VAT |
| ----- | ----- | ----- | ----- |
| [!KEYREF b1.nano] | ₽646 | ₽775 |
| [!KEYREF b1.micro] | ₽948 | ₽1 138 |
| [!KEYREF b1.medium] | ₽1 770 | ₽2 124 |
| [!KEYREF s1.nano] | ₽1 800 | ₽2 160 |
| [!KEYREF s1.micro] | ₽3 606 | ₽4 327 |
| [!KEYREF s1.small] | ₽7 206 | ₽8 647 |
| [!KEYREF s1.medium] | ₽14 418 | ₽17 302 |
| [!KEYREF s1.large] | ₽28 830 | ₽34 597 |
| [!KEYREF s1.xlarge] | ₽57 667 | ₽69 201 |
| [!KEYREF b2.nano] | ₽646 | ₽775 |
| [!KEYREF b2.micro] | ₽948 | ₽1 138 |
| [!KEYREF b2.medium] | ₽1 770 | ₽2 124 |
| [!KEYREF s2.micro] | ₽3 326 | ₽3 991 |
| [!KEYREF s2.small] | ₽6 651 | ₽7 982 |
| [!KEYREF s2.medium] | ₽13 302 | ₽15 962 |
| [!KEYREF s2.large] | ₽19 953 | ₽23 943 |
| [!KEYREF s2.xlarge] | ₽26 604 | ₽31 925 |
| [!KEYREF s2.2xlarge] | ₽39 906 | ₽47 887 |
| [!KEYREF s2.3xlarge] | ₽53 209 | ₽63 850 |
| [!KEYREF s2.4xlarge] | ₽66 511 | ₽79 813 |
| [!KEYREF s2.5xlarge] | ₽79 813 | ₽95 775 |

**[!TAB Per hour per host]**

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- | ----- |
| [!KEYREF b1.nano] | ₽0.8975 | ₽1.0770 |
| [!KEYREF b1.micro] | ₽1.3167 | ₽1.5800 |
| [!KEYREF b1.medium] | ₽2.4583 | ₽2.9500 |
| [!KEYREF s1.nano] | ₽2.5000 | ₽3.0000 |
| [!KEYREF s1.micro] | ₽5.0085 | ₽6.0102 |
| [!KEYREF s1.small] | ₽10.0085 | ₽12.0102 |
| [!KEYREF s1.medium] | ₽20.0254 | ₽24.0305 |
| [!KEYREF s1.large] | ₽40.0424 | ₽48.0508 |
| [!KEYREF s1.xlarge] | ₽80.0932 | ₽96.1119 |
| [!KEYREF b2.nano] | ₽0.8975 | ₽1.0770 |
| [!KEYREF b2.small] | ₽1.3167 | ₽1.5800 |
| [!KEYREF b2.medium] | ₽2.4583 | ₽2.9500 |
| [!KEYREF s2.micro] | ₽4.6190 | ₽5.5428 |
| [!KEYREF s2.small] | ₽9.2380 | ₽11.0856 |
| [!KEYREF s2.medium] | ₽18.4750 | ₽22.1700 |
| [!KEYREF s2.large] | ₽27.7120 | ₽33.2544 |
| [!KEYREF s2.xlarge] | ₽36.9500 | ₽44.3400 |
| [!KEYREF s2.2xlarge] | ₽55.4250 | ₽66.5100 |
| [!KEYREF s2.3xlarge] | ₽73.9010 | ₽88.6812 |
| [!KEYREF s2.4xlarge] | ₽92.3760 | ₽110.8512 |
| [!KEYREF s2.5xlarge] | ₽110.8510 | ₽133.0212 |

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

