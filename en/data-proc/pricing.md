---
title: '{{ dataproc-full-name }} pricing policy'
description: This article covers the {{ dataproc-name }} pricing policy.
editable: false
---

# {{ dataproc-name }} pricing policy


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ dataproc-name }} {#rules}

The total cost of using {{ dataproc-name }} includes:

* The cost of using the computing resources of {{ compute-full-name }} VMs to deploy hosts.
* Markup on computing resources for using the {{ dataproc-name }} managed service.
* Using the {{ compute-name }} network drives.
* Using {{ cloud-logging-full-name }} to collect and store logs.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using computing resources {#rules-compute}

The cost is charged per hour of host virtual machine time as part of {{ compute-name }} based on the [{{ compute-full-name }}](../compute/pricing.md#prices) computing resource pricing policy with a surcharge for using managed {{ dataproc-name }}.

For information about external IP pricing, see [{#T}](../vpc/pricing.md) in the {{ vpc-full-name }} documentation.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster host is charged under {{ compute-name }} based on [disk space pricing](../compute/pricing.md#prices-storage).

### Using {{ cloud-logging-full-name }} {#rules-logs}

You pay for receiving and storing your logs based on the {{ cloud-logging-full-name }} [pricing policy](../logging/pricing.md).

### Example of calculating the cost of standard hosts {#price-example}

Per-hour cost of using a cluster of two subclusters with the following parameters:

* First subcluster:
  * **Master host**: `m2.micro` class, Intel Cascade Lake, 2 × 100% vCPU, 16 GB RAM.
  * **Master host storage**: 20 GB `network-ssd`.

* Second subcluster:
  * **Data storage host**: `s2.micro` class, Intel Cascade Lake, 2 × 100% vCPU, 8 GB RAM.
  * **Host storage**: 100 GB `network-hdd`.

The cost is calculated as follows:



{% list tabs %}

- Standard hosts

  Per-hour cost of using a cluster of two subclusters with the following parameters:

  * First subcluster:
    * **Master host**: `m2.micro` class, Intel Cascade Lake, 2 × 100% vCPU, 16 GB RAM.
    * **Master host storage**: 20 GB `network-ssd`.

  * Second subcluster:
    * **Data storage host**: `s2.micro` class, Intel Cascade Lake, 2 × 100% vCPU, 8 GB RAM.
    * **Host storage**: 100 GB `network-hdd`.

  The cost is calculated as follows:

  {% include [usd-data-proc](../_pricing_examples/data-processing/usd.md) %}

{% endlist %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}

#### Standard hosts {#standard-hosts}



{% include [usd-standard-hosts](../_pricing/data-processing/usd-standard-hosts.md) %}


#### Dedicated hosts {#dedicated-hosts}



{% include [usd-dedicated-hosts](../_pricing/data-processing/usd-dedicated-hosts.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
