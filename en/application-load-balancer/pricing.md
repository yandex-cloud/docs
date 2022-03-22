---
editable: false
---

# Pricing for {{ alb-full-name }}

## What goes into the cost of using {{ alb-name }} {#rules}

When using the {{ alb-name }} service, you pay for the actual use of computing resources of every active load balancer. The service is charged on an hourly basis.

The load balancer consumption is measured in _resource units_. One resource unit includes:

* 1000 requests per second (RPS).
* 4000 concurrently active connections.
* 200 new connections per second.
* 22 MB (176 Mbit) of traffic per second.

The amount of load balancer's resource units consumed per hour is calculated based on the indicator demonstrating the highest consumption rate compared to the threshold. Calculated values of resource units are rounded up to an integer.

The number of resource units is calculated separately for each availability zone. The minimum number of units per hour per zone is 2. The load balancer usage isn't charged in the availability zones where the inbound traffic is disabled.

When calculating the number of resource units, hourly maximums for indicators are used.

### Example of cost calculation {#example}

A load balancer located in one availability zone, ran for an hour with the following indicators:

* 1500 RPS.
* 6000 parallel active connections.
* 50 new connections per second.
* 2 MB of traffic per second.

Here's the calculation of the cost for this hour and for the month comprised of 720 hours with the same indicators:

> RPS: 1500 / 1000 = 1.5 ~ 2
> Active connections: 6000 / 4000 = 1.5 ~ 2
> New connections: 50 / 200 = 0.25 ~ 1
> Traffic: 2 / 22 = 0.0909... ~ 1
> Minimum number of resource units in the zone: 2
>
> Number of resource units: 2
>
> {% if region == "ru" %}2 × 1.3889 = ₽2.7778
>
> Hourly total: ₽2.7778
> Monthly total: 2.7778 × 720 = ₽2000.0016{% endif %}
> {% if region == "kz" %}2 × 8.3333 = ₸16.6666
>
> Hourly total: ₸16.6666
> Monthly total: 16.6666 × 720 = ₸11999.952{% endif %}
> {% if region == "int" %}2 × 0.017806 = $0.035612
>
> Hourly total: $0.035612
> Monthly total: 0.035612 × 720 = $25.64064{% endif %}

Here {% if region == "ru" %}₽1.3889{% endif %}{% if region == "kz" %}₸8.3333{% endif %}{% if region == "int" %}$0.017806{% endif %} is the cost per resource unit.

## Pricing {#prices}

{% if region != "int" %}

{% include [disclaimer-new-prices](../_pricing/disclaimer-new-prices.md) %}

{% endif %}

{% if region == "ru" %}

{% include [rub-lcu.md](../_pricing/application-load-balancer/rub-lcu.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-lcu.md](../_pricing/application-load-balancer/kzt-lcu.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-lcu.md](../_pricing/application-load-balancer/usd-lcu.md) %}

{% endif %}

