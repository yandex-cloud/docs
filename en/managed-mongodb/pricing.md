---
editable: false
---
# Pricing policy for {{ MG }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ mmg-short-name }} {#rules}

The cost of {{ mmg-name }} usage is based on:

* Storage type and size (disk space).

* [The DB host class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Settings and number of backups.

* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [#T](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the host {{ MG }} is not performing its main functions.

### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (NVMe) can only be ordered for clusters with more than 3 hosts, in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.

    * During an automatic backup, {{ mmg-short-name }} does not create a new copy but saves changes in the DB as compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Prices {#prices}

### Hosts {#prices-hosts}

{% list tabs %}

- Prices in USD
  
  | Host class | Rate for 1 hour, without VAT
  | ----- | ----- 
  | **Intel Broadwell** | 
  {{ b1-nano }}| $0.013807
  {{ b1-micro }} | $0.020256
  {{ b1-medium }} | $0.037820
  {{ s1-nano }}| $0.038461
  {{ s1-micro }} | $0.077053
  {{ s1-small }} | $0.153976
  {{ s1-medium }} | $0.308083
  {{ s1-large }} | $0.616035
  {{ s1-xlarge }} | $1.232203
  **Intel Cascade Lake** | 
  {{ b2-nano }}| $0.013807
  {{ b2-micro }} | $0.020256
  {{ b2-medium }} | $0.037820
  {{ s2-micro }} | $0.077053
  {{ s2-small }} | $0.153976
  {{ s2-medium }} | $0.308083
  {{ s2-large }} | $0.464661
  {{ s2-xlarge }} | $0.616035
  {{ s2-2xlarge }} | $0.929338
  {{ s2-3xlarge }} | $1.232203
  {{ s2-4xlarge }}| $1.548892
  {{ s2-5xlarge }}| $1.858661
  
- Prices in roubles
  
  | Host class | Rate for 1 hour, with VAT |
  | ----- | -----
  | **Intel Broadwell** |  |
  {{ b1-nano }}| ₽1.0770
  {{ b1-micro }} | ₽1.5800
  {{ b1-medium }} | ₽2.9500
  {{ s1-nano }} | ₽3.0000 | 
  {{ s1-micro }} | ₽6.0102 | 
  {{ s1-small }} | ₽12.0102 | 
  {{ s1-medium }} | ₽24.0305 | 
  {{ s1-large }} | ₽48.0508 | 
  {{ s1-xlarge }} | ₽96.1119 
  **Intel Cascade Lake** | | 
  {{ b2-nano }}| ₽1.0770
  {{ b2-small }} | ₽1.5800
  {{ b2-medium }} | ₽2.9500
  {{ s2-micro }} | ₽6.0102
  {{ s2-small }} | ₽12.0102
  {{ s2-medium }} | ₽24.0305
  {{ s2-large }} | ₽36.2436
  {{ s2-xlarge }} | ₽48.0508
  {{ s2-2xlarge }} | ₽72.4884
  {{ s2-3xlarge }} | ₽96.1119
  {{ s2-4xlarge }}| ₽120.8136
  {{ s2-5xlarge }}| ₽144.9756
  
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

