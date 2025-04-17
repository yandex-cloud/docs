---
title: How to create a private connection to cloud networks
description: Follow this guide to create a private connection between {{ baremetal-full-name }} VRF segments and {{ vpc-full-name }} cloud networks.
---

# Creating a private connection to cloud networks

With [{{ interconnect-full-name }}](../../interconnect/index.yaml), you can create a [private connection](../concepts/network.md#private-connection-to-vpc) between {{ baremetal-name }} [subnets](../concepts/network.md#private-subnet) and {{ vpc-full-name }} [subnets](../../vpc/concepts/network.md#subnet).

{% note info %}

Before creating a private connection, make sure your folder has a [VRF](../../baremetal/concepts/network.md#vrf-segment) segment with one or more routable subnets in {{ baremetal-name }} as well as a routing instance with one or more [announced](../../interconnect/concepts/priv-con.md#prc-announce) prefixes of private {{ vpc-short-name }} subnets. You can [order](../tutorials/bm-vrf-and-vpc-interconnect.md#request-ri) a routing instance by [contacting]({{ link-console-support }}/tickets/create) support.

{% endnote %}

To create a private connection:

{% include [create-private-connection](../../_includes/baremetal/create-private-connection.md) %}