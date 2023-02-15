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


Calculating cost per hour:
> 
> 
> 8 × $0.017760 = $0.142080
>
> Total: $0.142080 is the cost of using a load balancer per hour.

Where:
* 8 is the number of resource units.
* $0.017760 is the cost per resource unit.

Calculating the cost per month (30 days) with the same hourly load:
> 
> 
> $0.142080 × 720 = $102.297600
>
> Total: $102.297600 is the cost of using the load balancer per month.

Where:
* $0.142080 is the cost of using a load balancer per hour.
* 720 is the number of hours in a month.



## Pricing {#prices}





{% include [usd-lcu.md](../_pricing/application-load-balancer/usd-lcu.md) %}



