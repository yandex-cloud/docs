---
title: '{{ mmg-full-name }} pricing policy'
description: This article covers the {{ mmg-name }} pricing policy.
editable: false
---

# {{ mmg-name }} pricing policy


{% include [pricing-increase-2026-05](../_includes/pricing-increase-2026-05.md) %}




This section describes the {{ mmg-name }} pricing [policy](#rules) and [current prices](#prices) for its resources.

{% note tip %}




For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=a147d66e1d1e#calculator) on our website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmg-short-name }} {#rules}

The {{ mmg-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Database host usage {#rules-hosts-uptime}

You are charged for each hour of host uptime, based on its allocated computing resources. Supported resource configurations are listed in the [Host classes](concepts/instance-types.md) section. For vCPU and RAM prices, see [Pricing](#prices).

The minimum billing unit is one minute, e.g., 1.5 minutes of host usage is billed as 2 minutes. You will not be charged for the time when the {{ SD }} host is unavailable for basic operations.

### Disk usage {#rules-storage}

You are billed for the following:

* Storage allocated for database clusters.

    * You can order non-replicated SSD storage (`network-ssd-nonreplicated`) only for clusters with three or more hosts, and it must be allocated in 93 GB increments.

    * You can order local SSD storage (`local-ssd`) only for clusters with three or more hosts:
        * For **Intel Broadwell** and **Intel Cascade Lake**: In 100 GB increments.
        * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments.

    For details on platform-specific storage limitations, see [{#T}](./concepts/storage.md).

* Database backup storage exceeding the cluster’s allocated space.

    * You are not charged for storing backups as long as the combined size of the database and all its backups remains below the selected storage quota.

    * During automatic backups, {{ mmg-short-name }} does not create a full copy; instead, it saves the changes made to the database since the previous backup. As a result, the storage used by automatic backups grows only in proportion to the amount of changes.

    * The number of hosts in a cluster does not affect the storage size and, consequently, the free backup quota.

The price covers one month of use, based on 720 hours per month.  The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes is billed as 2 minutes.

### Cluster cost calculation example {#example}

Suppose we calculate the 30-day usage cost of a cluster with the following configuration:

* **{{ SD }} hosts**: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ SD }} hosts:



{% include [usd-mongodb-host](../_pricing_examples/storedoc/usd-host.md) %}


Storage and total cost calculation:



{% include [usd-mongodb-storage](../_pricing_examples/storedoc/usd-storage.md) %}



## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

Prices for computing resources are the same for all host types: `mongod`, `mongos`, and `mongocfg`.

Access to ultra-high-speed network storage with three replicas (SSD) is available upon request. Contact [support]({{ link-console-support }}) or your account manager.



<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.mongo }}']}
    excludeSkuIds={['{{ pc|mdb.cluster.mongodb.v1.cpu.c20 }}', '{{ pc|mdb.cluster.mongodb.v2.cpu.c20 }}', '{{ pc|mdb.cluster.mongodb.v2.cpu.c5 }}', '{{ pc|mdb.cluster.mongodb.v1.cpu.c5 }}', '{{ pc|mdb.software_accelerated_network.mongodb.v2.cores}}', '{{ pc|mdb.software_accelerated_network.mongodb.v1.cores }}', '{{ pc|mdb.software_accelerated_network.mongodb.v4a.cores }}', '{{ pc|mdb.software_accelerated_network.mongodb.v3.cores }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}


