# Internal network load balancer

An internal network load balancer is used to balance traffic between resources that are connected:

* To {{ vpc-short-name }} subnets.
* Via VPN.
* Via [Cloud Interconnect](../../interconnect/index.yaml).

An internal network load balancer has the same purpose and traffic balancing mechanism as an external load balancer: the traffic is distributed across the resources of the [target groups](target-resources.md) attached to the load balancer.

An internal load balancer's [listener](listener.md) uses an [internal IP address](../../vpc/concepts/address.md) from the subnet it runs in. You can connect the load balancer to any subnet from any [availability zone](../../overview/concepts/geo-scope.md): actually, it will be present in all the subnets that includes targets attached to the load balancer.

## Guidelines and limitations {#notes}

The VM ports used to receive the traffic from the load balancer and to check status become unavailable when a VM is connected to an internal balancer. The VM will only receive traffic from the load balancer. The same restriction won't allow a VM from the load balancer's target group to access it through the port being used.

