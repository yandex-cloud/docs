---
title: "Deleting Redis clusters"
description: "After deleting a Redis database cluster, its backups are preserved and can be used for recovery within 7 days. To restore a deleted cluster from a backup, you will need its ID, so save the cluster ID in a safe place before deleting."
---

# Deleting clusters

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md#change-additional-settings) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

   {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder to delete the cluster from.
   1. Select **{{ mrd-name }}**.
   1. In the line of the appropriate cluster, click ![image](../../_assets/options.svg) and select **Delete**.
   1. In the window that opens, check **Delete cluster** and click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a cluster, run the command:

   ```
   {{ yc-mdb-rd }} cluster delete <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the [delete](../api-ref/Cluster/delete.md) API method and pass the ID of the cluster to be deleted in the `clusterId` call parameter.

   You can fetch the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

{% endlist %}
