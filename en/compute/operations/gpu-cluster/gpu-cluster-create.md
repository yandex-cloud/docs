# Creating a GPU cluster

{% note info %}

To use GPU clusters, contact your account manager.

{% endnote %}

This section explains how to create GPU clusters.

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the create GPU cluster CLI command:

      ```
      yc compute gpu-cluster create --help
      ```

      Please note that you can currently create clusters with the `InfiniBand` connection type only.

   1. Create a cluster in the default availability zone:

      ```
      yc compute gpu-cluster create --interconnect-type infiniband
      ```

{% endlist %}

Once you have created your cluster, you can [create VMs in it](gpu-add-to-cluster.md) by specifying the cluster ID or name in the `--gpu-cluster-id` and `--gpu-cluster-name` flags, respectively.