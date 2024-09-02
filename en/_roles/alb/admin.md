The `alb.admin` role enables managing Application Load Balancer resources and internal network load balancers, as well as viewing info on cloud networks, subnets, route tables, gateways, security groups, IP addresses, and quotas.

{% cut "Users with this role can:" %}

* View the list of [L7 balancers](../../application-load-balancer/concepts/application-load-balancer.md) and the info on them, as well as create, modify, delete, and use such balancers.
* View the list of [HTTP routers](../../application-load-balancer/concepts/http-router.md) and the info on them, as well as create, modify, delete, and use such routers.
* View the list of [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host) and info on them, as well as modify them.
* View the list of [backend groups](../../application-load-balancer/concepts/backend-group.md) and the info on them, as well as create, modify, delete, and use such groups.
* View the list of L7 balancer target groups and [network balancers](../../network-load-balancer/concepts/target-resources.md) and the info on them, as well as create, modify, delete, and use target groups.
* View the list of [network load balancers](../../network-load-balancer/concepts/index.md) and the info on them, as well as create internal network load balances (including those with UDP listeners), modify, delete, start, and stop them.
* View the list of [cloud networks](../../vpc/concepts/network.md#network) and info on them, as well as use them.
* View the list of [subnets](../../vpc/concepts/network.md#subnet) and info on them, as well as use them.
* View the list of [cloud resource addresses](../../vpc/concepts/address.md) and info on them, as well as use such addresses.
* View the list of [route tables](../../vpc/concepts/routing.md#rt-vpc) and info on them, as well as use them.
* View the list of [security groups](../../vpc/concepts/security-groups.md) and info on them, as well as use them.
* View information on [NAT gateways](../../vpc/concepts/gateways.md) and connect them to route tables.
* View the info on the used IP addresses in subnets, as well as create [internal addresses](../../vpc/concepts/address.md#internal-addresses).
* View the info on operations with the Virtual Private Cloud and Compute Cloud resources.
* View the list of operations with the Network Load Balancer resources.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
* View info on the [Application Load Balancer](../../application-load-balancer/concepts/limits.md#quotas), [Network Load Balancer](../../network-load-balancer/concepts/limits.md#load-balancer-quotas), and [Virtual Private Cloud](../../vpc/concepts/limits.md#vpc-quotas) quotas.

{% endcut %}

This role also includes the `alb.editor` permissions.

To connect a public IP address to a new or existing L7 balancer, you also need the `vpc.publicAdmin` [role](../../vpc/security/index.md#vpc-public-admin) assigned for the network where the balancer resides.