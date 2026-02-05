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

The size of a written data unit is 40 KB.

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




<MDX>
  <PriceList
    serviceIds={['{{ pcs|yds }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


If the data storage time is one hour, the time of resource usage by multiple streams is summed up. For example, if two streams are running 24/7 during a month, the time of resource usage will be 2 × 24 × 30 = 1,440 hours. The first 744 hours are free of charge. They will be used up by the two streams in 15 days. After that, you will be charged.

With extended storage, data is stored for up to 7 days.

With the provided storage limit, the minimum storage amount is 50 GB per segment.


## On-demand pricing {#on-demand}

With on-demand pricing:
* Data streams stored in [serverless {{ ydb-short-name }} databases](../ydb/concepts/serverless-and-dedicated.md#serverless) are charged for based on the [pricing policy {{ ydb-short-name }}](../ydb/pricing/serverless.md) for the serverless mode.

* Data streams stored in [dedicated {{ ydb-short-name }} database](../ydb/concepts/serverless-and-dedicated.md#dedicated)s are not charged for separately. Instead, you only pay for a dedicated database (see the [pricing policy for dedicated databases](../ydb/pricing/dedicated.md) for details).

