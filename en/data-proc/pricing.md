---
editable: false
---
# Pricing for {{ dataproc-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ dataproc-name }} {#rules}

The total cost of using {{ dataproc-name }} includes:

* The cost of using the computing resources of {{ compute-full-name }} VMs to deploy hosts.
* Markup on using the computing resources of the {{ dataproc-name }} managed service.
* The cost of using the {{ compute-name }} network drives.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of computing resources {#rules-compute}

Cost is charged under the {{ compute-name }} service for each hour of running the host virtual machine based on the [pricing for {{ compute-name }} computing resources](../compute/pricing.md#prices), including markup for using the {{ dataproc-name }} managed service.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster hosts is charged under the {{ compute-name }} service according to the [disk space pricing policy](../compute/pricing.md#prices-storage).

### Example of price calculation {#price-calculation-example}

You create a cluster with a single Data subcluster. Host master: `s2.micro` (2 vCPU, 8GB RAM) with 15GB SSD storage, one host per subcluster: `s2.small` (4 vCPU, 16 GB RAM), with 100 GB HDD storage.

The cost per hour of using the cluster includes the following components:

* (2 + 4) ×  ₽0.2040 + (8 + 16) ×  ₽0.0492 = ₽2.4048 (forthe  {{ compute-name }} computing resources).
*  ₽2.4048 × 0.1 = ₽0.2405 (the markup for using {{ dataproc-name }}).
* (15 × ₽7.4441 + 100 ×  ₽2.0847) / 30 / 24 = ₽0.4447 (for using {{ compute-name }} disks).

Total price per hour: ₽2.4048 + ₽0.2405 + ₽0.4447 = ₽3.09 ₽

## Pricing {#prices}

### Cost of computing resources with markup {{ dataproc-name }} {#prices-compute}

{% list tabs %}

- Prices in USD

  | Computing resources | Rate for 1 hour, without VAT | Including markup for {{dataproc-name }} |
  | ----- | ----- | ----- |
  | **Intel Broadwell** |
  | 20% vCPU | $0.007233 | $0.000182 |
  | 100% vCPU | $0.009906 | $0.000910 |
  | 1 GPU | $2.199346 | $0.199948 |
  | RAM (for 1 GB) | $0.003386 | $0.000256 |
  | **Intel Cascade Lake** |
  | 20% vCPU | $0.004115 | $0.000192 |
  | 50% vCPU | $0.006231 | $0.000480 |
  | 100% vCPU | $0.010545 | $0.000961 |
  | RAM (for 1 GB) | $0.002795 | $0.000256 |

- Prices in roubles

  | Computing resources | Rate for 1 hour, with VAT | Including markup for {{  dataproc-name }} |
  | ----- | ----- | ----- |
  | **Intel Broadwell** |
  | 20% vCPU | ₽0.5642 | ₽0.0142 |
  | 100% vCPU | ₽0.7727 | ₽0.0710 |
  | 1 GPU | ₽171.5490 | ₽15.5960 |
  | RAM (for 1 GB) | ₽0.2641 | ₽0.0200 |
  | **Intel Cascade Lake** |
  | 20% vCPU | ₽0.3210 | ₽0.0150 |
  | 50% vCPU | ₽0.4863 | ₽0.0375 |
  | 100% vCPU | ₽0.8226 | ₽0.0750 |
  | RAM (for 1 GB) | ₽0.2180 | ₽0.0200 |

{% endlist %}

{% note info %}

You can use GPUs on {{ dataproc-name }} hosts by submitting a request to [tech support](https://console.cloud.yandex.com/support).

{% endnote %}

### Egress {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}
