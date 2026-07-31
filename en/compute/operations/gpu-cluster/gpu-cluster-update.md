---
title: Updating a GPU cluster
description: Follow this guide to update a GPU cluster.
---

# Updating a GPU cluster


After creating a [GPU cluster](../../concepts/gpus.md#gpu-clusters), you can change its name, description, or labels.

For information on how to add a [VM](../../concepts/vm.md) to a GPU cluster, see [{#T}](./gpu-add-to-cluster.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the GPU cluster.
  1. [Navigate]({{ link-console-main }}/link/compute) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Next to the GPU cluster, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the window that opens, edit the GPU cluster's name, description, or [labels](../../../resource-manager/concepts/labels.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for updating GPU cluster parameters:

     ```bash
     yc compute gpu-cluster update --help
     ```

  1. Get a list of GPU clusters in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute gpu-cluster list
     ```

  1. Select `ID` or `NAME` of the GPU cluster in question, e.g., `first-gpu-cluster`.
  1. Update the GPU cluster parameters, e.g., rename the cluster:

     ```bash
     yc compute instance update first-gpu-cluster \
       --new-name updated-gpu-cluster
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the section specifying the GPU cluster:

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

  You can check the GPU cluster update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc compute gpu-cluster get <GPU_cluster_name>
  ```

- API {#api}

  To update a GPU cluster, use the [update](../../api-ref/GpuCluster/update.md) REST API method for the [GpuCluster](../../api-ref/GpuCluster/index.md) resource or the [GpuClusterService/Update](../../api-ref/grpc/GpuCluster/update.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](gpu-cluster-create.md)
* [{#T}](gpu-cluster-delete.md)
* [{#T}](gpu-add-to-cluster.md)
* [{#T}](../../concepts/gpus.md)
* [{#T}](../../concepts/vm-platforms.md)
