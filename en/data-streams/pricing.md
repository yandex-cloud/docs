---
title: "{{ yds-full-name }} pricing policy"
description: "This article describes the {{ yds-name }} pricing policy."
editable: false
---

# {{ yds-full-name }} pricing

{{ yds-name }} supports two pricing modes:

* [Based on allocated resources](#rules): You pay a fixed hourly rate for the established throughput limit and message retention period and additionally for the number of units of actually written data.
* [On-demand](#on-demand): You pay for data writes and reads performed, the amount of data read/written, and the size of storage actually used for messages with a valid retention period.

The pricing mode is set for each data stream individually. By default, streams in {{ yds-name }} are created with pricing based on allocated resources.

## Pricing based on allocated resources {#rules}

If pricing for allocated resources is used, the number of units of written data and resources allocated for streaming data are billed.

Pricing for the allocated resources includes the established segment throughput limit as well as storage time and size.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Examples of cost calculation {#price-example}

A single-shard stream receives two 50 KB messages per second. The message retention period is 12 hours.

Calculation of the monthly cost of processing data (provided that there are 31 days in the month):
> &lceil; 50 / 40 &rceil; = 2

Where:
* 50: Size of one message in KB.
* 40: [Size of units](#event) of written data in KB.
* 2: Number of data units written per message.

While calculating the cost, the number of units of written data is rounded up to an integer. In this example, the number is rounded to 2.

> 2 × 2 = 4

Where:
* 2: Number of messages per second.
* 2: Number of data units written per message.
* 4: Number of data units written per second.

> 4 × 60 × 60 × 24 × 31 = 10,713,600

Where:
* 4: Number of data units written per second.
* 60 × 60 × 24 × 31: Number of seconds in the month.
* 10,713,600: Number of data units written per month.




{% include [usd.md](../_pricing/data-streams/usd-example.md) %}


### Pricing {#prices}


#### Cost per unit of written data {#event}

The first 2,000,000 units of written data per month are free of charge.




{% include [usd.md](../_pricing/data-streams/usd-event.md) %}


#### Cost of allocated resources {#resources}

#### Pricing based on storage time {#time-limit}

Cost of using allocated resources per hour:




{% include [usd.md](../_pricing/data-streams/usd-resources.md) %}


#### Pricing based on storage size {#storage-limit}

Data is stored for up to 7 days.




{% include [usd.md](../_pricing/data-streams/usd-resources-storage-limit.md) %}


## Pricing based on actual usage {#on-demand}

If pricing based on the actual usage is used:
* Data streams stored in [{{ ydb-short-name }} serverless databases](https://cloud.yandex.ru/docs/ydb/concepts/serverless-and-dedicated#serverless) are charged for based on the [pricing policy for {{ ydb-short-name }} serverless mode](../ydb/pricing/serverless.md).

* Data streams stored in [{{ ydb-short-name }} dedicated databases](https://cloud.yandex.ru/docs/ydb/concepts/serverless-and-dedicated#dedicated) are not charged for separately (you only pay for a dedicated database, see the [pricing policy for dedicated databases](https://cloud.yandex.ru/docs/ydb/pricing/dedicated)).
