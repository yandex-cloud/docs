The `vpc.user` role allows you to use cloud networks, subnets, route tables, gateways, security groups, and IP addresses, get information on these resources, as well as on the quotas and resource operations.

{% cut "Users with this role can:" %}

* View information on [cloud networks](../../vpc/concepts/network.md#network) and use them.
* View information on [subnets](../../vpc/concepts/network.md#subnet) and use them.
* View information on [cloud resource addresses](../../vpc/concepts/address.md) and use them.
* View information on [route tables](../../vpc/concepts/static-routes.md#rt-vpc) and use them.
* View information on [security groups](../../vpc/concepts/security-groups.md) and use them.
* View information on [NAT gateways](../../vpc/concepts/gateways.md) and connect them to route tables.
* View information on the IP addresses used in subnets.
* View information on Virtual Private Cloud [quotas](../../vpc/concepts/limits.md#vpc-quotas).
* View information on resource operations for Virtual Private Cloud.
* View information on resource operations for Compute Cloud.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View information on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role also includes the `vpc.viewer` permissions.