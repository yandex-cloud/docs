---
title: "{{ mgl-full-name }} pricing policy"
description: "This article describes the {{ mgl-name }} pricing policy."
editable: false
---

# {{ mgl-full-name }} pricing

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## What is included in the {{ mgl-name }} cost {#rules}

When running {{ mgl-name }}, you pay for:
* Computing resources of your VM instance.
* Data storage used by the instance.

Other consumed resources to be additionally paid for:
* The space used in {{ objstorage-full-name }} to store backups.
* Egress traffic from {{ yandex-cloud }}.

In all calculations, 1 GB = 2<sup>10</sup> MB = 2<sup>20</sup> KB = 2<sup>30</sup> bytes.

### Using computing resources {#rules-hosts-uptime}

You are charged per hour of VM use.

The minimum billing unit is one hour (e.g., the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation).

### Disk space usage {#rules-storage}

You are charged for the following:
* Data storage allocated for your instance.
* Size of backups stored in {{ objstorage-name }}.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (e.g., storing 1 GB for 1.5 hours costs the same as for 2 hours).

### Example of instance cost calculation {#example}

The cost of using an instance with the following parameters for 30 days:

* **Instance type**: `s2.micro` (2 vCPU Intel Cascade Lake, 8 GB RAM).
* **Storage**: 30 GB.
* **Backups**: Size per backup is 20 GB, retention time is 7 days.

Calculating the cost of computing resources:

> 720 × (2 × $0.013440 + 8 × $0.003600) = $40.089600

Where:

* 720: Number of hours in 30 days.
* 2: Number of vCPUs.
* $0.013440: Cost of using a vCPU per hour.
* 8: Amount of RAM (in GB).
* 0.003600$: Cost of using 1 GB of RAM per hour.

Calculation for storage and backup cost:

> 30 × $0.104080 + 20 × 7 × $0.015360 = $5.272800

Where:

* 30: Storage size (in GB).
* $0.104080: Cost of using 1 GB of storage per month.
* 20: Size of each backup.
* 7: Backup retention time.
* $0.015360: Cost of storing 1 GB of backups.

Total instance cost calculation:

> $40.089600 + $5.272800 = $45.362400

Where $45.362400 is the cost of using the instance for 30 days.

## Pricing {#prices}

### Computing resources of instances {#prices-instance}




{% include [usd-instance-resources.md](../_pricing/managed-gitlab/usd-instance-resources.md) %}


### Storage and backups {#prices-storage}




{% include [usd-storage.md](../_pricing/managed-gitlab/usd-storage.md) %}


### Egress traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


## Licenses {#license}

By default, {{ mgl-name }} uses Community Edition {{ GL }}. If you have a paid {{ GL }} [license](https://about.gitlab.com/pricing/)(`Premium` or `Ultimate`), contact [support]({{ link-console-support }}) or your account manager to use it in {{ mgl-name }}.