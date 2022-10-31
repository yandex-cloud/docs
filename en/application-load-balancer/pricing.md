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

Calculating the number of resource units:
> Maximum (6000 / 1000, 30000 / 4000, 500 / 200, 20 / 22, 2) = maximum (6, 8, 3, 1, 2) = 8
>
> Total: 8 resource units.

Where:
* 6000 / 1000 = 6 is the number of resource units that contain 6000 RPS.
* 30000 / 4000 = 7.5 ~ 8 is the number of resource units that contain 30000 active connections.
* 500 / 200 = 2.5 ~ 3 is the number of resource units that contain 500 new connections.
* 20 / 22 = 0.9090... ~ 1 is the number of resource units that contain 20 MB of traffic per second.
* 2 is the minimum number of resource units in the zone.

Calculating the cost per hour:
> {% if region == "ru" %}8 × ₽2.22 = ₽17.76{% endif %}
> {% if region == "kz" %}8 × ₸11.10 = ₸88.80{% endif %}
> {% if region == "int" %}8 × $0.017760 = $0.142080{% endif %}
>
> Total: {% if region == "ru" %}₽17.76{% endif %}{% if region == "kz" %}₸88.80{% endif %}{% if region == "int" %}$0.142080{% endif %} is the cost of using a load balancer per hour.

Where:
* 8 is the number of resource units.
* {% if region == "ru" %}₽2.22{% endif %}{% if region == "kz" %}₸11.10{% endif %}{% if region == "int" %}$0.017760{% endif %} is the cost per resource unit.

Calculating the cost per month (30 days) with the same hourly load:
> {% if region == "ru" %}₽17.76 × 720 = ₽12787.20{% endif %}
> {% if region == "kz" %}₸88.80 × 720 = ₸63936.00{% endif %}
> {% if region == "int" %}$0.142080 × 720 = $102.297600{% endif %}
>
> Total: {% if region == "ru" %}₽12787.20{% endif %}{% if region == "kz" %}₸63936.00{% endif %}{% if region == "int" %}$102.297600{% endif %} is the cost of using the load balancer per month.

Where:
* {% if region == "ru" %}₽17.76{% endif %}{% if region == "kz" %}₸88.80{% endif %}{% if region == "int" %}$0.142080{% endif %} is the cost per resource unit.
* 720 is the number of hours in a month.

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
