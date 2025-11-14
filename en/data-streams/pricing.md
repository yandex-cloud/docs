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

* [Based on allocated resources](#rules): You pay a fixed hourly rate for the established throughput limit and message retention period, and additionally for the number of units of actually written data.
* [On-demand](#on-demand): You pay for the performed read/write operations, the amount of read or written data, and the actual storage used for messages that are still within their retention period.

The pricing model is set individually for each data stream. By default, new {{ yds-name }} data streams use the provisioned capacity pricing model.

## Provisioned capacity pricing model {#rules}

In provisioned capacity mode, billing is based on allocated resources for data stream processing and the actually written data.

Pricing for provisioned resources is based on the allocated throughput limit per segment and storage configuration, i.e., size or retention period.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Cost calculation examples {#price-example}

Let’s assume a single-shard stream receives two messages per second (50 KB each). The record retention period is 12 hours.

The cost of data processing per month (for a 31-day month) will be:




{% include [usd.md](../_pricing_examples/data-streams/usd-data-streams.md) %}





{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Price per write unit {#event}

The first 2,000,000 units of written data per month are free of charge.




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
* Data streams stored in [{{ ydb-short-name }} serverless databases](../ydb/concepts/serverless-and-dedicated.md#serverless) are charged for based on the [pricing policy {{ ydb-short-name }}](../ydb/pricing/serverless.md) for the serverless mode.

* Data streams stored in [{{ ydb-short-name }} dedicated databases](../ydb/concepts/serverless-and-dedicated.md#dedicated) are not charged for separately. Instead, you only pay for a dedicated database (see the [pricing policy for dedicated databases](../ydb/pricing/dedicated.md) for details).
