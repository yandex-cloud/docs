---
editable: false
---
# Pricing for {{ mmy-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmy-short-name }} {#rules}

The cost of {{ mmy-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ MY }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 3 hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.000385 |
    | 20% vCPU | $0.003462 |
    | 50% vCPU | $0.005769 |
    | 100% vCPU | $0.015128 |
    | RAM (for 1 GB) | $0.004103 |
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000385 |
    | 20% vCPU | $0.003462 |
    | 50% vCPU | $0.005769 |
    | 100% vCPU | $0.015000 |
    | RAM (for 1 GB) | $0.004103 |


- Prices in roubles, with VAT
  
    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.03 |
    | 20% vCPU | ₽0.27 |
    | 50% vCPU | ₽0.45 |
    | 100% vCPU | ₽1.18 |
    | RAM (for 1 GB) | ₽0.32 |
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.03 |
    | 20% vCPU | ₽0.27 |
    | 50% vCPU | ₽0.45 |
    | 100% vCPU | ₽1.17 |
    | RAM (for 1 GB) | ₽0.32 |
    
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

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-mysql#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

### {{ CH }} hosts {#calculated-clickhouse}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.008974
  {{ b1-micro }} | $0.015128
  {{ b1-medium }}  | $0.027949
  {{ s1-nano }} | $0.031538
  {{ s1-micro }} | $0.063077
  {{ s1-small }} | $0.126154
  {{ s1-medium }}| $0.252308
  {{ s1-large }} | $0.504615
  {{ s1-xlarge }} | $1.009231
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.008974
  {{ b2-micro }} | $0.015128
  {{ b2-medium }} | $0.027949
  {{ m2-micro }} | $0.095641
  {{ m2-small }} | $0.191282
  {{ m2-medium }}| $0.286923
  {{ m2-large }} | $0.382564
  {{ m2-xlarge }} | $0.573846
  {{ m2-2xlarge }} | $0.765128
  {{ m2-3xlarge }} | $1.147692
  {{ m2-4xlarge }} | $1.530256
  {{ m2-5xlarge }} | $1.912821
  {{ m2-6xlarge }} | $2.295385
  {{ s2-micro }} | $0.062821
  {{ s2-small }} | $0.125641
  {{ s2-medium }} | $0.251282
  {{ s2-large }} | $0.376923
  {{ s2-xlarge }} | $0.502564
  {{ s2-2xlarge }} | $0.753846
  {{ s2-3xlarge }} | $1.005128
  {{ s2-4xlarge }} | $1.256410
  {{ s2-5xlarge }} | $1.507692
  {{ s2-6xlarge }} | $2.010256

- Prices in roubles, with VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }}| ₽0.70
  {{ b1-micro }} | ₽1.18
  {{ b1-medium }} | ₽2.18
  {{ s1-nano }} | ₽2.46
  {{ s1-micro }} | ₽4.92
  {{ s1-small }} | ₽9.84
  {{ s1-medium }} | ₽19.68
  {{ s1-large }} | ₽39.36
  {{ s1-xlarge }} | ₽78.72
  **Intel Cascade Lake** |
  {{ b2-nano }}| ₽0.70
  {{ b2-micro }} | ₽1.18
  {{ b2-medium }} | ₽2.18
  {{ m2-micro }} | ₽7.46
  {{ m2-small }} | ₽14.92
  {{ m2-medium }}| ₽22.38
  {{ m2-large }} | ₽29.84
  {{ m2-xlarge }} | ₽44.76
  {{ m2-2xlarge }} | ₽59.68
  {{ m2-3xlarge }} | ₽89.52
  {{ m2-4xlarge }} | ₽119.36
  {{ m2-5xlarge }} | ₽149.20
  {{ m2-6xlarge }} | ₽179.04
  {{ s2-micro }} | ₽4.90
  {{ s2-small }} | ₽9.80
  {{ s2-medium }} | ₽19.60
  {{ s2-large }} | ₽29.40
  {{ s2-xlarge }} | ₽39.20
  {{ s2-2xlarge }} | ₽58.80
  {{ s2-3xlarge }} | ₽78.40
  {{ s2-4xlarge }}| ₽98.00
  {{ s2-5xlarge }}| ₽117.60
  {{ s2-6xlarge }}| ₽156.80

{% endlist %}
