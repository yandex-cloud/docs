---
title: How to create a private cloud network connection
description: In this tutorial, you will learn how to create a private connection between {{ baremetal-full-name }} VRF segments and {{ vpc-full-name }} cloud networks.
---

# Creating a private cloud network connection

With [{{ interconnect-full-name }}](../../interconnect/index.yaml), you can create a [private connection](../concepts/network.md#private-connection-to-vpc) between {{ baremetal-name }} [subnets](../concepts/network.md#private-subnet) and {{ vpc-full-name }} [subnets](../../vpc/concepts/network.md#subnet).

{% note info %}

Before creating a private connection, make sure your folder contains a [VRF](../../baremetal/concepts/network.md#vrf-segment) segment with at least one routable {{ baremetal-name }} subnet and a routing instance with at least one [announced](../../interconnect/concepts/priv-con.md#prc-announce) private {{ vpc-short-name }} subnet prefix. To [order](../tutorials/bm-vrf-and-vpc-interconnect.md#request-ri) a routing instance, please [contact]({{ link-console-support }}/tickets/create) support.

{% endnote %}

To create a private connection:

{% include [create-private-connection](../../_includes/baremetal/create-private-connection.md) %}