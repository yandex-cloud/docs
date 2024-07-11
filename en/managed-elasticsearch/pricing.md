---
title: "Pricing policy for Managed Service for Elasticsearch"
description: "In this section, you can find {{ mes-name }} pricing rules and effective prices for the resources it provides."
editable: false
---

# Pricing policy for Managed Service for Elasticsearch



{% include [Elasticsearch-end-of-service](../_includes/mdb/mes/note-end-of-service.md) %}

In this section, you can find {{ mes-name }} pricing [rules](#rules) and [effective prices](#prices) for the service resources.

To calculate the service cost, use the [calculator]({{ link-calc }}) on the {{ yandex-cloud }} website.

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and your storage size.
* For a `Stopped` cluster, you only pay for your storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mes-short-name }} {#rules}

The {{ mes-name }} usage cost is based on:

* {{ ES }} edition used.

* Computing resources allocated to cluster hosts (including hosts with the `Master node role`).

* Disk type and disk space.

* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources and {{ ES }} edition used. You can find supported resource configurations in the [Host classes](concepts/instance-types.md) section, and vCPU and RAM prices, in the [Prices](#prices) section.

You can select host class both for hosts with the `Data node` role and hosts with the `Master node` role.

The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You do not pay for the time when the {{ ES }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for clusters.

* Storage taken up by backups over specified cluster storage.

   * Backups are stored free of charge as long as the combined size of the data in the cluster and all backups is smaller than the selected storage size.

   * When performing automatic backups, {{ mes-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

   * The number of hosts in a cluster does not affect the storage volume and, therefore, the free volume of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **Hosts** with the `Data node` role: 3 `s2.micro` hosts: 2 × 100% vCPU, 8 GB RAM.
* **Hosts** with the `Master node` role: 3 `s2.micro` hosts: 2 × 100% vCPU, 8 GB RAM.
* **Storage**: 100 GB of HDD network storage.

The cost is calculated as follows:



> 3 × (2 × $0.013440 + 8 × $0.016800) + 3 × (2 × $0.013440 + 8 × $0.016800) = $0.967680
>
> Total: $0.967680, cost of operation of all hosts per hour.

Where:
* 3: Number of hosts.
* 2: Number of vCPUs.
* $0.013440: Cost of using 100% vCPU per hour.
* 8: Amount of RAM per host (in GB).
* $0.016800: Cost of using 1 GB of RAM at 100% vCPU per hour.

> 720 × $0.967680 + 100 × $0.025600 = $699.289600
>
> Total: $699.289600, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* $0.967680: Cost of operation of all hosts per hour.
* 100: Amount of network HDD storage (in GB).
* $0.025600: Cost of using 1 GB of network HDD storage per month.



## Prices for the Russia region {#prices}



All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

{% note info %}

As of June 13, 2022, the `Gold` [edition](./concepts/es-editions.md) in {{ mes-name }} clusters is no longer supported. You cannot create a new cluster with this edition or switch to it from `Basic` or `Platinum`. On July 6, 2022, all `Gold` edition clusters were automatically upgraded to `Platinum` at the same price through the end of 2022.

{% endnote %}

### Host computing resources {#prices-hosts}

The cost for computing resources depends on the selected {{ ES }} edition:



{% list tabs %}

- Basic

  {% include [usd-hosts-basic](../_pricing/managed-elasticsearch/usd-hosts-basic.md) %}

  **Costs per hour**

  {% include [usd-hosts-basic-cvos-hour](../_pricing/managed-elasticsearch/usd-hosts-basic-cvos-hour.md) %}

  **Costs per month**

  {% include [usd-hosts-basic-cvos-month](../_pricing/managed-elasticsearch/usd-hosts-basic-cvos-month.md) %}

- Gold

  {% include [usd-hosts-gold](../_pricing/managed-elasticsearch/usd-hosts-gold.md) %}

  **Costs per hour**

  {% include [usd-hosts-gold-cvos-hour](../_pricing/managed-elasticsearch/usd-hosts-gold-cvos-hour.md) %}

  **Costs per month**

  {% include [usd-hosts-gold-cvos-month](../_pricing/managed-elasticsearch/usd-hosts-gold-cvos-month.md) %}

- Platinum

  {% include [usd-hosts-platinum](../_pricing/managed-elasticsearch/usd-hosts-platinum.md) %}

  **Costs per hour**

  {% include [usd-hosts-platinum-cvos-hour](../_pricing/managed-elasticsearch/usd-hosts-platinum-cvos-hour.md) %}

  **Costs per month**

  {% include [usd-hosts-platinum-cvos-month](../_pricing/managed-elasticsearch/usd-hosts-platinum-cvos-month.md) %}

{% endlist %}


### Storage {#prices-storage}

{% include [local-ssd for Ice Lake only on request](../_includes/ice-lake-local-ssd-note.md) %}



{% include [usd-storage.md](../_pricing/managed-elasticsearch/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

