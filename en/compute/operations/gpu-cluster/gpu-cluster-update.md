# Updating a GPU cluster

After creating a cluster, you can change its name, description, or labels.

For information about how to add a VM to a cluster, see [{#T}](./gpu-add-to-cluster.md).

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating GPU cluster parameters:

      ```bash
      yc compute gpu-cluster update --help
      ```

   1. Get a list of GPU clusters in the default folder:

      ```bash
      yc compute gpu-cluster list
      ```

   1. Select the `ID` or `NAME` of the appropriate cluster (such as `first-gpu-cluster`).
   1. Change the cluster parameters. For example, here is how you can rename it:

      ```bash
      yc compute instance update first-gpu-cluster \
      --new-name updated-gpu-cluster
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and edit the fragment with the GPU cluster description:

      {% cut "Sample GPU cluster description in the {{ TF }} configuration" %}

      ```
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

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   You can check the cluster update using the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc compute gpu-cluster get <cluster_name>
   ```

{% endlist %}