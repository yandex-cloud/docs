* `security-group-ids`: [Security group](../../managed-kubernetes/operations/connect/security-groups.md) IDs.
* `subnets`: Names of subnets that will host the nodes.
* `ipv4-address`: IPv4 address assignment method.
* `ipv6-address`: IPv6 address assignment method.

The `ipv4-address` and `ipv6-address` parameters determine the method of assigning an IP address:
* `auto`: Only the internal IP address is assigned to the node.
* `nat`: Public and internal IP addresses are assigned to the node.

{% note info %}

{% include [nodes-internet-access](nodes-internet-access.md) %}

{% include [nodes-internet-access-additional](nodes-internet-access-additional.md) %}

{% endnote %}