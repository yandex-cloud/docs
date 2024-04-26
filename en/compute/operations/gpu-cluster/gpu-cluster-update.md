# Updating a GPU cluster


After creating a [GPU cluster](../../concepts/gpus.md#gpu-clusters), you can change its name, description, or labels.

For information on how to add a [VM](../../concepts/vm.md) to a GPU cluster, see [{#T}](./gpu-add-to-cluster.md).

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../../cli/) command for updating GPU cluster parameters:

      ```bash
      yc compute gpu-cluster update --help
      ```

   1. Get a list of GPU clusters in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute gpu-cluster list
      ```

   1. Select the `ID` or `NAME` of the appropriate GPU cluster, e.g., `first-gpu-cluster`.
   1. Change the GPU cluster parameters, e.g., rename it:

      ```bash
      yc compute instance update first-gpu-cluster \
        --new-name updated-gpu-cluster
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and edit the fragment with the GPU cluster description:

      {% cut "Sample GPU cluster description in the {{ TF }} configuration" %}

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

{% endlist %}