---
title: Deleting an Elasticsearch cluster
description: 'You can delete your Elasticsearch cluster if you no longer need it. All data in the cluster will be deleted. In the management console, select the directory from which you want to remove the cluster.'
keywords:
  - deleting an Elasticsearch cluster
  - Elasticsearch cluster
  - Elasticsearch
---

# Deleting clusters

You can delete an {{ ES }} cluster if you no longer need it. All data in the cluster will be deleted.

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](cluster-update.md#change-additional-settings) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

   {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting the cluster {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
   1. Select the service **{{ mes-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the desired cluster and select **Delete cluster**.
   1. Confirm cluster deletion and click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a cluster, run the command:

   ```bash
   {{ yc-mdb-es }} cluster delete <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}
  
- API

   Use the `delete` API method and pass the ID of the cluster to be deleted in the `clusterId` call parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
