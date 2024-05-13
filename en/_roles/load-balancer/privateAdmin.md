The `load-balancer.privateAdmin` role enables managing internal network load balancers and target groups, as well as viewing info on them and on the cloud networks, subnets, route tables, gateways, security groups, and IP addresses.

Users with this role can:
* View the list of [network load balancers](../../network-load-balancer/concepts/index.md) and the info on them, as well as create internal network load balances (including those with UDP listeners), modify, delete, start, and stop them.
* View the list of [target groups](../../network-load-balancer/concepts/target-resources.md) and the info on them, as well as create, modify, delete, and use target groups.
* View the list of [cloud networks](../../vpc/concepts/network.md#network) and the info on them.
* View the list of [subnets](../../vpc/concepts/network.md#subnet) and info on them, as well as use them.
* View the list of [cloud resource addresses](../../vpc/concepts/address.md) and the info on them.
* View the list of [route tables](../../vpc/concepts/static-routes.md#rt-vpc) and the info on them.
* View the list of [security groups](../../vpc/concepts/security-groups.md) and the info on them.
* View information on [NAT gateways](../../vpc/concepts/gateways.md).
* View the info on the used IP addresses in subnets, as well as create [internal addresses](../../vpc/concepts/address.md#internal-addresses).
* View the info on operations with the Virtual Private Cloud and Compute Cloud resources.
* View the list of operations with the Network Load Balancer resources.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
* View info on [Network Load Balancer](../../network-load-balancer/concepts/limits.md#load-balancer-quotas) and [Virtual Private Cloud](../../vpc/concepts/limits.md#vpc-quotas) quotas.

This role includes the `load-balancer.viewer` and `vpc.viewer` permissions.