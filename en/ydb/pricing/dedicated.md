---
title: Pricing policy for Dedicated mode in {{ ydb-full-name }}
description: In this article, you will learn about the pricing policy for Dedicated mode in {{ ydb-full-name }}.
editable: false
---

# Pricing policy for Dedicated mode in {{ ydb-name }}



{% note tip %}




For a cost calculation, use our [calculator](https://yandex.cloud/en/prices?state=02fcbc53c755#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [vat](../../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## What goes into the cost of using {{ ydb-name }} {#rules}

When using {{ ydb-name }} in *Dedicated* mode, you pay for:

* Type and size of [storage groups](../concepts/resources.md#storage-groups) allocated for the DB.
* [Computing resources](../concepts/resources.md#resource-presets) allocated to the DB.
* Disk space allocated for [temporary storage (spilling)](../concepts/resources.md#spilling).

The following resources are paid additionally:

* Space used in {{ objstorage-full-name }} to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Using computing resources {#rules-hosts-uptime}

The cost is calculated for each hour of VM operation as per its class. For detailed class specifications, see [{#T}](../concepts/index.md).

The minimum billing unit is one hour; for example, you will be charged for two hours when using a VM for 90 minutes.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for DB storage groups.
* Space used by on-demand DB backups saved in {{ objstorage-name }}.

    {% note info %}

    For each DB, {{ ydb-name }} automatically creates and stores two full backups for the last two days for free. No fee is charged for storing automatic backups.

    {% endnote %}

* Temporary storage size (for spilling).

    {% note info %}

    The cost of temporary storage (spilling) is specified per {{ ydb-short-name }} node.

    {% endnote %}

The price covers one month of use. The minimum billing unit is 1 GB/hr (e.g., storing 1 GB for 1.5 hours costs the same as for 2 hours).

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

{{ ydb-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for the Russia region {#prices}


{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}


### Host computing resources {#prices-compute-units}



{% include [usd-compute-units.md](../../_pricing/ydb/usd-compute-units.md) %}


### Storage and backups {#prices-storage}



{% include notitle [usd-storage.md](../../_pricing/ydb/usd-storage.md) %}


{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

