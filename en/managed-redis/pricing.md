---
title: '{{ mrd-full-name }} pricing policy'
description: This article covers the {{ mrd-name }} pricing policy.
editable: false
---

# {{ mrd-name }} pricing policy

In this section, you can find the {{ mrd-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=c46046673ba9#calculator) on the {{ yandex-cloud }} website or check out the pricing below.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

## What goes into the cost of using {{ mrd-short-name }} {#rules}

The {{ mrd-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The host operation cost is charged per hour based on what computing resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

The minimum billing unit is one minute (for example, 90 seconds of host operation count as two minutes). You do not pay for the time when the {{ VLK }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You are charged for the following:

* Storage allocated for DB clusters.

    * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts running Intel Cascade Lake and Intel Ice Lake, in increments of 93 GB.

    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
                * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

    For more information about platform-specific storage limitations, see [Disk types](./concepts/storage.md).

* Size of DB backups in excess of the storage requested for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.
    * The requested storage size is allocated for each host, so the number of hosts in the cluster does not affect the free backup size.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds counts as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **{{ VLK }}** hosts: Three `hm3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of SSD network storage.

Cost calculation for {{ VLK }} hosts:




{% include [usd-redis-host](../_pricing_examples/managed-redis/usd-host.md) %}


Calculation for the storage cost and total cost:




{% include [usd-redis-storage](../_pricing_examples/managed-redis/usd-storage.md) %}


## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mrd-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are going to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}




{% include [usd-host.md](../_pricing/managed-redis/usd-host.md) %}


### Storage and backups {#prices-storage}




{% include [usd-storage.md](../_pricing/managed-redis/usd-storage.md) %}


{% include [storage-limitations-mrd](../_includes/mdb/mrd/storage-limitations-note.md) %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
