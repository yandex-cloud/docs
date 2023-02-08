# {{ ig-name }} concepts

{{ ig-name }} is a {{ compute-name }} component that lets you create instance groups and manage them.
{{ ig-name }} automatically identifies and corrects unhealthy instances in a group to ensure their optimal performance.

{% note warning %}

All operations in {{ ig-name }} must be performed on behalf of a service account. For more information, see [{#T}](access.md).

{% endnote %}

Each group consists of one or more instances of the same type. Group instances may reside in different availability zones and regions. More about the [geo scope of {{ yandex-cloud }}](../../../overview/concepts/geo-scope.md).

![Instance groups](../../../_assets/instance-groups/ig.svg "Instance groups")

Use {{ ig-name }} to:

- Simultaneously [update](deploy/index.md) all instances in a group.

- Integrate with [{{ network-load-balancer-full-name }}](../../../network-load-balancer/concepts/index.md) and [{{ alb-full-name }}](../../../application-load-balancer/concepts/index.md) and evenly distribute workloads across instances.

- Create [automatically scaled instance groups](scale.md#auto-scale).

- Automatically [recover](autohealing.md) an instance if the application fails.

- Maintain the performance of application services in a reliable environment with multi-zone features instead of allocating resources for each zone.

When creating a group, describe the following:

- The [template](instance-template.md) for deploying group instances.

- [{#T}](policies/index.md) for scaling, deployment, and allocation.

Instance groups created in the folder can be accessed by all instances connected to the same cloud network. [Learn more about networking](../../../vpc/).