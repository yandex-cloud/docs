# Network in {{ data-transfer-full-name }}


When creating endpoints of certain types, you can select a [cloud subnet](../../vpc/concepts/network.md).  The transfer will use the above subnet to access the source or target endpoint hosts.

You can specify the subnet manually in the endpoint settings (for **On-Premise** endpoints) or have one selected automatically for [MDB endpoints](#managed-cluster-subnets). This subnet is referred to as the __selected subnet__. The network that the selected subnet belongs to is referred to as the __selected network__.

If hosts are referenced by domain names in the endpoint settings, DNS servers specified in the selected subnet's DHCP settings to will be used to resolve them into IP addresses. For more information, please see [IP addresses and domain names in endpoint settings](#ip-addresses-and-domain-names).

{% note info %}

Subnets selected for both the endpoints of a single transfer must belong to the same availability zone.

{% endnote %}

## MDB cluster subnets {#managed-cluster-subnets}

You can only specify a subnet for endpoints with the **On-Premise** connection type.  If the endpoint settings contain an MDB cluster ID rather than a host, one of the subnets that the database cluster is connected to will be selected for endpoint access.

{% note info %}

In the event that both the transfer endpoints are MDB clusters and the source and target subnets' availability zones do not intersect, you will not be able to initiate a transfer. There are two workarounds for this situation:

* Adding a host to one of the clusters selecting an appropriate availability zone.
* Configuring one of the endpoints as **On-Premise** and connecting it to any subnet with an availability zone matching that of the other endpoint. If there is no suitable network, create a new one in a required zone and specify it in the On-Premise endpoint setting.

{% endnote %}

## Subnet IP address ranges {#subnet-address-ranges}

When performing transfers between the source and target hosts that are in different subnets within {{ yandex-cloud }}, their IP address ranges should not overlap. For example, an error occurs if the hosts use subnets with the following IP ranges:

* `network-1/subnet-a` with the IPv4 CIDR `10.130.0.0/24`.
* `network-2/subnet-b` with the IPv4 CIDR `10.130.0.0/24`.

{% note info %}

To launch a successful transfer in the selected endpoint subnet address range, there must be at least one free IP address:

{% endnote %}

## IP address availability and ownership {#ip-address-availability}

An IP address __belongs to a network__ if it belongs to any CIDR of any subnet of a given network. For example, if there is a network called `my-network` with subnets `my-network-a` (CIDR `192.168.0.0/24`) and `my-network-b` (CIDR `192.168.1.0/24`), then `192.168.0.100` and `192.168.1.50` belong to `my-network` while `1.2.3.4` does not.

An IP address __is available via a subnet__ if it belongs to a given subnet or the network this subnet belongs to has properly configured routing for the IP address in question. `192.168.0.100` and `192.168.1.50` will be available via the `my-network-a` subnet (as well as via `my-network-b`). `1.2.3.4` will be available through these subnets in the following cases only:
* `my-network` has NAT for the Internet enabled; this will cause traffic to be routed to the Internet.
* `my-network` has a static route configured to process the address in question (`1.2.3.4`). This will cause traffic to be routed to the specified next-hop address.

## IP addresses and domain names in endpoint settings {#ip-addresses-and-domain-names}

If a host is specified as an IP address in the endpoint settings, the selected endpoint subnet will be used for access to a cluster even if the specified IP [does not belong](#ip-address-availability) to the network selected for the endpoint.

If an **On-Premise** endpoint with a host specified as a domain name or an MDB endpoint is being used, the host name will be resolved into an IP address using a DNS server specified in the DHCP settings for the selected subnet or a default DNS server (second address in the subnet range). For a transfer to be successful, the address that the host domain name is resolved to must belong to the network selected for the endpoint while the DNS server address must be [available](#ip-address-availability) via the selected subnet.

## Security groups {#security-groups}

You can assign [security groups](../../vpc/concepts/security-groups.md) to the subnet selected for the endpoint.  In the event that network access to source or target hosts is restricted by security groups, you can disable the network connectivity between {{ data-transfer-full-name }} and your DBMS without adding permissive rules for wide IP ranges to your security groups and allow access from specific groups in a granular manner.  You can grant access to your DBMS hosts using one of the methods below:

* Create a permissive rule called `self` in the security group that protects source or target hosts, and specify this security group in the endpoint settings.
* Create a new security group for the endpoint and create permissive rules between the endpoint and the DBMS security groups.

{% note info %}

Make sure to allow outgoing traffic to the port required by the security group specified in the endpoint.

{% endnote %}

## Transfering between a source on an external network and a target in {{ yandex-cloud }} {#source-external}

You can provide access to a source on an outside network using one of the following methods:

* By configuring a source to make it available from the internet.
* Using [{{ interconnect-full-name }}](../../interconnect/).
* Using an intermediate VM configured to [route traffic to {{ vpc-name }}](../../vpc/concepts/static-routes.md).

If you need to migrate data between {{ yandex-cloud }} and a third-party cloud, allow incoming connections to the third-party cloud database from the internet from [IP addresses used by {{ data-transfer-name }}](https://stat.ripe.net/widget/announced-prefixes#w.resource%3DAS200350%26w.min_peers_seeing%3D0).

To launch transfers requiring internet access to run, you need to have the `data-transfer.transfers.createExternal` privilege.

