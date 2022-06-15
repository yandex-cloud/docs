---
editable: false
---

# Pricing for {{ alb-full-name }}

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ alb-name }} can be used free of charge.

{% endif %}

{% if product == "yandex-cloud" %}

## What goes into the cost of using {{ alb-name }} {#rules}

When using the {{ alb-name }} service, you pay for the actual use of computing resources of every active load balancer. The service is charged on an hourly basis.

{% include [lcu-calculation](../_includes/application-load-balancer/lcu-calculation.md) %}

### Example of cost calculation {#example}

A load balancer located in one availability zone, ran for an hour with the following indicators:

{% include [lcu-example](../_includes/application-load-balancer/lcu-example.md) %}

Here's the calculation of the cost for this hour and for the month comprised of 720 hours with the same indicators:

> RPS: 6000 / 1000 = 6
> Active connections: 30000 / 4000 = 7.5 ~ 8
> New connections: 500 / 200 = 2.5 ~ 3
> Traffic: 20 / 22 = 0.9090... ~ 1
> Minimum number of resource units in the zone: 2
>
> Number of resource units: 8
>
> {% if region == "ru" %}8 × 2.22 = ₽17.76
>
> Hourly total: ₽17.76
> Monthly total: 17.76 × 720 = ₽12787.20{% endif %}
> {% if region == "kz" %}8 × 11.10 = ₸88.80
>
> Hourly total: ₸88.80
> Monthly total: 88.80 × 720 = ₸63936.00{% endif %}
> {% if region == "int" %}8 × 0.01776 = $0.14208
>
> Hourly total: $0.14208
> Monthly total: 0.14208 × 720 = $102.2976{% endif %}

Where {% if region == "ru" %}₽2.22{% endif %}{% if region == "kz" %}₸11.10{% endif %}{% if region == "int" %}$0.01776{% endif %} is the cost per resource unit.

## Pricing {#prices}

{% if region == "ru" %}

{% include [rub-lcu.md](../_pricing/application-load-balancer/rub-lcu.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-lcu.md](../_pricing/application-load-balancer/kzt-lcu.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-lcu.md](../_pricing/application-load-balancer/usd-lcu.md) %}

{% endif %}

{% endif %}
