---
editable: false
---
# Pricing for [!KEYREF mmy-name]

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

| Host class | Cost per month, without VAT | Cost per month, with VAT |
| ----- | ----- | ----- |
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | ₽423 | ₽508 |
| [!KEYREF b1.micro] | ₽715 | ₽858 |
| [!KEYREF b1.medium] | ₽1 318 | ₽1 581 |
| [!KEYREF s1.nano] | ₽1 605 | ₽1 926 |
| [!KEYREF s1.micro] | ₽2 956 | ₽3 547 |
| [!KEYREF s1.small] | ₽5 912 | ₽7 094 |
| [!KEYREF s1.medium] | ₽11 824 | ₽14 189 |
| [!KEYREF s1.large] | ₽23 648 | ₽28 377 |
| [!KEYREF s1.xlarge] | ₽47 296 | ₽56 755 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano] | ₽423 | ₽508 |
| [!KEYREF b2.micro] | ₽715 | ₽858 |
| [!KEYREF b2.medium] | ₽1 318 | ₽1 581 |
| [!KEYREF s2.micro] | ₽2 956 | ₽3 547 |
| [!KEYREF s2.small] | ₽5 912 | ₽7 094 |
| [!KEYREF s2.medium] | ₽11 824 | ₽14 189 |
| [!KEYREF s2.large] | ₽17 736 | ₽21 284 |
| [!KEYREF s2.xlarge] | ₽23 648 | ₽28 377 |
| [!KEYREF s2.2xlarge] | ₽35 472 | ₽42 567 |
| [!KEYREF s2.3xlarge] | ₽47 296 | ₽56 755 |
| [!KEYREF s2.4xlarge] | ₽59 121 | ₽70 945 |
| [!KEYREF s2.5xlarge] | ₽70 944 | ₽85 133 |

**[!TAB Per hour per host]**

| Host class | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| **Intel Broadwell** |  |
| [!KEYREF b1.nano] | ₽0.5880 | ₽0.7056 |
| [!KEYREF b1.micro] | ₽0.9930 | ₽1.1916 |
| [!KEYREF b1.medium] | ₽1.8300 | ₽2.1960 |
| [!KEYREF s1.nano] | ₽2.2290 | ₽2.6748 |
| [!KEYREF s1.micro] | ₽4.1050 | ₽4.9260 |
| [!KEYREF s1.small] | ₽8.2110 | ₽9.8532 |
| [!KEYREF s1.medium] | ₽16.4220 | ₽19.7064 |
| [!KEYREF s1.large] | ₽32.8440 | ₽39.4128 |
| [!KEYREF s1.xlarge] | ₽65.6890 | ₽78.8268 |
| **Intel Cascade Lake** |  |
| [!KEYREF b2.nano] | ₽0.5880 | ₽0.7056 |
| [!KEYREF b2.micro] | ₽0.9930 | ₽1.1916 |
| [!KEYREF b2.medium] | ₽1.8300 | ₽2.1960 |
| [!KEYREF s2.micro] | ₽4.1050 | ₽4.9260 |
| [!KEYREF s2.small] | ₽8.2110 | ₽9.8532 |
| [!KEYREF s2.medium] | ₽16.4220 | ₽19.7064 |
| [!KEYREF s2.large] | ₽24.6340 | ₽29.5608 |
| [!KEYREF s2.xlarge] | ₽32.8440 | ₽39.4128 |
| [!KEYREF s2.2xlarge] | ₽49.2670 | ₽59.1204 |
| [!KEYREF s2.3xlarge] | ₽65.6890 | ₽78.8268 |
| [!KEYREF s2.4xlarge] | ₽82.1120 | ₽98.5344 |
| [!KEYREF s2.5xlarge] | ₽98.5340 | ₽118.2408 |

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

