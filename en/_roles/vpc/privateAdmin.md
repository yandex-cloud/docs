The `vpc.privateAdmin` role allows you to manage cloud networks, subnets, and route tables, as well as view information on the quotas, resources, and resource operations. This role also allows you to manage connectivity within Yandex Cloud, while it does not allow doing so from the internet.

{% cut "Users with this role can:" %}

* View the list of [cloud networks](../../vpc/concepts/network.md#network) and info on them, as well as create, modify, and delete them.
* View the list of [subnets](../../vpc/concepts/network.md#subnet) and info on them, as well as create, modify, and delete them.
* View the list of [route tables](../../vpc/concepts/routing.md#rt-vpc) and info on them, as well as create, modify, and delete them.
* Link route tables to subnets.
* View the list of [security groups](../../vpc/concepts/security-groups.md) and info on them, as well as create default security groups within cloud networks.
* Configure [DHCP](../../vpc/concepts/dhcp-options.md) in subnets.
* View the list of [cloud resource addresses](../../vpc/concepts/address.md) and info on them, as well as create internal IP addresses.
* View information on [NAT gateways](../../vpc/concepts/gateways.md).
* View information on the IP addresses used in subnets.
* View information on Virtual Private Cloud [quotas](../../vpc/concepts/limits.md#vpc-quotas).
* View information on resource operations for Virtual Private Cloud.
* View information on resource operations for Compute Cloud.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role includes the `vpc.viewer` permissions.