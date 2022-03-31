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


#### Limits {#vpc-limits}
| Type of limit | Value |
----- | -----
| Minimum CIDR size for a subnet | /28 |
| Maximum CIDR size for a subnet | /16 |
| Maximum number of simultaneous TCP/UDP connections per VM | 50,000 |
| Supported network and transport layer protocols | IP, ICMP, TCP, UDP, GRE |
| Maximum number of security groups per interface | 5 |
| Maximum number of rules per security group | 50 |
| Maximum number of CIDRs per rule | 50 |
| Size of the DNS server IP address list | 100 characters |

#### Outgoing traffic filtering {#vpc-egress-traffic-filter}

{% include [port-25.md](vpc/port-25.md) %}
