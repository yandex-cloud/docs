---
title: '{{ network-load-balancer-full-name }}. FAQ'
description: How do I get logs of my work in {{ network-load-balancer-full-name }}? For more information, see Data requests.
---

# General questions about {{ network-load-balancer-name }}

{% include [logs](../../_qa/logs.md) %}

#### Can I protect a network load balancer against accidental deletion? {#deletion-protection}

Yes, you can [protect a network load balancer against accidental deletion](../operations/deletion-protection.md).

#### What does _incoming and outgoing traffic processing by a load balancer_ mean? {#traffic-processing}

In the pricing policy, {{ network-load-balancer-name }} _traffic processing_ refers to the amount of data handled by the [load balancer listeners](../concepts/listener.md). 

_Traffic processing_ and _data transfer traffic_ are two separate categories. If the load balancer has a public IP address, you pay for both the traffic processed by the load balancer (see the [NLB pricing](../../vpc/pricing.md#prices-traffic)) and transfer of cloud data to the internet (see [pricing for outgoing traffic](../../vpc/pricing.md#prices-traffic)). 

Incoming traffic is billed differently: incoming internet traffic is free, so only the NLB pricing applies.
