# Deleting a GPU cluster


Before deleting a [GPU cluster](../../concepts/gpus.md#gpu-clusters), make sure to delete all its [VMs](../../concepts/vm.md).

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the delete GPU cluster [CLI](../../../cli/) command:

      ```bash
      yc compute gpu-cluster delete --help
      ```

   1. Get a list of GPU clusters in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute gpu-cluster list
      ```

   1. Select the `ID` or `NAME` of the appropriate GPU cluster, e.g., `first-gpu-cluster`.
   1. Delete the GPU cluster:

      ```bash
      yc compute gpu-cluster delete first-gpu-cluster
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and remove the fragment with the GPU cluster description:

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

   You can check the GPU cluster deletion using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc compute gpu-cluster list
   ```

{% endlist %}