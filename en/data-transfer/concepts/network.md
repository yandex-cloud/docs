---
title: Networking in {{ data-transfer-full-name }}
description: In this article, you will learn about network in {{ data-transfer-full-name }}.
---

# Networking in {{ data-transfer-full-name }}


When creating endpoints of certain types, you can select a [cloud subnet](../../vpc/concepts/network.md). The transfer will use the above subnet to access source or target endpoint hosts.

You can specify the subnet manually in the endpoint settings (for **On-Premise** endpoints) or have one selected automatically for [MDB endpoints](#managed-cluster-subnets). This subnet is referred to as the __selected subnet__. The network the selected subnet belongs to is referred to as the __selected network__.

If hosts are referenced by domain names in the endpoint settings, the DNS servers specified in the selected subnet DHCP settings will be used to resolve them into IP addresses. All the subnet's DNS servers must resolve the host domain name into an IP address; otherwise, the transfer may fail to start because the transfer services use an arbitrary subnet DNS server for name resolution. For more information, see [IP addresses and domain names in endpoint settings](#ip-addresses-and-domain-names).

The subnets selected for both endpoints of the same transfer must belong to the same availability zone.

## MDB cluster subnets {#managed-cluster-subnets}

You can only specify a subnet for endpoints with the **On-Premise** connection type. If the endpoint settings contain an MDB cluster ID rather than a host, one of the subnets that the database cluster is connected to will be selected for endpoint access.

{% note info %}

If both endpoints of the transfer are MDB clusters, and the [availability zones](../../overview/concepts/geo-scope.md) of the source and target subnets do not intersect, you will not be able to initiate a transfer. There are two workarounds for this situation:

* Adding a host to one of the clusters and selecting an appropriate availability zone.
* Configuring one of the endpoints as **On-Premise** and connecting it to any subnet with an availability zone matching that of the other endpoint. If there is no suitable network, create a new one in a required zone and specify it in the On-Premise endpoint settings.

{% endnote %}

## Subnet IP address ranges {#subnet-address-ranges}

When performing transfers between the source and target hosts that are in different subnets within {{ yandex-cloud }}, their IP address ranges should not overlap. For example, an error occurs if the hosts use subnets with the following IP ranges:

* `network-1/subnet-a` with the IPv4 CIDR `10.130.0.0/24`.
* `network-2/subnet-b` with the IPv4 CIDR `10.130.0.0/24`.

{% note info %}

To launch a successful transfer in the selected endpoint subnet address range, there must be at least one free IP address:

{% endnote %}

## IP address availability and ownership {#ip-address-availability}

An IP address __belongs to a network__ if it belongs to any CIDR of any subnet on this network. For example, if there is a network named `my-network` with the `my-network-a` (CIDR `192.168.0.0/24`) and `my-network-b` (CIDR `192.168.1.0/24`) subnets, then the `192.168.0.100` and `192.168.1.50` addresses belong to `my-network` while `1.2.3.4` does not.

An IP address is __available via a subnet__ if it belongs to this subnet's network, or if the network this subnet belongs to has routing correctly configured for the IP address. `192.168.0.100` and `192.168.1.50` will be available via the `my-network-a` subnet (as well as via `my-network-b`). `1.2.3.4` will be available through these subnets in the following cases only:
* An egress [NAT gateway](../../vpc/concepts/gateways.md) is enabled in `my-network`; this will cause traffic to be routed to the internet.
* `my-network` has a static route configured to process the address in question (`1.2.3.4`). This will cause traffic to be directed to the next-hop address specified in the route.

## IP addresses and domain names in endpoint settings {#ip-addresses-and-domain-names}

If a host is specified as an IP address in the endpoint settings, the selected endpoint subnet will be used for access to a cluster even if the specified IP [does not belong](#ip-address-availability) to the network selected for the endpoint.

If an **On-Premise** endpoint with a host specified as a domain name or an MDB endpoint is being used, the host name will be resolved into an IP address using a DNS server specified in the DHCP settings for the selected subnet or a default DNS server (second address in the subnet range). For a transfer to be successful, the address that the host domain name resolves into must belong to the network selected for the endpoint while the DNS server address must be [available](#ip-address-availability) via the selected subnet.

## Security groups {#security-groups}

You can assign [security groups](../../vpc/concepts/security-groups.md) to the subnet selected for the endpoint. In the event that network access to source or target hosts is restricted by security groups, you can disable network connectivity between {{ data-transfer-full-name }} and your DBMS without adding permissive rules for wide IP ranges to your security groups, and allow access from specific groups granularly. You can grant access to your DBMS hosts using one of the methods below:

* Create a permissive rule called `self` in the security group that protects source or target hosts, and specify this security group in the endpoint settings.
* Create a new security group for the endpoint and create permissive rules between the endpoint and the DBMS security groups.

{% note info %}

Make sure to allow outgoing traffic to the port required by the security group specified in the endpoint.

{% endnote %}

## Transfering between a source on an external network and a target in {{ yandex-cloud }} {#source-external}

You can provide access to a source on an external network using one of the following methods:

* Configure the source to make it accessible from the internet.
* Use [{{ interconnect-full-name }}](../../interconnect/index.yaml).
* Use a VPN.

If you need to transfer data between your cloud in {{ yandex-cloud }} and another cloud, including a different cloud in {{ yandex-cloud }}, or between your cloud in {{ yandex-cloud }} and a cluster in a user installation on your site, allow internet connections to a database in the third-party cloud or your site from [{{ data-transfer-name }} IP addresses](../../overview/concepts/public-ips.md#virtual-private-cloud).

If you are using [{{ interconnect-name }}](../../interconnect/concepts/index.md) or a VPN for connections, you do not need to configure the third-party cloud. To set up network connectivity, in the endpoint settings, specify a subnet from which you can connect to an external resource.

To run transfers requiring internet access, the [`data-transfer.admin`](../security/index.md) role is required. To create endpoints with a subnet specified in their settings, assign to the user the [`vpc.user`](../../vpc/security/index.md) role for the folder the subnet resides in.


