---
editable: false
---
# Pricing for {{ mmg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmg-short-name }} {#rules}

The cost of {{ mmg-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ MG }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 3 hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mmg-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Host computing resources {#prices-host}

The prices for computing resources are the same for all types of hosts: mongod, mongos, and mongocfg.

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour|
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.000385 |
    | 20% vCPU | $0.003718 |
    | 50% vCPU | $0.006026 |
    | 100% vCPU | $0.012821 |
    | RAM (for 1 GB) | $0.006410 |
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000385 |
    | 20% vCPU | $0.003718 |
    | 50% vCPU | $0.006026 |
    | 100% vCPU | $0.012821 |
    | RAM (for 1 GB) | $0.006410 |

- Prices in roubles, with VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.03 |
    | 20% vCPU | ₽0.29 |
    | 50% vCPU | ₽0.47 |
    | 100% vCPU | ₽1.00 |
    | RAM (for 1 GB) | ₽0.50 |
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.03 |
    | 20% vCPU | ₽0.29 |
    | 50% vCPU | ₽0.47 |
    | 100% vCPU | ₽1.00 |
    | RAM (for 1 GB) | ₽0.50 |

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Prices in USD, without VAT

  Service | Rate for 1 GB per month
  ----- | ----- | -----
  Fast network storage | $0.104302 |
  Backup over storage size | $0.032594


- Prices in roubles, with VAT

  Service | Rate for 1 GB per month
  ----- | -----
  Fast network storage | ₽8.1356 |
  Backup over storage size | ₽2.5424

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}


## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-mongodb#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.013590
  {{ b1-micro }} | $0.020256
  {{ b1-medium }}  | $0.037692
  {{ s1-nano }} | $0.038462
  {{ s1-micro }} | $0.076923
  {{ s1-small }} | $0.153846
  {{ s1-medium }}| $0.307692
  {{ s1-large }} | $0.615385
  {{ s1-xlarge }} | $1.230769
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.013590
  {{ b2-micro }} | $0.020256
  {{ b2-medium }} | $0.037692
  {{ m2-micro }} | $0.128205
  {{ m2-small }} | $0.256410
  {{ m2-medium }}| $0.384615
  {{ m2-large }} | $0.512821
  {{ m2-xlarge }} | $0.769231
  {{ m2-2xlarge }} | $1.025641
  {{ m2-3xlarge }} | $1.538462
  {{ m2-4xlarge }} | $2.051282
  {{ m2-5xlarge }} | $2.564103
  {{ m2-6xlarge }} | $3.076923
  {{ s2-micro }} | $0.076923
  {{ s2-small }} | $0.153846
  {{ s2-medium }} | $0.307692
  {{ s2-large }} | $0.461538
  {{ s2-xlarge }} | $0.615385
  {{ s2-2xlarge }} | $0.923077
  {{ s2-3xlarge }} | $1.230769
  {{ s2-4xlarge }} | $1.538462
  {{ s2-5xlarge }} | $1.846154
  {{ s2-6xlarge }} | $2.461538

- Prices in roubles, with VAT

  Host class | Rate for 1 hour
  ----- | -----
  | **Intel Broadwell** |
  {{ b1-nano }}| ₽1.06
  {{ b1-micro }} | ₽1.58
  {{ b1-medium }} | ₽2.94
  {{ s1-nano }} | ₽3.00 |
  {{ s1-micro }} | ₽6.00 |
  {{ s1-small }} | ₽12.00 |
  {{ s1-medium }} | ₽24.00 |
  {{ s1-large }} | ₽48.00 |
  {{ s1-xlarge }} | ₽96.00
  **Intel Cascade Lake** |
  {{ b2-nano }}| ₽1.06
  {{ b2-small }} | ₽1.58
  {{ b2-medium }} | ₽2.94
  {{ m2-micro }} | ₽10.00
  {{ m2-small }} | ₽20.00
  {{ m2-medium }}| ₽30.00
  {{ m2-large }} | ₽40.00
  {{ m2-xlarge }} | ₽60.00
  {{ m2-2xlarge }} | ₽80.00
  {{ m2-3xlarge }} | ₽120.00
  {{ m2-4xlarge }} | ₽160.00
  {{ m2-5xlarge }} | ₽200.00
  {{ m2-6xlarge }} | ₽240.00
  {{ s2-micro }} | ₽6.00
  {{ s2-small }} | ₽12.00
  {{ s2-medium }} | ₽24.00
  {{ s2-large }} | ₽36.00
  {{ s2-xlarge }} | ₽48.00
  {{ s2-2xlarge }} | ₽72.00
  {{ s2-3xlarge }} | ₽96.00
  {{ s2-4xlarge }}| ₽120.00
  {{ s2-5xlarge }}| ₽144.00
  {{ s2-6xlarge }} | ₽192.00

{% endlist %}
