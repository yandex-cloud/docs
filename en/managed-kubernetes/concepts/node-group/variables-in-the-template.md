---
title: Variables in a {{ managed-k8s-full-name }} node template
description: In this tutorial, you will learn how to use variables in a {{ managed-k8s-name }} node template.
---

# Variables in a {{ managed-k8s-full-name }} node template

{{ managed-k8s-name }} creates [groups of same-type cluster nodes](../index.md#node-group) from a template. To use different specifications for such nodes, use the substitution of template variables.

[System](../../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) and [user-defined](../../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) variables are supported.

For more information about variables and their substitution steps, see [{#T}](../../../compute/concepts/instance-groups/variables-in-the-template.md).

For example, you can use variables to [create](../../operations/node-group/node-group-create-in-instance-pool.md) a multi-zone group of nodes from reserved instance pools located in different [availability zones](../../../overview/concepts/geo-scope.md).

You can use variables via the [CLI](../../cli-ref/node-group/create.md), [{{ TF }}](../../../terraform/resources/kubernetes_node_group.md), and [API](../../managed-kubernetes/api-ref/NodeGroup/create.md).

## Examples {#examples}

In this example, we will create a node group in three availability zones with one node from reserved instance pools per zone.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [reserved-pools-cli-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-multi-zone.md) %}

- {{ TF }} {#tf}

  {% include [reserved-pools-tf-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-multi-zone.md) %}

{% endlist %}

See [Reserved instance pools for node groups](./reserved-pools.md#examples) for examples for a group of nodes from a reserved instance pool in a single availability zone.

### See also {#see-also}

* [{#T}](../../../compute/concepts/instance-groups/variables-in-the-template.md)
* [{#T}](./reserved-pools.md)
* [{#T}](../../operations/node-group/node-group-create-in-instance-pool.md)
