#### Quotas {#vpc-quotas}
| Type of limit | Value |
----- | -----
| Number of cloud networks per cloud | 2 |
| Number of subnets per cloud | 6 |
| Number of all public IP addresses per cloud | 8 |
| Number of static public IP addresses per cloud | 2 |
| Number of routing tables per cloud | 8 |
| Number of static routes per cloud | 256 |
| Maximum number of security groups | 10 |
| Maximum number of security groups per interface | 5 |


#### Limits {#vpc-limits}
| Type of limit | Value |
----- | -----
| Minimum CIDR size for a subnet | /28 |
| Maximum CIDR size for a subnet | /16 |
| Maximum number of TCP/UDP connections per VM^*^ | 50000 |
| Supported network and transport layer protocols | IP, ICMP, TCP, UDP, GRE, ESP, AH |
| Maximum number of rules per security group | 50 |
| Maximum number of CIDRs per rule | 50 |
| Size of the DNS server IP address list | 100 characters |

^*^ All TCP/IP and UDP connections opened and half-opened within 180 seconds are taken into account. If there are no data or keep-alive packets in the connection during this time, it is forcibly closed.

#### Outgoing traffic filtering {#vpc-egress-traffic-filter}

{% include [port-25.md](vpc/port-25.md) %}
