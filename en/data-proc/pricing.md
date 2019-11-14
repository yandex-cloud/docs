---
editable: false
---
# Pricing for {{ dataproc-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ dataproc-name }} {#rules}

Price calculations for the usage of  {{ dataproc-name }} takes into account the use of host computing resources, storage and egress traffic:

* vCPU or GPU usage time,

* amount of RAM used per unit of time (GB×hour),

* {{ compute-full-name }} platform that is specified when creating hosts,

* storage type and size for each host (disk space),

* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of computing resources {#rules-compute}

The cost is calculated for each hour of operation of the host in accordance with the requested computing resources. Prices of computing resources are calculated based on [prices for similar resources for {{ compute-name }}](../compute/pricing.md#prices), with a markup for using {{ dataproc-name }} images.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ dataproc-name }} host is not performing its main functions.

### Disk space usage {#rules-storage}

What's charged is the amount of storage allocated for each of the cluster hosts.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Computing resources {#prices-compute}

{% list tabs %}

- Prices in USD

  | Computing resources | Rate for 1 hour, without VAT | Including markup for {{ dataproc-name }} |
  | ----- | ----- | ----- |
  | **Intel Broadwell** |
  | 20% vCPU | $0.007233 | $0.000182 |
  | 100% vCPU | $0.009906 | $0.000910 |
  | 1 GPU | $2.571743 | $0.199948 |
  | RAM (for 1 GB) | $0.003386 | $0.000256 |
  | **Intel Cascade Lake** |
  | 20% vCPU | $0.004115 | $0.000192 |
  | 50% vCPU | $0.006231 | $0.000480 |
  | 100% vCPU | $0.010545 | $0.000961 |
  | 1 GPU | $2.571743 | $0.199948 |
  | RAM (for 1 GB) | $0.002795 | $0.000256 |

- Prices in roubles

  | Computing resources | Rate for 1 hour, with VAT | Including markup for {{ dataproc-name }} |
  | ----- | ----- | ----- |
  | **Intel Broadwell** |
  | 20% vCPU | ₽0.5642 | ₽0.0142 |
  | 100% vCPU | ₽0.7727 | ₽0.0710 |
  | 1 GPU | ₽200.5960 | ₽15.5960 |
  | RAM (for 1 GB) | ₽0.2641 | ₽0.0200 |
  | **Intel Cascade Lake** |
  | 20% vCPU | ₽0.3210 | ₽0.0150 |
  | 50%+ vCPU | ₽0.4863 | ₽0.0375 |
  | 100% vCPU | ₽0.8226 | ₽0.0750 |
  | 1 GPU | ₽200.5960 | ₽15.5960 |
  | RAM (for 1 GB) | ₽0.2180 | ₽0.0200 |
  
{% endlist %}

{% note info %}

The feature of using GPU on {{ dataproc-name }} hosts is available on request to [tech support](https://console.cloud.yandex.com/support).

{% endnote %}

### Storage {#prices-storage}

{% list tabs %}

- Prices in USD
  | Service | Rate for 1 GB per month, without VAT |
  | ----- | -----
  | Standard network storage| $0.029334 |
  | Fast network storage| $0.104302 |

- Prices in roubles
  | Service | Rate for 1 GB per month, with VAT |
  | ----- | -----
  | Standard network storage| ₽2.2881 |
  | Fast network storage| ₽8.1356 |
  
{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

