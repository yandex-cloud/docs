---
title: Creating a group with nodes from a {{ compute-full-name }} reserved instance pool
description: Follow this guide to create a group with nodes from a {{ compute-name }} reserved instance pool.
---

# Creating a group with nodes from a {{ compute-full-name }} reserved instance pool


{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

{% include [reserved-pools-intro](../../../_includes/compute/reserved-pools-intro.md) %}

{% include [reserved-pools-mk8s-intro](../../../_includes/managed-kubernetes/reserved-pools-mk8s-intro.md) %}

For more information, see [{#T}](../../concepts/node-group/reserved-pools.md) and [{#T}](../../../compute/concepts/reserved-pools.md). 

{% note warning %}

{% include [reserved-pools-mk8s-restrictions](../../../_includes/managed-kubernetes/reserved-pools-mk8s-restrictions.md) %}

{% endnote %}

## Creating a node group in a single availability zone with nodes from a reserved instance pool in that zone {#single-zone}

1. [Create](../../../compute/operations/reserved-pools/create-reserved-pool.md) a reserved instance pool with a configuration you want to use for {{ managed-k8s-name }} cluster nodes.

    {% include [reserved-pools-mk8s-resources-warning](../../../_includes/managed-kubernetes/reserved-pools-mk8s-resources-warning.md) %}

1. [Create](../kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster.
1. Create a node group:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      In the terminal, run this command:

      {% include [reserved-pools-cli-single-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-single-zone.md) %}

      For more information about this command, see the [CLI reference](../../cli-ref/node-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, describe the node group parameters:

          {% include [reserved-pools-tf-single-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-single-zone.md) %}

      1. Create a node group:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      For more information about `yandex_kubernetes_node_group`, see [this {{ TF }} reference](../../../terraform/resources/kubernetes_node_group.md).

    {% endlist %}

## Creating a node group in three availability zones with nodes from reserved instance pools in each zone {#multi-zone}

1. [Create](../../../compute/operations/reserved-pools/create-reserved-pool.md) a reserved instance pool with a configuration you want to use for {{ managed-k8s-name }} cluster nodes.

    {% include [reserved-pools-mk8s-resources-warning](../../../_includes/managed-kubernetes/reserved-pools-mk8s-resources-warning.md) %}

1. [Create](../kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster.
1. Create a node group:

    {% include [reserved-pools-mk8s-variable-tip](../../../_includes/managed-kubernetes/reserved-pools-mk8s-variable-tip.md) %}

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      In the terminal, run this command:

      {% include [reserved-pools-cli-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-cli-multi-zone.md) %}

      For more information about this command, see the [CLI reference](../../cli-ref/node-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, describe the node group parameters:

          {% include [reserved-pools-tf-multi-zone](../../../_includes/managed-kubernetes/reserved-pools-tf-multi-zone.md) %}

      1. Create a node group:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      For more information about `yandex_kubernetes_node_group`, see [this {{ TF }} reference](../../../terraform/resources/kubernetes_node_group.md).

    {% endlist %}

### See also {#see-also}

* [{#T}](../../concepts/node-group/reserved-pools.md)
* [{#T}](../../concepts/node-group/variables-in-the-template.md)
* [{#T}](../../../compute/concepts/reserved-pools.md)
* [Working with reserved instance pools](../../../compute/operations/index.md#reserved-pools)
* [{#T}](../../../compute/concepts/instance-groups/variables-in-the-template.md)
* [{#T}](./node-group-create.md)
