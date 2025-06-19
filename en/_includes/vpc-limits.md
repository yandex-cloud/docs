#### Quotas {#vpc-quotas}

#|
|| Type of limit | Value ||
|| Number of cloud networks per cloud
`vpc.networks.count` | 2 ||
|| Number of subnets per cloud
`vpc.subnets.count` | 12 ||
|| Number of all public IP addresses per cloud
`vpc.externalAddresses.count` | 8 ||
|| Number of static public IP addresses per cloud
`vpc.externalStaticAddresses.count` | 2 ||
|| Number of routing tables per cloud
`vpc.routeTables.count` | 8 ||
|| Number of static routes per cloud
`vpc.staticRoutes.count` | 256 ||
|| Maximum number of security groups
`vpc.securityGroups.count` | 10 ||
|| Maximum number of security groups per interface | 5 ||
|#

#### Limits {#vpc-limits}
Type of limit | Value
----- | -----
Minimum CIDR size for a subnet | /28
Maximum CIDR size for a subnet | /16
Maximum number of VM connections when using custom security groups^1^ ^2^ | 350,000
Supported network and transport layer protocols | IP, ICMP, TCP, UDP, GRE, ESP, AH
Maximum number of rules per security group | 50
Maximum number of CIDRs per rule | 50
Size of the DNS server IP address list | 100 characters
Maximum number of DNS requests to a DNS server (second address [in a subnet](../vpc/concepts/network.md#subnet)) | 1,000 requests per second
Maximum number of NAT gateways | 20

^1^ Counts all TCP and UDP connections opened and half-opened within 180 seconds. If there are no data or keep-alive packets in the connection during this time, it is forcibly closed.
^2^ The old network diagram had a limit of 50,000 connections.

#### Outgoing traffic filtering {#vpc-egress-traffic-filter}

{% include [port-25.md](vpc/port-25.md) %}
