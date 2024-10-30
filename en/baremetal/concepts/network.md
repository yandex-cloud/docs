# Network

## Public network {#public-network}

A network with internet access, to which all servers are physically connected.

## Private network {#vrf}

A local network to which all servers are connected. Logically joins servers into isolated user networks.

### Private subnet {#private-subnet}

A network physically bounded by the network equipment of a single pool, isolated both from the internet and from other users' networks.

Within a single pool, L2 connectivity (VLAN) and L3 connectivity (VRF) are possible between leased servers. Between servers physically hosted in different pools, only L3 connectivity is available.

If you want to configure connections between servers from different pools, you need to assign subnet routing and specify a default gateway.

For routing purposes, any CIDR in the ranges reserved for private networks can be used: `10.0.0.0/8`, `172.16.0.0/12`, or `192.168.0.0/16`.

### Virtual routing and forwarding (VRF) {#vrf-segment}

To provide L3 routing, private subnets are aggregated into virtual routing and forwarding segments (VRFs).

Servers from the same or different pools connected to different private subnets aggregated into a VRF will be able to maintain L3 networking between them.

## DHCP in a {{ baremetal-full-name }} network {#vrf}

In public and private networks, server network interfaces are configured using DHCP.

If you select `Automatically` in the **Public address** selector when ordering the server, its network interface connected to the public network will be given an IPv4 address from the public range of internet networks.

A server network interface connected to a private network is given an IP address from the CIDR specified in the settings for routing the private subnet to which the server is connected.

If the server OS is installed from Marketplace images, DHCP IP address acquisition is enabled by default on all physical interfaces of this server.

Within a private network, the DHCP server is automatically activated as soon as the routing settings are specified in the parameters of that subnet. Until the routing settings are defined, the private subnet runs as an L2 network. In which case you need to manually assign IP addresses to its servers.