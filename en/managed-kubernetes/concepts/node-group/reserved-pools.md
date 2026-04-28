---
title: Reserved instance pools for {{ managed-k8s-full-name }} node groups
description: In this article, you will learn how to use reserved instance pools for {{ managed-k8s-name }} node groups.
---

# Reserved instance pools for {{ managed-k8s-full-name }} node groups

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

{% include [reserved-pools-intro](../../../_includes/compute/reserved-pools-intro.md) %}

For more information, see [{#T}](../../../compute/concepts/reserved-pools.md).

{% include [reserved-pools-mk8s-intro](../../../_includes/managed-kubernetes/reserved-pools-mk8s-intro.md) %}

In {{ managed-k8s-name }}, you can use reserved instance pools via the [CLI](../../cli-ref/node-group/create.md), [{{ TF }}](../../../terraform/resources/kubernetes_node_group.md), and [API](../../managed-kubernetes/api-ref/NodeGroup/create.md).

{% include [reserved-pools-mk8s-variable-tip](../../../_includes/managed-kubernetes/reserved-pools-mk8s-variable-tip.md) %}

## Limitations {#restrictions}

{% include [reserved-pools-mk8s-restrictions](../../../_includes/managed-kubernetes/reserved-pools-mk8s-restrictions.md) %}

{% include [reserved-pools-mk8s-resources-warning](../../../_includes/managed-kubernetes/reserved-pools-mk8s-resources-warning.md) %}

## Examples {#examples}

In this example, we will create a node group in one availability zone with two nodes from that zone's reserved instance pool.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [reserved-pools-cli-single-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-single-zone.md) %}

- {{ TF }} {#tf}

  {% include [reserved-pools-tf-single-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-single-zone.md) %}

{% endlist %}

Examples for a multi-zone group with nodes from a reserved instance pool using variables are provided on the [Node template variables](./variables-in-the-template.md#examples) page.

### See also {#see-also}

* [{#T}](../../../compute/concepts/reserved-pools.md)
* [Working with reserved instance pools](../../../compute/operations/index.md#reserved-pools)
* [{#T}](./variables-in-the-template.md)
* [{#T}](../../operations/node-group/node-group-create-in-instance-pool.md)
