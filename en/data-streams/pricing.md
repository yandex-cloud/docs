---
title: '{{ yds-full-name }} pricing policy'
description: This article covers the {{ yds-name }} pricing policy.
editable: false
---

# {{ yds-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{{ yds-name }} supports two pricing models:

* [For provisioned capacity](#rules): A fixed hourly rate applies for the provisioned throughput limit and record retention period, plus additional charges for units of data written above allocated limit.
* [On-demand](#on-demand): Billing is calcualted per read/write operations performed, the volume of data read or written, and the actual storage used for messages still within their retention period.

The pricing model is set individually for each data stream. By default, new {{ yds-name }} data streams use the provisioned capacity pricing model.

## Provisioned capacity pricing model {#rules}

In provisioned capacity mode, billing is based on allocated resources for data stream processing and the actual data written.

Pricing for provisioned resources is based on the allocated throughput limit per segment and storage configuration, i.e., volume size or retention period.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Cost calculation examples {#price-example}

A single-shard stream receives 2 messages/sec (50 KB each). The record retention period is 12 hours.

Monthly data processing cost (for a 31-day month):



{% include [usd.md](../_pricing_examples/data-streams/usd-data-streams.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Price per write unit {#event}

The first 2,000,000 write units per month are free.



{% include [usd.md](../_pricing/data-streams/usd-event.md) %}


### Provisioned resource pricing {#resources}

### Retention-based pricing {#time-limit}

The price is specified per 1 hour of provisioned resource usage:



#### Storage pricing with a segment throughput limit up to 1 MB/s {#up-to-1}



{% include [usd.md](../_pricing/data-streams/usd-resources.md) %}


### Storage volume-based pricing {#storage-limit}

Data is retained for up to 7 days.



{% include [usd.md](../_pricing/data-streams/usd-resources-storage-limit.md) %}


## On-demand pricing {#on-demand}

With on-demand pricing:
* Data streams storing data in [{{ ydb-short-name }} serverless databases](../ydb/concepts/serverless-and-dedicated.md#serverless) are billed according to [{{ ydb-short-name }} serverless pricing rules](../ydb/pricing/serverless.md).

* Data streams that store data in [{{ ydb-short-name }} dedicated databases](../ydb/concepts/serverless-and-dedicated.md#dedicated) are not billed separately. You only pay for the dedicated database itself (see the [pricing policy for dedicated databases](../ydb/pricing/dedicated.md)).

