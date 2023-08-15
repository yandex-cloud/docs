# Internal network load balancer

An internal network load balancer is used to balance traffic between resources that are connected:
* To [{{ vpc-full-name }}](../../vpc/) [subnets](../../vpc/concepts/network.md#network).
* Via VPN.
* Through [{{ interconnect-full-name }}](../../interconnect/index.yaml).

An internal network load balancer has the same purpose and traffic balancing mechanism as an external load balancer: the traffic is distributed across the resources of the [target groups](target-resources.md) attached to the load balancer.

An internal load balancer's [listener](listener.md) uses an [internal IP address](../../vpc/concepts/address.md#internal-addresses) from the subnet it runs in. You can connect the load balancer to any subnet from any [availability zone](../../overview/concepts/geo-scope.md): technically, it will be present in all subnets that include targets attached to the load balancer.

## Recommendations and limitations {#notes}

The [VM](../../compute/concepts/vm.md) ports used to receive traffic from the load balancer and to perform health checks become unavailable when a VM is connected to an internal load balancer. The VM will only receive traffic from the load balancer. The same restriction will not allow a VM from the load balancer's target group to access it through the port being used.
