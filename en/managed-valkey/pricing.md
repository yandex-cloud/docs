---
title: '{{ mrd-full-name }} pricing policy'
description: This article covers the {{ mrd-name }} pricing policy.
editable: false
---

# {{ mrd-name }} pricing policy


{% include [pricing-increase-2026-05](../_includes/pricing-increase-2026-05.md) %}


In this section, you can find the {{ mrd-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=c46046673ba9#calculator) on our website or check out the pricing below.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

## What goes into the cost of using {{ mrd-short-name }} {#rules}

The {{ mrd-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Database host usage {#rules-hosts-uptime}

You are charged for each hour of host uptime, based on its allocated computing resources. Supported resource configurations are listed in the [Host classes](concepts/instance-types.md) section. For vCPU and RAM prices, see [Pricing](#prices).

The minimum billing unit is one minute, e.g., 1.5 minutes of host operation cost the same as two minutes. You will not be charged for the time when the {{ VLK }} host is unavailable for basic operations.

### Disk space usage {#rules-storage}

You are billed for the following:

* Storage allocated for database clusters.

    * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts running Intel Cascade Lake and Intel Ice Lake, in increments of 93 GB.

    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
                * For **Intel Broadwell** and **Intel Cascade Lake**: In 100 GB increments.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

    For more information about platform-specific storage limitations, see [Disk types](./concepts/storage.md).

* Size of database backups in excess of the storage requested for the cluster.

    * Backups are stored free of charge as long as the total size of the database and all its backups is smaller than the selected storage size.
    * The requested storage size is allocated for each host, so the number of hosts in the cluster does not affect the free backup size.

The price covers one month of use, based on 720 hours per month. The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes is billed as 2 minutes.

### Cluster cost calculation example {#example}

Suppose we calculate the 30-day usage cost of a cluster with the following configuration:

* **{{ VLK }} hosts**: Three `hm3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of SSD network storage.

Cost calculation for {{ VLK }} hosts:




{% include [usd-valkey-host](../_pricing_examples/managed-valkey/usd-host.md) %}


Calculation for the storage cost and total cost:




{% include [usd-valkey-storage](../_pricing_examples/managed-valkey/usd-storage.md) %}


## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mrd-name }} provides two types of CVoS: for vCPUs and for RAM on the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at your current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Storage size and internet traffic cannot currently be reserved via CVoS.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}


{% include [storage-limitations-mrd](../_includes/mdb/mvk/storage-limitations-note.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.redis }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.redis.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.redis.highfreq-v3.cores }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
