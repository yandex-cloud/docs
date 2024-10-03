---
title: "Network load balancer"
description: "Network load balancers (NLB) are designed for building fault-tolerant scalable applications and services in {{ yandex-cloud }}. Fault-tolerance and scalability are achieved by distributing the traffic that comes to the balancer across the cloud resources located behind it."
---

# Network load balancer. Overview

*Network Load Balancer (NLB)* is designed for building fault-tolerant and scalable applications and services in {{ yandex-cloud }}.

Fault-tolerance and scalability are achieved by distributing the traffic that comes to the balancer across the cloud resources located behind it.

A network load balancer operates at the 4th level of the OSI network model. It also uses technologies running at layer 3 to speed up data packet processing.

## Using network load balancers {#nlb-apps}

A network load balancer can be used together with the following resources and services in {{ yandex-cloud }}:

* [VMs](./scenarios.md#nlb-vm): individual VM instances added to the balancer's target group directly, without using integrations with other services.
* [Instance groups ({{ ig-name}})](./scenarios.md#nlb-ig) tracks the number of VMs in the group and changes the composition of the balancer's target group as needed.
* [Clusters ({{ managed-k8s-name }})](./scenarios.md#nlb-mk8s): Master node of the {{ k8s }} cluster tracks the number of VMs in the cluster node groups and changes the composition of the balancer's target group as needed.

The traffic coming to the balancer is distributed in a certain way across the instances located behind it.

The structure of the network load balancer includes the following key components:

* [Traffic Listener](listener.md) accepts traffic on the balancer.
* [Target Group](target-resources.md): Set of resources that receive traffic from the listener.
* [Resource health checker for target groups](health-check.md) checks the availability of resources in the target group.

You can create a network load balancer by specifying only its name. The other parameters are optional. An [external balancer](#nlb-types) is created by default. Traffic listeners and target groups can be created later and linked to the previously created network load balancer.

## Deployment tools {#tools}

A network load balancer can be deployed in {{ yandex-cloud }} using the following tools:
* [Cloud console]({{ link-console-main }})
* [YC CLI](../../cli/quickstart.md)
* [Terraform](https://terraform-provider.yandexcloud.net/Resources/lb_network_load_balancer)
