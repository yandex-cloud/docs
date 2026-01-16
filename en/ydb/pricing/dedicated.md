---
title: Pricing policy for {{ ydb-full-name }} with dedicated instances
description: "In this tutorial, you will learn about\_the pricing policy for {{ ydb-full-name }} with dedicated instances."
editable: false
---

# Pricing policy for {{ ydb-name }} with dedicated instances



{% note tip %}




To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=02fcbc53c755#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [vat](../../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## What goes into the cost of using {{ ydb-name }} {#rules}

When using {{ ydb-name }} in dedicated-instance mode, you pay for the following:
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

{{ ydb-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are planning to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for the Russia region {#prices}


{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|ydb }}']}
    skuIds={['{{ pc|ydb.cluster.v2.cpu }}', '{{ pc|v1.commitment.selfcheckout.m6.ydb.cpu.c100.v2 }}', '{{ pc|v1.commitment.selfcheckout.y1.ydb.cpu.c100.v2 }}', 
    '{{ pc|ydb.cluster.v2.ram }}', '{{ pc|v1.commitment.selfcheckout.m6.ydb.ram.v2 }}', '{{ pc|v1.commitment.selfcheckout.y1.ydb.ram.v2 }}', 
    '{{ pc|ydb.cluster.v1.ssd }}', '{{ pc|ydb.db.backup.v1 }}', '{{ pc|ydb.spilling_type1.v1 }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% note info "Minimum group size" %}

A single [storage group](../concepts/resources.md#storage-groups) can store up to 100 GB of user data. The minimum granularity of space allocation for a DB is one storage group.

{% endnote %}


{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

