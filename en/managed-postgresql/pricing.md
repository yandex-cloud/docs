---
editable: false
---
# Pricing for {{ mpg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mpg-short-name }} {#rules}

The cost of {{ mpg-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. Exact class characteristics are given in [{#T}](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ PG }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with 3 or more hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mpg-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Prices in USD, without VAT
  
    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.000513 |
    | 20% vCPU | $0.003590 |
    | 50% vCPU | $0.006026 |
    | 100% vCPU | $0.017179 |
    | RAM (for 1 GB) | $0.003974 |
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000513 |
    | 20% vCPU | $0.003590 |
    | 50% vCPU | $0.006026 |
    | 100% vCPU | $0.014487 |
    | RAM (for 1 GB) | $0.003974 |
  
- Prices in roubles, with VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.04 |
    | 20% vCPU | ₽0.28 |
    | 50% vCPU | ₽0.47 |
    | 100% vCPU | ₽1.34 |
    | RAM (for 1 GB) | ₽0.31 |
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.04 |
    | 20% vCPU | ₽0.28 |
    | 50% vCPU | ₽0.47 |
    | 100% vCPU | ₽1.13 |
    | RAM (for 1 GB) | ₽0.31 |

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

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-postgresql#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.008974
  {{ b1-micro }} | $0.015128
  {{ b1-medium }}  | $0.027949
  {{ s1-nano }} | $0.033077
  {{ s1-micro }} | $0.066154
  {{ s1-small }} | $0.132308
  {{ s1-medium }}| $0.264615
  {{ s1-large }} | $0.529231
  {{ s1-xlarge }} | $1.058462
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.008974
  {{ b2-micro }} | $0.015128
  {{ b2-medium }} | $0.027949
  {{ m2-micro }} | $0.092564
  {{ m2-small }} | $0.185128
  {{ m2-medium }}| $0.277692
  {{ m2-large }} | $0.370256
  {{ m2-xlarge }} | $0.555385
  {{ m2-2xlarge }} | $0.740513
  {{ m2-3xlarge }} | $1.110769
  {{ m2-4xlarge }} | $1.481026
  {{ m2-5xlarge }} | $1.851282
  {{ m2-6xlarge }} | $2.221538
  {{ s2-micro }} | $0.060769
  {{ s2-small }} | $0.121538
  {{ s2-medium }} | $0.243077
  {{ s2-large }} | $0.364615
  {{ s2-xlarge }} | $0.486154
  {{ s2-2xlarge }} | $0.729231
  {{ s2-3xlarge }} | $0.972308
  {{ s2-4xlarge }} | $1.215385
  {{ s2-5xlarge }} | $1.458462
  {{ s2-6xlarge }} | $1.944615

- Prices in roubles, with VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }}| ₽0.70
  {{ b1-micro }} | ₽1.18
  {{ b1-medium }} | ₽2.18
  {{ s1-nano }} | ₽2.58 |
  {{ s1-micro }} | ₽5.16 |
  {{ s1-small }} | ₽10.32 |
  {{ s1-medium }} | ₽20.64 |
  {{ s1-large }} | ₽41.28 |
  {{ s1-xlarge }} | ₽82.56
  **Intel Cascade Lake** |
  {{ b2-nano }}| ₽0.70
  {{ b2-micro }} | ₽1.18
  {{ b2-medium }} | ₽2.18
  {{ m2-micro }} | ₽7.22
  {{ m2-small }} | ₽14.44
  {{ m2-medium }}| ₽21.66
  {{ m2-large }} | ₽28.88
  {{ m2-xlarge }} | ₽43.32
  {{ m2-2xlarge }} | ₽57.76
  {{ m2-3xlarge }} | ₽86.64
  {{ m2-4xlarge }} | ₽115.52
  {{ m2-5xlarge }} | ₽144.40
  {{ m2-6xlarge }} | ₽173.28
  {{ s2-micro }} | ₽4.74
  {{ s2-small }} | ₽9.48
  {{ s2-medium }} | ₽18.96
  {{ s2-large }} | ₽28.44
  {{ s2-xlarge }} | ₽37.92
  {{ s2-2xlarge }} | ₽56.88
  {{ s2-3xlarge }} | ₽75.84
  {{ s2-4xlarge }}| ₽94.80
  {{ s2-5xlarge }}| ₽113.76
  {{ s2-6xlarge }}| ₽151.68

{% endlist %}
