---
title: How to get information about a GPU cluster in {{ compute-full-name }}
description: Follow this guide to get information about a GPU cluster.
---

# Getting information about a GPU cluster


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [GPU cluster](../../concepts/gpus.md#gpu-clusters).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Select the cluster.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the GPU cluster details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about a [GPU cluster](../../concepts/gpus.md#gpu-clusters):

      ```bash
      yc compute gpu-cluster get --help
      ```

  1. Get information about a GPU cluster by specifying its name or ID:

      ```bash
      yc compute gpu-cluster get <GPU_cluster_name>
      ```

      Result:

      ```text
      id: fhm6cnc4kpp8********
      folder_id: b1gqs1teo2q2********
      created_at: "2024-02-14T15:10:21Z"
      name: test-cluster
      status: READY
      zone_id: {{ region-id }}-a
      interconnect_type: INFINIBAND
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [GPU cluster](../../concepts/gpus.md#gpu-clusters) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_gpu_cluster" "my_gpu_cluster" {
        gpu_cluster_id = "<GPU_cluster_ID>"
      }

      output "gpu_cluster" {
        value = data.yandex_compute_gpu_cluster.my_gpu_cluster.zone
      }
      ```

      Where:

      * `data "yandex_compute_gpu_cluster"`: Description of the GPU cluster as a data source:
        * `gpu_cluster_id`: GPU cluster ID.
      * `output "gpu_cluster"`: Output variable that contains information about the GPU cluster availability zone:
        * `value`: Returned value.

     You can replace `zone` with any other parameter to get the information you need. For more information about the `yandex_compute_gpu_cluster` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/compute_gpu_cluster).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      zone = {{ region-id }}-a
      ```

- API {#api}

  To get detailed information about a [GPU cluster](../../concepts/gpus.md#gpu-clusters), use the [get](../../api-ref/GpuCluster/get.md) REST API method for the [GpuCluster](../../api-ref/GpuCluster/index.md) resource or the [GpuClusterService/Get](../../api-ref/grpc/GpuCluster/get.md) gRPC API call.

{% endlist %}
