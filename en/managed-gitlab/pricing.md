---
title: '{{ mgl-full-name }} pricing policy'
description: This article covers the {{ mgl-name }} pricing policy.
editable: false
---

# {{ mgl-full-name }} pricing policy


{% include [pricing-increase-2026-05](../_includes/pricing-increase-2026-05.md) %}




{% note tip %}




For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=fa8a272b5f0e#calculator) on our website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ mgl-name }} {#rules}

When using {{ mgl-name }}, you pay for:
* Computing resources of your VM instance.
* Data storage (disk) capacity of the instance.

You also pay for the following resources:
* Space used in {{ objstorage-full-name }} to store backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

In all calculations, 1 GB = 2<sup>10</sup> MB = 2<sup>20</sup> KB = 2<sup>30</sup> bytes.

### Using computing resources {#rules-hosts-uptime}

The VM operation cost is charged per hour.

The price of computing resources depends on the selected [approval rule](concepts/approval-rules.md) configuration.

The minimum billing unit is one hour, e.g., 1.5 hours of VM operation are billed as 2 hours.

### Disk space usage {#rules-storage}

You pay for the following:
* Data storage capacity allocated for your instance.
* Amount of backups stored in {{ objstorage-name }}.

The price covers one month of use. The minimum billing unit is 1 GB per hour, e.g., storing 1 GB for 1.5 hours is billed as for 2 hours.

### Example of instance cost calculation {#example}

The cost of using an instance with the following properties for 30 days:

* **Instance type**: `s2.micro` (2 vCPUs, Intel Cascade Lake, 8 GB RAM).
* **Storage**: 30 GB.
* **Backups**: 20 GB each, 7-day retention period.
* **Approval rules**: Disabled.

Calculating the cost of computing resources:



{% include [usd-managed-gitlab-compute](../_pricing_examples/managed-gitlab/usd-managed-gitlab-compute.md) %}


Calculating the cost of storage and backup:



  {% include [usd-managed-gitlab-storage](../_pricing_examples/managed-gitlab/usd-managed-gitlab-storage.md) %}


Total instance cost calculation:



{% include [usd-managed-gitlab-instance](../_pricing_examples/managed-gitlab/usd-managed-gitlab-instance.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The price of computing resources depends on the selected [approval rule](concepts/approval-rules.md) configuration.



<MDX>
  <PriceList
    serviceIds={['{{ pcs|managed-gitlab }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

## Licenses {#license}

By default, {{ mgl-name }} uses {{ GL }} Community Edition. If you have a paid {{ GL }} [license](https://about.gitlab.com/pricing/) (either `Premium` or `Ultimate`), contact [our support]({{ link-console-support }}) or your account manager to use it in {{ mgl-name }}.
