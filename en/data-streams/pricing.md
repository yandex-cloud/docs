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

* [Based on allocated resources](#rules): You pay a fixed hourly rate for the established throughput limit and message retention period and additionally for the number of units of actually written data.
* [On-demand](#on-demand): You pay for data writes and reads performed, the amount of data read/written, and the size of storage actually used for messages with a valid retention period.

The pricing mode is set for each data stream individually. By default, streams in {{ yds-name }} are created with pricing based on allocated resources.

## Pricing based on allocated resources {#rules}

If pricing for allocated resources is used, the number of units of written data and resources allocated for streaming data are billed.

Pricing for the allocated resources includes the established segment throughput limit as well as storage time and size.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Cost calculation examples {#price-example}

A single-shard stream receives two 50 KB messages per second. The message retention period is 12 hours.

Data processing cost per month (for a 31-day month):



{% include [usd.md](../_pricing_examples/data-streams/usd-data-streams.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Price per unit of written data {#event}

The first 2,000,000 units of written data per month are free of charge.



{% include [usd.md](../_pricing/data-streams/usd-event.md) %}


### Price of allocated resources {#resources}

### Pricing based on storage time {#time-limit}

The price is specified for one hour of using allocated resources:



#### Data storage with throughput limit per segment of up to 1 MB/s {#up-to-1}



{% include [usd.md](../_pricing/data-streams/usd-resources.md) %}


### Pricing based on storage size {#storage-limit}

Data is stored for up to 7 days.



{% include [usd.md](../_pricing/data-streams/usd-resources-storage-limit.md) %}


## Pricing based on actual usage {#on-demand}

If pricing based on the actual usage is used:
* Data streams stored in [{{ ydb-short-name }} serverless databases](../ydb/concepts/serverless-and-dedicated.md#serverless) are charged for based on the [pricing policy for {{ ydb-short-name }} serverless mode](../ydb/pricing/serverless.md).

* Data streams stored in [{{ ydb-short-name }} dedicated databases](../ydb/concepts/serverless-and-dedicated.md#dedicated) are not charged for separately (you only pay for a dedicated database, see the [pricing policy for dedicated databases](../ydb/pricing/dedicated.md)).

