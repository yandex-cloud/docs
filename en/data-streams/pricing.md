# Pricing for {{ yds-full-name }}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ yds-full-name }} can be used free of charge.

When the service becomes publicly available on **September 24, 2021**, you'll be charged for using it.

## What goes into the cost of using {{ yds-short-name }} {#rules}

While using {{ yds-short-name }}, the number of units of written data and resources allocated for streaming data are billed.

Pricing for allocated resources is based on the limit of the shard throughput and data retention period.

### Example of cost calculation {#price-example}

A single-shard stream receives two 50 KB messages per second. The message retention period is 12 hours.

Calculation of the monthly cost of processing data (provided that there are 31 days in the month):

> &lceil; 50 / 40 &rceil; = 2

Where:

* 50 is the size of one message in KB.
* 40 is the size of units of written data in KB.
* 2 is the number of data units written per message.

While calculating the cost, the number of units of written data is rounded up to an integer. In this example, the number is rounded to 2.

> 2 × 2 = 4

Where:

* 2 is the number of messages per second.
* 2 is the number of data units written per message.
* 4 is the number of data units written per second.

> 4 × 60 × 60 × 24 × 31 = 10&nbsp;713&nbsp;600

Where:

* 4 is the number of data units written per second.
* 60 × 60 × 24 × 31 is the number of seconds in the month.
* 10&nbsp;713&nbsp;600 is the number of data units written per month.




{% include [usd.md](../_pricing/data-streams/usd-example.md) %}

## Pricing {#prices}

### Cost of a unit of written data {#event}




{% include [usd.md](../_pricing/data-streams/usd-event.md) %}

### Cost of allocated resources {#resources}

Cost of using allocated resources per month:




{% include [usd.md](../_pricing/data-streams/usd-resources.md) %}

