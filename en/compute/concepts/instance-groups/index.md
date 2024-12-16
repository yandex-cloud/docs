---
title: '{{ ig-name }} concepts'
description: In this article, you will learn about {{ ig-name }} concepts.
---

# {{ ig-name }} concepts


{{ ig-name }} is a {{ compute-name }} component that allows you to create and manage instance groups.
{{ ig-name }} can automatically identify and heal unhealthy instances in a group to ensure their optimal performance.

{% note warning %}

To work in {{ ig-name }}, you must use a service account. For more information, see [{#T}](access.md).

{% endnote %}

Each group consists of one or more instances of the same type. Group instances may reside in different availability zones. Learn more about [{{ yandex-cloud }} availability zones](../../../overview/concepts/geo-scope.md).

Group instances can also be part of a [VM placement group](../placement-groups.md). To enable this, when [creating an instance group](../../operations/placement-groups/create-ig-in-pg.md), describe placement group parameters in the [instance template](instance-template.md#instance-template). You can create an instance group in a placement group using the [CLI](../../../cli/quickstart.md) and [API](../../api-ref/).

![Instance groups](../../../_assets/instance-groups/ig.svg "Instance groups")

With {{ ig-name }}, you can:

- Simultaneously [update](deploy/index.md) all instances in a group.

- Provide integration with [{{ network-load-balancer-full-name }}](../../../network-load-balancer/concepts/index.md) and [{{ alb-full-name }}](../../../application-load-balancer/concepts/index.md) and evenly distribute workloads across instances.

- Create [automatically scaled instance groups](scale.md#auto-scale).

- Automatically [recover](autohealing.md) a VM instance if an application fails.

- Maintain the performance of application services in a reliable environment with multi-zone features instead of allocating resources for each zone.

- [Handle application stateless and stateful workloads](./stateful-workload.md).

When creating a group, you need to describe the following:

- [Template](instance-template.md) for deploying group instances.

- [{#T}](policies/index.md) for scaling, deployment, and allocation.

An instance group created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../../vpc/).
