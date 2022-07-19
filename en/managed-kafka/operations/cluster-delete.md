---
title: "Deleting Apache Kafka clusters"
description: "You can delete an Apache Kafka® cluster if you no longer need it. All data in the cluster will be deleted. In the management console, select the directory from which you want to delete the cluster."
---

# Deleting clusters

You can delete an {{ KF }} cluster if you no longer need it. All data in the cluster will be deleted.

## Before deleting a cluster {#before-you-delete}

[Disable deletion protection](cluster-update.md#change-additional-settings) for the cluster if it is enabled.

## Deleting a cluster {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
   1. Select **{{ mkf-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the desired cluster and select **Delete cluster**.
   1. Read the warning displayed. Confirm cluster deletion and click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a cluster, run the command:

   ```
   {{ yc-mdb-kf }} cluster delete <cluster name or ID>
   ```

- {{ TF }}

   {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% if api != "noshow" %}

- API

   Use the API [delete](../api-ref/Cluster/delete.md) method: pass the requisite cluster ID in the `clusterId` parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}
