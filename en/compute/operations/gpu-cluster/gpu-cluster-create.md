---
title: How to create a GPU cluster
description: Follow this guide to create a GPU cluster.
---

# Creating a GPU cluster


{% note info %}

By default, a [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) has a zero [quota](../../concepts/limits.md#compute-quotas) for creating GPU clusters. To change the [quota]({{ link-console-quotas }}), contact [support]({{ link-console-support }}).

{% endnote %}

This section explains how to create a GPU cluster. Currently, GPU clusters can only be created in the `{{ region-id }}-a` [availability zone](../../../overview/concepts/geo-scope.md).

After creating a cluster, you can [add](gpu-add-to-cluster.md) [VMs](../../concepts/vm.md) from the same availability zone to it.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating a GPU cluster:

     ```bash
     yc compute gpu-cluster create --help
     ```

     Note that currently, you can only create GPU clusters with the `infiniband` interconnect type.
  1. Create a GPU cluster in the default availability zone:

     ```bash
     yc compute gpu-cluster create --interconnect-type infiniband
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, define the parameters of the resource you want to create:

     ```hcl
     provider "yandex" {
       zone = "{{ region-id }}-a"
     }

     resource "yandex_compute_gpu_cluster" "default" {
       name               = "<GPU_cluster_name>"
       interconnect_type  = "<interconnect_type>"
       zone               = "{{ region-id }}-a"
       labels             = {
         <label_1_key> = "<label_1_value>"
         <label_2_key> = "<label_2_value>"
       }
     }
     ```

     Where:
     * `name`: GPU cluster name. This is a required parameter.
     * `interconnect_type`: Interconnect type. Currently, you can only create GPU clusters with the `infiniband` interconnect type. This is a required parameter.
     * `labels`: Resource [label](../../../resource-manager/concepts/labels.md) in `<key> = "<value>"` format. This is an optional parameter.

     For more information about the `yandex_compute_gpu_cluster` resource properties, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/compute_gpu_cluster).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a GPU cluster in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new GPU cluster and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc compute gpu-cluster get <GPU_cluster_name>
  ```

{% endlist %}