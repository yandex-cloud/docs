---
title: '{{ alb-full-name }} pricing policy'
description: This article provides the {{ alb-name }} pricing policy.
editable: false
---

# {{ alb-full-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ alb-name }} {#rules}

When using the {{ alb-name }} service, you pay for the actual use of computing resources of every active load balancer.

The amount of resources used is defined as the number of [resource units](concepts/application-load-balancer.md#lcu-scaling) that are internal VM instances created for a load balancer in each of its availability zones.

{% include [lcu-thresholds](../_includes/application-load-balancer/lcu-thresholds.md) %}

You can set a limit on the number of load balancer resource units in its [autoscaling settings](concepts/application-load-balancer.md#lcu-scaling-settings). The default minimum number of units per availability zone is 2, while the total number of units across all zones is not limited. You cannot set a minimum value below 2.

The load balancer usage is charged on an hourly basis. You pay for the maximum number of resource units that were running for an hour. When [creating](operations/application-load-balancer-create.md) an L7 load balancer, the cost calculation is displayed in the [management console]({{ link-console-main }}) on the right.

### Cost calculation example {#example}

A load balancer is hosted in one availability zone. The default autoscaling settings are used: at least two resource units per zone and no limit on the maximum total number of units.

The load balancer was running for an hour. The external load on it reached the following maximum figures (different maximum values are possible at different points in time):

{% include [lcu-example](../_includes/application-load-balancer/lcu-example.md) %}

This is equal to **eight resource units**:

{% include [lcu-example-amounts](../_includes/application-load-balancer/lcu-example-amounts.md) %}

Calculating cost per hour:




{% include [usd-alb-hour](../_pricing_examples/application-load-balancer/usd-hour.md) %}


Calculating the cost per month (30 days) with the same hourly load:




{% include [usd-alb-month](../_pricing_examples/application-load-balancer/usd-month.md) %}



## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



{% include [usd-lcu.md](../_pricing/application-load-balancer/usd-lcu.md) %}



