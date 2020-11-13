# Internal load balancer

The feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

An internal load balancer is used to balance traffic between resources that are connected:

* To VPC subnets.
* Via VPN.
* Via [Cloud Interconnect](../../vpc/interconnect/index.md).

An internal load balancer has the same purpose and traffic balancing mechanism as an external load balancer: the traffic is distributed across the resources of the [target groups](target-resources.md) connected to the load balancer.

[The listener](listener.md) of an internal load balancer uses an [internal IP address](../../vpc/concepts/address.md) from the subnet it runs in. You can connect the load balancer to any subnet from any [availability zone](../../overview/concepts/geo-scope.md): actually, it will be present in all the subnets that includes target resources connected to the balancer.

## Guidelines and limitations {#notes}

When you use an internal load balancer, keep in mind the following:

1. An internal IP address is assigned to the balancer randomly from the subnet's address range.
1. The VM ports used to receive the traffic from the load balancer and to check status become unavailable when a VM is connected to an internal balancer. The VM will only receive traffic from the load balancer.

