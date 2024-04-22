The `vpc.admin` role allows you to manage cloud networks, subnets, route tables, NAT gateways, security groups, internal and public IP addresses, as well as external network connectivity.

{% cut "Users with this role can:" %}

* View information on [cloud networks](../../vpc/concepts/network.md#network), as well as create, modify, and delete them.
* Configure external access to cloud networks.
* Manage connectivity of multiple cloud networks.
* Manage multi-interface instances that provide connectivity between multiple networks.
* View information on [subnets](../../vpc/concepts/network.md#subnet), as well as create, modify, and delete them.
* View information on [route tables](../../vpc/concepts/static-routes.md#rt-vpc), as well as create, modify, and delete them.
* Link route tables to subnets.
* View information on [NAT gateways](../../vpc/concepts/gateways.md), as well as create, modify, and delete them.
* Connect NAT gateways to route tables.
* View information on [security groups](../../vpc/concepts/security-groups.md), as well as create, modify, and delete them.
* Create and delete default security groups in [cloud networks](../../vpc/concepts/network.md#network).
* Create and delete security group [rules](../../vpc/concepts/security-groups.md#security-groups-rules), as well as edit their metadata.
* Configure [DHCP](../../vpc/concepts/dhcp-options.md) in subnets.
* View information on [cloud resource addresses](../../vpc/concepts/address.md), as well as create, update, and delete internal and public IP addresses.
* View information on the IP addresses used in subnets.
* View information on Virtual Private Cloud [quotas](../../vpc/concepts/limits.md#vpc-quotas).
* View information on resource operations for Virtual Private Cloud.
* View information on resource operations for Compute Cloud.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View information on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role also includes the `vpc.privateAdmin`, `vpc.publicAdmin`, and `vpc.securityGroups.admin` permissions.