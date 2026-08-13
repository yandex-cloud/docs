---
title: '{{ mspqr-full-name }} pricing policy'
description: This article covers the {{ mspqr-name }} pricing policy.
editable: false
keywords:
  - keyword: '{{ SPQR }}'
  - keyword: '{{ mspqr-full-name }}'
  - keyword: '{{ mspqr-name }}'
---

# {{ mspqr-name }} pricing policy



This section describes the {{ mspqr-name }} pricing [policy](#rules) and [current prices](#prices) for its resources.

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mspqr-name }} {#rules}

The {{ mspqr-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Database host usage {#rules-hosts-uptime}

The host operation cost is charged per hour based on the host class. For detailed class specifications, see [Host classes](concepts/instance-types.md).

The minimum billing unit is one minute, e.g., 1.5 minutes of host usage is billed as 2 minutes. You are not billed for downtime periods when the host cannot perform its primary functions.

### Disk space usage {#rules-storage}

You are billed for the following:

* Storage allocated for database clusters.

    * You can order local SSD storage (`local-ssd`) only for clusters with three or more hosts:

        * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
        * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.

    * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

{% include [pricing-backup-general](../_includes/mdb/pricing-backup-general.md) %} 

For more information, see [Backups in {{ mspqr-name }}](concepts/backup.md).

The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes is billed as 2 minutes.

## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mspqr-name }} provides two types of CVoS: for vCPUs and for RAM on the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at your current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Storage size and internet traffic cannot currently be reserved via CVoS.

{% endnote %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}

{% include [ice-lake-local-ssd-note](../_includes/ice-lake-local-ssd-note.md) %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.spqr }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.spqr.v1.cores }}', '{{ pc|mdb.software_accelerated_network.spqr.v2.cores }}', '{{ pc|mdb.software_accelerated_network.spqr.v3.cores }}', '{{ pc|mdb.software_accelerated_network.spqr.v4a.cores }}' ]}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

