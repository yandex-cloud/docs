---
editable: false
---
# Pricing for {{ mrd-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

## What goes into the cost of using {{ mrd-short-name }} {#rules}

The cost of {{ mrd-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ RD }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Disk space allocated for database clusters.

* Space used by DB backups in excess of the disk space requested for the cluster.
    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.
    * The requested disk size is allocated for each host, so the number of hosts in the cluster does not affect the storage size and, consequently, the free backup size.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | 5% vCPU (**burstable**, 2 GB RAM) | $0.000128 |
    | 20% vCPU (**burstable**, 4 GB RAM) | $0.002949 |
    | 100% vCPU (**high-memory**) | $0.016026 |
    | RAM (for 1 GB) | $0.004359 |
    
- Prices in roubles, with VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | 5% vCPU (**burstable**, 2 GB RAM) | ₽0.01 |
    | 20% vCPU (**burstable**, 4 GB RAM) | ₽0.23 |
    | 100% vCPU (**high-memory**) | ₽1.25 |
    | RAM (for 1 GB) | ₽0.34 |

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

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-redis#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT

  | RAM, GB | Rate for 1 hour|
  | ----- | ----- |
  | **burstable** |
  | 2 | $0.008974 |
  | 4 | $0.023333 |
  | **high-memory** |
  | 8 | $0.066923 |
  | 12 | $0.084359 |
  | 16 | $0.101795 |
  | 24 | $0.168718 |
  | 32 | $0.203590 |
  | 48 | $0.273333 |
  | 64 | $0.343077 |
  | 80 | $0.412821 |
  | 96 | $0.546667 |
  | 128 | $0.686154 |
  | 160 | $0.825641 |
  | 192 | $0.965128 |
  | 224 | $1.104615 |
  | 256 | $1.244103 |

- Prices in roubles, with VAT

  | RAM, GB | Rate for 1 hour |
  | ----- | ----- |
  | **burstable** |
  | 2 | ₽0.70 |
  | 4 | ₽1.82 |
  | **high-memory** |
  | 8 | ₽5.22 |
  | 12 | ₽6.58 |
  | 16 | ₽7.94 |
  | 24 | ₽13.16 |
  | 32 | ₽15.88 |
  | 48 | ₽21.32 |
  | 64 | ₽26.76 |
  | 80 | ₽32.20 |
  | 96 | ₽42.64 |
  | 128 | ₽53.52 |
  | 160 | ₽64.40 |
  | 192 | ₽75.28 |
  | 224 | ₽86.16 |
  | 256 | ₽97.04 |

{% endlist %}
