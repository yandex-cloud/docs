---
editable: false
---

# Pricing for {{ mch-short-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ mch-short-name }} {#rules}

The cost of {{ mch-name }} usage is based on:

* Storage type and size (disk space).

* [The host class](concepts/instance-types.md) selected for the cluster.

* The number of database hosts in clusters (including ZooKeeper hosts for {{ CH }} clusters).

* Settings and number of backups.

* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. Exact class characteristics are given in [{#T}](concepts/instance-types.md).

{% note important %}

When you create a cluster with 2 or more {{ CH }}  hosts, 3  {{ ZK }} hosts are created automatically to provide replication and fault tolerance.

{% endnote %}

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You aren't charged for time when the DBMS or {{ ZK }} host isn't performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (SSD) can only be ordered for clusters with more than 2 hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mch-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

### {{ CH }} and ZooKeeper {#clickhouse-zookeeper}

You can choose the host class for {{ CH }} and ZooKeeper hosts (as appropriate for the expected replication load).

For example, let's say you create a {{ CH }} cluster with 3 `s1.micro` class hosts, but didn't specify the class of the ZooKeeper hosts. {{ mch-short-name }} automatically creates 3 `s1.nano` class ZooKeeper hosts.

The hourly price will be calculated using the rates below (including VAT): `3 × ₽5.5119 + 3 × ₽1.7492 = ₽21.78`.

## Pricing {#prices}

### {{ CH }} hosts {#prices-clickhouse}

{% list tabs %}

- Prices in USD

  | Host class | Rate for 1 hour, without VAT
  | ----- | -----
  | **Intel Broadwell** |  |
  | {{ b1-nano }} | $0.009046 |
  | {{ b1-micro }} | $0.015276 |
  | {{ b1-medium }} | $0.028153 |
  | {{ s1-nano }} | $0.035332 |
  | {{ s1-micro }} | $0.070665 |
  | {{ s1-small }} | $0.141200 |
  | {{ s1-medium }} | $0.282398 |
  | {{ s1-large }} | $0.564797 |
  | {{ s1-xlarge }} | $1.129465 |
  | **Intel Cascade Lake** |  |
  | {{ b2-nano }}  |  $0.009046 |
  | {{ b2-micro }} | $0.015276 |
  | {{ b2-medium }} | $0.028153 |
  | {{ s2-micro }} | $0.065138 |
  | {{ s2-small }} | $0.130276 |
  | {{ s2-medium }} | $0.260553 |
  | {{ s2-large }} | $0.390815 |
  | {{ s2-xlarge }} | $0.521092 |
  | {{ s2-2xlarge }} | $0.781630 |
  | {{ s2-3xlarge }} | $1.042184 |
  | {{ s2-4xlarge }} | $1.302738 |
  | {{ s2-5xlarge }} | $1.563276 |

- Prices in roubles

  | Host class | Rate for 1 hour, with VAT |
  | ----- | -----
  | **Intel Broadwell** |
  | {{ b1-nano }} | ₽0.7056 |
  | {{ b1-micro }} | ₽1.1916 |
  | {{ b1-medium }} | ₽2.1960 |
  | {{ s1-nano }} | ₽2.7559 |
  | {{ s1-micro }} | ₽5.5119 |
  | {{ s1-small }} | ₽11.0136 |
  | {{ s1-medium }} | ₽22.0271 |
  | {{ s1-large }} | ₽44.0542 |
  | {{ s1-xlarge }} | ₽88.0983 |
  | **Intel Cascade Lake** |
  | {{ b2-nano }} | ₽0.7056 |
  | {{ b2-micro }} | ₽1.1916 |
  | {{ b2-medium }} | ₽2.1960 |
  | {{ s2-micro }} | ₽5.0808 |
  | {{ s2-small }} | ₽10.1616 |
  | {{ s2-medium }} | ₽20.3232 |
  | {{ s2-large }} | ₽30.4836 |
  | {{ s2-xlarge }} | ₽40.6452 |
  | {{ s2-2xlarge }} | ₽60.9672 |
  | {{ s2-3xlarge }} | ₽81.2904 |
  | {{ s2-4xlarge }} | ₽101.6136 |
  | {{ s2-5xlarge }} | ₽121.9356 |

{% endlist %}

### {{ ZK }} hosts {#prices-zookeeper}

{% list tabs %}

- Prices in USD

  | Host class | Rate for 1 hour, without VAT
  | ----- | -----
  | **Intel Broadwell** |
  | {{ b1-nano }} | $0.008984 |
  | {{ b1-micro }} | $0.014215 |
  | {{ b1-medium }} | $0.022953 |
  | {{ s1-nano }} | $0.022425 |
  | {{ s1-micro }} | $0.043806 |
  | {{ s1-small }} | $0.086570 |
  | {{ s1-medium }} | $0.172098 |
  | {{ s1-large }} | $0.343415 |
  | {{ s1-xlarge }} | $0.685658 |
  | **Intel Cascade Lake** |
  | {{ b2-nano }} |  $0.008984 |
  | {{ b2-micro }} | $0.014215 |
  | {{ b2-medium }} | $0.022953 |
  | {{ s2-micro }} | $0.040784 |
  | {{ s2-small }} | $0.080261 |
  | {{ s2-medium }} | $0.159215 |
  | {{ s2-large }} | $0.238169 |
  | {{ s2-xlarge }} | $0.317123 |
  | {{ s2-2xlarge }} | $0.475030 |
  | {{ s2-3xlarge }} | $0.632938 |
  | {{ s2-4xlarge }} | $0.790846 |
  | {{ s2-5xlarge }} | $0.948753 |

- Prices in roubles

  | Host class | Rate for 1 hour, with VAT |
  | ----- | -----
  | **Intel Broadwell** |
  {{ b1-nano }}| ₽0.7008
  {{ b1-micro }}| ₽1.1088
  {{ b1-medium }}| ₽1.7904
  {{ s1-nano }}| ₽1.7492 |
  {{ s1-micro }}| ₽3.4169 |
  {{ s1-small }}| ₽6.7525 |
  {{ s1-medium }}| ₽13.4237 |
  {{ s1-large }}| ₽26.7864 |
  {{ s1-xlarge }}| ₽53.4814 |
  **Intel Cascade Lake** |
  {{ b2-nano }}| ₽0.7008
  {{ b2-micro }}| ₽1.1088
  {{ b2-medium }}| ₽1.7904
  {{ s2-micro }}| ₽3.1812
  {{ s2-small }}| ₽6.2604
  {{ s2-medium }}| ₽12.4188
  {{ s2-large }}| ₽18.5772
  {{ s2-xlarge }}| ₽24.7356
  {{ s2-2xlarge }}| ₽37.0524
  {{ s2-3xlarge }}| ₽49.3692
  {{ s2-4xlarge }}| ₽61.6860
  {{ s2-5xlarge }}| ₽74.0028

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Prices in USD
  | Service | Rate for 1 GB per month, without VAT |
  | ----- | -----
  | Standard network storage| $0.029334 |
  | Fast network storage| $0.104302 |
  | SSD| $0.104302 |
  | Backups beyond the storage size| $0.032594 |

- Prices in roubles
  | Service | Rate for 1 GB per month, with VAT |
  | ----- | -----
  | Standard network storage| ₽2.2881 |
  | Fast network storage| ₽8.1356 |
  | SSD| ₽8.1356 |
  | Backups beyond the storage size| ₽2.5424 |

{% endlist %}


### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

