# Pricing for {{ yds-full-name }}

{{ yds-name }} supports two pricing modes:

* [Based on allocated resources](#rules): You pay a fixed hourly rate for the established throughput limit and message retention period and additionally for the number of units of actually written data.
* [On-demand](#on-demand): You pay for data writes and reads performed, the amount of data read/written, and the size of storage actually used for messages with a valid retention period.

Pricing mode is set for each data stream individually. By default, streams in {{ yds-name }} are created with pricing based on allocated resources.

## Pricing based on allocated resources {#rules} 

While using {{ yds-name }}, the number of units of written data and resources allocated for streaming data are billed.

Pricing for the allocated resources includes the established segment throughput limit as well as storage time and size.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Examples of cost calculation {#price-example}

A single-shard stream receives two 50 KB messages per second. The message retention period is 12 hours.

Calculation of the monthly cost of processing data (provided that there are 31 days in the month):
> &lceil; 50 / 40 &rceil; = 2

Where:
* 50 is the size of one message in KB.
* 40 is the [size of units](#event) of written data in KB.
* 2 is the number of data units written per message.

While calculating the cost, the number of units of written data is rounded up to an integer. In this example, the number is rounded to 2.

> 2 × 2 = 4

Where:
* 2 is the number of messages per second.
* 2 is the number of data units written per message.
* 4 is the number of data units written per second.

> 4 × 60 × 60 × 24 × 31 = 10713600

Where:
* 4 is the number of data units written per second.
* 60 × 60 × 24 × 31 is the number of seconds in the month.
* 10713600 is the units of data written per month.




{% include [usd.md](../_pricing/data-streams/usd-example.md) %}


### Pricing {#prices}

#### Cost of a unit of written data {#event}

The first 2000000 units of written data per month are free of charge.




{% include [usd.md](../_pricing/data-streams/usd-event.md) %}


#### Cost of allocated resources {#resources}

#### Pricing based on storage time {#time-limit}

Cost of using allocated resources per hour:




{% include [usd.md](../_pricing/data-streams/usd-resources.md) %}


#### Pricing based on storage size {#storage-limit}

Data is stored for up to 7 days.




{% include [usd.md](../_pricing/data-streams/usd-resources-storage-limit.md) %}


## On-demand pricing {#on-demand}

With on-demand pricing, data streams are billed at the level of {{ ydb-short-name }} Serverless database topics where their data is stored. Go to the [Pricing policy for {{ ydb-short-name }} Serverless mode](../ydb/pricing/serverless.md) page to learn more about pricing and cost calculation.
