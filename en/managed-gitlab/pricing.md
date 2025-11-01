---
title: '{{ mgl-full-name }} pricing policy'
description: This article covers the {{ mgl-name }} pricing policy.
editable: false
---

# {{ mgl-full-name }} pricing policy



{% note tip %}




To calculate the cost of using {{ mgl-name }}, use [our calculator](https://yandex.cloud/en/prices?state=fa8a272b5f0e#calculator) on the {{ yandex-cloud }} website or see the pricing data below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ mgl-name }} {#rules}

When using {{ mgl-name }}, you pay for:
* Computing resources of your VM instance.
* Data storage used by the instance.

Other consumed resources to be additionally paid for:
* The space used in {{ objstorage-full-name }} to store backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

In all calculations, 1 GB = 2<sup>10</sup> MB = 2<sup>20</sup> KB = 2<sup>30</sup> bytes.

### Using computing resources {#rules-hosts-uptime}

VM operation cost is charged per hour.

The price of computing resources depends on the selected [approval rule](concepts/approval-rules.md) configuration.

The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a VM for 90 minutes (1.5 hours).

### Disk space usage {#rules-storage}

You pay for the following:
* Data storage allocated for your instance.
* Amount of backups stored in {{ objstorage-name }}.

The price covers one month of use. The minimum billing unit is 1 GB per hour (e.g., storing 1 GB for 1.5 hours costs the same as for 2 hours).

### Example of instance cost calculation {#example}

The cost of using an instance with the following properties for 30 days:

* **Instance type**: `s2.micro` (2 vCPU Intel Cascade Lake, 8 GB RAM).
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

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Computing resources of instances {#prices-instance}

The price of computing resources depends on the selected [approval rule](concepts/approval-rules.md) configuration:



{% include [usd-instance-resources.md](../_pricing/managed-gitlab/usd-instance-resources.md) %}


### Storage and backups {#prices-storage}



{% include [usd-storage.md](../_pricing/managed-gitlab/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

## Licenses {#license}

By default, {{ mgl-name }} uses {{ GL }} Community Edition. If you have a paid {{ GL }} [license](https://about.gitlab.com/pricing/) (either `Premium` or `Ultimate`), contact [our support]({{ link-console-support }}) or your account manager to use it in {{ mgl-name }}.
