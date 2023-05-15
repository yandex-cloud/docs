# Updating a GPU cluster

After creating a cluster, you can change its name, description, or labels.

For information about how to add a VM to a cluster, see [{#T}](./gpu-add-to-cluster.md).

{% list tabs %}

- CLI

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

{% endlist %}