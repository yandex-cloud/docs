---
title: '{{ interconnect-full-name }} pricing policy'
description: This article covers the {{ interconnect-name }} pricing policy.
editable: false
---

# {{ interconnect-name }} pricing policy




The service is provided if technically feasible.

## What goes into the cost? {#rules}

When setting up a `private` or `public` **connection**, the cost calculation covers:
* [Cost of physical ports](#other-services) for a [trunk](concepts/trunk.md).
* [Cost of data ](#data) transmitted through the [trunk](concepts/trunk.md).
* [Cost of private and public connections within the trunk](#other-services).

**Cost calculation for a trunk with a single 10GBASE-LR physical port, 300 TB of traffic, and two private connections to two VPC networks**:


## Start of billing {#billing} 

Automatic billing for the service starts with the earliest of the two events:
* The [BGP session](./concepts/priv-con.md#bgp-peering) of any [private connection](./concepts/priv-con.md) in the trunk goes `Active`.
* More than 90 days elapses since the [trunk](./concepts/trunk.md) was created (port was reserved) on the {{ yandex-cloud }} equipment. The state of the trunk physical port (ports) is irrelevant.



### Data size {#data}



{% include [usd-data](../_pricing/interconnect/usd-data.md) %}


### Other services {#other-services}



{% include [usd-other-services](../_pricing/interconnect/usd-other-services.md) %}


