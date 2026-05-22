* `security-group-ids`: [Security group](../../managed-kubernetes/operations/connect/security-groups.md) IDs.
* `subnets`: Names of subnets that will host the nodes.
* `ipv4-address`: IPv4 address assignment method.
* `ipv6-address`: IPv6 address assignment method.

The `ipv4-address` and `ipv6-address` parameters set the method of assigning IP addresses:
* `auto`: Assign only internal IP addresses to nodes.
* `nat`: Assign public and internal IP addresses to nodes.

{% include [public-ip](public-ip.md) %}
