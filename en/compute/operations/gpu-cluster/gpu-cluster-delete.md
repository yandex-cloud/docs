---
title: Deleting a GPU cluster
description: Follow this guide to delete a GPU cluster.
---

# Deleting a GPU cluster


Before deleting a [GPU cluster](../../concepts/gpus.md#gpu-clusters), make sure to delete all its [VMs](../../concepts/vm.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the GPU cluster.
  1. [Navigate]({{ link-console-main }}/link/compute) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Next to the GPU cluster, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for deleting a GPU cluster :

     ```bash
     yc compute gpu-cluster delete --help
     ```

  1. Get a list of GPU clusters in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute gpu-cluster list
     ```

  1. Select the `ID` or `NAME` of the GPU cluster, e.g., `first-gpu-cluster`.
  1. Delete the GPU cluster:

     ```bash
     yc compute gpu-cluster delete first-gpu-cluster
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the section specifying the GPU cluster:

     {% cut "Example of specifying a GPU cluster in {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_compute_gpu_cluster" "default" {
       name               = "gpu-cluster-name"
       interconnect_type  = "infiniband"
       zone               = "{{ region-id }}-a"

       labels = {
         environment = "test"
       }
     }
     ...
     ```

     {% endcut %}

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the GPU cluster deletion using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

    ```bash
    yc compute gpu-cluster list
    ```

- API {#api}

  To delete a GPU cluster, use the [delete](../../api-ref/GpuCluster/delete.md) REST API method for the [GpuCluster](../../api-ref/GpuCluster/index.md) resource or the [GpuClusterService/Delete](../../api-ref/grpc/GpuCluster/delete.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](gpu-cluster-create.md)
* [{#T}](gpu-cluster-update.md)
* [{#T}](gpu-add-to-cluster.md)
* [{#T}](../../concepts/gpus.md)
* [{#T}](../../concepts/vm-platforms.md)

