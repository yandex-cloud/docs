---
title: Network
description: In this article, you will learn about public and private networks.
---

# Network

## Public network {#public-network}

A network with internet access, to which all servers are physically connected.

## Private network {#private-network}

A local network to which all servers are connected. Logically joins servers into isolated user networks.

### Private subnet {#private-subnet}

A network physically bounded by the network equipment of a single pool, isolated both from the internet and from other users' networks.

Within a single pool, L2 connectivity (VLAN) and L3 connectivity (VRF) are possible between leased servers. Between servers physically hosted in different pools, only L3 connectivity is available.

To configure networking between servers from different [pools](./servers.md), select the same [VRF](#vrf-segment) for the appropriate subnets under **Routing settings**.

For subnet addressing purposes, you can use any CIDR in the ranges reserved for private networks: `10.0.0.0/8`, `172.16.0.0/12`, or `192.168.0.0/16`. The subnet must include at least eight addresses (the maximum CIDR prefix length is `/29`).

### Virtual routing and forwarding (VRF) {#vrf-segment}

To provide L3 routing, private subnets with configured routing are aggregated into virtual routing and forwarding segments (VRFs).

Servers from the same or different pools connected to different private subnets aggregated into a VRF will be able to maintain L3 networking between them.

## DHCP in a {{ baremetal-full-name }} network {#dhcp}

In public and private networks, server network interfaces are configured using DHCP.

If you select `Automatically` in the **Public address** selector when ordering the server, its network interface connected to a public network will get an IPv4 address from the public range of internet networks.

If DHCP is disabled on a server, consider the following when configuring the network interface of a public network:
* The subnet which the server's public IP address belongs to has a CIDR with a `/31` prefix and consists of two addresses: the gateway IP address and the host IP address.
* The host IP address is specified in the **Public IPv4 address** field on the page with server information.
* The gateway IP address is less than the host IP address by one.

Example:
* Server public IPv4 address: `1.2.3.111`.
* Subnet CIDR: `1.2.3.110/31`.
* Gateway IP address: `1.2.3.110`.

A server network interface connected to a private network is given an IP address from the CIDR specified in the settings for routing the private subnet to which the server is connected.

If the server OS is installed from {{ marketplace-short-name }} images, DHCP IP address acquisition is enabled by default on all physical interfaces of this server.

Within a private network, the DHCP server is automatically activated as soon as the routing settings are specified in the parameters of that subnet. Until the routing settings are defined, the private subnet runs as an L2 network. In which case you need to manually assign IP addresses to its servers.