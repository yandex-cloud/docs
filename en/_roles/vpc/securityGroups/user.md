The `vpc.securityGroups.user` role allows you to assign security groups to network interfaces and view information on the resources, quotas, and resource operations.

{% cut "Users with this role can:" %}

* Assign security groups to instance network interfaces.
* Get a list of [cloud networks](../../../vpc/concepts/network.md#network) and view information on them.
* Get a list of [subnets](../../../vpc/concepts/network.md#subnet) and view information on them.
* Get a list of [cloud resource addresses](../../../vpc/concepts/address.md) and view information on them.
* Get a list of [route tables](../../../vpc/concepts/routing.md#rt-vpc) and view information on them.
* Get a list of [security groups](../../../vpc/concepts/security-groups.md) and view information on them.
* View information on [NAT gateways](../../../vpc/concepts/gateways.md).
* View information on the IP addresses used in subnets.
* View information on Virtual Private Cloud [quotas](../../../vpc/concepts/limits.md#vpc-quotas).
* View information on resource operations for Virtual Private Cloud.
* View information on resource operations for Compute Cloud.
* View information on the relevant [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View information on the relevant [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role includes the `vpc.viewer` permissions.