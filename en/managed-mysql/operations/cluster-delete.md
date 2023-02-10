---
title: "Deleting a MySQL cluster"
description: "After you delete a MySQL database cluster, its backups are kept for 7 days for recovery purposes. To restore a deleted cluster from its backup, you'll need its ID, so please store the cluster ID safely before deleting the cluster."
---

# Deleting a {{ MY }} cluster

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md#change-additional-settings) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

   {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs %}

- Management console

   1. Open the [folder page]({{ link-console-main }}) in the management console.
   1. Select **{{ mmy-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the required cluster and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a cluster, run the command:

   ```
   {{ yc-mdb-my }} cluster delete <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [delete](../api-ref/Cluster/delete.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [Getting the Cluster ID](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}
