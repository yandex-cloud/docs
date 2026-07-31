---
title: How to create a GPU cluster
description: Follow this guide to create a GPU cluster.
---

# Creating a GPU cluster


{% note info %}

By default, a [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) has a zero [quota](../../concepts/limits.md#compute-quotas) for creating GPU clusters. To change the [quota]({{ link-console-quotas }}), contact [support]({{ link-console-support }}).

{% endnote %}

This section explains how to create a GPU cluster. You can create GPU clusters in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` [availability zones](../../../overview/concepts/geo-scope.md).

After creating a cluster, you can [add](gpu-add-to-cluster.md) [VMs](../../concepts/vm.md) from the same availability zone to it.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) for the new GPU cluster.
  1. [Navigate]({{ link-console-main }}/link/compute) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Click **{{ ui-key.yacloud.gpu-cluster.action_create-cluster }}**.
  1. In the window that opens:

      1. In the **{{ ui-key.yacloud.gpu-cluster.field_name }}** field, enter a name for the GPU cluster.

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Optionally, in the **{{ ui-key.yacloud.gpu-cluster.field_description }}** field, add a description for the GPU cluster.
      1. In the **{{ ui-key.yacloud.gpu-cluster.field_accessibility-zone }}** field, select an availability zone for the cluster.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md) to the cluster.
  1. Click **{{ ui-key.yacloud.gpu-cluster.action_create-cluster }}**.

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

  1. In the {{ TF }} configuration file, describe the resource you want to create:

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
     * `name`: GPU cluster name. This is a required setting.
     * `interconnect_type`: Interconnect type. Currently, you can only create GPU clusters with the `infiniband` interconnect type. This is a required setting.
     * `labels`: Resource [label](../../../resource-manager/concepts/labels.md) in `<key> = "<value>"` format. This is an optional setting.

     For more information about the `yandex_compute_gpu_cluster` resource properties, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_gpu_cluster).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a GPU cluster in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new GPU cluster and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc compute gpu-cluster get <GPU_cluster_name>
  ```

- API {#api}

  To create a GPU cluster, use the [create](../../api-ref/GpuCluster/create.md) REST API method for the [GpuCluster](../../api-ref/GpuCluster/index.md) resource or the [GpuClusterService/Create](../../api-ref/grpc/GpuCluster/create.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](gpu-add-to-cluster.md)
* [{#T}](gpu-cluster-update.md)
* [{#T}](gpu-cluster-delete.md)
* [{#T}](../../concepts/gpus.md)
* [{#T}](../../concepts/vm-platforms.md)

