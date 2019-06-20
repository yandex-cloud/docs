---
editable: false
---
# Pricing policy for {{ mpg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ mpg-short-name }} {#rules}

The cost of {{ mpg-name }} usage is based on:

* Storage type and size (disk space).

* [The DB class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Settings and number of backups.

* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [#T](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the host {{ PG }} is not performing its main functions.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (NVMe) can only be ordered for clusters with more than 3 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.

    * During an automatic backup, {{ mpg-short-name }} does not create a new copy but saves changes in the DB as compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Hosts {prices-hosts}

{% list tabs %}

- Prices in USD
  
  | Host class | Rate for 1 hour, without VAT
  | ----- | -----
  | **Intel Broadwell** |
  {{ b1-nano }}| $0.009046
  {{ b1-micro }} | $0.015276
  {{ b1-medium }} | $0.028153
  {{ s1-nano }}| $0.033246
  {{ s1-micro }} | $0.066362
  {{ s1-small }} | $0.132594
  {{ s1-medium }} | $0.265319
  {{ s1-large }} | $0.530508
  {{ s1-xlarge }} | $1.061147
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.009046
  {{ b2-micro }} | $0.015276
  {{ b2-medium }} | $0.028153
  {{ s2-micro }} | $0.061184
  {{ s2-small }} | $0.122384
  {{ s2-medium }} | $0.244753
  {{ s2-large }} | $0.367123
  {{ s2-xlarge }} | $0.489507
  {{ s2-2xlarge }} | $0.734276
  {{ s2-3xlarge }} | $0.979030
  {{ s2-4xlarge }}| $1.223784
  {{ s2-5xlarge }}| $1.468538
  
- Prices in roubles
  
  | Host class | Rate for 1 hour, with VAT |
  | ----- | -----
  | **Intel Broadwell** |
  | {{ b1-nano }} | ₽0.7056 |
  | {{ b1-micro }} | ₽1.1916 |
  | {{ b1-medium }} | ₽2.1960 |
  | {{ s1-nano }} | ₽2.5932 |
  | {{ s1-micro }} | ₽5.1763 |
  | {{ s1-small }} | ₽10.3424 |
  | {{ s1-medium }} | ₽20.6949 |
  | {{ s1-large }} | ₽41.3797 |
  | {{ s1-xlarge }} | ₽82.7695 |
  | **Intel Cascade Lake** |
  | {{ b2-nano }} | ₽0.7056 |
  | {{ b2-micro }} | ₽1.1916 |
  | {{ b2-medium }} | ₽2.1960 |
  | {{ s2-micro }} | ₽4.7724 |
  | {{ s2-small }} | ₽9.5460 |
  | {{ s2-medium }} | ₽19.0908 |
  | {{ s2-large }} | ₽28.6356 |
  | {{ s2-xlarge }} | ₽38.1816 |
  | {{ s2-2xlarge }} | ₽57.2736 |
  | {{ s2-3xlarge }} | ₽76.3644 |
  | {{ s2-4xlarge }} | ₽95.4552 |
  | {{ s2-5xlarge }} | ₽114.5460 |
  
{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Prices in USD
  | Service | Rate for 1 GB per month, without VAT |
  | ----- | -----
  | Standard network storage| $0.029334 |
  | Fast network storage| $0.104302 |
  | NVMe| $0.104302 |
  | Backups beyond the storage size| $0.032594 |
  
- Prices in roubles
  | Service | Rate for 1 GB per month, with VAT |
  | ----- | -----
  | Standard network storage| ₽2.2881 |
  | Fast network storage| ₽8.1356 |
  | NVMe| ₽8.1356 |
  | Backups beyond the storage size| ₽2.5424 |
  
{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

