---
editable: false
---
# Pricing for {{ alb-full-name }}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ alb-name }} can be used free of charge.

Until and including **September 23rd of 2021**, {{ alb-name }} can be used free of charge. Since September 24th of 2021, the service will become payable.

## What goes into the cost of using {{ alb-name }}

When using the {{ alb-name }} service, you pay for the actual use of computing resources of each active load balancer. The bill for using the service is hourly.

The use of a load balancer is measured in _capacity units_. A capacity unit includes:

* 1000 requests per second (RPS).
* 4000 active connections.
* 200 new connections per second.
* 22 MB (176 MBit) of processed traffic per second.

The hourly amount of a load balancer capacity units is calculated by taking one of four metrics which was consumed the most in relation to its threshold and applying the ceiling function to the value.

For each availability zone the amount of capacity units is calculated separately. The minimum amount of units for an availability zone is 2. You are not charged for the use of a load balancer in a disabled availability zone.

The amount of capacity units is calculated based on maximum values of the metrics in an hour.

### Example of cost calculation {#example}

A load balancer with a single availability zone enabled had worked for an hour. The metrics measured for that hour are as follows:

* 1500 RPS.
* 6000 active connections.
* 50 new connections per second.
* 2 MB of processed traffic per second.

The hourly bill and the monthly bill, given that the month is 720 hours of the same consumption, are calculated as follows:

> RPS: 1500 / 1000 = 1.5 ~ 2
> Active connections: 6000 / 4000 = 1.5 ~ 2
> New connections: 50 / 200 = 0.25 ~ 1
> Traffic: 2 / 22 = 0.0909... ~ 1
> The minimum amount of capacity units for a zone: 2
>
> The amount of capacity units: 2
>
> 
> 
> 2 × 0.017806 = $0.035612
>
> Total (hourly): $0.035612
> Total (monthly): 0.035612 × 720 = $25.64064

Here, $0.017806 is the price of a capacity unit. 

## Pricing {#prices}




{% include [usd-lcu.md](../_pricing/application-load-balancer/usd-lcu.md) %}  

