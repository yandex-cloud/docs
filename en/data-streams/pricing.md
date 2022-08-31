# Pricing for {{ yds-full-name }}

## What goes into the cost of using {{ yds-name }} {#rules}

While using {{ yds-name }}, the number of units of written data and resources allocated for streaming data are billed.

Pricing for allocated resources is based on the limit of the shard throughput and data retention period.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of cost calculation {#price-example}

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

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-streams/rub-example.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-streams/kzt-example.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-streams/usd-example.md) %}

{% endif %}

## Pricing {#prices}

### Cost of a unit of written data {#event}

The first 2000000 units of written data per month are free of charge.

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-streams/rub-event.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-streams/kzt-event.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-streams/usd-event.md) %}

{% endif %}

### Cost of allocated resources {#resources}

Cost of using allocated resources per hour:

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-streams/rub-resources.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-streams/kzt-resources.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-streams/usd-resources.md) %}

{% endif %}