# Deleting a GPU cluster

Before deleting a cluster, make sure to delete all its VMs.

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the delete GPU cluster CLI command:

      ```bash
      yc compute gpu-cluster delete --help
      ```

   1. Get a list of GPU clusters in the default folder:

      ```bash
      yc compute gpu-cluster list
      ```

   1. Select the `ID` or `NAME` of the appropriate cluster (such as `first-gpu-cluster`).
   1. Delete the cluster:

      ```bash
      yc compute gpu-cluster delete first-gpu-cluster
      ```


{% endlist %}