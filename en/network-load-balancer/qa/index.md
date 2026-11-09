---
title: '{{ network-load-balancer-full-name }}. FAQ'
description: How do I get logs of my work in {{ network-load-balancer-full-name }}? For more information, see Data requests.
---

# General questions about {{ network-load-balancer-name }}

{% include [logs](../../_qa/logs.md) %}

#### Can I write logs of {{ network-load-balancer-name }} resources? {#write-logs}

You can track [management event](../at-ref.md) in {{ at-full-name }}. To do this, [create](../../audit-trails/operations/create-trail.md) a trail and enable management layer logging in it.

You cannot a {{ cloud-logging-full-name }} log group to the load balancer directly.

#### Can I protect a network load balancer against accidental deletion? {#deletion-protection}

Yes, you can [protect a network load balancer against accidental deletion](../operations/deletion-protection.md).

#### What does _incoming and outgoing traffic processing by a load balancer_ mean? {#traffic-processing}

In the pricing policy, {{ network-load-balancer-name }} _traffic processing_ refers to the amount of data handled by the [load balancer listeners](../concepts/listener.md). 

_Traffic processing_ and _data transfer traffic_ are two separate categories. If the load balancer has a public IP address, you pay for both the traffic processed by the load balancer (see the [NLB pricing](../../vpc/pricing.md#prices-traffic)) and transfer of cloud data to the internet (see [pricing for outgoing traffic](../../vpc/pricing.md#prices-traffic)). 

Incoming traffic is billed differently: incoming internet traffic is free, so only the NLB pricing applies.

#### How to protect a network load balancer from DDoS attacks and IP address brute-forcing? {#ddos-protection}

To protect the network load balancer, you can use [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md). Do it by enabling **{{ ui-key.yacloud.common.field_ddos-protection-provider }}** when [creating](../operations/load-balancer-create.md) the load balancer. DDoS protection applies to its public IP address. You [pay](../../vpc/pricing.md#prices-ddos-protection) for every gigabyte of the incoming legitimate traffic.

To additionally restrict access to target load load balancer resources by IP addresses, use [security groups](../../vpc/concepts/security-groups.md).
