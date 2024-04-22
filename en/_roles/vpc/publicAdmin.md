The `vpc.publicAdmin` role allows you to manage NAT gateways, public IP addresses, and external network connectivity, as well as view information on the quotas, resources, and resource operations. This role grants administrator privileges for multi-interface instances that provide connectivity between multiple networks.

{% cut "Users with this role can:" %}

* View information on [cloud networks](../../vpc/concepts/network.md#network) and configure external access to them.
* Manage connectivity of multiple cloud networks.
* Manage multi-interface instances that provide connectivity between multiple networks.
* View information on [subnets](../../vpc/concepts/network.md#subnet) and modify them.
* View information on [NAT gateways](../../vpc/concepts/gateways.md), as well as create, modify, and delete them.
* Connect NAT gateways to route tables.
* View information on [cloud resource addresses](../../vpc/concepts/address.md), as well as create, update, and delete public IP addresses.
* View information on [route tables](../../vpc/concepts/static-routes.md#rt-vpc), as well as link route tables to subnets.
* View information on [security groups](../../vpc/concepts/security-groups.md).
* View information on the IP addresses used in subnets.
* View information on Virtual Private Cloud [quotas](../../vpc/concepts/limits.md#vpc-quotas).
* View information on resource operations for Virtual Private Cloud.
* View information on resource operations for Compute Cloud.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View information on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role also includes the `vpc.viewer` permissions.

You can assign a role for a cloud or folder. Important: If a network and subnet are in different folders, the `vpc.publicAdmin` role is checked for the folder where the network is located.