# DHCP in a {{ baremetal-full-name }} network

In public and private networks, server network interfaces are configured using DHCP.

If you select `Automatically` in the **Public address** selector when ordering the server, its network interface connected to a public network will get an IPv4 address from the public range of internet networks.

If DHCP is disabled on a server, consider the following when configuring the network interface of a public network:
* The subnet which the server's public IP address belongs to has a CIDR with a `/31` prefix and consists of two addresses: the gateway IP address and the host IP address.
* The host IP address is specified in the **Public IPv4 address** field on the page with server information.
* The gateway IP address is less than the host IP address by one.

Here is an example:
* Server public IPv4 address: `198.51.100.111`.
* Subnet CIDR: `198.51.100.110/31`.
* Gateway IP address: `198.51.100.110`.

The server network interface connected to a private network gets an IP address from the CIDR specified in the routing settings of the private subnet the server is connected to.

If the server OS is installed from {{ marketplace-short-name }} images, DHCP IP address acquisition is enabled by default on all physical interfaces of this server.

Within a private network, the DHCP server is automatically activated as soon as the routing settings are specified in the parameters of that subnet. Until the routing settings are defined, the private subnet runs as an L2 network. In which case you need to manually assign IP addresses to its servers.