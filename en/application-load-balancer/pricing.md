---
editable: false
---

# Pricing for {{ alb-full-name }}

## What goes into the cost of using {{ alb-name }} {#rules}

When using the {{ alb-name }} service, you pay for the actual use of computing resources of every active load balancer.

The amount of resources used is defined as the number of [resource units](concepts/application-load-balancer.md#lcu-scaling) that are internal VM instances created for a load balancer in each of its availability zones.

{% include [lcu-thresholds](../_includes/application-load-balancer/lcu-thresholds.md) %}

You can set a limit on the number of load balancer resource units in its [autoscaling settings](concepts/application-load-balancer.md#lcu-scaling-settings). The default minimum number of units per availability zone is 2, while the total number of units across all zones is not limited.

The load balancer usage is charged on an hourly basis. You pay for the maximum number of resource units that were running for an hour.

### Example of cost calculation {#example}

A load balancer is hosted in one availability zone. The default autoscaling settings are used: at least two resource units per zone and no limit on the maximum total number of units.

The load balancer was running for an hour. The external load on it reached the following maximum figures (different maximum values are possible at different points in time):

> {% include [lcu-example](../_includes/application-load-balancer/lcu-example.md) %}

This is equal to **eight resource units**:

> {% include [lcu-example-amounts](../_includes/application-load-balancer/lcu-example-amounts.md) %}

{% if product == "yandex-cloud" %}

Calculating cost per hour:
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
* {% if region == "ru" %}₽17.76{% endif %}{% if region == "kz" %}₸88.80{% endif %}{% if region == "int" %}$0.142080{% endif %} is the cost of using a load balancer per hour.
* 720 is the number of hours in a month.

{% endif %}

{% if product == "cloud-il" %}

Calculating cost per hour:
> 8 × ₪0.1127 = ₪0.9016
>
> Total: ₪0.9016 is the cost of using a load balancer per hour.

Where:
* 8 is the number of resource units.
* ₪0.1127 is the cost per resource unit.

Calculating the cost per month (30 days) with the same hourly load:
> ₪0.9016 × 720 = ₪649.1520
>
> Total: ₪649.1520 is the cost of using the load balancer per month.

Where:
* ₪0.9016 is the cost of using the load balancer per hour.
* 720 is the number of hours in a month.

{% endif %}

## Pricing {#prices}

{% if product == "yandex-cloud" %}

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

{% if product == "cloud-il" %}

{% include [ils-lcu.md](../_pricing/application-load-balancer/ils-lcu.md) %}

{% endif %}
