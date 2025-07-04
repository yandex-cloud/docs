---
title: How to use network load balancers in {{ network-load-balancer-full-name }}
description: In this tutorial, you will learn about using a network load balancer in {{ network-load-balancer-name }}.
---

# Network load balancer use cases


## VMs {#nlb-vm}
A load balancer’s incoming traffic is distributed in a certain way among VMs located in the target groups downstream of the load balancer.

If multiple traffic listeners are used on one load balancer, the traffic coming to these listeners will be distributed among all target groups connected to this load balancer simultaneously.

For example, traffic coming to "Listener-1" will be sent to instances in target groups 1 and 2.

For more granular traffic listening, instead of creating multiple listeners per load balancer, we recommend creating a separate load balancer for each service.


### Use cases {#examples-vm}

* [{#T}](../tutorials/web-service.md)
* [{#T}](../tutorials/exchange.md)
* [{#T}](../tutorials/migration-from-nlb-to-alb/index.md)


## Instance group {#nlb-ig}
When creating an instance group, a target group for the network load balancer will also be created, which will include all VMs from this group.

When adding or removing VMs from the group, the load balancer's target group will also reflect these changes.

[Example](../tutorials/vm-autoscale/index.md) of deploying an instance group with autoscaling and integration with a network load balancer.

### Use cases {#examples-ig}

* [{#T}](../tutorials/fault-tolerance.md)
* [{#T}](../tutorials/updating-under-load.md)
* [{#T}](../tutorials/exchange.md)
* [{#T}](../tutorials/mssql-alwayson-lb.md)
* [{#T}](../tutorials/migration-from-nlb-to-alb/index.md)


## {{ managed-k8s-name }} cluster {#nlb-mk8s}
To use a network load balancer as part of services within a {{ managed-k8s-name }} cluster, you need to create a service of the `LoadBalancer` type. Then the cluster itself will create network load balancer objects according to the provided manifests and will monitor the load balancer's target group receiving VMs from all node groups of that cluster.

To learn more about deploying a service using a network load balancer in a Kubernetes cluster, see [Granting access to an app running in a Kubernetes cluster](../../managed-kubernetes/operations/create-load-balancer.md).


### Use cases {#examples-mk8s}

* [{#T}](../tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)
