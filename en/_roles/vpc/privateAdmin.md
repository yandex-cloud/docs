The `vpc.privateAdmin` role allows you to manage cloud networks, subnets, and route tables, as well as view information on the quotas, resources, and resource operations. This role also allows you to manage connectivity within Yandex Cloud, while it does not allow doing so from the internet.

{% cut "Users with this role can:" %}

* View information on [cloud networks](../../vpc/concepts/network.md#network), as well as create, modify, and delete them.
* View information on [subnets](../../vpc/concepts/network.md#subnet), as well as create, modify, and delete them.
* View information on [route tables](../../vpc/concepts/static-routes.md#rt-vpc), as well as create, modify, and delete them.
* Link route tables to subnets.
* View information on [security groups](../../vpc/concepts/security-groups.md) and create default security groups in cloud networks.
* Configure [DHCP](../../vpc/concepts/dhcp-options.md) in subnets.
* View information on [cloud resource addresses](../../vpc/concepts/address.md), as well as create internal IP addresses.
* View information on [NAT gateways](../../vpc/concepts/gateways.md).
* View information on the IP addresses used in subnets.
* View information on Virtual Private Cloud [quotas](../../vpc/concepts/limits.md#vpc-quotas).
* View information on resource operations for Virtual Private Cloud.
* View information on resource operations for Compute Cloud.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View information on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role includes the permissions of the `vpc.viewer` role.