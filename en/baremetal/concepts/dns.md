---
title: DNS in a {{ baremetal-full-name }} private network
description: Learn how to provide DNS servers and domain name to {{ baremetal-name }} servers via DHCP, use incoming DNS connections, and work within the limitations.
---

# DNS in a private network

In a {{ baremetal-name }} [private subnet](./private-network.md#private-subnet) with enabled [DHCP](./dhcp.md), you can configure DNS servers and a domain name. These settings are provided via DHCP to the private network interfaces of all servers on the subnet that use DHCP. You can specify these settings when [creating a subnet](../operations/subnet-create.md) or [edit them](../operations/configure-dns.md) for an existing subnet.

## DNS servers {#dns-servers}

In the subnet settings, you can select an [incoming {{ dns-full-name }} connection](../../dns/concepts/dns-connection.md#dns-inbound) or specify the IPv4 address of your own DNS server. You can also configure several DNS servers and use both options together.

An incoming DNS connection allows resolving names from [internal DNS zones](../../dns/concepts/dns-zone.md#private-zones) available in the {{ vpc-name }} network the connection was created in. For example, you can access managed database cluster hosts from a {{ baremetal-name }} server by their FQDNs. You do not need to deploy a separate VM with a DNS forwarder for that.

To use an incoming DNS connection, [configure network connectivity](../tutorials/bm-vrf-and-vpc-interconnect.md) between the VRF of the private subnet and the cloud network using {{ interconnect-full-name }} and {{ cr-name }}. Make sure the virtual router announces the prefix of the {{ vpc-name }} subnet the DNS connection IP address is in.

Your own DNS server can reside in a {{ baremetal-name }} network or your enterprise infrastructure. The specified IPv4 address must be reachable from the private subnet.

## Domain name {#domain-name}

The _domain name_ in the DHCP settings is the search domain the server’s operating system adds to short names when resolving DNS queries. For example, with `example.internal` as the domain name, `app` resolves as `app.example.internal`.

Specifying a domain name is optional. All selected DNS servers must support name resolution for this domain. Configuring a domain name in DHCP does not create a DNS zone or resource records: you need to configure them on your DNS servers.

## Applying the settings {#apply-settings}

DHCP option `6` provides the DNS server addresses, while options `15` and `119` provide the domain name. Once you save the settings, the DHCP server transmits them for five minutes to connected servers during their next address lease renewal.

The list of DNS servers thus provided overrides the previous DNS settings of the private interface rather than extends them. If the server uses custom DHCP or DNS processing rules, make sure the operating system can accept the new settings.

{% note info %}

The operating system may ignore the domain name provided via DHCP. For example, you may need to specify `dhcp4-overrides.use-domains: true` for an OS with Netplan. For more info on how to check and configure your operating system, see [{#T}](../operations/configure-dns.md#check-settings).

{% endnote %}

## Limitations {#limitations}

* DNS settings can only be provided to network interfaces that get their IP addresses via DHCP. For interfaces with static IP addressing, configure DNS manually in the OS.
* You can specify a maximum of three DNS servers per private subnet, including your own servers and incoming DNS connections.
* {{ baremetal-name }} sends the DHCP options but does not check whether the DNS servers are available. You need to configure routing between the {{ baremetal-name }} server and the DNS servers by yourself. Selecting an incoming DNS connection does not establish network connectivity with the cloud network.
* You can only create one incoming DNS connection per {{ vpc-name }} network. The number of connections available through a virtual router depends on the number of cloud networks associated with that router. With that said, the limit of three DNS servers per private subnet still applies.
* Several DNS servers on the list should resolve the same names. Incoming connections from different cloud networks may have access to different internal DNS zones. If one server returns `NXDOMAIN` (name not found), the client resolver may not query the next server. Therefore, do not use this list to distribute queries across different DNS zones.
* You cannot delete an incoming DNS connection as long as it is in the settings of at least one {{ baremetal-name }} private subnet. Before deleting a connection, remove it from the DNS settings of all such subnets.

## Use cases {#examples}

* [{#T}](../tutorials/bm-vpc-dns-forwarder.md)

#### Useful links {#see-also}

* [{#T}](../operations/configure-dns.md)
* [{#T}](./dhcp.md)
* [{#T}](../../dns/operations/connection-inbound-create.md)
