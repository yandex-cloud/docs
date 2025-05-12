---
title: '{{ alb-full-name }} pricing policy'
description: This article covers the {{ alb-name }} pricing policy.
editable: false
---

# {{ alb-full-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ alb-name }} {#rules}

When using the {{ alb-name }} service, you only pay for the actual compute resources consumed by active load balancers.

Resource usage is determined by the number of [resource units](concepts/application-load-balancer.md#lcu-scaling), i.e., internal VMs, provisioned per availability zone for the load balancer.

{% include [lcu-thresholds](../_includes/application-load-balancer/lcu-thresholds.md) %}

You can limit the number of load balancer resource units in its [autoscaling settings](concepts/application-load-balancer.md#lcu-scaling-settings). By default, each availability zone requires at least 2 units, while the total number of units across all zones is unlimited. You cannot set a limit lower than 2 resource units per zone.

Load balancer usage is billed hourly. You are charged based on the highest number of resource units running during each hour. When [creating](operations/application-load-balancer-create.md) an L7 load balancer, you can see its cost calculation in the [management console]({{ link-console-main }}) on the right.

### Cost calculation example {#example}

A load balancer operates within a single availability zone. We use the default autoscaling settings with the minimum of 2 resource units per zone and no limit on the maximum total number of units.

The load balancer has been running for an hour. The inbound traffic reached these peak values at various timestamps:

{% include [lcu-example](../_includes/application-load-balancer/lcu-example.md) %}

This workload requires **eight resource units** to process:

{% include [lcu-example-amounts](../_includes/application-load-balancer/lcu-example-amounts.md) %}

Calculating cost per hour:




{% include [usd-alb-hour](../_pricing_examples/application-load-balancer/usd-hour.md) %}


30-day cost estimate for this hourly workload:




{% include [usd-alb-month](../_pricing_examples/application-load-balancer/usd-month.md) %}
 


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



{% include [usd-lcu.md](../_pricing/application-load-balancer/usd-lcu.md) %}

 

