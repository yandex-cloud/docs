---
title: "How to use network load balancers in {{ network-load-balancer-full-name }}"
description: "In this tutorial, you will learn about using a network load balancer in {{ network-load-balancer-name }}."
---

# Network load balancer use cases

## Virtual machines {#nlb-vm}

The figure below shows an example of using a network load balancer with individual [instances](../../compute/concepts/vm.md).

Traffic coming to the load balancer is distributed in a certain way among the instances located in the target groups behind it.

If multiple traffic listeners are used on one load balancer, the traffic coming to these listeners will be distributed among all target groups connected to this load balancer simultaneously.

For example, traffic coming to "Listener-1" will be sent to instances in target groups 1 and 2.

For more granular traffic listening, instead of creating multiple listeners per load balancer, we recommend you to create a separate load balancer for each service.

## Instance group {#nlb-ig}

The figure below shows an example of using a network load balancer with an [instance group](../../compute/concepts/instance-groups/index.md).

When creating an instance group, a target group for the network load balancer will also be created, which will include all VMs from this group.

When adding or removing VMs from the group, the load balancer's target group will also reflect these changes.

[Example](../../_tutorials/infrastructure/vm-autoscale.md) of deploying an instance group with automatic scaling and integration with a network load balancer.

## {{ managed-k8s-name }} cluster {#nlb-mk8s}

The figure below shows an example of using a network load balancer with [{{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md).

To use a network load balancer as part of services within a {{ managed-k8s-name }} cluster, you need to create a service of the `LoadBalancer` type. Next, the cluster will independently create network load balancer objects according to the manifests provided and monitor the composition of the load balancer's target group, which will include the VMs of all node groups of this cluster.

To learn more about deploying a service using a network load balancer in a Kubernetes cluster, see [Granting access to an app running in a Kubernetes cluster](../../managed-kubernetes/operations/create-load-balancer.md).
