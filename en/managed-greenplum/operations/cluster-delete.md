# Deleting {{ GP }} clusters

## Before deleting a cluster {#before-you-delete}

[Disable deletion protection](./update.md#change-additional-settings) for the cluster if it is enabled.

## Deleting a cluster {#delete}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the desired cluster and select **Delete cluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a cluster, run the command:

   ```bash
   {{ yc-mdb-gp }} cluster delete <cluster ID or name>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To delete the infrastructure created with {{ TF }}:

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the {{ TF }} configuration file of the desired cluster.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in the configuration file will be deleted.

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To delete a cluster, use the [delete](../api-ref/Cluster/delete.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Delete](../api-ref/grpc/cluster_service.md#Delete) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
